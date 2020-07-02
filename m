Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28927C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072D320663
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593669610;
	bh=pa1KsL0wFxiWclLRmFHMJNlSNaoiIY/uIWQHhzSE9PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1jrX3Q1lUh5QKlAc+OLgIY4scysFUb/iOgemz6LdPg2+tOQfZ/qHFSbPLf/qBf7bl
	 6kKjT8iq8WJgt7BP/oM2A3D0pSl0C+W27/rsSgCa+yPG0sS8Ikviu6gn2z30cH/YKp
	 QsONIU2OUL4RnU9/7hXTpVRktGGaVDEugIIdtmmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgGBGAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:00:08 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:34524 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGBGAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:00:07 -0400
Received: by mail-ej1-f67.google.com with SMTP id y10so27771404eje.1;
        Wed, 01 Jul 2020 23:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+0TJgtyGdUFAif3iB9nD6dvgm5MlSiy6/23tSnNTIE=;
        b=Szt6ZAUsoH7wTylBmI4oLzLcqpYwmPiyPx17U3uC5RD97hpLmvIIOgSacZOnaJmGVj
         ENXsM32uf0pCnh+dWved370AShpXNwCn1XNdvwkYU7CeFzpG9yEWLH+tYVShNp3Yl1Aj
         OpsdSRl57F3jPiuZInPTAXeja98mSsAHTSI+oGvzkxKyT6noPoNiXCfOnl/09ObIMh5t
         wqyocZKuPJ+aTNo7z7tzl4bOD0TDX//AGzPf8xdWt2hekBR9kx4k3JSwLBfdPipuIGnO
         v3A7Mv1LKtl9TDJ+dLAc4khaITIybhITdpte08qG2LWsPvwwhQHXb/0Lwp7+ZG+jwYp/
         0OAg==
X-Gm-Message-State: AOAM531aMuwXT2rxao0sxRGZC+6CrnoR/bcx9GVfF5SBOplMfWpaVVe3
        cwQV11oi8YbBdModKnWbh/Z6vyV1
X-Google-Smtp-Source: ABdhPJx+92owXVBEj1k0uFeSCkezcOnNF9loDGUYXY+ITfPZQt/zwwOX52FKrdde00pwe9p9ip6TWQ==
X-Received: by 2002:a17:906:a1c7:: with SMTP id bx7mr20452601ejb.388.1593669605407;
        Wed, 01 Jul 2020 23:00:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id a37sm8647592edf.86.2020.07.01.23.00.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jul 2020 23:00:04 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:00:02 +0200
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Kukjin Kim' <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Marek Szyprowski' <m.szyprowski@samsung.com>,
        'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>,
        'Sylwester Nawrocki' <snawrocki@kernel.org>,
        'Chanwoo Choi' <cw00.choi@samsung.com>,
        'Pankaj Dubey' <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 1/4] arm64: dts: exynos: Add PWM interrupts on Exynos7
Message-ID: <20200702060002.GA4175@kozik-lap>
References: <CGME20200629205534epcas5p33eb7cbdff4aee986d2e509e0c79cf952@epcas5p3.samsung.com>
 <20200629204442.17336-1-krzk@kernel.org>
 <001101d64ef2$8f824620$ae86d260$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001101d64ef2$8f824620$ae86d260$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 08:54:28PM +0530, Alim Akhtar wrote:
> Hi Krzysztof,
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 30 June 2020 02:15
> > To: Rob Herring <robh+dt@kernel.org>; Kukjin Kim <kgene@kernel.org>;
> > Krzysztof Kozlowski <krzk@kernel.org>; devicetree@vger.kernel.org;
> linux-arm-
> > kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>; Bartlomiej Zolnierkiewicz
> > <b.zolnierkie@samsung.com>; Sylwester Nawrocki <snawrocki@kernel.org>;
> > Alim Akhtar <alim.akhtar@samsung.com>; Chanwoo Choi
> > <cw00.choi@samsung.com>; Pankaj Dubey <pankaj.dubey@samsung.com>
> > Subject: [PATCH 1/4] arm64: dts: exynos: Add PWM interrupts on Exynos7
> > 
> > Add required interrupts to PWM node on Exynos7.  This fixes DT schema
> > warning:
> > 
> >     pwm@136c0000: 'interrupts' is a required property
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Not tested
> > ---
> >  arch/arm64/boot/dts/exynos/exynos7.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> > b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> > index f590891efe25..523547b3d539 100644
> > --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> > +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> > @@ -581,6 +581,11 @@
> >  		pwm: pwm@136c0000 {
> >  			compatible = "samsung,exynos4210-pwm";
> >  			reg = <0x136c0000 0x100>;
> > +			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>;
> PWM IRQs are from 449 ~ 453 for PWM[0] ~ PWM[4] on this SoC.
> 444 ~ 447 are for HSI2C and 448 is for ADC.

Ah, indeed.

> Please see the exynos7.dtsi
> Also drivers/pwm/pwm-samsung.c does not uses interrupt at all, still we need
> interrupts property to be added here?

That's a good point. For S3C SoCs the PWM timer was used also as a
clocksource so it required interrupts. But since Exynos this is not
used.  I don't know why the bindings introduced required interrupts...
It seems it would be better just to remove them from bindings and DTS.

Best regards,
Krzysztof

