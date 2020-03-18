Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C895EC5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9581520757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584545020;
	bh=nkPUvBSmIHHgd9m0yImG18XAlre50qo46aqiiguVCrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gBgAqMfw4VQGXW8YYLj6OC+c4JUravuQShyfxi85Jc/4haT1i1UTWO0Qw2YuaOhUZ
	 tYqYQUJ0E+KkcxPqw1fDYc8kiFlh/dTEQB2hlJft6WwdaYF/JIHclD7OQ+FyPvbEY6
	 Xz3X1V+VzJ806FIvxZY1uiIjmYD8B7LMX6SOCQn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCRPXj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:23:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39104 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRPXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:23:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id a43so9586124edf.6;
        Wed, 18 Mar 2020 08:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o/P0A6ezH4SEJwDeuvTx7Zm75dRTOfNAGjM7Gto+Be4=;
        b=flTghI1W5Mmj1ocbRbrBeuM9H0tjl6rY3yO3nmRLKVgtAi+p/94fhUFJWe7UYBCWvC
         9w+j5a90756CSW25Blc7/h1cOSXPWdMAXlAZAFjRM0kB9Xh3FshlWOB0nSkV6u4G7S5m
         gqtUxUdBYSO9tOibrBoFAVl/pM/bUEBkAuR51QUMPHPNtmp7zTpuB4XNgT9WyUrPGKFp
         DzCA1nS5yFeF5qI8mScoywQvtTqJRz6GHo4rWhQuXww/RnZk4bzlbOBOGpVA8I4AVxyO
         46w/+v9TtZrAvYCbnqpcSdYy/mc8SM74BAxads83fBkR309GqLJ+KmBClPolRu4/HvV/
         NVfA==
X-Gm-Message-State: ANhLgQ1+BDcqHYnB5uEzCA9uDUfqJwcKpUU1e7ojxzxSuhy4hUTGyJEz
        KSNXxsQfPg1HZSV43ihsyfNkVRpI
X-Google-Smtp-Source: ADFU+vvlLB74JgRlXg+xDPlq4YvNZSuookChWiizS7jCejQkfzsJGQqnWGmzWtT6WtrTpus21OVJ/w==
X-Received: by 2002:a50:950b:: with SMTP id u11mr4435941eda.233.1584545016013;
        Wed, 18 Mar 2020 08:23:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id lc15sm363298ejb.58.2020.03.18.08.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 08:23:35 -0700 (PDT)
Date:   Wed, 18 Mar 2020 16:23:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stenkin Evgeniy <stenkinevgeniy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: DTS: Add devicetree file for the Galaxy S2
Message-ID: <20200318152322.GA4112@kozik-lap>
References: <20200312153411.13535-1-paul@crapouillou.net>
 <20200312153411.13535-2-paul@crapouillou.net>
 <20200313090011.GB7416@pi3>
 <20200318142543.C167520772@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200318142543.C167520772@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 03:25:22PM +0100, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> 
> Le ven. 13 mars 2020 à 10:00, Krzysztof Kozlowski <krzk@kernel.org> a écrit
> :
> > On Thu, Mar 12, 2020 at 04:34:11PM +0100, Paul Cercueil wrote:
> > >  From: Stenkin Evgeniy <stenkinevgeniy@gmail.com>
> > > 
> > >  Add devicetree file for the Exynos 4210 based Galaxy S2 (i9100
> > > version).
> > 
> > Thanks for the patch!
> > 
> > It is an GT-I9100.
> > 
> > +Cc Marek (I have few questions further)
> > 
> > 
> > > 
> > >  Signed-off-by: Stenkin Evgeniy <stenkinevgeniy@gmail.com>
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  ---
> > >   arch/arm/boot/dts/Makefile             |   1 +
> > >   arch/arm/boot/dts/exynos4210-i9100.dts | 816
> > > +++++++++++++++++++++++++
> > >   2 files changed, 817 insertions(+)
> > >   create mode 100644 arch/arm/boot/dts/exynos4210-i9100.dts
> > > 
> > >  diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > >  index d6546d2676b9..522436d30690 100644
> > >  --- a/arch/arm/boot/dts/Makefile
> > >  +++ b/arch/arm/boot/dts/Makefile
> > >  @@ -181,6 +181,7 @@ dtb-$(CONFIG_ARCH_EXYNOS3) += \
> > >   	exynos3250-monk.dtb \
> > >   	exynos3250-rinato.dtb
> > >   dtb-$(CONFIG_ARCH_EXYNOS4) += \
> > >  +	exynos4210-i9100.dtb \
> > >   	exynos4210-origen.dtb \
> > >   	exynos4210-smdkv310.dtb \
> > >   	exynos4210-trats.dtb \
> > >  diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts
> > > b/arch/arm/boot/dts/exynos4210-i9100.dts
> > >  new file mode 100644
> > >  index 000000000000..c218e34959be
> > >  --- /dev/null
> > >  +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> > >  @@ -0,0 +1,816 @@
> > >  +// SPDX-License-Identifier: GPL-2.0
> > >  +/*
> > >  + * Samsung's Exynos4210 based Galaxy S2 (i9100 version) device tree
> > 
> > Ditto
> > 
> > >  + *
> > >  + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> > >  + *		http://www.samsung.com
> > >  + * Copyright (c) 2020 Stenkin Evgeniy <stenkinevgeniy@gmail.com>
> > >  + * Copyright (c) 2020 Paul Cercueil <paul@crapouillou.net>
> > >  + *
> > >  + * Device tree source file for Samsung's Galaxy S2 smartphone
> > > (i9100 version),
> > >  + * which is based on Samsung's Exynos4210 SoC.
> > 
> > Duplicated description, you mentioned it before.
> > 
> > >  + */
> > >  +
> > >  +/dts-v1/;
> > >  +#include "exynos4210.dtsi"
> > >  +#include "exynos4412-ppmu-common.dtsi"
> > >  +
> > >  +#include <dt-bindings/gpio/gpio.h>
> > >  +#include <dt-bindings/input/linux-event-codes.h>
> > >  +
> > >  +/ {
> > >  +	model = "Samsung Galaxy S2 (i9100)";
> > 
> > GT-I9100
> > 
> > >  +	compatible = "samsung,i9100", "samsung,exynos4210",
> > > "samsung,exynos4";
> > 
> > I think it shares a lot with Trats board...
> > 
> > Marek, how similar these
> > designs are? Maybe it is worth to split some parts and make common part?
> > 
> > >  +
> > >  +
> > >  +	memory@40000000 {
> > >  +		device_type = "memory";
> > >  +		reg = <0x40000000 0x40000000>;
> > >  +	};
> > >  +
> > 
> > You do not have a chosen node, at least for stdout serial selection.
> > Probably you should have one... bootargs I guess could come from
> > bootloader.
> > 
> > 
> > >  +	vemmc_reg: regulator-0 {
> > >  +		compatible = "regulator-fixed";
> > >  +		regulator-name = "VMEM_VDD_2.8V";
> > >  +		regulator-min-microvolt = <2800000>;
> > >  +		regulator-max-microvolt = <2800000>;
> > >  +		gpio = <&gpk0 2 GPIO_ACTIVE_HIGH>;
> > >  +		enable-active-high;
> > 
> > This looks like a stub/fake regulator. Probably it shoould be replaced
> > with proper regulator coming from PMIC (few seems to be missing there).
> > 
> > I don't have the schematics so I cannot judge... I see Trats has the
> > same.
> > 
> > Marek, mayybe you know, is it really a separate regulator?
> > 
> > >  +	};
> > >  +
> > >  +	tsp_reg: regulator-1 {
> > >  +		compatible = "regulator-fixed";
> > >  +		regulator-name = "TSP_FIXED_VOLTAGES";
> > >  +		regulator-min-microvolt = <3300000>;
> > >  +		regulator-max-microvolt = <3300000>;
> > >  +		gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
> > >  +		startup-delay-us = <70000>;
> > >  +		enable-active-high;
> > >  +		regulator-boot-on;
> > >  +		regulator-always-on;
> > 
> > always-on and boot-on should not be needed. You have a consumer for this
> > regulator.
> 
> About this: the touchscreen driver does not use a regulator, so I believe
> that's why these properties were here.
> 
> I sent patches upstream to address the issue:
> https://lkml.org/lkml/2020/3/15/94
> 
> I believe this means I cannot merge the i9100 devicetree until it is acked.

This can stay because it is correct with current bindings and driver.
However you should remove avdd-supply/vdd-supply from touchscreen node
because they are not used/supported.

You can re-add them once bindings get accepted.

Best regards,
Krzysztof
