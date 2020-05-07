Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05270C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70A82078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgEGGyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:54:55 -0400
Received: from verein.lst.de ([213.95.11.211]:44911 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEGGyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:54:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1010968B05; Thu,  7 May 2020 08:54:52 +0200 (CEST)
Date:   Thu, 7 May 2020 08:54:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org,
        jk@ozlabs.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/spufs: Add rcu_read_lock() around fcheck()
Message-ID: <20200507065451.GA6185@lst.de>
References: <20200428114811.68436-1-mpe@ellerman.id.au> <20200428135245.GA2827@lst.de> <875zdifrgw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zdifrgw.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 09:42:39PM +1000, Michael Ellerman wrote:
> Christoph Hellwig <hch@lst.de> writes:
> > On Tue, Apr 28, 2020 at 09:48:11PM +1000, Michael Ellerman wrote:
> >> 
> >> This comes from fcheck_files() via fcheck().
> >> 
> >> It's pretty clearly documented that fcheck() must be wrapped with
> >> rcu_read_lock(), so fix it.
> >
> > But for this to actually be useful you'd need the rcu read lock until
> > your are done with the file (or got a reference).
> 
> Hmm OK. My reasoning was that we were done with the struct file, because
> we return the ctx that's hanging off the inode.
> 
> +	ctx = SPUFS_I(file_inode(file))->i_ctx;
> 
> But I guess the lifetime of the ctx is not guaranteed if the file goes
> away.
> 
> It looks like the only long lived reference on the ctx is the one
> taken in spufs_new_file() and dropped in spufs_evict_inode().
> 
> So if we take a reference to the ctx with the RCU lock held we should be
> safe, I think. But I've definitely exhausted my spufs/vfs knowledge at
> this point.
> 
> Something like below.

Looks reasonable.
