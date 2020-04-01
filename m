Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD26C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D8520787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fo6s2JSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbgDAHyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:54:24 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32820 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730426AbgDAHyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:54:24 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0317qoDT003866;
        Wed, 1 Apr 2020 09:54:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=BKDE9MMecDKQRqYD8xRMWRfHz2z9BYvJ+3QJiN4RSdc=;
 b=fo6s2JSzvzSnzc5+c8zCLT+tOmDPmjUI50rROTqmWa+0Y0JchJWaWTcGR8/4vYvzsZm0
 1E9EhOR3Jl3+k1BqCNalctaYiwZK1V0nHQrYqBiwME4B0fmDjIEoYn4NyJE0yKJWo4qa
 Vq4/DvNVxoEbZgh8XeJKencMOivf0Qxyh6lQmbbVYEV1SvLt6SA4Qp4dVIKNub9wofcs
 /RPOVv40xboslSX4qUWx2bSd8Fxvbp6dcAK+7O5JWuPRdglYjB+a8OBBevlcD21EDh8H
 UkkjCz56ErWCtRc/bunxHFwne7zd5Oy3yLHsjxuxekMym0GRzUvuIRWrwLumIXZbtDFf uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 302y53wr1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 09:54:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F7EE10002A;
        Wed,  1 Apr 2020 09:54:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B3DF21BA87;
        Wed,  1 Apr 2020 09:54:08 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Apr
 2020 09:53:52 +0200
Subject: Re: [PATCH] ARM: dts: stm32: fix a typo for DAC io-channel-cells on
 stm32f429
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1584613411-10218-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <939dfabe-4adf-983e-8d06-d2c1025650cb@st.com>
Date:   Wed, 1 Apr 2020 09:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1584613411-10218-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 3/19/20 11:23 AM, Fabrice Gasnier wrote:
> Fix a typo on STM32F429 DAC, e.g. s/channels/channel
> 
> Fixes: 25329b23fae9 ("ARM: dts: stm32: Add DAC support on stm32f429")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index d777069..393f43c 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -414,14 +414,14 @@
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
