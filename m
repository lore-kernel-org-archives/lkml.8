Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43886C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7E2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W/GiWN27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:00:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F150C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kh884d4MFcKuORRz816KMV8dO7B8Es83ozqJwyPkb8c=; b=W/GiWN27p9dRMGWMr8W20V/nw
        kR/6qr096WJ6EgZOnD2TzcxyjCmfJswhTMwzqvxNTfWpUOo4+pguoI6QNQLtQA4xzAT1rOecK1Dwh
        de7t4z9cv5okphkvafq5qIZQEnFgZGrSBp13ruqO8yGWpN9cT5OW/eRQmnCDIH/LrBhtI2u4QpcLa
        WQiZxmoR/Qzs1j06UKRTshY9HOm1KBLZTHp23bY9JLQyfyaLlTs0O/kwd/wY2eNc0CyoRagytgXQA
        KHiculwJgpPzi5aq1e5FyhkQ3qEl72igrqVWSSfy0ckRHRDE5cuws/m10kUUfB8dNFbi6znfen29W
        8MjPLOXwg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:42714)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jbQCl-00004q-G9; Wed, 20 May 2020 16:00:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jbQCi-0007Rg-2e; Wed, 20 May 2020 16:00:20 +0100
Date:   Wed, 20 May 2020 16:00:20 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
Message-ID: <20200520150019.GN1551@shell.armlinux.org.uk>
References: <20200513150007.1315395-1-lkundrak@v3.sk>
 <20200513150007.1315395-3-lkundrak@v3.sk>
 <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
 <CAOMZO5BdiXCVXs+8jP7PoRvgKd1sxCu4KhjvJBvL=Qig2WOs4g@mail.gmail.com>
 <1e15be39906034a95b86c026e060ed9866586d94.camel@pengutronix.de>
 <20200514082755.GN1551@shell.armlinux.org.uk>
 <ab384507b90474b0030d8ce64fdcfe868b52c3cb.camel@pengutronix.de>
 <20200514085307.GO1551@shell.armlinux.org.uk>
 <20200520133824.GK1695525@furthur.local>
 <ebcfc9843b57c5611b2106a3fe3553efb48734f0.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebcfc9843b57c5611b2106a3fe3553efb48734f0.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 04:04:39PM +0200, Lucas Stach wrote:
> Am Mittwoch, den 20.05.2020, 15:38 +0200 schrieb Lubomir Rintel:
> > Yes. This means that in fact "core" is the only required clock for all
> > implementations of vivante,gc and the common binding needs to be updated
> > to reflect that. I'll follow with a patch that does that, unless there
> > are strong objections.
> > 
> > If there are implementations that require different clock inputs, then they
> > need to use additional compatible string for the particular flavor and the
> > binding should have conditionals for them. Something like this:
> > 
> >   if:
> >     properties:
> >       compatible:
> >         contains:
> >           const: fsl,imx6sx-gpu
> >   then:
> >     properties:
> >       clocks:
> >         minItems: 4
> 
> The DT binding of a device should describe the hardware of the device,
> not the specific integration into a SoC. Now it's a bit hard to make
> any definite statements about the Vivante GC GPU module itself, as most
> of the information we have is from reverse engineering. It's pretty
> clear though that the GPU module has at least 2 clock inputs: axi and
> core, as there is a feature bit that tells us if it's okay to gate the
> axi clock independently from core. 
> 
> I'm not 100% sure about the older cores as found in Dove, but all the
> more recent cores allow to clock the shader partition independently of
> the core partition, so that's another clock input.
> 
> Now when it comes to a SoC integration, it's totally fine to have all
> those GPU module clock inputs fed from the same clock source and behind
> a shared gate maybe. But that doesn't change the clock inputs from the
> device perspective, it's still 3 independent clock inputs, which then
> just point to the same clock source in the DT.
> 
> imx6sx.dtsi is even a precedent of such a setup: all module clock
> inputs are fed by a common clock and share a single gate.

It's very good to stand on a pedistal, and try to dictate what you
want, but what you want is not always possible, and that is the case
here.  You have made your idea of how you see the hardware quite
plain.

Getting back to reality, again, what we know is that there is one
clock for the GC600 on Dove, since are register settings to control
that clock.

What we also know is that there is an AHB clock, but how that relates
to the rest of the system, we have no documentation.  It is that is
used for the AHB bus, which incidentally includes the GC600 for access
to its register set. I don't remember whether AHB peripherals require
the clock or not, that is something that would need to be checked.
If they do, then it seems that clock is missing from the binding.

Then there's a description of the AXI interface to the GC600 which
mentions no clock (see 10.7.2 below).  It has a clock, but what that
clock is, and how it relates to the rest of the system is not clearly
specified.

So, again, what you're basically asking for is for someone to guess
and throw some ficticious model into DT.

No, if it's not known, then we should not be guessing and throwing
random garbage into a SoC DT description - once it's in the DT
description, it has to be supported going forward, and if it's later
found to be incorrect, then we have a problem.

So, I don't see how Dove can meet your requirements, and I think you
have to compromise on this, and just accept that Dove only has one
known clock.

If you want to continue being pedantic about this, then in order to
support that pedanty, we need to add an AHB clock to all Vivante GC
descriptions as well since the AHB interface requires it - there it
is called HCLK in the AHB specs.  Here is the extract from the Dove
documentation for the AHB interface:

10.7.1              AHB Interface
                    The main features of the AHB interface are:
                    n    256k addressable register space
                    n    32-bit accesses only (no bursts)
                    n    32-bit data bus
                    n    Error response for illegal accesses
                    n    Asynchronous interface to the Graphics Core
                    n    Interrupt support
                    The interface uses a separate clock that is slower
                    than the AXI Bus clock, thus allowing a more
                    relaxed logic design. Because the Core clock is
                    different from the interface clock, design within
                    the GPU Core ensures that incoming and outgoing
                    data are handled properly when they cross clock
                    boundaries.
                    The GPU block occupies 256 KB (64k 32-bit words) of
                    the system address space. An AHB ERROR response is
                    returned if an illegal access is detected. Only
                    32-bit reads and writes are permitted.

10.7.2              AXI Interface
                    The main features of the AXI interface are:
                    n    64-bit independent read and write data buses
                    n    Multiple Burst length (8 bytes, 16 bytes,
                         32 bytes, or 64 bytes)
                    n    High-performance out-of-order / 16 multiple
                         outstanding accesses
                    n    Supports out-of-order return data for
                         different clients
                    n    Asynchronous interface to the graphics core
                    The AXI Interface included in the graphics GPU is
                    used to retrieve data from the memory attached to
                    the AXI Interconnect.
                    The possible graphics clients using the AXI to fetch
                    data are:
                    n   DMA (to fetch commands, states, index and
                        vertex data)
                    n   Rasterizer
                    n   Texture engine (for reading of texture data)
                    n   Pixel engine (for reading and writing of Z and
                        color buffer)

Now, as far as clocking goes:

4.3                   Clocking
4.3.1                 Clock Domains
                      The 88AP510 has one PLL for the CPU and DDR Memory
                      Controller, and a Core PLL that generates the AXI,
                      Mbus, and internal clocks.
                      The CPU and DDR Memory Controller operate
                      synchronously at a ratio of N:1 (N=1..10), 5:2 or 7:2.
                      The GPU, VMeta■, and Display controller operate in
                      the AXI bus clock domain, which is asynchronous to
                      the CPU clock domain. The synchronization between
                      the AXI and CPU clock domains is implemented by the
                      Memory Controller Bridge (MCB). The Mbus is clocked
                      at Tclk, which is asynchronous to the AXI clock
                      domain. Synchronization between the Mbus and the AXI
                      clock domains is accomplished by the Upstream bridge
                      and the Downstream bridge.
4.3.2                 Core PLL Clock Tree
                      The GPU, VMeta■, and Display Controller derive the
                      operating clock from the Core PLL through the
                      dedicated PLL clock dividers, and are asynchronous
                      to the AXI interconnect bus clock. The clock
                      tree is depicted in Figure 5.

                      Figure 4: AXI Units Clock Tree

                      <diagram of Core-PLL feeding the display controller,
                       VMeta and GPU clocks, through dividers, which are
                       not the AXI clock but the functional clocks for these
                       peripherals. No mention of how the AXI clock is
                       derived.>

Figure 5 is something entirely different, so I suspect they mean figure
4 there.

So, as I say, you're basically asking for someone to make something up
to suit your requirements and throw that into DT.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
