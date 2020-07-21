Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB27C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6C520714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="z2zQJ+0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgGUIdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:33:07 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30288 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbgGUIdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:33:06 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06L8HNEJ015522;
        Tue, 21 Jul 2020 10:32:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=CibemXE2ARvrszMiSzpsNnNZsBGP7TWt0eJ8XHPZ0IM=;
 b=z2zQJ+0Yz2nGqPF6BaMqzl7aDjRaG9/1rG6VVL1nAvtQKxr3AoE1+NJVgANpqmVns7Zc
 Znr6mSWJyOhQs8MgZT7HVpocAXrxYbicmpFYQ47MBL6C6vvAofOivCU+EgWxLY/VeagZ
 zXhLSfklIqtQvc4LxYNQTG2m7583LnJ8EdXEacti7odutBlA9GYkIyAWVwFdNFrUgC+T
 LI4WKw2oXSwGmxAV6mcTkIfD7KVwDdWcFu26qyO6F2niDVv7tk0IT/9tMjoYH889HPdx
 eQVRs8vtrrwIFPUC+eECtNVI8+Y02GddXg8iGJW2Rs/DDfZjmsAN7Z+sjy2rAXkKY/UQ Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsfpcphg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:32:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB1E3100034;
        Tue, 21 Jul 2020 10:32:55 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ABCF62A614B;
        Tue, 21 Jul 2020 10:32:55 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 Jul
 2020 10:32:55 +0200
Subject: Re: [PATCH] ARM: dts: stm32: Correct spi4 pins in
 stm32mp15-pinctrl.dtsi
To:     Patrick Delaunay <patrick.delaunay@st.com>,
        <linux-kernel@vger.kernel.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200708114324.7309-1-patrick.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <3cc829c2-8d9f-d053-7330-7ac0a83436d1@st.com>
Date:   Tue, 21 Jul 2020 10:32:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708114324.7309-1-patrick.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_02:2020-07-21,2020-07-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick

On 7/8/20 1:43 PM, Patrick Delaunay wrote:
> Move spi4_pins_a nodes from pinctrl_z to pinctrl
> as the associated pins are not in BANK Z.
> 
> Fixes: 498a7014989dfdd9a47864b55704dc829ed0dc90
> Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
> ---
> 

Applied on stm32-next by updating Fixes tag.

Thanks
Alex

>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 28 ++++++++++++------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index 7eb858732d6d..6aedbd7077ff 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1574,6 +1574,20 @@
>   		};
>   	};
>   
> +	spi4_pins_a: spi4-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
> +				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
> +			bias-disable;
> +		};
> +	};
> +
>   	usart2_pins_a: usart2-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
> @@ -1776,18 +1790,4 @@
>   			bias-disable;
>   		};
>   	};
> -
> -	spi4_pins_a: spi4-0 {
> -		pins {
> -			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
> -				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
> -			bias-disable;
> -			drive-push-pull;
> -			slew-rate = <1>;
> -		};
> -		pins2 {
> -			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
> -			bias-disable;
> -		};
> -	};
>   };
> 
