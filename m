Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00C6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDDF2065F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tP1oszWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgGHNfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:35:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8124 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729357AbgGHNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:35:34 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068DSCcX001721;
        Wed, 8 Jul 2020 15:35:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Sil9NtsmeDcnD3IRYnuVtCbIFFHaLCEaDU6aa17NGfw=;
 b=tP1oszWGk6T9wPYP/F9IRSI9QEtzYRlYXXGRGV3LHW4necD8tWAKVDIU8dvZdop6xBDt
 M/2uIoQUIWbK38FKV57fD5NuFlo+qBO230/BnMaBo/4NgYBQQScEslbwE4En4wOCGbWs
 l7LPu/zXGykHaz+qVJZtg9QxaDGw0VFpwipQi2eN27OWCRfkFG4/ltxHBu774HK/9bpJ
 ayWDW9k+lJFxYYDdrzA/iLJKpfFT9C4Z8HiZZeBdeg5mJ+n7vJSgvAyxYNkHb89rsS8g
 fiCPYcSMNNazyo9nxE5MknIx940QzReomg/1w72smeSKMQ9pLofmtwRm10imQIZ2Jn71 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 322ew9fxwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 15:35:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CFAE010002A;
        Wed,  8 Jul 2020 15:35:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C62822BF9B5;
        Wed,  8 Jul 2020 15:35:26 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 8 Jul
 2020 15:35:26 +0200
Subject: Re: [PATCH 6/6] phy: stm32: use NULL instead of zero
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20200708132809.265967-1-vkoul@kernel.org>
 <20200708132809.265967-6-vkoul@kernel.org>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <2f81b551-c0ec-686d-7662-9b3092b82a4e@st.com>
Date:   Wed, 8 Jul 2020 15:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708132809.265967-6-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_11:2020-07-08,2020-07-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 7/8/20 3:28 PM, Vinod Koul wrote:
> devm_clk_get() and devm_reset_control_get() expect a const char *id for
> the last arg, but a value of zero was provided. This results in below
> sparse warning:
> 
> drivers/phy/st/phy-stm32-usbphyc.c:330:42: warning: Using plain integer as NULL pointer
> drivers/phy/st/phy-stm32-usbphyc.c:343:52: warning: Using plain integer as NULL pointer
> 
> Instead of zero, use NULL
> 
> Cc: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>

Thanks!

Regards,
Amelie

> ---
>   drivers/phy/st/phy-stm32-usbphyc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
> index 56bdea4b0bd9..2b3639cba51a 100644
> --- a/drivers/phy/st/phy-stm32-usbphyc.c
> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
> @@ -327,7 +327,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   	if (IS_ERR(usbphyc->base))
>   		return PTR_ERR(usbphyc->base);
>   
> -	usbphyc->clk = devm_clk_get(dev, 0);
> +	usbphyc->clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(usbphyc->clk)) {
>   		ret = PTR_ERR(usbphyc->clk);
>   		dev_err(dev, "clk get failed: %d\n", ret);
> @@ -340,7 +340,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	usbphyc->rst = devm_reset_control_get(dev, 0);
> +	usbphyc->rst = devm_reset_control_get(dev, NULL);
>   	if (!IS_ERR(usbphyc->rst)) {
>   		reset_control_assert(usbphyc->rst);
>   		udelay(2);
> 
