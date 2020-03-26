Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64154C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E1A20774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585259778;
	bh=60FKxXmeBih+dFIlysh9/kVusI4cRU3E3zOMa39lTtA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=z3qbkEh5Qd4br8C2roaL9RS4Co9J8QNFSJCIF45qvfMsS3wejO/GY+PwANfMAIBQ8
	 bsRhqIf7kdw6IIoCL2/HsuztMr+di1HlCwH5PPD8VSmxkO7ZRbnpUlBchCeOtPzUCp
	 pLCa+p9CnlhZl0XwMWJL7WYnoi8B7NnYwtiyCUCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCZV4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:56:17 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42307 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZV4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:56:16 -0400
Received: by mail-il1-f194.google.com with SMTP id f16so6907611ilj.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B4eUj1VJNe32redVDC5bFOpW5fSi/T9854EMg72WAbo=;
        b=U/8eWq97Wny3wgOUhSrhlUv3catkWD+4C3Iy+KOP71/3XGwAQaCuGhPEpOhjv5yj6t
         xPX40/sj2Ba+7Uru9MCCtQ609V/8BOtT+8iLrKBDWgCu6C6AA/wM1X+MQtYj673IptBA
         /oePRCdXoVDTaGT4RPd33HLz0agt39cNYKaCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B4eUj1VJNe32redVDC5bFOpW5fSi/T9854EMg72WAbo=;
        b=LKn2ieKfQnpk8Fra/LLpa56riv3yrN/5PlH+bJ3/yonW/V1oatKrzWbq/GWnUDA9QN
         KgDZfHaGjW8xqikh+svpP5Cm2NtuS3K5BQ5flz6/ZXfk3bNx4e5FI6smeyIoDyuI15ex
         xawR6ltUAzHXQsmS0+cPuTwc1ZXc1W+4Cboz80PBdcW7Mil8OXY6Jg98lqvfnp+HwHRe
         PFxfLB1nPet6vu/bwnlPQodsr22Z4LYGXWQlUiGCshJnEm5nKaaak4pl3XKOK2GtQO6q
         exvfuv16fawYqvIc4vTMp/FHIedzi6hKZQiiBcjrZHDYAqwIcsMXuDw1cIExrqJf75O6
         9iqg==
X-Gm-Message-State: ANhLgQ0m6tabsVbAT8K3szjRvowbFwtAwpbsUr8qfz8bKfB0nogN+XKa
        14jJAWXGmpvcwQyFZ4KEK1hgPQ==
X-Google-Smtp-Source: ADFU+vtExdO8eMcT48/u+xZDt1+AcEbZl4LYEe9K22SOyNimecH+1TWpOrqIXKhkdGvA3tStj4aWVA==
X-Received: by 2002:a92:8f91:: with SMTP id r17mr9911502ilk.97.1585259774247;
        Thu, 26 Mar 2020 14:56:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s25sm1201672ilb.37.2020.03.26.14.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 14:56:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] media: vimc: Add missing {RGB,BGR,GBR}888 media
 bus codes
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, linux-media@vger.kernel.org
Cc:     Helen Koike <helen.koike@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200326214730.2449707-1-nfraprado@protonmail.com>
 <20200326214730.2449707-3-nfraprado@protonmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <47dec848-dd66-9b5a-d7e6-38f6ea050b2e@linuxfoundation.org>
Date:   Thu, 26 Mar 2020 15:56:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326214730.2449707-3-nfraprado@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 3:47 PM, Nícolas F. R. A. Prado wrote:
> Add missing RGB888_*, BGR888_* and GBR888_* media bus codes in the
> vimc_pix_map_list. Since there is no GBR24 pixelformat, use the RGB24
> pixelformat for MEDIA_BUS_FMT_GBR888_1X24.
> 
> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
> ---
> 
> Changes in v2:
> - Fix array formatting
> - Change commit message to reflect v2 changes
> - Change code array size
> - Add other BGR888 and RGB888 formats to BGR24 and RGB24 pixelformats
> 
>   drivers/media/platform/vimc/vimc-common.c | 16 ++++++++++++++--
>   drivers/media/platform/vimc/vimc-common.h |  2 +-
>   2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/vimc/vimc-common.c b/drivers/media/platform/vimc/vimc-common.c
> index 119846f3eaa5..11489334cff7 100644
> --- a/drivers/media/platform/vimc/vimc-common.c
> +++ b/drivers/media/platform/vimc/vimc-common.c
> @@ -19,13 +19,25 @@ static const struct vimc_pix_map vimc_pix_map_list[] = {
>   
>   	/* RGB formats */
>   	{
> -		.code = { MEDIA_BUS_FMT_BGR888_1X24 },
> +		.code = {
> +			MEDIA_BUS_FMT_BGR888_1X24,
> +			MEDIA_BUS_FMT_BGR888_3X8
> +		},
>   		.pixelformat = V4L2_PIX_FMT_BGR24,
>   		.bpp = 3,
>   		.bayer = false,
>   	},
>   	{
> -		.code = { MEDIA_BUS_FMT_RGB888_1X24 },
> +		.code = {
> +			MEDIA_BUS_FMT_RGB888_1X24,
> +			MEDIA_BUS_FMT_RGB888_2X12_BE,
> +			MEDIA_BUS_FMT_RGB888_2X12_LE,
> +			MEDIA_BUS_FMT_RGB888_3X8,
> +			MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +			MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
> +			MEDIA_BUS_FMT_RGB888_1X32_PADHI,
> +			MEDIA_BUS_FMT_GBR888_1X24
> +		},
>   		.pixelformat = V4L2_PIX_FMT_RGB24,
>   		.bpp = 3,
>   		.bayer = false,
> diff --git a/drivers/media/platform/vimc/vimc-common.h b/drivers/media/platform/vimc/vimc-common.h
> index 585441694c86..d5e0e8d32542 100644
> --- a/drivers/media/platform/vimc/vimc-common.h
> +++ b/drivers/media/platform/vimc/vimc-common.h
> @@ -69,7 +69,7 @@ do {									\
>    * V4L2_PIX_FMT_* fourcc pixelformat and its bytes per pixel (bpp)
>    */
>   struct vimc_pix_map {
> -	unsigned int code[1];

> +	unsigned int code[8];
Please add a define for this instead of hard coded value.


>   	unsigned int bpp;
>   	u32 pixelformat;
>   	bool bayer;
> 

