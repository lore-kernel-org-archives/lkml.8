Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD76EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8D020787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZL9LR7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgGVLfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgGVLfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:35:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF9AC0619DF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:35:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so2092616ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TGNDP7TokQIPIiDyQQilw1gTxHg2ntwORp5IuJSSxuk=;
        b=aZL9LR7W/tIRttDyuKuxTLD2H6940gR+znMFp2lInXL0+1POU9uVrCT4hYQxPdhmrn
         S2+g7c/STj8trDv1J2dQh3yyuNbmZ/FBmfEofuV2tYt9DbWbverlMsjtAkntWgcoBobl
         GmDgFcdpbAIHAOBcT+RBAoeWRhrGDrKkVU9oGAjoW+TesAdIwns/dtIXqAMavqIOPb8q
         xHk0KNI0Tyh4U6NHUfxwyi5CC896PdNiIKLXyXjv83xR+Xzdz2Uq+gXtg41h/iWsNeyf
         sH5vhVzLjP4d3Igau5+FBEbxHeer8J86otHzCm6cfki7BTD3cKxo7/mNY4xV309jy07l
         VllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGNDP7TokQIPIiDyQQilw1gTxHg2ntwORp5IuJSSxuk=;
        b=ovM2Y4nvDYYC1wQ54pxLbY8cJpxgPQyQaN4DW8a0mMb3EGI506uicXghQXTzE7ltoc
         OWVEIDwtF+be/6SglNXZ3FGpv4VbcXQ+/skC1yIfCmugBDiPacUdUYjQ1jH7l4y1NW40
         2t6/i8m2MOBmLrMbIZzP7v+J5acr7Czm2W4nsPXaaYIKInUhJ7SowJS81PrpK7ufPBP6
         Wnc8KRWSxfAwW0B6YP0ULmgFBaMMFjQ+CGv0wuTaYWxZ0DRGCcmuRandzTHQ9yfvIojS
         4I2Bqf1R5y7bO2j874HYbJMSOkj0PBSdxeGnFvVAbrDx+Vrv9JjJvQZY0XnH947fiVm/
         kg5Q==
X-Gm-Message-State: AOAM5313PAjqw7bRLqlw6pasge3QcBV2jz6DzBWK9VTbDvzRIsOnvHl6
        jJmQDn5981UUpkkCPR/OND3pVA==
X-Google-Smtp-Source: ABdhPJx10tJmh0m7u1T2ZgbF1/QplULMvy/0nd1WW5FAXaMP8a/XeDzSYyeVLyeB1Xeshxh8kVGUpQ==
X-Received: by 2002:a2e:978c:: with SMTP id y12mr14882344lji.270.1595417745685;
        Wed, 22 Jul 2020 04:35:45 -0700 (PDT)
Received: from [192.168.1.12] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id p1sm6537308lji.93.2020.07.22.04.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 04:35:44 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] media: s5p-mfc: Use standard frame skip mode
 control
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
References: <20200721074538.505-1-stanimir.varbanov@linaro.org>
 <20200721074538.505-6-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <d219e893-8a9e-e977-a901-d17b71121555@linaro.org>
Date:   Wed, 22 Jul 2020 14:35:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721074538.505-6-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could someone mfc driver maintainers ack or review this patch?

On 7/21/20 10:45 AM, Stanimir Varbanov wrote:
> Use the standard menu control for frame skip mode in the MFC
> driver. The legacy private menu control is kept for backward
> compatibility.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> index 912fe0c5ab18..3092eb6777a5 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> @@ -261,6 +261,11 @@ static struct mfc_control controls[] = {
>  		.menu_skip_mask = 0,
>  		.default_value = V4L2_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE_DISABLED,
>  	},
> +	{
> +		.id = V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE,
> +		.maximum = V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT,
> +		.default_value = V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED,
> +	},
>  	{
>  		.id = V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT,
>  		.type = V4L2_CTRL_TYPE_BOOLEAN,
> @@ -1849,6 +1854,7 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
>  		p->seq_hdr_mode = ctrl->val;
>  		break;
>  	case V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE:
> +	case V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE:
>  		p->frame_skip_mode = ctrl->val;
>  		break;
>  	case V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT:
> 

-- 
regards,
Stan
