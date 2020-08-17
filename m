Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D38C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A460F20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nslJ1+xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgHQJnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgHQJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:43:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2EAC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:43:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so14295335wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qPlhVA01MUGvYBvTptO3+HXUAf2pza0AyA7yKccmN8M=;
        b=nslJ1+xoD0yWudkHNjqrd/pHfIZV1qUk9jRWIG95ey32Rmmnr/dg6qtTTnUknd+UGf
         iVDH83hLu4R3LIo2dV6/7hWGOmRzyX6jGES6ysEd91TVupDrDkCUUHGybo4zF0Q7lgk2
         TAou0KBPZ9URL6vGmmYgIBOXgvXahr5yR/I30kocPO2szduyKzQY+Fiq/JWgR3kuTq4/
         hVxZaSdlVhRpKpB79mUVDMLU232XeXks/HyYBKB0CrQWrL7z6OVYDXbaf4XDkw/SUK5R
         0DwOWhFDlJLsJiKNV/+H3rqk7mXKxRan2OcOvZK5grcdYRjfw1lJ+fUL3G7/s3ypgVU+
         6gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qPlhVA01MUGvYBvTptO3+HXUAf2pza0AyA7yKccmN8M=;
        b=efAWmwEhFc91XvtrxsAC8i1v9ClFVDMmPyb5rrDPkaAZKne/OgjTaLFcuVif668xRp
         yeQvwNNh9ZYsUMyS2p7TNXRCvv8SeYIGY1vZQvsSuqy0ijLxF7mwL3gLNW5SOn69iU/P
         x188tZlEsU1i6LsWLRdw+ZdT/hoImJyU+Igcxd0O/iu6cio9bKY8GWUQPy1z7TFcYepb
         H72k2lioZ8sZgmk3hIlEZrKxT3GRDMxEPL1E5zlckDnu3C910ZqMncMKPLuxiLkNiW7i
         Ipw4h2XIYH1V58tWfy44YRpw6i77Ic3CtgAy35LTNJ+Kr5WOw/Dbdh028zKhTBzsOE+d
         RVow==
X-Gm-Message-State: AOAM531Zh55pA2sasfDYwPaDmf6WBCNj+peUGW4pO41F8gZ2Ix/r4fxI
        R4VjZ3258sB+uwBd2vTMjBiTsw==
X-Google-Smtp-Source: ABdhPJzLQ3hYfhFcIyaTTVp965Xi1bI8BaT5rrHoC/S3nivR3ZHXbMOurHwGPuRyfJKx2YyKXGtUBg==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr15230345wro.64.1597657415105;
        Mon, 17 Aug 2020 02:43:35 -0700 (PDT)
Received: from [192.168.1.10] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id v7sm12043475wmj.28.2020.08.17.02.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 02:43:34 -0700 (PDT)
Subject: Re: [PATCH V3] venus: core: add shutdown callback for venus
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, saiprakash.ranjan@codeaurora.org
References: <1596694917-7761-1-git-send-email-mansur@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <31d2e971-dda2-0aa0-661e-cca9e0aace13@linaro.org>
Date:   Mon, 17 Aug 2020 12:43:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596694917-7761-1-git-send-email-mansur@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mansur,

On 8/6/20 9:21 AM, Mansur Alisha Shaik wrote:
> After the SMMU translation is disabled in the
> arm-smmu shutdown callback during reboot, if
> any subsystem are still alive then IOVAs they
> are using will become PAs on bus, which may
> lead to crash.
> 
> Below are the consumers of smmu from venus
> arm-smmu: consumer: aa00000.video-codec supplier=15000000.iommu
> arm-smmu: consumer: video-firmware.0 supplier=15000000.iommu
> 
> So implemented shutdown callback, which detach iommu maps.
> 
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
> Changes in V3:
> - Fix build errors
> 
>  drivers/media/platform/qcom/venus/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

As there is no more comments and it looks good to me:

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 203c653..cfe211a 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -341,6 +341,16 @@ static int venus_remove(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void venus_core_shutdown(struct platform_device *pdev)
> +{
> +	struct venus_core *core = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = venus_remove(pdev);
> +	if (ret)
> +		dev_warn(core->dev, "shutdown failed %d\n", ret);
> +}
> +
>  static __maybe_unused int venus_runtime_suspend(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> @@ -592,6 +602,7 @@ static struct platform_driver qcom_venus_driver = {
>  		.of_match_table = venus_dt_match,
>  		.pm = &venus_pm_ops,
>  	},
> +	.shutdown = venus_core_shutdown,
>  };
>  module_platform_driver(qcom_venus_driver);
>  
> 

-- 
regards,
Stan
