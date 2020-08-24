Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097A2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E6E2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598266061;
	bh=G1EuT7WRdVE2XHuuoDboS9gTa7E+TX7S2m2v/JaoZTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DglK2jG+UtLpTq3wT6FIJUuVDc3KXGhfmZdwTdXkRxUkFvxv05wg39sCZssMxH6cn
	 Mm2Zv0weC4VtAsgF6nYGPwpY+ttXyDFe1uC2yKKcfeh/rk3+9DLcCY5pDfCXxM+BRc
	 INJvpkbnLkUevbQHdEr2EsY6psEpGY1LOG0E6DxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHXKrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgHXKrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:47:35 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF57F2071E;
        Mon, 24 Aug 2020 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598266054;
        bh=G1EuT7WRdVE2XHuuoDboS9gTa7E+TX7S2m2v/JaoZTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/6rJ9cDMEh8WN0Di+Ss8+wulQMZcrXJZ0RtbJ2Vrqj5eS7W1BzvgoSEphYrUwT6g
         ovdc8a8Scnywli4DYjN6NP+FsiIvAf0m4qROJ2f25yKKjb6HBg4B4XZjUFfeFYgCBm
         1681B+Y0+T30BwX6IYJJ4CqYVscfn7ZLEeKU5dAc=
Date:   Mon, 24 Aug 2020 18:47:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] arm64: dts: imx8mm-var-som-symphony: Add
 Variscite Symphony board with VAR-SOM-MX8MM
Message-ID: <20200824104718.GC12776@dragon>
References: <20200817070120.4937-1-krzk@kernel.org>
 <20200817070120.4937-4-krzk@kernel.org>
 <20200823020051.GJ30094@dragon>
 <20200823085847.GC2886@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823085847.GC2886@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 10:58:47AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Aug 23, 2020 at 10:00:51AM +0800, Shawn Guo wrote:
> > On Mon, Aug 17, 2020 at 09:01:20AM +0200, Krzysztof Kozlowski wrote:
> > > Add a DTS for Variscite Symphony evaluation kit with VAR-SOM-MX8MM
> > > System on Module.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > 
> > > ---
> > > 
> > > Changes since v1:
> > > 1. Remove duplicated "leds" node,
> > > 2. Fix heartbeat to active low,
> > > 3. Add nxp,ptn5150 extcon.
> > > ---
> > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > >  .../dts/freescale/imx8mm-var-som-symphony.dts | 248 ++++++++++++++++++
> > >  2 files changed, 249 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > index a39f0a1723e0..dcfb8750cd78 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
> > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> > >  
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > > new file mode 100644
> > > index 000000000000..2d3c30ac5e04
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > > @@ -0,0 +1,248 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "imx8mm-var-som.dtsi"
> > > +
> > > +/ {
> > > +	model = "Variscite VAR-SOM-MX8MM Symphony evaluation board";
> > > +	compatible = "variscite,var-som-mx8mm-symphony", "variscite,var-som-mx8mm", "fsl,imx8mm";
> > > +
> > > +	reg_usdhc2_vmmc: regulator-1 {
> > 
> > regulator-usdhc2-vmmc
> 
> You mean the node name? If so, it's not correct with device tree
> specification:
> "The node-name (...) should describe the general class of device.:
> If appropriate, the name should be one of the following choices:
> (...)
>  - regulator"
> 
> Adding specific function/type/usage to the name of the node is a
> opposite choice to "general class".

Well, the node is named in general class, i.e. regulator-xxx, and we
would like the suffix to be a bit more specific.  We have been using
this name schema for fixed-regulator on i.MX platforms for long time.

Shawn
