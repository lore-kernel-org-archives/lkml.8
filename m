Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE79C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2032065F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="F+6LQUKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgGHNfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:35:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52359 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728210AbgGHNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:35:33 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068DRjZY011083;
        Wed, 8 Jul 2020 15:34:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=yLQyONm0OZ3tpaysk6y1/Tkb1PKTErxNitHpKeaMJiU=;
 b=F+6LQUKl0v3IRItP9iY+weKyyx0Uj7xxK/zIexSzaZkncqX5ITkYjCSpDzfOgVXxKwh2
 uupHtqOtsZ/n1op0CvB0E7n3j9zDdaX9FTPIauuQ8Z9hr1VfP2vXKa1QjYRN3/yizQL0
 Yupbm9KTiF02FT5zWndOFV8BYEzXgtzryU/scHQtvTu105kYDE4v52a4hvQAzFTbA4uS
 psM5cwxZeer2E9QibAZAr3N0Vp0c7BoNUPqD7d3uqXAZ7euK41F9iKgio5LbYeHefk8A
 qFtqhSbjz+a1oeXoiA5EISj/WoNCjzhR9hQwHVmwULJp7tVX7tRDgxEsIk/+HOtKgzIG 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 322fhv7tru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 15:34:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7633810002A;
        Wed,  8 Jul 2020 15:34:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 66B392BF9B7;
        Wed,  8 Jul 2020 15:34:44 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 15:34:42 +0200
Subject: Re: [PATCH v2 20/28] ASoC: sti: uniperif: Mark 'uni_tdm_hw' as
 __maybe_unused
To:     Lee Jones <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
 <20200707143742.2959960-21-lee.jones@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <fdb3fb06-d710-5c4b-6b85-fc9bb90b891b@st.com>
Date:   Wed, 8 Jul 2020 15:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707143742.2959960-21-lee.jones@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_11:2020-07-08,2020-07-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/20 4:37 PM, Lee Jones wrote:
> Only 2 of the 3 source files which include this headerfile actually
> reference 'uni_tdm_hw'.  The other source file 'sti_uniperif.c' sees
> as it as being unused.  Mark it as __maybe_unused to show that this
> behaviour is not only known, it's intentional.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  sound/soc/sti/uniperif.h:1351:38: warning: ‘uni_tdm_hw’ defined but not used [-Wunused-const-variable=]
>  1351 | static const struct snd_pcm_hardware uni_tdm_hw = {
>  | ^~~~~~~~~~
> 
> Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks
Arnaud
> ---
>  sound/soc/sti/uniperif.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
> index 2dc2da5d458bd..e22d045d5cd99 100644
> --- a/sound/soc/sti/uniperif.h
> +++ b/sound/soc/sti/uniperif.h
> @@ -1348,7 +1348,7 @@ struct sti_uniperiph_data {
>  	struct sti_uniperiph_dai dai_data;
>  };
>  
> -static const struct snd_pcm_hardware uni_tdm_hw = {
> +static const struct snd_pcm_hardware __maybe_unused uni_tdm_hw = {
>  	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
>  		SNDRV_PCM_INFO_MMAP_VALID,
> 
