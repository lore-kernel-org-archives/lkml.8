Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B15C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4242072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ApbCYCm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFI5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:57:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44244 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCFI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:57:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so1557665eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HIKZujjihh1s+IvJgZIBXxxG3VuVixHJ2zZMGP7f5ds=;
        b=ApbCYCm4C3dDhGo8AB22p7YfzlZjsxj6XAp/L7HrsFpZchnbNucy76iro9tFMWSNAm
         +8DH05IPpfPAIS38G4xHkprVFjH32Zd+8/UYqQtdymtcUpeWsmz/9tQBcKN3mVjI/7nw
         FVrHMowqB8JEURcRCm1YjPZox0PBhINWJZmQywrOJdRVu6T3rsL9eD1R6OP6/mpMtC80
         vsAoXCpsv9XPVlEEgJXodgL5kuS1TJDP9eK70SfdWjKPMjmL1F8Dwi9jm0m8NZ1f5mcc
         R22V/gxn/NeWDDpFvnAnCn8FhJHTPXEvGDdZixWH4seZJvRYIIcWSOuZpgmIor6ql42T
         1Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HIKZujjihh1s+IvJgZIBXxxG3VuVixHJ2zZMGP7f5ds=;
        b=WjfEvaqtrNi3a1aFbw9NRj3+1qSuQcFPQjlPc7v5wny0y6FFupE/n51bP7qqhmUWcY
         Mq59PgueNj0xwSMjuDmD3IvRFrfin2xJohiadxg7wiRZBStdsxbWIt72rdLqATmTBHQI
         qqQUWTeIHvd4yFlMP5UpgZdOI92NWfmW7l/Zjp+O4PmZl7Agg+xMMRmNwwdl9fBquUkG
         UeJN8nqhXFgIKRSDqdBt0pak23iSh+0T+tkNwySHpdLUmDbo99VHSjaoBOIQBCuyMmeR
         GKXIYBQqoezOKwQeIaIqmCslVgs6xtbplK9EOcTUj0tu2gX7cSvbTkpDtO/1MW08X3a6
         rNYQ==
X-Gm-Message-State: ANhLgQ34NXoTvZyDf+GLYU636LwNjYAtkCxGcsOIaYkuwLjBlBV5JKcw
        fNErvu4o3TLMUFYM3rEoO3JZCHJ156M=
X-Google-Smtp-Source: ADFU+vtKmlWnoiuxBrdVpANGDvxFR85NnJGhtovu5ZhTJ0svqRt0GXFeOhqgOrETEd/BGytVN3mk2w==
X-Received: by 2002:a50:ed18:: with SMTP id j24mr2081280eds.124.1583485042506;
        Fri, 06 Mar 2020 00:57:22 -0800 (PST)
Received: from [192.168.27.209] ([94.155.124.210])
        by smtp.googlemail.com with ESMTPSA id q5sm1294432edw.34.2020.03.06.00.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 00:57:21 -0800 (PST)
Subject: Re: [PATCH v2] media: venus: support frame rate control
To:     Jeffrey Kardatzke <jkardatzke@google.com>,
        linux-media@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200222003311.106837-1-jkardatzke@google.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <da345a46-599d-2a00-0e96-112e702781c9@linaro.org>
Date:   Fri, 6 Mar 2020 10:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200222003311.106837-1-jkardatzke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thanks for the patch!

It looks good to me, except one indentation issue but I will fix it when
applying no need to resend it.

On 2/22/20 2:33 AM, Jeffrey Kardatzke wrote:
> Add encoder control for enabling/disabling frame rate control via
> V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE. It is enabled by default.
> 
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>  drivers/media/platform/qcom/venus/core.h       | 1 +
>  drivers/media/platform/qcom/venus/venc.c       | 4 +++-
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 8 +++++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 11585fb3cae3..2b0649ffbd92 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -187,6 +187,7 @@ struct venc_controls {
>  	u32 bitrate_mode;
>  	u32 bitrate;
>  	u32 bitrate_peak;
> +	u32 rc_enable;
>  
>  	u32 h264_i_period;
>  	u32 h264_entropy_mode;
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 453edf966d4f..56079c9d9900 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -731,7 +731,9 @@ static int venc_set_properties(struct venus_inst *inst)
>  	if (ret)
>  		return ret;
>  
> -	if (ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_VBR)
> +	if (!ctr->rc_enable)
> +		rate_control = HFI_RATE_CONTROL_OFF;
> +	else if (ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_VBR)
>  		rate_control = HFI_RATE_CONTROL_VBR_CFR;
>  	else
>  		rate_control = HFI_RATE_CONTROL_CBR_CFR;
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 877c0b3299e9..0572a00b8380 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -199,6 +199,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  		}
>  		mutex_unlock(&inst->lock);
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
> +		ctr->rc_enable = ctrl->val;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -214,7 +217,7 @@ int venc_ctrl_init(struct venus_inst *inst)
>  {
>  	int ret;
>  
> -	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 30);
> +	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 31);
>  	if (ret)
>  		return ret;
>  
> @@ -351,6 +354,9 @@ int venc_ctrl_init(struct venus_inst *inst)
>  	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>  			  V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME, 0, 0, 0, 0);
>  
> +	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> +		V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE, 0, 1, 1, 1);
> +
>  	ret = inst->ctrl_handler.error;
>  	if (ret)
>  		goto err;
> 

-- 
regards,
Stan
