Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3392068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="oS6225LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgFOKuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:50:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26604 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728815AbgFOKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:50:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FAWlLl003188;
        Mon, 15 Jun 2020 12:50:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=6uazfPAhQsttgP5kzZTw92A9LjEqdyZWqPnjXh89SHU=;
 b=oS6225LDlBacpl1Ddp48BwFpC3AjwYU6WszDnpBmvJyMVLu3A99UsTAMux5ThvFGXLdT
 EGKbmHBHT1RwwsvWZtGETAqqnfqJUn8hacHEZ8fWeieTN3j3BuFUGFh3AnWEgWcAmSDe
 8mEKZpYJa2klMIpGrfOVeHs2OeaCBiemAmW3pJWkC5OABdFKlKbicvxyJiDDzjeVZxCM
 MJZT7wGb5ubVnMS8az9TEu4JpUCXYdYVzFftMfgQePUKsu7F9mYpB8etX2ZAbDrUEgnW
 ifHB1d6k5wffirFxYAsBj1HrqL3hw5EirUI4TT0ugMkXEzN1omzOFHoJnSBUSMLSQI21 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mmjvs6j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 12:50:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6828B10002A;
        Mon, 15 Jun 2020 12:50:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3A0382B8A11;
        Mon, 15 Jun 2020 12:50:00 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Jun
 2020 12:49:59 +0200
Subject: Re: [PATCH 1/5] ARM: dts: stm32: add usart2, usart3 and uart7 pins in
 stm32mp15-pinctrl
To:     Erwan Le Ray <erwan.leray@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20200528074029.24962-1-erwan.leray@st.com>
 <20200528074029.24962-2-erwan.leray@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <2ee07ea1-1336-3bc5-d978-c5dc5cd5f04f@st.com>
Date:   Mon, 15 Jun 2020 12:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528074029.24962-2-erwan.leray@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_02:2020-06-15,2020-06-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erwan

On 5/28/20 9:40 AM, Erwan Le Ray wrote:
> Adds usart2_pins_c, usart3_pins_b, usart3_pins_c and uart7_pins_c pins
> configurations in stm32mp15-pinctrl.
> - usart2_pins_c pins are connected to Bluetooth chip on dk2 board.
> - usart3_pins_b pins are connected to GPIO expansion connector on evx board.
> - usart3_pins_c pins are connected to GPIO expansion connector on dkx board.
> - uart7_pins_c pins are connected to Arduino Uno connector on dkx board.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index fb98a66977fe..99e399e4e4c3 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1658,6 +1658,36 @@
>   		};
> 

...


> +	usart3_pins_b: usart3-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */

On EVx board this line is shared with ETH_CLK. The choice between both 
is done thanks to SB23 and default choice is "ETH_CLK". So hardware 
update has to be done to use usart3_rts. some words around that in 
comment would be great.

Thanks
alex

> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
> +				 <STM32_PINMUX('I', 10, AF8)>; /* USART3_CTS_NSS */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart3_idle_pins_b: usart3-idle-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> +				 <STM32_PINMUX('I', 10, ANALOG)>; /* USART3_CTS_NSS */
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart3_sleep_pins_b: usart3-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> +				 <STM32_PINMUX('I', 10, ANALOG)>, /* USART3_CTS_NSS */
> +				 <STM32_PINMUX('B', 12, ANALOG)>; /* USART3_RX */
> +		};
> +	};
> +
> +	usart3_pins_c: usart3-1 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
> +				 <STM32_PINMUX('B', 13, AF7)>; /* USART3_CTS_NSS */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart3_idle_pins_c: usart3-idle-1 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> +				 <STM32_PINMUX('B', 13, ANALOG)>; /* USART3_CTS_NSS */
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart3_sleep_pins_c: usart3-sleep-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> +				 <STM32_PINMUX('B', 13, ANALOG)>, /* USART3_CTS_NSS */
> +				 <STM32_PINMUX('B', 12, ANALOG)>; /* USART3_RX */
> +		};
> +	};
> +
>   	usbotg_hs_pins_a: usbotg-hs-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 10, ANALOG)>; /* OTG_ID */
> 
