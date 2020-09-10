Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE0320BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tf+BqZu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgIJKok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgIJKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:43:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F9C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:43:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t16so5805628edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OdGrid5jHArS354agKgp+U0Cw8ArS/XKAuRiv2AvpLY=;
        b=tf+BqZu/Jtz2YykbHq7GkLyTKze9+8Z2KP1rjUrHGv1QNhoncmxSJ3ZRPhwpfthIOs
         /RZ4EI5duiNIFSgDq+NFAt9G9MgWkUU7z5z+Y4y9QcdDrKuqyToWs2zqxhVzsybpEzNo
         B0PVrZhBFQV1CkRr6Et/qI8vEi/hsYtBovj3/Cp30iKZq+yIDhnL8PkLiMIrpgWgy+9c
         eoypGTpaC4aWPTtILxXMMwWrA+42coYYKissX+obmt+GGF0ASwain7i7W6vzA6Xf0ZYr
         BUR25fhq5MwoL39ahMXZzk1KFCP+w+Oqmdke+ifRbkPghEd/cW1iIKiD7+wLKQKGShrn
         hiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OdGrid5jHArS354agKgp+U0Cw8ArS/XKAuRiv2AvpLY=;
        b=Ha1hpHR4//8wuUDZtQ14veJFqUe01DLPpWBdRB4P46jQaRsiu//cLWHFwwujZN3ijJ
         8JRYK7RwB/kpx3wSUIPc6Mo204+oImySDLnAJqq8KgN9LDCuAWt+u/Nh1Ytckf+xov/N
         3Xd19EkqEdVa9F6tAUE6DpoAwJEq3UcXYpCBWjPRYRbieL9yNE43ZArOYhbGawaLl9vm
         NqqOQ883x205DsyInfv5J/ypkVcq8xeCWHPFzdBOq2lCxW+QiMTZXWbky5PRNeCHHdL6
         gTUuPk61J8HWDt5nUa5g1WCQlITLyROpQvOmQremb9z08gDIPWpiNGSglmwWUt6QKni0
         sllg==
X-Gm-Message-State: AOAM5329qVDFMm38a5ViXi6uXBX70+dn8psHoA9dsx8jb/S3vYF8Fv9x
        iOl+3B66mrViqNmWl84aK4ivTw==
X-Google-Smtp-Source: ABdhPJyj6mdNNT6Yadr/16y9PbAvqa8DY90z443T/c9iIIqLAe5J/eD33GIh7457kbnnOmArf1kv9A==
X-Received: by 2002:aa7:d593:: with SMTP id r19mr8864145edq.331.1599734620543;
        Thu, 10 Sep 2020 03:43:40 -0700 (PDT)
Received: from [192.168.1.8] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id ks21sm6485542ejb.63.2020.09.10.03.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 03:43:39 -0700 (PDT)
Subject: Re: [RESEND 1/3] venus: core: handle race condititon for core ops
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1596781478-12216-1-git-send-email-mansur@codeaurora.org>
 <1596781478-12216-2-git-send-email-mansur@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <de32b19e-c643-54d7-0233-c9fe03d4762a@linaro.org>
Date:   Thu, 10 Sep 2020 13:43:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596781478-12216-2-git-send-email-mansur@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mansur,

On 8/7/20 9:24 AM, Mansur Alisha Shaik wrote:
> For core ops we are having only write protect but there
> is no read protect, because of this in multthreading
> and concurrency, one CPU core is reading without wait
> which is causing the NULL pointer dereferece crash.
> 
> one such scenario is as show below, where in one
> core core->ops becoming NULL and in another core
> calling core->ops->session_init().
> 
> CPU: core-7:
> Call trace:
>  hfi_session_init+0x180/0x1dc [venus_core]

I thought more on this issue. I think we have to return error from
hfi_session_init() in the case when the driver is in
system-error-handler. Infact all userspace ioctls must end up with error
while we are in recovery state. What do you think?

>  vdec_queue_setup+0x9c/0x364 [venus_dec]
>  vb2_core_reqbufs+0x1e4/0x368 [videobuf2_common]
>  vb2_reqbufs+0x4c/0x64 [videobuf2_v4l2]
>  v4l2_m2m_reqbufs+0x50/0x84 [v4l2_mem2mem]
>  v4l2_m2m_ioctl_reqbufs+0x2c/0x38 [v4l2_mem2mem]
>  v4l_reqbufs+0x4c/0x5c
> __video_do_ioctl+0x2b0/0x39c
> 
> CPU: core-0:
> Call trace:
>  venus_shutdown+0x98/0xfc [venus_core]
>  venus_sys_error_handler+0x64/0x148 [venus_core]
>  process_one_work+0x210/0x3d0
>  worker_thread+0x248/0x3f4
>  kthread+0x11c/0x12c
> 
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 2 +-
>  drivers/media/platform/qcom/venus/hfi.c  | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 203c653..fe99c83 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -64,8 +64,8 @@ static void venus_sys_error_handler(struct work_struct *work)
>  	pm_runtime_get_sync(core->dev);
>  
>  	hfi_core_deinit(core, true);
> -	hfi_destroy(core);
>  	mutex_lock(&core->lock);
> +	hfi_destroy(core);
>  	venus_shutdown(core);
>  
>  	pm_runtime_put_sync(core->dev);
> diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
> index a211eb9..2eeb31f 100644
> --- a/drivers/media/platform/qcom/venus/hfi.c
> +++ b/drivers/media/platform/qcom/venus/hfi.c
> @@ -195,7 +195,7 @@ EXPORT_SYMBOL_GPL(hfi_session_create);
>  int hfi_session_init(struct venus_inst *inst, u32 pixfmt)
>  {
>  	struct venus_core *core = inst->core;
> -	const struct hfi_ops *ops = core->ops;
> +	const struct hfi_ops *ops;
>  	int ret;
>  
>  	if (inst->state != INST_UNINIT)
> @@ -204,10 +204,13 @@ int hfi_session_init(struct venus_inst *inst, u32 pixfmt)
>  	inst->hfi_codec = to_codec_type(pixfmt);
>  	reinit_completion(&inst->done);
>  
> +	mutex_lock(&core->lock);
> +	ops = core->ops;
>  	ret = ops->session_init(inst, inst->session_type, inst->hfi_codec);
>  	if (ret)
>  		return ret;
>  
> +	mutex_unlock(&core->lock);
>  	ret = wait_session_msg(inst);
>  	if (ret)
>  		return ret;
> 

-- 
regards,
Stan
