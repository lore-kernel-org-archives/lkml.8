Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C53C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01113206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlBfyTly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbgFWJqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732176AbgFWJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:46:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E351C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:46:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so20955315ejj.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x+77SZ+h191D5taiGIual/fH3dxCziZR7JzlGfHatlI=;
        b=PlBfyTlyRsdE4Hjc2qcH9bWRW/CcTDVvYJ9WSRBw17Ei+1vZse8RqGb6Nllr3H31pK
         CnRPgRvogdkUThTlf424Tj9KDrKdiFZYhkZrqpgkdLXo+MDhkT6YIZFnFOjKFF3Yzimv
         toftp8vJf8cGsApoMj8kTBeH6NIsvMh1ewEViJH1r5VWWVKCFaxm2YzgS577MopiREV0
         luu6DQIg5yd57q+i7rwrmr+Q/+2VxyWDK4IYKDHEmh4zwZ+YDr5cDM03LbO4OpxE6Js7
         sTjFrD4zHHfWRtxGFwD3C6iVO2yQzS8WzMFuCzgreTB37x+hCsTskZBU2GccvkOjrCAa
         Rgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+77SZ+h191D5taiGIual/fH3dxCziZR7JzlGfHatlI=;
        b=pjboTWd8QP/MYEWFnozvlKAItJ2Jl7XBO9YqN1jyh1hgjrxcQQ96xPY1n07CIqrf/0
         eEEsSxztoueLGZpQK5rcOv7W6A6jfadRd01LpmaHpJfbwm3ffHJNm4GgvymQ/yR+Fy2N
         t7kdaag+/vOZOI1B6V938IEPyzUwinX1UlWU0s/OCeS9DlJyeXuzQeIOQ/Eg/Pu1l1oP
         HJAuTSOwUZLZTI3D1DniEMMkj+Et0EzyHfohFlTS3iNV0Tw4ozB8Ix6dH5hq7dj+XiwT
         gx9dOZlf3R5gKQtUY1LnjAV3bInwcstMhIY+oDipAubBJUNw9iiS2Nntt9TeblaWN7jB
         7/HA==
X-Gm-Message-State: AOAM530jofu18ioP/pjpuGcBRyTEhZX4KpLKj5FEpapPy6e3GIKyX2Nn
        OtbsyNYbd+rrtvFQtRv9gYkKzgbGZc/rLA==
X-Google-Smtp-Source: ABdhPJyKssYlhvVFoqJPqqFT0oY7g6LG8jXxrJ9ggE47PRgNm8b4O7gNRoAlUcC9URw4jkbhDAcKmw==
X-Received: by 2002:a17:906:d78f:: with SMTP id pj15mr2290711ejb.283.1592905560963;
        Tue, 23 Jun 2020 02:46:00 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-249.ip.btc-net.bg. [212.5.158.249])
        by smtp.googlemail.com with ESMTPSA id rv16sm4970844ejb.60.2020.06.23.02.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 02:45:59 -0700 (PDT)
Subject: Re: [PATCH] media: venus: vdec: Fix runtime PM imbalance in vdec_open
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200522111357.2613-1-dinghao.liu@zju.edu.cn>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <5d88210d-db4c-e171-5d4b-5dffe22d4d48@linaro.org>
Date:   Tue, 23 Jun 2020 12:45:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522111357.2613-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao,

This patch is not applicable anymore after [1].

[1] 63342afea65e ("media: venus: vdec: Use pmruntime autosuspend")

On 5/22/20 2:13 PM, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 4ed2628585a1..6f2964130728 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1349,7 +1349,7 @@ static int vdec_open(struct file *file)
>  
>  	ret = pm_runtime_get_sync(core->dev_dec);
>  	if (ret < 0)
> -		goto err_free_inst;
> +		goto err_put_sync;
>  
>  	ret = vdec_ctrl_init(inst);
>  	if (ret)
> @@ -1394,7 +1394,6 @@ static int vdec_open(struct file *file)
>  	vdec_ctrl_deinit(inst);
>  err_put_sync:
>  	pm_runtime_put_sync(core->dev_dec);
> -err_free_inst:
>  	kfree(inst);
>  	return ret;
>  }
> 

-- 
regards,
Stan
