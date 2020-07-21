Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C705DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C69208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zv/sNEUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGUHQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:16:16 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19422 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgGUHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:16:16 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06L77RKS010258;
        Tue, 21 Jul 2020 09:16:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=73dAVS9zUnqZ8WATP62hAGazNOj36cZliVUS8oX7h4U=;
 b=zv/sNEUL05QFtuyXeubVy9UghJ47mfJ+LITSloTtydnx8AyIyOUG90UXZDK5nh6WlYj4
 yCGAMF4CrYHmVG8tPA5lDMnXLLjhU3fouCZXgYuJBnUEDeiVPiylOXf7ncEAI5rhGhde
 Ab6eUKuu8qTh9IC0Yvyq4MzBMrXZHHnjrMQDOcxXj5OTlwn7iN/kqXTObosvjFYfIUpn
 5w/82ZpxNwgbePUmSVpJt/pV5mXw8iLDVSDCnOhy6mnjC/tiu31tJxRmVXbHAYlH9Xq3
 J/lvBl+eUZTeAdV05MAZZI0sYAnddRZp97gdGAXmXQoIwC/x6Ah3bySZUHqpH+dnXeZJ 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsfpcana-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 09:16:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF3FB10002A;
        Tue, 21 Jul 2020 09:16:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF0CA220CCB;
        Tue, 21 Jul 2020 09:16:02 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 Jul
 2020 09:16:02 +0200
Subject: Re: [PATCH] ARM: dts: stm32: cosmetic update in
 stm32mp15-pinctrl.dtsi
To:     Patrick Delaunay <patrick.delaunay@st.com>,
        <linux-kernel@vger.kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200616153329.15148-1-patrick.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b18bd7f8-f63c-13ad-6220-f7745600a7a6@st.com>
Date:   Tue, 21 Jul 2020 09:16:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200616153329.15148-1-patrick.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_02:2020-07-21,2020-07-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick

On 6/16/20 5:33 PM, Patrick Delaunay wrote:
> Use tabs where possible and remove multiple blanks lines.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
> ---
> 
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 

Applied on stm32-next.

Thanks.
Alex

> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index 7eb858732d6d..7d351757f2f8 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -210,8 +210,8 @@
>   				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_TXD3 */
>   				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RGMII_TX_CTL */
>   				 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH_MDC */
> -			         <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
> -			         <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
> +				 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
> +				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
>   				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RGMII_RXD1 */
>   				 <STM32_PINMUX('H', 6, ANALOG)>, /* ETH_RGMII_RXD2 */
>   				 <STM32_PINMUX('H', 7, ANALOG)>, /* ETH_RGMII_RXD3 */
> @@ -453,7 +453,7 @@
>   	i2c5_pins_b: i2c5-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 0, AF4)>, /* I2C5_SCL */
> -			         <STM32_PINMUX('D', 1, AF4)>; /* I2C5_SDA */
> +				 <STM32_PINMUX('D', 1, AF4)>; /* I2C5_SDA */
>   			bias-disable;
>   			drive-open-drain;
>   			slew-rate = <0>;
> @@ -463,7 +463,7 @@
>   	i2c5_sleep_pins_b: i2c5-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 0, ANALOG)>, /* I2C5_SCL */
> -			         <STM32_PINMUX('D', 1, ANALOG)>; /* I2C5_SDA */
> +				 <STM32_PINMUX('D', 1, ANALOG)>; /* I2C5_SDA */
>   		};
>   	};
>   
> @@ -1072,7 +1072,6 @@
>   		};
>   	};
>   
> -
>   	sai2a_pins_b: sai2a-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('I', 6, AF10)>,	/* SAI2_SD_A */
> 
