Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB502C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BBC20A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xeYU70BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgEGJnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:43:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22384 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:43:01 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0479fPWk022718;
        Thu, 7 May 2020 11:42:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=C6VZfWVT/W089/elvBzkkxDMJ3kKhbKEFFjieRseRaI=;
 b=xeYU70BQt0Cv+Qih+qGvv2jPnN4Zf9PolFzyjnSKQep+ZqAw4I4wgc4RKnQt63gFf+m3
 WLrh1Y5NhNWtBPdyM+jJ+eFkYYWxUgCyrMalDGood79NHdCw0jk9pIYUMCGaA+O3rH/s
 gUD5BjqHtF+WDvGogqLZZmy7mv8cpny71SSoSNNvfoDWsuwyjYMiJ+UCJP7KczTgCUBu
 0Y201GQwZORG/Ah/8GIKhW1GcG+T8/8irKxeD3Pw/2gg+4ajJ1AdMG9Ga/QpdakrocaA
 3v+WVBDLt/NIgx4DCWqLa6ythpSlPviLP6pKpC3zDmDTfykYYw6K4+6rwPMRB1w78YL3 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rx08u41g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 11:42:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7632410002A;
        Thu,  7 May 2020 11:42:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67A3C2AC599;
        Thu,  7 May 2020 11:42:51 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 7 May
 2020 11:42:47 +0200
Subject: Re: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco
 board
To:     <dillon.minfei@gmail.com>, <mcoquelin.stm32@gmail.com>,
        <philippe.schenker@toradex.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <philippe.schenker@toradex.com>
 <1588842971-20495-1-git-send-email-dillon.minfei@gmail.com>
 <1588842971-20495-2-git-send-email-dillon.minfei@gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <67c1d18e-033d-30d5-3945-7985a03bf142@st.com>
Date:   Thu, 7 May 2020 11:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1588842971-20495-2-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_06:2020-05-05,2020-05-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dillon

On 5/7/20 11:16 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Enable the stmpe811 touch screen on stm32429-disco board.
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---

You have to add version to your patches. When you send updates of your 
patches, it is better to resend the whole series by adding [PATCH v2] 
... instead of [PATCH] (you can do it easily using git format-patch and 
subject-prefix). Then in your cover letter you have to explain changes 
between 2 series versions.

So please resend the whole series by adding V2 prefix, update 
cover-letter explaining changes, and add a title to your cover-letter 
please.

regards
alex



>   arch/arm/boot/dts/stm32f429-disco.dts | 47 +++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
> index 30c0f67..fad1ec1 100644
> --- a/arch/arm/boot/dts/stm32f429-disco.dts
> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
> @@ -49,6 +49,8 @@
>   #include "stm32f429.dtsi"
>   #include "stm32f429-pinctrl.dtsi"
>   #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>
>   
>   / {
>   	model = "STMicroelectronics STM32F429i-DISCO board";
> @@ -127,3 +129,48 @@
>   	pinctrl-names = "default";
>   	status = "okay";
>   };
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	stmpe811@41 {
> +		compatible = "st,stmpe811";
> +		reg = <0x41>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&gpioa>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
> +
> +		stmpe_touchscreen {
> +			compatible = "st,stmpe-ts";
> +			/* 8 sample average control */
> +			st,ave-ctrl = <3>;
> +			/* 7 length fractional part in z */
> +			st,fraction-z = <7>;
> +			/*
> +			 * 50 mA typical 80 mA max touchscreen drivers
> +			 * current limit value
> +			 */
> +			st,i-drive = <1>;
> +			/* 1 ms panel driver settling time */
> +			st,settling = <3>;
> +			/* 5 ms touch detect interrupt delay */
> +			st,touch-det-delay = <5>;
> +		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			/* forbid to use ADC channels 3-0 (touch) */
> +			st,norequest-mask = <0x0F>;
> +		};
> +	};
> +};
> 
