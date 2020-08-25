Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7399A2074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diMnaWxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHYNOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgHYNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:14:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F684C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 06:14:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h15so5933213wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J2KLLHnWpzEaROqybattjmp752iKViN/pWCMk2HsG6o=;
        b=diMnaWxxxQ1b4KnV9p1ds1iP6jlA49k4zMKFqrt6UUzC+pTeMietsYGYeO3+g7LZ+X
         BjJZpq4TbL4/eKtsNRKXxYh4jeU+J0pBOvmABldjaz6hKNnt/aM7IK8mry8dPgMNs2cD
         zFQJ5CT2PEG2x6HjqG62X0fxufHGzshuxeLvstVfRBXgxy1ilrL4SjYkUm//lIXW4DQL
         E7yCrY8csXQ6JXESWRsNd+buhKNT1nwQySZWsekFupQO6dLQXBLtiwWdQVUJYJWmS15b
         SGF3vfAfXu50Qw09uKCvLLdE3siHMMGeujTbU5vqgQhmXu3O/utbrLn5FZxaDdGCTilU
         1yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2KLLHnWpzEaROqybattjmp752iKViN/pWCMk2HsG6o=;
        b=VAuAz0HtpONmKOJI9+9ZW6vR2VV6Wu7+4rkl0/OLjFC5AixhnCTYvDb7A9kx4yzxDG
         CyBR0L6Iy8b4CupuYJxMmVzJZ/p8qm+8dTwV5YMxgn8jgeo9w0WkyVU1nN4Wreywr78y
         7aL/Y0oXkz6x3fAgO5kMhN77KN//pk0KY7gGqhWF6dzIng4TUC2usg5F3Pg/k0nDNFkH
         ziPV0A5S/6mDS0Js+BSNK0RhbvoBN3DOV0iLwOuKKCXItxVojpFspCFk/5/VkEI5aFyj
         ankrSMfnQWFFpsCobjbpT55eWXFzAoZRFf1rIwoSfRjQr7A0HLsCw33WeIdqrcEP1kaN
         navA==
X-Gm-Message-State: AOAM533b3dAfC/qQtzgKFT7IH2jVluU8JsiK4BUumNWDhe/gdNePNrI1
        hjUBk/hIsboFM4zbKLJv+4eMLw==
X-Google-Smtp-Source: ABdhPJxCPhGC8o2j7hWAzsss3oYxt71NlITRxQ7VCIMr0NGOVx0aZ/OkPd6JMEkFzAXFV9uaYIojaA==
X-Received: by 2002:adf:c108:: with SMTP id r8mr10930488wre.350.1598361241278;
        Tue, 25 Aug 2020 06:14:01 -0700 (PDT)
Received: from [192.168.1.4] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id u17sm18413285wrp.81.2020.08.25.06.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 06:14:00 -0700 (PDT)
Subject: Re: [RESEND 3/3] venus: handle use after free for
 iommu_map/iommu_unmap
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1596781478-12216-1-git-send-email-mansur@codeaurora.org>
 <1596781478-12216-4-git-send-email-mansur@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <05935d9c-b8f2-42b3-181c-023f716d4949@linaro.org>
Date:   Tue, 25 Aug 2020 16:13:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596781478-12216-4-git-send-email-mansur@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/20 9:24 AM, Mansur Alisha Shaik wrote:
> In concurrency usecase and reboot scenario we are trying
> to map fw.iommu_domain which is already unmapped during
> shutdown. This is causing NULL pointer dereference crash.
> 
> This case is handled by adding necessary checks.
> 
> Call trace:
>  __iommu_map+0x4c/0x348
>  iommu_map+0x5c/0x70
>  venus_boot+0x184/0x230 [venus_core]
>  venus_sys_error_handler+0xa0/0x14c [venus_core]
>  process_one_work+0x210/0x3d0
>  worker_thread+0x248/0x3f4
>  kthread+0x11c/0x12c
>  ret_from_fork+0x10/0x18
> 
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 8801a6a..c427e88 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -171,9 +171,14 @@ static int venus_shutdown_no_tz(struct venus_core *core)
>  
>  	iommu = core->fw.iommu_domain;
>  
> -	unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, mapped);
> -	if (unmapped != mapped)
> -		dev_err(dev, "failed to unmap firmware\n");
> +	if (core->fw.mapped_mem_size && iommu) {
> +		unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, mapped);
> +
> +		if (unmapped != mapped)
> +			dev_err(dev, "failed to unmap firmware\n");
> +		else
> +			core->fw.mapped_mem_size = 0;
> +	}
>  
>  	return 0;
>  }
> @@ -288,7 +293,11 @@ void venus_firmware_deinit(struct venus_core *core)
>  	iommu = core->fw.iommu_domain;
>  
>  	iommu_detach_device(iommu, core->fw.dev);
> -	iommu_domain_free(iommu);
> +
> +	if (core->fw.iommu_domain) {

why not just ?

	if (iommu)

> +		iommu_domain_free(iommu);
> +		core->fw.iommu_domain = NULL;
> +	}
>  
>  	platform_device_unregister(to_platform_device(core->fw.dev));
>  }
> 

-- 
regards,
Stan
