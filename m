Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2923EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5E20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgGHGHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:07:34 -0400
Received: from verein.lst.de ([213.95.11.211]:33725 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgGHGHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:07:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4EEC168AFE; Wed,  8 Jul 2020 08:07:30 +0200 (CEST)
Date:   Wed, 8 Jul 2020 08:07:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: stop using ->read and ->write for kernel access v3
Message-ID: <20200708060730.GB4919@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <CAHk-=wib3BP9AoFzhR_Z0oPRwx7vkcS=zsDuUmx0FbCrtia7CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wib3BP9AoFzhR_Z0oPRwx7vkcS=zsDuUmx0FbCrtia7CA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:24:01PM -0700, Linus Torvalds wrote:
> On Tue, Jul 7, 2020 at 10:48 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi Al and Linus (and Stephen, see below),
> >
> > as part of removing set_fs entirely (for which I have a working
> > prototype), we need to stop calling ->read and ->write with kernel
> > pointers under set_fs.
> 
> I'd be willing to pick up patches 1-6 as trivial and obvious cleanups
> right now, if you sent those to me as a pull request. That would at
> least focus the remaining series a bit on the actual changes..

If we do that we should do 1-7 and 9-12 to include the read side as
well.  But yes, maybe that way we'll get started.
