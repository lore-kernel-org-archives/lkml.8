Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43FA22CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgG0P6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:58:33 -0400
Received: from verein.lst.de ([213.95.11.211]:44198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgG0P6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:58:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91E3C68B05; Mon, 27 Jul 2020 17:58:29 +0200 (CEST)
Date:   Mon, 27 Jul 2020 17:58:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/23] init: open code setting up stdin/stdout/stderr
Message-ID: <20200727155829.GA7225@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-19-hch@lst.de> <20200727030534.GD795125@ZenIV.linux.org.uk> <20200727054625.GA1241@lst.de> <20200727060322.GC794331@ZenIV.linux.org.uk> <20200727064828.GA2317@lst.de> <20200727155453.GE794331@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727155453.GE794331@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 04:54:53PM +0100, Al Viro wrote:
> On Mon, Jul 27, 2020 at 08:48:28AM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 27, 2020 at 07:03:22AM +0100, Al Viro wrote:
> > > On Mon, Jul 27, 2020 at 07:46:25AM +0200, Christoph Hellwig wrote:
> > > > On Mon, Jul 27, 2020 at 04:05:34AM +0100, Al Viro wrote:
> > > > > On Tue, Jul 14, 2020 at 09:04:22PM +0200, Christoph Hellwig wrote:
> > > > > > Don't rely on the implicit set_fs(KERNEL_DS) for ksys_open to work, but
> > > > > > instead open a struct file for /dev/console and then install it as FD
> > > > > > 0/1/2 manually.
> > > > > 
> > > > > I really hate that one.  Every time we exposed the internal details to
> > > > > the fucking early init code, we paid for that afterwards.  And this
> > > > > goes over the top wrt the level of details being exposed.
> > > > > 
> > > > > _IF_ you want to keep that thing, move it to fs/file.c, with dire comment
> > > > > re that being very special shite for init and likely cause of subsequent
> > > > > trouble whenever anything gets changed, a gnat farts somewhere, etc.
> > > > 
> > > > Err, while I'm all for keeping internals internal, fd_install and
> > > > get_unused_fd_flags are exported routines with tons of users of this
> > > > pattern all over.
> > > 
> > > get_file_rcu_many()?  All over the place?  Besides, that's _not_ the normal
> > > pattern for get_unused_fd() - there's a very special reason we don't expect
> > > an error from it here.
> > 
> > Oh well.  I can add an init_dup2, but that should probably go after
> > the series adding fs/for-init.c or fs/init.c.  I'll skip it for the
> > current set of fixups and will send it once we have a stable branch for
> > that.
> 
> OK.  The really serious ones are around f_pos uses and d_genocide() one.
> FWIW, cleanup_rootfs() should probably be removed - it looks rather
> pointless.

I've got all that in a series I've tested this morning, and which
I really should post now..
