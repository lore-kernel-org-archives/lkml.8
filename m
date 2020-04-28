Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCD7C8300A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6410E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="LeCX3Zjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgD1QbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:31:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:65036 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727920AbgD1QbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:31:07 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SGSBjo006731;
        Tue, 28 Apr 2020 18:30:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ic7llUtkSK0ilmom6xcazPRbfZzypbw4vTA5QnUR8n0=;
 b=LeCX3ZjlnxfQNQtSeZlUTzxTpILz/ztv+4YcNIGtzEBUgAHIrF8edghSdGAJeiMmSsfi
 ICedDnNomNemROz4MEpcGqaBER4nF5KihKaiKLpluJSAEvnj3QnSFDn+QCnzrSB9BO20
 EX5PBH2uN98p19LzH6clzmKcRxc+g6gLE7AeDgmCklmBwnJu/ZcJuZWvbiwgeF/XihHd
 pVZXxbcQfb7ctWhRm8epu3ReWRfRwpLLaWdDZwOL53MtcbaRUh8biIIH6NvjKFFqt4aQ
 V0IGDT2wyZv1jHdnm8ZvDIy4UkWDJb1SegVSEg8jAoeIt7Dh2YEukh1s3odv6Vvq01OI eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30n4j5w64w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 18:30:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F23C10002A;
        Tue, 28 Apr 2020 18:30:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 204942A497E;
        Tue, 28 Apr 2020 18:30:57 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Apr
 2020 18:30:53 +0200
Subject: Re: [PATCH v2] ARM: dts: stm32: add cortex-M4 pdds management in
 Cortex-M4 node
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
References: <20200401150339.7933-1-arnaud.pouliquen@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <21895154-7930-8354-0ddb-5c646cf6840e@st.com>
Date:   Tue, 28 Apr 2020 18:30:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401150339.7933-1-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_11:2020-04-28,2020-04-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud

On 4/1/20 5:03 PM, Arnaud Pouliquen wrote:
> Add declarations related to the syscon pdds for deep sleep management.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> v2: patch rebasing
> 
>   arch/arm/boot/dts/stm32mp151.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 5260818543e5..a40772eac487 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1124,6 +1124,11 @@
>   			};
>   		};
>   
> +		pwr_mcu: pwr_mcu@50001014 {
> +			compatible = "syscon";
> +			reg = <0x50001014 0x4>;
> +		};
> +
>   		exti: interrupt-controller@5000d000 {
>   			compatible = "st,stm32mp1-exti", "syscon";
>   			interrupt-controller;
> @@ -1700,6 +1705,7 @@
>   			resets = <&rcc MCU_R>;
>   			st,syscfg-holdboot = <&rcc 0x10C 0x1>;
>   			st,syscfg-tz = <&rcc 0x000 0x1>;
> +			st,syscfg-pdds = <&pwr_mcu 0x0 0x1>;
>   			status = "disabled";
>   		};
>   	};
> 

Applied on stm32-next.

Thanks.
Alex
