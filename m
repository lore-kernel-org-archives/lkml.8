Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FFE208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="mTb8US4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgH1J40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:56:26 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:17068 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbgH1J4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:56:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S9akhE007533;
        Fri, 28 Aug 2020 11:56:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=De9Gry9zDbTRBC+JgD9O3wMoP8aZ/HsvcrhG/ag37Zg=;
 b=mTb8US4J83giFQPS883PT+Uv1KO+CaE05/alKu8XEkzVdYAQT47TOdReCecFJcFv8lMC
 qIsOGiYw/aeQZ8pl1SJxhpjtl/uqvNDmKBD30MFvf0udng7bB5ay4GFmrxh7qgyMjMb+
 H6vnydOPt31wAq6zPu+Qmoxtt5dHweAk9TKzTReMa9SU9NZ9j4lEw7iuPuvj5Zh4Tyjr
 ZwWjSomWMkjFLlEMGDGWRz1gWxqTBjwNh3/1QHXbN/cHisGiLtl6b5F8Ykg/6Ud9nNDe
 JEsTVXNJv+aeGVM6Eq2tzUMEe72cxQdbERKeem4THgvo1DoGhjKWyKxpKmkEQoA4Lqej iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b2n2wru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 11:56:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 79B7B10002A;
        Fri, 28 Aug 2020 11:56:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7033C2AE6D7;
        Fri, 28 Aug 2020 11:56:18 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 11:56:17 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add display controller node to stm32h743
To:     Tobias Schramm <t.schramm@manjaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200814225007.3421473-1-t.schramm@manjaro.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <34df4ecd-ecff-3645-ecf5-172031e9d7b4@st.com>
Date:   Fri, 28 Aug 2020 11:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814225007.3421473-1-t.schramm@manjaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_05:2020-08-28,2020-08-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias

On 8/15/20 12:50 AM, Tobias Schramm wrote:
> The stm32h743 has a display controller. This commit adds it to the
> device tree.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>   arch/arm/boot/dts/stm32h743.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 7c612db9efcf..7febe19e780d 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -334,6 +334,16 @@ usbotg_fs: usb@40080000 {
>   			status = "disabled";
>   		};
>   
> +		ltdc: display-controller@50001000 {
> +			compatible = "st,stm32-ltdc";
> +			reg = <0x50001000 0x200>;
> +			interrupts = <88>, <89>;
> +			resets = <&rcc STM32H7_APB3_RESET(LTDC)>;
> +			clocks = <&rcc LTDC_CK>;
> +			clock-names = "lcd";
> +			status = "disabled";
> +		};
> +
>   		mdma1: dma-controller@52000000 {
>   			compatible = "st,stm32h7-mdma";
>   			reg = <0x52000000 0x1000>;
> 

Applied on stm32-next. I modified slightly the commit message.

Thanks.
Alex
