Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE17C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E692420784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FKKmCM/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbgDAIwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:52:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58474 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgDAIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:52:38 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0318mpeP020674;
        Wed, 1 Apr 2020 10:52:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=r52PE0j1vMBkkUz5Eegf2p3sdm+5DC8eaQV1TiyeLGc=;
 b=FKKmCM/2e0k3XoRM0JKKuHFS2qqrsvmHjmUccd+uxE4Ew0LCbN9KoV0O1Tj5tVpM3KV+
 lNFxoVqXzamJb+sQAVbXSq+hZdZOm89oGFjXbZ8MfQCnmqQnSLr8/DqFBUP+cFwglzKc
 SPJTxchaIbiSbBRyhyIiSHwnkzzG6K87sG4RiBGw4jhZn6kB5cdjOCwHQTXGxpE+teb4
 mDKtb8K+Q78N0SU6eFj+bjiUvQGj/DhC735mYO6WEFoK3NZwL9FCwazdzWd6ke/BSWx5
 DWamg2/bzA2cqAK1BIbq07ZDH6uATLWCWzTYsTI38t5Lzv22YwNcYmOGjQUH27IZWOHc HQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301xbmm00j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 10:52:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E61B100039;
        Wed,  1 Apr 2020 10:52:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 695BA21D6CC;
        Wed,  1 Apr 2020 10:52:22 +0200 (CEST)
Received: from [10.211.14.17] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Apr
 2020 10:52:21 +0200
Subject: Re: [PATCH v6 4/6] mfd: stm32: enable regmap fast_io for
 stm32-lptimer
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200401083909.18886-1-benjamin.gaignard@st.com>
 <20200401083909.18886-5-benjamin.gaignard@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <4ca5f15f-c967-9c84-4a9f-13a11f71a72a@st.com>
Date:   Wed, 1 Apr 2020 10:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200401083909.18886-5-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 10:39 AM, Benjamin Gaignard wrote:
> Because stm32-lptimer need to write in registers in interrupt context
> enable regmap fast_io to use a spin_lock to protect registers access
> rather than a mutex.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/mfd/stm32-lptimer.c | 1 +
>  1 file changed, 1 insertion(+)
Hi Benjamin,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice
> 
> diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
> index a00f99f36559..746e51a17cc8 100644
> --- a/drivers/mfd/stm32-lptimer.c
> +++ b/drivers/mfd/stm32-lptimer.c
> @@ -17,6 +17,7 @@ static const struct regmap_config stm32_lptimer_regmap_cfg = {
>  	.val_bits = 32,
>  	.reg_stride = sizeof(u32),
>  	.max_register = STM32_LPTIM_MAX_REGISTER,
> +	.fast_io = true,
>  };
>  
>  static int stm32_lptimer_detect_encoder(struct stm32_lptimer *ddata)
> 
