Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67636C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B46205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pzKPTnjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgDULRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:17:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24956 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgDULRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:17:24 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LBC8lR025528;
        Tue, 21 Apr 2020 13:17:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=/c16tCY9ekQ35yC4luKxDhPkTxyEHJ14jZb/3fcZqkE=;
 b=pzKPTnjr6v2ZLEYjerQsEGRihro9YwPNcBh8DzpgozrlZcahPHcTbC36jXENi6xHwubV
 AttYW5Cymhc0xgMay9GU+9f/TTIN30xsSZTZnwS5SbjfOiIXiDdBbPPtEnbRRbU2ou3e
 suUD5EO2R2ozzGKmZP9AgTbPJMPPu59Pq0/+S5eijEsrN64l4c018FtiZwGilTNVQAaL
 SV6WLQlKVSMjoLOSyJK4prUd+xKeEKEJ+VZAHs5oOqsMARgGSsHENQMnlJv+J4QuRr9i
 lVxbV9mAexlrsu0LuX9h23Vt2pTuEs2B4ZtwMniZ/tToVkWqBDKlY57SwWI0RcYj3Lok +g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fpp8qx6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 13:17:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE7FF10003B;
        Tue, 21 Apr 2020 13:17:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9EFB02ADA0F;
        Tue, 21 Apr 2020 13:17:10 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 Apr
 2020 13:17:04 +0200
Subject: Re: [PATCH 2/6] ARM: dts: Add missing pinctrl entries for STM32MP15
To:     <mani@kernel.org>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200420173124.27416-1-mani@kernel.org>
 <20200420173124.27416-3-mani@kernel.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <2241c327-7cd6-7abd-b94f-00abe43b97e1@st.com>
Date:   Tue, 21 Apr 2020 13:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200420173124.27416-3-mani@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_04:2020-04-20,2020-04-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani

Commit title should be ARM: dts: stm32 ...
otherwise it's good.

regards
alex

On 4/20/20 7:31 PM, mani@kernel.org wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> These pinctrl definitions will be used by Stinger96/IoTBox boards
> from Shiratech.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 64 ++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index aeddcaadb829..858c83038e5a 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1519,6 +1519,30 @@
>   		};
>   	};
>   
> +	usart2_pins_b: usart2-1 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
> +				 <STM32_PINMUX('A', 1, AF7)>; /* USART2_RTS */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('F', 4, AF7)>, /* USART2_RX */
> +				 <STM32_PINMUX('E', 15, AF7)>; /* USART2_CTS_NSS */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart2_sleep_pins_b: usart2-sleep-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F', 5, ANALOG)>, /* USART2_TX */
> +				 <STM32_PINMUX('A', 1, ANALOG)>, /* USART2_RTS */
> +				 <STM32_PINMUX('F', 4, ANALOG)>, /* USART2_RX */
> +				 <STM32_PINMUX('E', 15, ANALOG)>; /* USART2_CTS_NSS */
> +		};
> +	};
> +
>   	usart3_pins_a: usart3-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
> @@ -1558,6 +1582,19 @@
>   		};
>   	};
>   
> +	uart4_pins_c: uart4-2 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
> +			bias-disable;
> +		};
> +	};
> +
>   	uart7_pins_a: uart7-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART4_TX */
> @@ -1573,6 +1610,19 @@
>   		};
>   	};
>   
> +	uart7_pins_b: uart7-1 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('F', 7, AF7)>; /* UART7_TX */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('F', 6, AF7)>; /* UART7_RX */
> +			bias-disable;
> +		};
> +	};
> +
>   	uart8_pins_a: uart8-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */
> @@ -1647,4 +1697,18 @@
>   			bias-disable;
>   		};
>   	};
> +
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
>   };
> 
