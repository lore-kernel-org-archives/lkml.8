Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0B6C5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B428320749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CMYrR8XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgCMNNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:13:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36178 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbgCMNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:13:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DD7L64023461;
        Fri, 13 Mar 2020 14:13:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=oUI8ZXDq4EiPObS+0wbkrkh1Q7HpkSyN8K/N9gjWHwY=;
 b=CMYrR8XBBnQtWJkA0eWefudDD9tn9gsZT+GMJWILTLOZQXISvjGUkZozI5RgrAlEej7E
 K26gR/vCvzJnXvccC54NJ5ZY7qlXk61EkVin6FWr+6iogkfVCuvRjv1Z3qK+viYZyNCz
 Al4pVtZs3kkxEH7UgQ6ZzB19S8CcN4dhLO1Wkrd1mHzpl6q0+crBBGjg0FT2Ru5QYzbN
 Ac1lulXTPrDkN6+Zpqlce1abtkUexXV0v7QcHq5VUzr3C8LzIbe0y4+YTqFfFPmq+m6e
 QVf95UmlFyj9+62dckN+X2O6Nrqcl4GZh1EYhaGTrWTH6d3n0wMgjPy468bX+P2eQzo+ Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yqt82guej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 14:13:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA20310002A;
        Fri, 13 Mar 2020 14:13:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 849672A8913;
        Fri, 13 Mar 2020 14:13:00 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Mar
 2020 14:12:59 +0100
Subject: Re: [PATCH] ARM: dts: stm32: add cpu clock-frequency property on
 stm32mp15x
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <kernel@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200224172031.27868-1-a.fatoum@pengutronix.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e5a6ce75-061d-fa75-8fe6-285b4259952f@st.com>
Date:   Fri, 13 Mar 2020 14:12:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224172031.27868-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_04:2020-03-12,2020-03-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 2/24/20 6:20 PM, Ahmad Fatoum wrote:
> All of the STM32MP151[1], STM32MP153[2] and STM32MP157[3] have their
> Cortex-A7 cores running at 650 MHz.
> 
> Add the clock-frequency property to CPU nodes to avoid warnings about
> them missing.
> 
> [1]: https://www.st.com/en/microcontrollers-microprocessors/stm32mp151.html
> [2]: https://www.st.com/en/microcontrollers-microprocessors/stm32mp153.html
> [3]: https://www.st.com/en/microcontrollers-microprocessors/stm32mp157.html
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Applied on stm32-next.

Thanks.
Alex

> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 1 +
>   arch/arm/boot/dts/stm32mp153.dtsi | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index fb41d0778b00..fd46a8e11126 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -17,6 +17,7 @@ cpus {
>   
>   		cpu0: cpu@0 {
>   			compatible = "arm,cortex-a7";
> +			clock-frequency = <650000000>;
>   			device_type = "cpu";
>   			reg = <0>;
>   		};
> diff --git a/arch/arm/boot/dts/stm32mp153.dtsi b/arch/arm/boot/dts/stm32mp153.dtsi
> index 2d759fc6015c..6d9ab08667fc 100644
> --- a/arch/arm/boot/dts/stm32mp153.dtsi
> +++ b/arch/arm/boot/dts/stm32mp153.dtsi
> @@ -10,6 +10,7 @@ / {
>   	cpus {
>   		cpu1: cpu@1 {
>   			compatible = "arm,cortex-a7";
> +			clock-frequency = <650000000>;
>   			device_type = "cpu";
>   			reg = <1>;
>   		};
> 
