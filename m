Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D8C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A692078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="YReJOvnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbgDAIVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:21:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47564 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgDAIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:21:24 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0318Is1m016051;
        Wed, 1 Apr 2020 10:21:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=2LCt8uA66pi/fY3wjKmgurjBraqWfS8tTA6ImKoZ4+M=;
 b=YReJOvnM3mdzpepnWXqX+x1AX3MdpbBO910KweK2iWFva1K1R+zqB3Nx9riBzfJlXg4g
 Mzpqx8Xdq/OTyGtVvt9ytzC5auozXjbkeGRvzPEggt/Q2xtnyA7xtAmXdAuccznKg+9G
 YiRCW1Yhnl+Mh+3Ve+KEtOsosm5xSl/othLbb3zXvLyVrbBh4J0LSnh16wJh+WTvXUk3
 g8BQumoLKq/xngo4vOxllOhRBlDrMNlKXPLCvLGSjqosM0k+xe2SXaINrahUYzrpErZN
 HoX//vbhW3WBVpe/xhqjCTu5Zi5MM0K1Th/Wm4YRL0+5icBYwLIJONRrzBhIgmGWjRjW oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301xbmkrhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 10:21:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E106100038;
        Wed,  1 Apr 2020 10:21:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 77A912126CB;
        Wed,  1 Apr 2020 10:21:10 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Apr
 2020 10:20:12 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add cortex-M4 pdds management in
 Cortex-M4 node
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
References: <20200320125841.11059-1-arnaud.pouliquen@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <0b14ed2a-c384-af73-2e28-541eadb309e2@st.com>
Date:   Wed, 1 Apr 2020 10:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320125841.11059-1-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud

On 3/20/20 1:58 PM, Arnaud Pouliquen wrote:
> Add declarations related to the syscon pdds for deep sleep management.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---

Can you please rebase it on top of stm32-next ?

>   arch/arm/boot/dts/stm32mp151.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 7b93eb4b8f49..46ea1024340e 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1115,6 +1115,11 @@
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
> @@ -1693,6 +1698,7 @@
>   			st,syscfg-tz = <&rcc 0x000 0x1>;
>   			st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
>   			st,syscfg-copro-state = <&tamp 0x148 0xFFFFFFFF>;
> +			st,syscfg-pdds = <&pwr_mcu 0x0 0x1>;
>   			status = "disabled";
>   		};
>   	};
> 
