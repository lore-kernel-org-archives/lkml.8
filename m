Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A531CC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3F220842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="SKsdT2gG";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="eudbFuiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgAJRhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:37:31 -0500
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:34506 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbgAJRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:37:31 -0500
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AHaW0v003446
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 17:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=xzWn1OMg/kRBdPGY5cSYHXjxrtR25cVLedpzVE8XDTg=;
 b=SKsdT2gGEEFjWm1OQs24C9xp18p7AQ8nXeW7wBy0MdVcQvkx8mmsnwOjQadzeLaFc5oZ
 6Bkt0NhzFQeQt3p2NR2JFyrE50JZVeKz5et+SDg1d7gyIoxGObSzdgfQisqexzVMb2Pl
 KmS51h4bTAbDO/P7rGw8d+wHaBsyqw/bd4i8MMqurPVC0ehdo8Wnjyiz0+NPesa0l77S
 +NF9ntLnzu081++BYRsnWcxI0xh5x6vat0n9rb/oMAS7388FCuXU7a+Y9hy89SsVkHGh
 DtXDQFqCgDGakfVSGXZjlE/DpbSZZ856j5r9Qpsr6x1QCdAGsaR2M1rUz3EtsoRIBfOQ aw== 
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        by mx08-00252a01.pphosted.com with ESMTP id 2xag2su2hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 17:37:29 +0000
Received: by mail-wm1-f71.google.com with SMTP id h130so1120330wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xzWn1OMg/kRBdPGY5cSYHXjxrtR25cVLedpzVE8XDTg=;
        b=eudbFuiFpxiYBXsumIrZk5v2K0RcDambijz9CR6j4vfIhiv09EPkoC4Iap4aOXhjY+
         e+apgz4raC1u6K55M2t+JqSWdpUTU/zP/n9j7vF7ORpWW6Zlu5RnTlpFfvNX+U4ji1lw
         dKpMDCFcBBdGskvbgur3sLBTJFj7Sa2nq4DTeo56U2IhqUIvRnxA0otUH4DD9ExXC9hh
         COAU07dXao/SesrTu7gpROWkTTOKgKv+F9qYoA3m5/gCd9YGfmN0+ktaUGgeZAg6C6uo
         iMEHthpBZop+6pORS/khftnO2rEEOlIYRx+oCuEjF1fI24AeJA+DHXQAitgdsCaGXuzZ
         VuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xzWn1OMg/kRBdPGY5cSYHXjxrtR25cVLedpzVE8XDTg=;
        b=c6uNZf+D+nUfODFx0Q5jghPuaSVHKFURDt74pK/xiySZXaXwILfBp1MoA3A+kK3l7M
         KJ/33bM8LBHU5ETD148Kck0g6TCVYfx9RhzoZsJo3gfCuM+7gzrVFq4Vt3kLpaT6cYV9
         Jxxrlr28YItt4o8KoTrVLJGG2WweOW2VXbvSwLuXVATJvfvcU6NjRqKn0fpAiGP/g4qX
         spw39TeGFz8mPIK3sNRZParlmlbS+6SO4ChV+f5gelN7bzX1QjpA5bVH/n2KN51SwqFY
         bcAqCf0XzehTGAFB+e8yqnVE+OS6SoLIaz92YP1rrZVqOYoSPsjlZg7jfyI93isf+v0f
         NZLw==
X-Gm-Message-State: APjAAAXwmbUB1ch28RYncnD2JyViPQTXoUYNxDN+OO/nuGHm6JDMD/YX
        UpXyyzFXaP+MhDn/8Q+7UMb5Cc1bypJX/8BzC9lj60iBeo8e4w2k7fFMCrti9yI069epfBWrvwm
        1bu/VV2YTHxsIknMuA528N6gK
X-Received: by 2002:a5d:5091:: with SMTP id a17mr4687590wrt.362.1578677848173;
        Fri, 10 Jan 2020 09:37:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqx44UlbuVmiPyz5iGzy41EJVez9kdBqhJkQVvHkfelCDcd0A4HMd0i0npDRAlfsoN/TmkGfzg==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr4687563wrt.362.1578677847921;
        Fri, 10 Jan 2020 09:37:27 -0800 (PST)
Received: from ?IPv6:2a00:1098:3142:14:910a:522a:cf5c:edd0? ([2a00:1098:3142:14:910a:522a:cf5c:edd0])
        by smtp.gmail.com with ESMTPSA id d14sm3100880wru.9.2020.01.10.09.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 09:37:27 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: bcm283x: Unify CMA configuration
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200110172935.19709-1-nsaenzjulienne@suse.de>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <c5bb42a8-e1c2-3e21-dc1d-d36a069bf97f@raspberrypi.org>
Date:   Fri, 10 Jan 2020 17:37:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110172935.19709-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 10/01/2020 17:29, Nicolas Saenz Julienne wrote:
> With the introduction of the Raspberry Pi 4 we were forced to explicitly
> configure CMA's location, since arm64 defaults it into the ZONE_DMA32
> memory area, which is not good enough to perform DMA operations on that
> device. To bypass this limitation a dedicated CMA DT node was created,
> explicitly indicating the acceptable memory range and size.
> 
> That said, compatibility between boards is a must on the Raspberry Pi
> ecosystem so this creates a common CMA DT node so as for DT overlays to
> be able to update CMA's properties regardless of the board being used.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> If this doesn't make it into v5.5 I'd be tempted to add:
> Fixes: d98a8dbdaec6 ("ARM: dts: bcm2711: force CMA into first GB of memory")
> 
>   arch/arm/boot/dts/bcm2711.dtsi | 33 +++++++++++++--------------------
>   arch/arm/boot/dts/bcm283x.dtsi | 13 +++++++++++++
>   2 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> index 8687534d4528..c8e4041308e0 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -12,26 +12,6 @@ / {
>   
>   	interrupt-parent = <&gicv2>;
>   
> -	reserved-memory {
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		/*
> -		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
> -		 * that's not good enough for the BCM2711 as some devices can
> -		 * only address the lower 1G of memory (ZONE_DMA).
> -		 */
> -		linux,cma {
> -			compatible = "shared-dma-pool";
> -			size = <0x2000000>; /* 32MB */
> -			alloc-ranges = <0x0 0x00000000 0x40000000>;
> -			reusable;
> -			linux,cma-default;
> -		};
> -	};
> -
> -
>   	soc {
>   		/*
>   		 * Defined ranges:
> @@ -869,6 +849,19 @@ pin-rts {
>   	};
>   };
>   
> +&rmem {
> +	#address-cells = <2>;
> +};
> +
> +&cma {
> +	/*
> +	 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
> +	 * that's not good enough for the BCM2711 as some devices can
> +	 * only address the lower 1G of memory (ZONE_DMA).
> +	 */
> +	alloc-ranges = <0x0 0x00000000 0x40000000>;
> +};
> +
>   &i2c0 {
>   	compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
>   	interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 839491628e87..6128baed83c2 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -30,6 +30,19 @@ chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> +	rmem: reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		cma: linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x4000000>; /* 64MB */
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +
>   	thermal-zones {
>   		cpu_thermal: cpu-thermal {
>   			polling-delay-passive = <0>;
> 

For what it's worth,

Reviewed-by: Phil Elwell <phil@raspberrypi.org>

Phil
