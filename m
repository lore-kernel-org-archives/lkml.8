Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0AFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A172067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgGOGvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:51:43 -0400
Received: from verein.lst.de ([213.95.11.211]:57781 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgGOGvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:51:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79AA767357; Wed, 15 Jul 2020 08:51:40 +0200 (CEST)
Date:   Wed, 15 Jul 2020 08:51:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
Message-ID: <20200715065140.GA22060@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:34:45PM -0700, Linus Torvalds wrote:
> On Tue, Jul 14, 2020 at 12:06 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > this series starts to move the early init code away from requiring
> > KERNEL_DS to be implicitly set during early startup.  It does so by
> > first removing legacy unused cruft, and the switches away the code
> > from struct file based APIs to our more usual in-kernel APIs.
> 
> Looks good to me, with the added note on the utimes cruft too as a
> further cleanup (separate patch).
> 
> So you can add my acked-by.
> 
> I _would_ like the md parts to get a few more acks. I see the one from
> Song Liu, anybody else in md land willing to go through those patches?
> They were the bulk of it, and the least obvious to me because I don't
> know that code at all?

Song is the maintainer.   Neil is the only person I could think of
that also knows the old md code pretty well.  Guoqing has contributed
a lot lately, but the code touched here is rather historic (and not
used very much at all these days as people use modular md and initramfѕ
based detection).
