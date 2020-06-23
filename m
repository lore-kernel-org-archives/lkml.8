Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F950206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Of+mxFWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgFWJrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731921AbgFWJrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:47:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92ECC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:47:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a1so6923389ejg.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zrmS3gtTtQi2K4pHTUv0F6q9doiPp0Co7v5Yn1sfwnU=;
        b=Of+mxFWt4GzUnIW+a9/K2elfBjiOpM+Fj6/L3R+8cuHbLnWeh+6bgR676UMbUV1ols
         XVbeZTzFaO+42UXh5NTacD2pXb4moofm09bJp/fwRx2Uy1uOnx9dL/60ZU1qH4y1IiQe
         b50//s8mc0XhoJwKsO6WtUaGpSJq1mADHrg9pUZtKDhUPixD2Ou/d7LmfxNMcX7teHF3
         XAktmS/zFNq6FGCIHJ7HCFBu2TPRR6a4DDVpH51XxJJJTNnKiOmCSrvmLLAubnSpc96f
         eeimgnxBbvFdb39LTrujygMt0fpT7mYoeUd/+HQie9LOOiGqa3KVuhw/pMPrWVeZOv2P
         ljuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zrmS3gtTtQi2K4pHTUv0F6q9doiPp0Co7v5Yn1sfwnU=;
        b=jlw/nMjIYVKdO5Gg4t+Az5dqVbjAuVVLif64iR3aDKF8uJ2rRwEV9RGUcKV9uh8JKw
         CfUBn/VTZCTFqk41+kQ65Os3wo1e8UpsRJNMGHacM96qntr8RHN6QoR3JlP7qW+jT+Xa
         mCFJZswIQR4ZqDd6pioYx5v6k3pXMIIL1rmBVqqvISD3KbyjYLbJSkCpI7dMo7rnyTvx
         uLwWc73wsiWdoR38Mx/ZejWwucmMvdnpGY52Wo3OPj7atWmna+GXt/VP48l/Eo/bKPZE
         Co1RvW0DlNIsbfxZXTn4BsJ+bsNSJGRtzetD3avbf8YJ/3rupeh8i3DKekKePA4TVfoK
         jAxQ==
X-Gm-Message-State: AOAM532N4OF4AsEit77/cxUZ3c1bRH/85X636gV1iqby2EyZYPebWJd2
        LzoSBBwqAbtre8LM4AfsUQ1AMeT+GLSWeQ==
X-Google-Smtp-Source: ABdhPJyVv2e/pbkuvnYAXqgFazRNKuDtyZiYAnHSEMVx0ukqHYTA41EbzOlMIi3sxLzqqJLXjba/lQ==
X-Received: by 2002:a17:906:168b:: with SMTP id s11mr3840952ejd.444.1592905633803;
        Tue, 23 Jun 2020 02:47:13 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-249.ip.btc-net.bg. [212.5.158.249])
        by smtp.googlemail.com with ESMTPSA id z22sm3210381edx.72.2020.06.23.02.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 02:47:13 -0700 (PDT)
Subject: Re: [PATCH] media: venus: venc: Fix runtime PM imbalance in venc_open
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200524043132.32758-1-dinghao.liu@zju.edu.cn>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <c7f623b3-792b-d53f-a2ab-3736b79cb9b3@linaro.org>
Date:   Tue, 23 Jun 2020 12:47:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200524043132.32758-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao,

Thanks for the patch!

On 5/24/20 7:31 AM, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 9981a2a27c90..eefcfbb8f211 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1169,7 +1169,7 @@ static int venc_open(struct file *file)
>  
>  	ret = pm_runtime_get_sync(core->dev_enc);
>  	if (ret < 0)
> -		goto err_free_inst;
> +		goto err_put_sync;
>  
>  	ret = venc_ctrl_init(inst);
>  	if (ret)
> @@ -1214,7 +1214,6 @@ static int venc_open(struct file *file)
>  	venc_ctrl_deinit(inst);
>  err_put_sync:
>  	pm_runtime_put_sync(core->dev_enc);
> -err_free_inst:
>  	kfree(inst);
>  	return ret;
>  }
> 

-- 
regards,
Stan
