Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E57C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C452065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NB7CejOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgENXkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgENXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:40:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8460C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w6BkmSCK+9PvyslXlTzZk3UIk7P2/MFM4deljPFam9A=; b=NB7CejObDlLA77BJZUE81lycY
        MeDeTt5CYKPIKdhx9O50BLP04pUP9vAZJFhY/TWIj9EWXUt1odSpUbJPGCye+BD/5Ps/yfCG+LR6W
        7sU725RS2Rw5rnS9SCCeA6LPtl6bJ0hl2FM9oxM+9ZB9GHrpNYtUFgvZax6TEVCZoRkEbJtW+BKhI
        mOKX7L8AqEQp3ULi3r3Japa6hJYqtoCsNaPCe5eew+wkv5h1eF1SL1TvHCP03k3CF7U5559kiHGjQ
        1O1O7A/oUW98eQkLHRFGYZUUxyfoIDIehKaJDQthWBXknuJEgaEzj0W8MzD19UWwr1GpBhet4es3k
        wtnkXT9mA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60542)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jZNSZ-00026B-TD; Fri, 15 May 2020 00:40:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jZNSY-0000z1-21; Fri, 15 May 2020 00:40:14 +0100
Date:   Fri, 15 May 2020 00:40:14 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: static kernel in vmalloc space
Message-ID: <20200514234013.GQ1551@shell.armlinux.org.uk>
References: <20200504091018.GA24897@afzalpc>
 <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc>
 <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514162535.GP1551@shell.armlinux.org.uk>
 <CAK8P3a2KR+O5Ua5hsNgzLQV5-V1pat6JH_WM10Es-oUhXO2OgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2KR+O5Ua5hsNgzLQV5-V1pat6JH_WM10Es-oUhXO2OgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 11:12:01PM +0200, Arnd Bergmann wrote:
> On Thu, May 14, 2020 at 6:25 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Thu, May 14, 2020 at 02:41:11PM +0200, Arnd Bergmann wrote:
> > > On Thu, May 14, 2020 at 1:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> 
> > > It's clearly possible to do something very similar for older chips
> > > (v6 or v7 without LPAE, possibly even v5), it just gets harder
> > > while providing less benefit.
> >
> > Forget about doing this for anything without a PIPT cache - or you're
> > going to end up having to flush the data cache each time you enter or
> > exit the kernel.
> 
> Right, let's forget I said anything about v5 or earlier ;-)
> 
> I expected the non-aliasing VIPT caches to work the same as PIPT, can
> you clarify if there is something to be aware of for those? I see that some
> ARMv8 chips and most ARMv6 chips (not OMAP2 and Realview) are
> of that kind, and at we clearly don't want to break running on ARMv8 at
> least.

There are some aliasing VIPT implementations on ARMv6, but I don't
remember how common.

> Anyway my point was that it's best to only do it for LPAE anyway, everything
> else being a distraction, as the only non-LPAE SoCs I could find with
> support for over 2GB are some of the higher-end i.MX6 versions and the
> original highbank.

Yep.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
