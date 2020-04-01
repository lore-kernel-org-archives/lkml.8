Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF60C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2243120714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ghgQv232"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbgDAHzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:55:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730426AbgDAHzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:55:07 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0317qqm0016819;
        Wed, 1 Apr 2020 09:54:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=L3tZcNB6Zg4kzHn8ixX1iKWn3Upb6IYByXlIZINZM5g=;
 b=ghgQv2321JvzvV40jrK14Nv+QmrzE4kSAOfMjVjwzVaQVD/WvthsdJCaiytRgSKOFgem
 HwxhTof6gCmL71HeRskmvhcs+tJu8tRdhKytZ6JcUH8KmjKoBCgC5cV0ZcBiisyD7pbt
 clHg6qvLKBDHn/x7PFGD1Y/NZNFQCWbS+ehiVMoL5dOv3B+1HrgOr8oCqXvWBEu7w5lZ
 b70iuET5a+/upTRQpKFC8lTqxQWE1o1OWX9BCcmws0mXQxtPYO4lOAjR3/4H4isAkJNd
 sIeFKoP1I1pPjrqEkQQptMDXDfT9To2tH6UXPipiJ9KYlR126ODRq7u2OnHBAcjwduVz Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301xbmkkag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 09:54:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 897D8100034;
        Wed,  1 Apr 2020 09:54:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7BF3021BA8F;
        Wed,  1 Apr 2020 09:54:52 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Apr
 2020 09:54:48 +0200
Subject: Re: [PATCH] ARM: dts: stm32: fix a typo for DAC io-channel-cells on
 stm32mp15
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1584613826-10838-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e2890c8b-a950-baac-8f25-d7b8adb147d5@st.com>
Date:   Wed, 1 Apr 2020 09:54:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1584613826-10838-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 3/19/20 11:30 AM, Fabrice Gasnier wrote:
> Fix a typo on STM32MP15 DAC, e.g. s/channels/channel
> 
> Fixes: da6cddc7e8a4 ("ARM: dts: stm32: Add DAC support to stm32mp157c")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 3ea05ba..5260818 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -550,14 +550,14 @@
>   
>   			dac1: dac@1 {
>   				compatible = "st,stm32-dac";
> -				#io-channels-cells = <1>;
> +				#io-channel-cells = <1>;
>   				reg = <1>;
>   				status = "disabled";
>   			};
>   
>   			dac2: dac@2 {
>   				compatible = "st,stm32-dac";
> -				#io-channels-cells = <1>;
> +				#io-channel-cells = <1>;
>   				reg = <2>;
>   				status = "disabled";
>   			};
> 
Applied on stm32-next.

Thanks.
Alex
