Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73535C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48448206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="X35JI2fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCMNPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:15:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1895 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgCMNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:14:59 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DDDJIv004634;
        Fri, 13 Mar 2020 14:14:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=96tzSx1sjU99KhvK259+0KWD9N1uJtRZcwvduWLOsSU=;
 b=X35JI2fxlbiM+NNfrY/7YkoajwAjKup2jGRyKlAjK+lHVVSwzfopoqwnJD5df/1QmbPK
 Zx1juGiGvAyl2QnW7CEq7wjV0RNZkMg5AkpzV7943BJ7q1bISviR/4X9z8rXJEzCO3IQ
 aDRz8ix/OvkHp30sBLiPH6oxlAhWKKBYBs6X8tEQpZsHWS8ILfg6ikEULxq+AuJjar2E
 Cj4kSLfrJAs+UrbQpUEeHZo8OHcZFLW9HsVYK7wpz2WkTNjR2DM/G0ZpyW1skb8beXMR
 85+kkgE+RdVB+0YKl/h41nAee4dx1HT5cGGdkOZz/6iMby8Y37CDSrOwp9IxWX9SCLVH uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yqt818vpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 14:14:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 647BF10003E;
        Fri, 13 Mar 2020 14:14:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 584C02A8914;
        Fri, 13 Mar 2020 14:14:45 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Mar
 2020 14:14:44 +0100
Subject: Re: [PATCH] ARM: dts: stm32: Rename stmfx node names
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200228125205.8126-1-benjamin.gaignard@st.com>
 <20200228125205.8126-2-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <594855ac-2d50-ccf9-6c75-07bb5ef47e82@st.com>
Date:   Fri, 13 Mar 2020 14:14:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228125205.8126-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_04:2020-03-12,2020-03-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 2/28/20 1:52 PM, Benjamin Gaignard wrote:
> Rename stmfx node names according to yaml description.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---

Applied on stm32-next with commit title updated.

Thanks.
Alex

>   arch/arm/boot/dts/stm32746g-eval.dts  | 2 +-
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
> index fcc804e3c158..4ea3f98dd275 100644
> --- a/arch/arm/boot/dts/stm32746g-eval.dts
> +++ b/arch/arm/boot/dts/stm32746g-eval.dts
> @@ -165,7 +165,7 @@
>   		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
>   		interrupt-parent = <&gpioi>;
>   
> -		stmfx_pinctrl: stmfx-pin-controller {
> +		stmfx_pinctrl: pinctrl {
>   			compatible = "st,stmfx-0300-pinctrl";
>   			gpio-controller;
>   			#gpio-cells = <2>;
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index 228e35e16884..3f4668a43afe 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -210,7 +210,7 @@
>   		interrupt-parent = <&gpioi>;
>   		vdd-supply = <&v3v3>;
>   
> -		stmfx_pinctrl: stmfx-pin-controller {
> +		stmfx_pinctrl: pinctrl {
>   			compatible = "st,stmfx-0300-pinctrl";
>   			gpio-controller;
>   			#gpio-cells = <2>;
> @@ -218,7 +218,7 @@
>   			#interrupt-cells = <2>;
>   			gpio-ranges = <&stmfx_pinctrl 0 0 24>;
>   
> -			joystick_pins: joystick {
> +			joystick_pins: joystick-pins {
>   				pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
>   				bias-pull-down;
>   			};
> 
