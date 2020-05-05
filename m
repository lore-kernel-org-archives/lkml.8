Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B8C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15182083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="iohroaea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgEELwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:52:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52734 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEELwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:52:02 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045BnGiQ000379;
        Tue, 5 May 2020 13:51:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=l0JyW/3R0Flv5jIiu021fxxE/efUs1UCSOIMu/2MEZo=;
 b=iohroaeajtm3mtFVZzmUE5VU+VlQAAUS4Hj2hyoarU4yHKIAukyjj+YV+hRG28DKUXCM
 ApxGyUoSLwC+ND4l1Gg1mfcAK7scIcCdZ992Jk+QLzQiM8w6xXVXlNCPB05Ki6aQcGem
 YRSu3yw9bpIuMS00y9y+RiF6umQegEpi3UqdrsbKDGO+f/0iBxPneEwSAoPnuaCihHBn
 3LF1xZzIQTXAxmFszKxfHjAdqq6Xama6OLsgsP2SdTWUf+ulXAciE3q2BRpuSn0CJvFC
 CYOSOVO//AvbUQIhbIonjiulIr0FlnxtqGEmSg55CciUJgPUeMppelzMfjgv4VidpVNB OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxb1yub2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 13:51:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E55CA10002A;
        Tue,  5 May 2020 13:51:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D36D42AD9E5;
        Tue,  5 May 2020 13:51:44 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 May
 2020 13:51:40 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add sd-uhs properties in SD-card node
 for stm32mp157c-ed1
To:     Yann Gautier <yann.gautier@st.com>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ludovic Barre <ludovic.barre@st.com>
References: <20200430101649.29381-1-yann.gautier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <d9cab5f8-9472-98e3-f0d0-09b44e9563d8@st.com>
Date:   Tue, 5 May 2020 13:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200430101649.29381-1-yann.gautier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_07:2020-05-04,2020-05-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yann

On 4/30/20 12:16 PM, Yann Gautier wrote:
> The sdmmc1 peripheral is connected on SD-card on STM32MP1-ED1 board.
> Add the UHS features the controller is able to manage.
> Those features require a level shifter on the board, and the support of
> the voltage switch in driver, which is done in Linux v5.7.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Yann Gautier <yann.gautier@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> index 9d2592db630c..1d7dfe97b160 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> @@ -320,6 +320,10 @@
>   	bus-width = <4>;
>   	vmmc-supply = <&vdd_sd>;
>   	vqmmc-supply = <&sd_switch>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-ddr50;
>   	status = "okay";
>   };
>   
> 

Applied on stm32-next.

Thanks.
Alex
