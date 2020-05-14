Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D075C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA8E206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nj4+W+i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgENIxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgENIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:53:16 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A8C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fH2E9NMtzf0VD7/i5YL3RPMfzmTBfXtCfHdyTIjPXGs=; b=Nj4+W+i06RdtPAsq+h3thgIle
        phKRmRH2FqwyCmbYzcnrVbAiWDbYXro0WOV1EyR/E7XvFq2NnpBrC1auIj9HBzFHhVbWtwLAbFeev
        T97ydik2A3LvCuaNKyiKXp34tdT+/CMSIZdM6SeOstr0/DlpN8A4b6TU+jvsDKDBgqK94qBP8ozhN
        LcemgBwNh3Yad79Wj8LFPqvzfNheF1Qsfj8m4n6umKOIzJiMhtsXVWjQLyXst2cJXlAeY1xIKYPaR
        vsF0Dhrbw8XiLfFPDgvk9hyKT2ypPBkGek9SIYKxc90koP9ZeB76Cl9tZq5pKw83jnpoKsUn5433x
        A06PeO5Xg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:57840)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jZ9c5-0007cM-7b; Thu, 14 May 2020 09:53:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jZ9c4-0000RC-3w; Thu, 14 May 2020 09:53:08 +0100
Date:   Thu, 14 May 2020 09:53:08 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
Message-ID: <20200514085307.GO1551@shell.armlinux.org.uk>
References: <20200513150007.1315395-1-lkundrak@v3.sk>
 <20200513150007.1315395-3-lkundrak@v3.sk>
 <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
 <CAOMZO5BdiXCVXs+8jP7PoRvgKd1sxCu4KhjvJBvL=Qig2WOs4g@mail.gmail.com>
 <1e15be39906034a95b86c026e060ed9866586d94.camel@pengutronix.de>
 <20200514082755.GN1551@shell.armlinux.org.uk>
 <ab384507b90474b0030d8ce64fdcfe868b52c3cb.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab384507b90474b0030d8ce64fdcfe868b52c3cb.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:40:58AM +0200, Lucas Stach wrote:
> Am Donnerstag, den 14.05.2020, 09:27 +0100 schrieb Russell King - ARM Linux admin:
> > On Thu, May 14, 2020 at 10:18:02AM +0200, Lucas Stach wrote:
> > > Am Mittwoch, den 13.05.2020, 23:41 -0300 schrieb Fabio Estevam:
> > > > On Wed, May 13, 2020 at 2:09 PM Fabio Estevam <festevam@gmail.com> wrote:
> > > > 
> > > > > The binding doc Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> > > > > says that only the 'reg' clock could be optional, the others are
> > > > > required.
> > > > 
> > > > arch/arm/boot/dts/dove.dtsi only uses the 'core' clock.
> > > > arch/arm/boot/dts/stm32mp157.dtsi uses 'bus' and 'core'
> > > > 
> > > > Maybe the binding needs to be updated and it seems that using
> > > > devm_clk_get_optional() like you propose is safe.
> > > 
> > > The binding is correct as-is. We want to require those clocks to be
> > > present, but the dove DT was added before the binding was finalized, so
> > > the driver still treats the clocks as optional to not break
> > > compatibility with old DTs. Maybe this warrants a comment in the
> > > code...
> > 
> > The binding doc in mainline says:
> > 
> >   clocks:
> >     items:
> >       - description: AXI/master interface clock
> >       - description: GPU core clock
> >       - description: Shader clock (only required if GPU has feature PIPE_3D)
> >       - description: AHB/slave interface clock (only required if GPU can gate slave interface independently)
> >     minItems: 1
> >     maxItems: 4
> > 
> >   clock-names:
> >     items:
> >       enum: [ bus, core, shader, reg ]
> >     minItems: 1
> >     maxItems: 4
> > 
> > which looks correct to me - and means that Dove is compliant with that.
> 
> The YAML binding actually did loose something in translation here,
> which I didn't notice. Previously all those clocks were listed under
> "Required properties", with the exceptions listed in parenthesis. So
> the Dove GPU, which is a combined 2D/3D core should have axi, core and
> shader clocks specified.

That may be your desire, but that is impossible without knowing that
(a) it has the clocks
(b) what those clocks are connected to

I guess we could "make something up" but as DT is supposed to describe
hardware, I don't see how we can satisfy that and your requirement.

The only thing that is known from the documentation is that there is
one clock for the GPU on Dove.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
