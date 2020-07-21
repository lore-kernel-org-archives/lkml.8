Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE74C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF09A2077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595347712;
	bh=bE63ofQYOuJCDHkwYPXWxgUsUB8i3gu/kQjGh79M6RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C95RpNWBfy83MTxilSUrrKzD9AsQSbNVQR+dr+0vPbVYTWbTOEwrGZmfjM8v3lzSf
	 P0/XAP+tu0BLZUCrAMYpTA76StlVFtK0GoZa2Z7L2TOR4Exx2ysdCDYUX1vWTk1wZK
	 wWdgyciTJpyr4GzQGMKUiMdzZ8vsTtbCENa9hkm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgGUQIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbgGUQI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:08:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A2822BEF;
        Tue, 21 Jul 2020 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595347708;
        bh=bE63ofQYOuJCDHkwYPXWxgUsUB8i3gu/kQjGh79M6RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFvxtf5wi2negsmKSYII+qpSHBLTYdCnnn1E0C3PnhkIMZ5dLJpDtmr/u3sHC02tp
         5SFo/r2n+QH+plLsBmzNni4khMvB0xAz1nF4iEYpE1pkmsE3xbjCem+tGPH7LyX6Zl
         gzEPDSCll+1qsyOeLZOs4Eo1NUB9nWPMPxhDPYHA=
Date:   Tue, 21 Jul 2020 18:08:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        George Kennedy <george.kennedy@oracle.com>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct
 fbcon_ops"->clear_margins.
Message-ID: <20200721160836.GA2109047@kroah.com>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam>
 <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
 <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
 <20200715151220.GE2571@kadam>
 <adfa8720-c411-dfe6-6b0f-7591dd95396c@i-love.sakura.ne.jp>
 <20200716100006.GN3278063@phenom.ffwll.local>
 <b202b74b-6a7b-e2be-2350-72144331303b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b202b74b-6a7b-e2be-2350-72144331303b@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 08:27:21PM +0900, Tetsuo Handa wrote:
> On 2020/07/16 19:00, Daniel Vetter wrote:
> > On Thu, Jul 16, 2020 at 12:29:00AM +0900, Tetsuo Handa wrote:
> >> On 2020/07/16 0:12, Dan Carpenter wrote:
> >>> I've complained about integer overflows in fbdev for a long time...
> >>>
> >>> What I'd like to see is something like the following maybe.  I don't
> >>> know how to get the vc_data in fbmem.c so it doesn't include your checks
> >>> for negative.
> >>
> >> Yes. Like I said "Thus, I consider that we need more sanity/constraints checks." at
> >> https://lore.kernel.org/lkml/b1e7dd6a-fc22-bba8-0abb-d3e779329bce@i-love.sakura.ne.jp/ ,
> >> we want basic checks. That's a task for fbdev people who should be familiar with
> >> necessary constraints.
> > 
> > I think the worldwide supply of people who understand fbdev and willing to
> > work on it is roughly 0. So if someone wants to fix this mess properly
> > (which likely means adding tons of over/underflow checks at entry points,
> > since you're never going to catch the driver bugs, there's too many and
> > not enough people who care) they need to fix this themselves.
> 
> But I think we can enforce reasonable constraint which is much stricter than Dan's basic_checks()
> (which used INT_MAX). For example, do we need to accept var->{xres,yres} >= 1048576, for
> "32768 rows or cols" * "32 pixels per character" = 1045876 and vc_do_resize() accepts only
> rows and cols < 32768 ?
> 
> > 
> > Just to avoid confusion here.
> > 
> >> Anyway, my two patches are small and low cost; can we apply these patches regardless
> >> of basic checks?
> > 
> > Which two patches where?
> 
> [PATCH v3] vt: Reject zero-sized screen buffer size.
>  from https://lkml.kernel.org/r/20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp

This is now in my tree.

> [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
>  from https://lkml.kernel.org/r/20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp

That should be taken by the fbdev maintainer, but I can take it too if
people want.

thanks,

greg k-h
