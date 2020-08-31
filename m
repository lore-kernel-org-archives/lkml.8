Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D378C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C9B2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYYSC4hY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgHaRGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgHaRGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:06:20 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CBEC061573;
        Mon, 31 Aug 2020 10:06:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l23so6122515edv.11;
        Mon, 31 Aug 2020 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u4sKpJRBaQSUXgG3D6yX9pvNnzDpclOknSCxOcHgR7c=;
        b=gYYSC4hYqEORnDcxwSsnSWRBf3ioYjiJ3xLqskImUlkf9jryYq5DWuPxdtFtHmGd6F
         CH9GULdP3JJjBC5ZgWaPjCRqmoYgtokuZmvIWJmNjc6EjrX/3P7ox7YP/AHdjSbiSYKM
         GbDrv/yHMJY6uLr0fowgqm8Mo7gm6Zo4+ouX1iyOd4RVB3NVDE71ow8qG3KiTOVqLUqa
         btBlVX9TrYbFyz/+wQHEbtirDdi0/P1DqCeiI2ereAw48vXA/xS1UrpRGuo5c3/GDKEI
         dgrpQAxQqUwfjXAjak4xjU0kGojxsz5jW89xd19ghRqYQquEW18TQAdzZWWOPYMssRME
         w1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u4sKpJRBaQSUXgG3D6yX9pvNnzDpclOknSCxOcHgR7c=;
        b=Pe9qf7dc4XNYRUlQE+IXi9bO6+tix9LGPpuI6mDbbXjKkkZE3hbrOIkDWt87IYjagu
         eAW4/0XaSsgUpi36R1zkm0Cdlve86y1J11b6gnqSsz2TED/O4R4OeRPjYLGI75jkgEix
         ZHs7BZCsblgy4N+P+LR2X32dc1vQnX1vAMxxeNCk7n9Z5ckVIzqG5VvtErOp3+xDD2rS
         H2AJ8EcUThcgA+kzu0GDIT8ZCyZCMB+jCgNYAQX15m7UcCzMXoczQigKgFZWX01oJZgp
         FIvqeKrAwgG4RYDWXdTeM4NWMT9vqSrJMdt0tzvgNXGrkMhJoCFkhRBgoFWWc4Zc2H3H
         sUww==
X-Gm-Message-State: AOAM530Jq9ne0neowCDX2pNjcoy+0N8sbuNgAG3BaXO3b2lvX35YhQj9
        4+HCnlBV7vxg8ox4GxJ1qpE=
X-Google-Smtp-Source: ABdhPJydJI4mOY5eMb7W8MUzEfAXm3D6CazcHI5jOSApGYesoRPd1Pl94XA/SpLRu0LMoRSBHzmwWw==
X-Received: by 2002:a50:fc04:: with SMTP id i4mr2063666edr.14.1598893578432;
        Mon, 31 Aug 2020 10:06:18 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id k6sm7238260ejr.104.2020.08.31.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:06:17 -0700 (PDT)
Date:   Mon, 31 Aug 2020 20:06:15 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 4/4] arm: dts: owl-s500: Add RoseapplePi
Message-ID: <20200831170615.GB2551342@BV030612LT>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
 <5a6fc55341b346439ba32b5a3e14087edbaa6226.1598621459.git.cristian.ciocaltea@gmail.com>
 <20200831092648.GD4154@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831092648.GD4154@mani>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 02:56:48PM +0530, Manivannan Sadhasivam wrote:
> On 0828, Cristian Ciocaltea wrote:
> > Add a Device Tree for the RoseapplePi SBC.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Cristi

> Thanks,
> Mani
> 
> > ---
> >  arch/arm/boot/dts/Makefile                 |  1 +
> >  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 47 ++++++++++++++++++++++
> >  2 files changed, 48 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 4572db3fa5ae..bff9ef996fbb 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -868,6 +868,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
> >  dtb-$(CONFIG_ARCH_ACTIONS) += \
> >  	owl-s500-cubieboard6.dtb \
> >  	owl-s500-guitar-bb-rev-b.dtb \
> > +	owl-s500-roseapplepi.dtb \
> >  	owl-s500-sparky.dtb
> >  dtb-$(CONFIG_ARCH_PRIMA2) += \
> >  	prima2-evb.dtb
> > diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > new file mode 100644
> > index 000000000000..a2087e617cb2
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Roseapple Pi
> > + *
> > + * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "owl-s500.dtsi"
> > +
> > +/ {
> > +	compatible = "roseapplepi,roseapplepi", "actions,s500";
> > +	model = "Roseapple Pi";
> > +
> > +	aliases {
> > +		serial2 = &uart2;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial2:115200n8";
> > +	};
> > +
> > +	memory@0 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x80000000>; /* 2GB */
> > +	};
> > +
> > +	uart2_clk: uart2-clk {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <921600>;
> > +		#clock-cells = <0>;
> > +	};
> > +};
> > +
> > +&twd_timer {
> > +	status = "okay";
> > +};
> > +
> > +&timer {
> > +	clocks = <&hosc>;
> > +};
> > +
> > +&uart2 {
> > +	status = "okay";
> > +	clocks = <&uart2_clk>;
> > +};
> > -- 
> > 2.28.0
> > 
