Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DA3C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A359C20753
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HRxjFxuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEGHPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:15:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62702 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgEGHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:15:34 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0477DNFR027002;
        Thu, 7 May 2020 09:15:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=L51sRJlfOsw4Y7/MDpiNrdjYapAryMpWAkXSpi9QQMY=;
 b=HRxjFxukXyKSMaGNQBkkWJ6P9pwuXC6m/u402TaI5cIh+7kndEykDz4wN80nn4MXVHHa
 1j28srPK3cmTG83qYegPsTqT5F0gdgvGw4J9TN8Hcjn4NtkuuOqhzi//3ss9UOPEnwNF
 CdS3z2fuw6rQxe5O6VNqjTmvjfwSuV6sBAYejGHA1Hpp6eWK7LlInQE2rS1UHDze5w/p
 qSwWGuTMx6Dqsm2POVWyQKGtECFXM43Wj4e3kFQ6x7Vy3L6wHoXGiQUEajt2kI9RfTyI
 4iFKwYo3GC3/Ak+KSka6HzwiTnwIK5H/Eoa6eFxww2mCPd9L0TlV4UGC4hk3Vri1uxOB YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxb2a4tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:15:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A04C810002A;
        Thu,  7 May 2020 09:15:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 91ABC222CCC;
        Thu,  7 May 2020 09:15:16 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 7 May
 2020 09:15:12 +0200
Subject: Re: [PATCH] ARM: dts: stm32: bump PSCI to version 1.0 on stm32mp15x
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <robh+dt@kernel.org>, Etienne Carriere <etienne.carriere@st.com>
References: <20200506174840.19856-1-etienne.carriere@linaro.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <52715352-c1f1-970a-5441-7780fc48c933@st.com>
Date:   Thu, 7 May 2020 09:15:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200506174840.19856-1-etienne.carriere@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_04:2020-05-05,2020-05-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne

On 5/6/20 7:48 PM, Etienne Carriere wrote:
> From: Etienne Carriere <etienne.carriere@st.com>
> 
> Declare PSCI v1.0 support instead of v0.1 as the former is supported
> by the PSCI firmware stacks stm32mp15x relies on.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 3ea05ba48215..ebceead1b120 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -24,10 +24,8 @@
>   	};
>   
>   	psci {
> -		compatible = "arm,psci";
> +		compatible = "arm,psci-1.0";
>   		method = "smc";
> -		cpu_off = <0x84000002>;
> -		cpu_on = <0x84000003>;
>   	};
>   
>   	intc: interrupt-controller@a0021000 {
> 

Applied on stm32-next.

Thanks.
Alex
