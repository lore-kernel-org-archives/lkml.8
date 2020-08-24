Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E753C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC172071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598266399;
	bh=cTeo0zWq2ywPS3zyZESGXSQGBCrunzsym3wsfcZXJmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TvYuRZWd1fDRU8Lrt3OwPsx3+h85zdjyhDnEsWMFpF7HHoXQiW9JX92+orOmllxsR
	 pqufZjuPtdOoIZFWHL34AHAG2gTsTalDwCvUQ7d5y6b3plp7lwilyIeKjK7P26WdFh
	 0y69kWE0e9ljYYKN+xdwHi+K8aK2Dk7hkCaEBiI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHXKxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:53:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36687 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHXKxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:53:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id b66so5443230wmb.1;
        Mon, 24 Aug 2020 03:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tUXtK9Uo1WfECoGzPEeRZ8dUOgvco4xZiJV1j3yK2Y=;
        b=KJfa5XMoviMpfpxHxveMMsX1Z/NCgcZ0qRXS8U1RX+CqqsC49enqGycEGlBzHFiLD6
         bCsTi5y8k7H/EWkL0W+YQ2wMYKSijA5FOwZdJ3CHGGdQx7gSo4DHciN4dWkn+o7qdSzR
         1KDDZivwgkKxYUeO+Z1hB2NY8BrR8KwidZYZTLOD8sPMkrx+35feHNHt79eavZCax4Zi
         KF1NpV2XyppC7+bKcbDDcorzi0nm65/3l0XAdrWEnq3dEvgxeRYLgMZGZarnBRwUiwDU
         i751KbwWbhirN32eyTDt7lmljmlJMkExX1iD3CXM7zALw4dYFfzjLQDtug214viVT+Xw
         n8CQ==
X-Gm-Message-State: AOAM531kS1MoxmDEDZfOIFtXsa8o+mdtNKfLg5cvbmKzse0C4FFpDQ6I
        mCOKDjUIF67Wu+zsRzKGLXs=
X-Google-Smtp-Source: ABdhPJxWWIX9hAxIRnMQN/xNYUKKY4EpLDyOC668+DgpUXg2I6pfWXrVb3ipIlX9lnWcCo3YPXiVDQ==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr5187679wmj.137.1598266386477;
        Mon, 24 Aug 2020 03:53:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m1sm22881072wmc.28.2020.08.24.03.53.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:53:05 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:53:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>
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
Message-ID: <20200824105303.GA32211@kozik-lap>
References: <20200817070120.4937-1-krzk@kernel.org>
 <20200817070120.4937-4-krzk@kernel.org>
 <20200823020051.GJ30094@dragon>
 <20200823085847.GC2886@kozik-lap>
 <20200824104718.GC12776@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824104718.GC12776@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:47:19PM +0800, Shawn Guo wrote:
> On Sun, Aug 23, 2020 at 10:58:47AM +0200, Krzysztof Kozlowski wrote:
> > On Sun, Aug 23, 2020 at 10:00:51AM +0800, Shawn Guo wrote:
> > > On Mon, Aug 17, 2020 at 09:01:20AM +0200, Krzysztof Kozlowski wrote:
> > > > Add a DTS for Variscite Symphony evaluation kit with VAR-SOM-MX8MM
> > > > System on Module.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > 
> > > > ---
> > > > 
> > > > Changes since v1:
> > > > 1. Remove duplicated "leds" node,
> > > > 2. Fix heartbeat to active low,
> > > > 3. Add nxp,ptn5150 extcon.
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > > >  .../dts/freescale/imx8mm-var-som-symphony.dts | 248 ++++++++++++++++++
> > > >  2 files changed, 249 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > > index a39f0a1723e0..dcfb8750cd78 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
> > > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> > > >  
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > > > new file mode 100644
> > > > index 000000000000..2d3c30ac5e04
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > > > @@ -0,0 +1,248 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "imx8mm-var-som.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "Variscite VAR-SOM-MX8MM Symphony evaluation board";
> > > > +	compatible = "variscite,var-som-mx8mm-symphony", "variscite,var-som-mx8mm", "fsl,imx8mm";
> > > > +
> > > > +	reg_usdhc2_vmmc: regulator-1 {
> > > 
> > > regulator-usdhc2-vmmc
> > 
> > You mean the node name? If so, it's not correct with device tree
> > specification:
> > "The node-name (...) should describe the general class of device.:
> > If appropriate, the name should be one of the following choices:
> > (...)
> >  - regulator"
> > 
> > Adding specific function/type/usage to the name of the node is a
> > opposite choice to "general class".
> 
> Well, the node is named in general class, i.e. regulator-xxx, and we
> would like the suffix to be a bit more specific.  We have been using
> this name schema for fixed-regulator on i.MX platforms for long time.

Name "regulator-usdhc2-vmmc" is not general, it is specific. The DT
specification gives the example of generic name and it is "regulator".

It is the same with CPU nodes having names "cpu@0", not "cpu-a53@0" or
whatever other suffix. It is the same reason why I2C is "i2c@12345678",
not "i2c_1@" or "i2c_for_abcd".

The suffix is not needed as Linux does not use it (instead uses
regulator-name which is specific). Humans on the other hand can
understand the specifics from the label and from the regulator name.
Therefore they also do not need the suffix.

I know that other i.MX DTSes follow this pattern but it is still not the
recommended one. It's a pattern which should be replaced.

Anyway, if the names of regulators stop this patch from being applied, I
will change them to expected.

Best regards,
Krzysztof

