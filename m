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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D390C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01272208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="U4tOtbIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgH1JyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:54:25 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:16630 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbgH1JyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:54:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S9aj4Q007515;
        Fri, 28 Aug 2020 11:54:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=th8nEc7OFj8YSYgcJlorABSYkKgwnGO3yKrwpGSpweY=;
 b=U4tOtbIbYf+FXXANLL9Ldt/lIhIUGVZXxXmOXNZGd6EZwOEg5vTBa8oCzN0aLDWUI4zG
 BIAlaKmI10I0jn9Jsd10wUjIEsyoMjFlJA+VGEMK5khL4b8iIjwDHXbzxtzZlnTzVS22
 q0DKxMlRdCtRzkPMqzhAiWjrkxKsaFmiNY8nYfA0VfAsuIrWP8BvuV8jDSEtmYF/wugJ
 iGtyRChF7UsBbMv7LmtQlIrQnbN10/q7qHJJf1dJeU4OgrbEou66R+ubvFehZly7AVZ3
 CqilFPvOekTcTjHpP8DUptrm1EAC/AVRPj1HsE8opcM45kuAeN87pys4CWPkkf+msYXb Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b2n2weq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 11:54:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 414EA10002A;
        Fri, 28 Aug 2020 11:54:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3531A2AE6C9;
        Fri, 28 Aug 2020 11:54:17 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 11:54:16 +0200
Subject: Re: [PATCH] ARM: dts: stm32: use stm32h7 usart compatible string for
 stm32h743
To:     Tobias Schramm <t.schramm@manjaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200814181125.3202399-1-t.schramm@manjaro.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <37d194f3-a9d5-625d-13b7-d749c7b21855@st.com>
Date:   Fri, 28 Aug 2020 11:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814181125.3202399-1-t.schramm@manjaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_05:2020-08-28,2020-08-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias

On 8/14/20 8:11 PM, Tobias Schramm wrote:
> Previously the FIFO on the stm32h743 usart was not utilized, because
> the stm32f7 compatible configures it without FIFO support.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>   arch/arm/boot/dts/stm32h743.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 69e2f1e78ed6..9dd58974bf8d 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -126,7 +126,7 @@ spi3: spi@40003c00 {
>   		};
>   
>   		usart2: serial@40004400 {
> -			compatible = "st,stm32f7-uart";
> +			compatible = "st,stm32h7-uart";
>   			reg = <0x40004400 0x400>;
>   			interrupts = <38>;
>   			status = "disabled";
> @@ -194,7 +194,7 @@ dac2: dac@2 {
>   		};
>   
>   		usart1: serial@40011000 {
> -			compatible = "st,stm32f7-uart";
> +			compatible = "st,stm32h7-uart";
>   			reg = <0x40011000 0x400>;
>   			interrupts = <37>;
>   			status = "disabled";
> 

Applied on stm32-next.

Thanks.
Alex
