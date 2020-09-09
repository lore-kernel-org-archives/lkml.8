Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BC1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350D2218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HBVQErCl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KfNndKZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgIIP2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgIIP0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:26:37 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13D9C06134A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:55:10 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Bmk6Z1N76zKmTb;
        Wed,  9 Sep 2020 15:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:subject:subject:from:from
        :date:date:received; s=mail20150812; t=1599659692; bh=Y07xZUbsg7
        /kT6L0Yk6Xwpf4QZHn+uAsNE/SVHG1y6E=; b=HBVQErClVHgarqgQpRI8e4D+UL
        R0tBW85Lq2hAzMMBITl1c5oJn+okNPaVDk1hzGE2QpWraAPqlxqo8dmnP8nms7oJ
        ME5DbJj73riCcuXCEs35PNCt86+HxmV0bdeAqwX6h6uXCCHYs1fiiKG2Fue9EJWz
        KmIRZtKQP1IUUQkroKaGr4WKb4wJovBdFj5ARDLd7Vg3AqKWdlky0BLJgpt/QnO4
        3sN9Cu1AmgjNwZLNZtmB6v5ZoKpIOirnh0tp4XWOiUjuBRXrO9LThitTq5tQgOl3
        IecDrvEiPoTO3rULXKoL9GuUKTgb4LGIZEzz32GGOOeli5uKqUljsvzcp93A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1599659694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sssy7uYMA7mVpGV79atJBK4CxRHqfJaWH4twd+tWB2A=;
        b=KfNndKZJbk2UVlyhNWkqJq/a2Nep4PPE+Ef7RSK6xDGrCyN4smd+ZJOkDtT/0BOl+MDzNJ
        XsglS4mmQDB3EjqHAlGeeTvdW3JWQv3GL9vyTrnSKiw87w5Yhg0nyl2kHXeOKLuuGGlcQf
        7Ltf2Q3fAkxxewVAv/tUQrOoysIX2+kDn8iI5U9pfkRGOTf/4SsdIVo4BBDkRmcl5QHMpf
        nZgW1h4SoLIFDVgvNfQcS5SGILVUu9LV1cw+YTXf8Bcpu5fA2zXErQzpNE7QRXSaSQTCoa
        QhMWlBGMNbD5kvFKaOBo/sGQWcpfhNXyjR0K3fjKn5R1kwNGsYqUNoHK8RcMOg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 2TP-CsRcaYYW; Wed,  9 Sep 2020 15:54:52 +0200 (CEST)
Date:   Wed, 9 Sep 2020 15:54:46 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] dt-bindings: arm: sunxi: update H2+/H3 cpu clocks
Message-ID: <20200909155446.382cf06d@monster.powergraphx.local>
In-Reply-To: <20200909120859.yosl2vgs3rj34stu@gilmour.lan>
References: <20200903100708.GA466735@monster.powergraphx.local>
        <20200909120859.yosl2vgs3rj34stu@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.01 / 15.00 / 15.00
X-Rspamd-Queue-Id: 07CD4EF9
X-Rspamd-UID: 4e72cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 14:08:59 +0200
Maxime Ripard <maxime@cerno.tech> wrote:
> Hi!
> 
> Thanks for contributing
> 
> The prefix isn't right though.
> 
> dt-bindings is used when you're modifying the binding itself, ie the
> description of what the node is supposed to look like, not when you
> actually use that node in a DT.
> 
> In that case, that would be ARM: dts: sunxi:
> 
> (we're on the ARM architecture, modifying dts's, for the sunxi platform)

Ah, I see, it was my first attempt to contribute and wasn't 100% sure, just
took the line from similar patches on the LKML. Thanks for the correction.

> On Thu, Sep 03, 2020 at 12:07:08PM +0200, Wilken Gottwalt wrote:
> > Change H2+/H3 clocks to 8 steps from 528 MHz up to 1200 MHz to support a
> > more fine-grained powersave setup. The SoCs are made for 1296 MHz, so
> > these clocks are still in a safe range. Tested on a NanoPi Duo and
> > OrangePi Zero.
> 
> How was this tested?

This is a longer story. It actually runs on hardware which is in production
for about 2-3 years, some use H2+ with full voltage regulators and some are
similar to the NanoPi DUO, where the voltage regulator can only switch
between 1.1 and 1.3 volts. It runs in two ways: A fully dynamic setup where
the ondemand scheduler is used and the second way where it is switched to
fixed values (based on load and temperature) using the cpufrequtils. The
devices running a 4.14.x kernel and are tested against 4.19.x kernels.
These devices are routers running a custom tcp/ip stack and have a high I/O
load. I also prepared devices based on a custom H3 design, which ran stable
at 1.392 GHz (but had passive coolers attached). Do these explanations
help?

> cpufreq OPP misconfiguration on Allwinner SoCs has been known to create
> some errors that are fairly hard to spot and be quite easy to go
> unnoticed (like caches corruptions).

Yeah, I noticed that in the beginning where I prepared the first kernels
for these devices. But after switching to multiples of 48MHz and bigger
steps these issues disappeared. I'm aware that this does not proof that
these issues do not appear, but thougth I share the values which I
consider stable.

> The only reliable test we have is:
> https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test
> 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> > ---
> >  arch/arm/boot/dts/sun8i-h3.dtsi | 34 +++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> > index 4e89701df91f..5517fcc02b7d 100644
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > @@ -48,23 +48,53 @@ cpu0_opp_table: opp_table0 {
> >  		compatible = "operating-points-v2";
> >  		opp-shared;
> >  
> > -		opp-648000000 {
> > -			opp-hz = /bits/ 64 <648000000>;
> > +		opp-528000000 {
> > +			opp-hz = /bits/ 64 <528000000>;
> > +			opp-microvolt = <1020000 1020000 1300000>;
> > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > +		};
> > +
> > +		opp-624000000 {
> > +			opp-hz = /bits/ 64 <624000000>;
> >  			opp-microvolt = <1040000 1040000 1300000>;
> >  			clock-latency-ns = <244144>; /* 8 32k periods */
> >  		};
> >  
> > +		opp-720000000 {
> > +			opp-hz = /bits/ 64 <720000000>;
> > +			opp-microvolt = <1060000 1060000 1300000>;
> > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > +		};
> > +
> >  		opp-816000000 {
> >  			opp-hz = /bits/ 64 <816000000>;
> >  			opp-microvolt = <1100000 1100000 1300000>;
> >  			clock-latency-ns = <244144>; /* 8 32k periods */
> >  		};
> >  
> > +		opp-912000000 {
> > +			opp-hz = /bits/ 64 <912000000>;
> > +			opp-microvolt = <1140000 1140000 1300000>;
> > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > +		};
> > +
> >  		opp-1008000000 {
> >  			opp-hz = /bits/ 64 <1008000000>;
> >  			opp-microvolt = <1200000 1200000 1300000>;
> >  			clock-latency-ns = <244144>; /* 8 32k periods */
> >  		};
> > +
> > +		opp-1104000000 {
> > +			opp-hz = /bits/ 64 <1104000000>;
> > +			opp-microvolt = <1240000 1240000 1300000>;
> > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > +		};
> > +
> > +		opp-1200000000 {
> > +			opp-hz = /bits/ 64 <1200000000>;
> > +			opp-microvolt = <1300000 1300000 1300000>;
> > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > +		};
> >  	};
> 
> IIRC U-Boot will start the CPU at 1008 MHz on the H3, so in the
> situation where a board doesn't list the regulators attached to the CPU,
> the kernel will happily use the 1104 and 1200 MHz frequencies, even
> though it won't adjust the voltage accordingly, causing errors.

Yeah, I know that. The u-boot running on the mentioned devices also have
these modifications, including a higher clocked DRAM (actually running at
624 MHz).

> The way we worked around that is to provide the extra OOPs in a separate
> DTSI so that the boards with regulator support can opt-in.

Oh, did I overlooked something? I was working on 4.14 up to 4.19 kernels
and may be a bit to eager to post the modifications.

greetings,
Will

> Maxime
> 
> >  
> >  	cpus {
> > -- 
> > 2.28.0
> > 
