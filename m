Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA20CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A56620671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FlwveDta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgENQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgENQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:25:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F4C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JPLZxXuF7yodRZCXQ3CE5KPziLgfM5ayWE6A7Api2Yw=; b=FlwveDtae04WSkTVrnUsh/Uz2
        rc+TJuHh3HuX+v4pWvszHH8plZHnisShvsa8yuPOuylYEkV8weNRvI+/A91lVTelbRrfkWFoY6DiZ
        oor/RfX0HFp5tjonY0rRmqA0fViASjaJoULZguSioBF7jT+yHzoFOtRBtxWWAlac0eKPSsgjj4N+s
        nJWWJmCWSuzdRzNOoWgRivuptGuWEPIhPB0RcJIVHSvQzgduoQUbK/nyWpXI/ca4uOz4cTkieTywQ
        j0IoxY5po7/VCqkxtXQ4P8sE6p2MPc1mjspLACxenttU1woKLN8DGr7RfhBnI72XoaGtzy2p4gQrF
        zDFXA639g==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:40240)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jZGfw-0000fU-St; Thu, 14 May 2020 17:25:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jZGfv-0000hD-S4; Thu, 14 May 2020 17:25:35 +0100
Date:   Thu, 14 May 2020 17:25:35 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: static kernel in vmalloc space
Message-ID: <20200514162535.GP1551@shell.armlinux.org.uk>
References: <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc>
 <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc>
 <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 02:41:11PM +0200, Arnd Bergmann wrote:
> On Thu, May 14, 2020 at 1:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> > On Tue, May 12, 2020 at 09:49:59PM +0200, Arnd Bergmann wrote:
> >
> > > Any idea which bit you want to try next?
> >
> > My plan has been to next post patches for the static kernel migration
> > to vmalloc space (currently the code is rigid, taking easy route
> > wherever possible & not of high quality) as that feature has an
> > independent existence & adds value by itself.  And then start working
> > on other steps towards VMSPLIT_4G_4G.
> >
> > Now that you mentioned about other things, i will slowly start those
> > as well.
> 
> Sounds good.
> 
> > > Creating a raw_copy_{from,to}_user()
> > > based on get_user_pages()/kmap_atomic()/memcpy() is probably a good
> > > next thing to do. I think it can be done one page at a time with only
> > > checking for
> > > get_fs(), access_ok(), and page permissions, while get_user()/put_user()
> > > need to handle a few more corner cases.
> >
> > Before starting w/ other things, i would like to align on the high
> > level design,
> >
> > My understanding (mostly based on your comments) as follows,
> > (i currently do not have a firm grip over these things, hope to have
> > it once started w/ the implementation)
> >
> > 1. SoC w/ LPAE
> > 2. TTBR1 (top 256MB) for static kernel, modules, io mappings, vmalloc,
> >         kmap, fixmap & vectors
> 
> Right, these kind of go together because pre-LPAE cannot do the
> same TTBR1 split, and they more frequently have conflicting
> static mappings.
> 
> It's clearly possible to do something very similar for older chips
> (v6 or v7 without LPAE, possibly even v5), it just gets harder
> while providing less benefit.

Forget about doing this for anything without a PIPT cache - or you're
going to end up having to flush the data cache each time you enter or
exit the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
