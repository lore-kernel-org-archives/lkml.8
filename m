Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBF8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934D620578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WlZmD7df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgGGPrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgGGPr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:47:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE609C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:47:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so20183875pgn.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8OsXhI1ow0ICnQQfygb3TbrMB8HYFWWZMqnOKFYxMt0=;
        b=WlZmD7dfuVkARO3bbn8Rez6bpySJlZ2m8+d0iTFhuQWQcOrGG8Z8UXAamA1rD1l6oD
         21M8bAtWrUWfV51OR0gr99MO0ksKYRnCmrZ2hU6iI61AeJogo1ZWmFNBAagHVtMwNMBX
         eJOGqOo4tg2Lw7NwAKy1Iqa+qHEGUh5oBWHWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8OsXhI1ow0ICnQQfygb3TbrMB8HYFWWZMqnOKFYxMt0=;
        b=QnLBE1xwfZ5w4H2t9BefGM1jyTa6LBdA0yWrl8Pb1H+QtMtOLsXHuQpS3yNo/84OSn
         fI41uJX6UVpZfB/77UHENbAlMlzDcg/qg8gSLhjeIvnD6hHaV+ZowBBbJl6JJDBvJ5H9
         yWj2O2Cw0Zl7y5PdSMqB/zByqKbnBAaY5ZTlbFpi1CmkuVjb+F3N6tDHfvLKxEgDKPAy
         dXTQTmR2GjxHzfezUXhprktec+XGb2CLW8U3T83xJWTCEAqiTohoxfykSobjwp/+o/1R
         B2caT+8PD3U3ySHy9yG2y1kzXIr4SkU+Y1FQOpOphXdrorCOOkW37czOrMV8IeFdD27S
         Q1fQ==
X-Gm-Message-State: AOAM531d92G5qE1YTTBRhobTEH9WUmdOKNf93sfCOmlMd7ct9yuNgYo6
        jlpj87fc1qnjZaAt+yx3//cO7w==
X-Google-Smtp-Source: ABdhPJxQxJa1njAaRhDNLuicmcU7WU2v2N9eWIWAAkK6x7NhLBDYZ8Iwn/Vic99qtjC3a+OO4o6k5A==
X-Received: by 2002:a63:a361:: with SMTP id v33mr41437759pgn.101.1594136849214;
        Tue, 07 Jul 2020 08:47:29 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z26sm22712347pfr.187.2020.07.07.08.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:47:28 -0700 (PDT)
Subject: Re: [PATCH v2 15/15] mmc: host: sdhci-iproc: Do not define 'struct
 acpi_device_id' when !CONFIG_ACPI
To:     Lee Jones <lee.jones@linaro.org>, ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200701124702.908713-1-lee.jones@linaro.org>
 <20200701124702.908713-16-lee.jones@linaro.org> <20200707064701.GC3500@dell>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <78030915-d7a4-d0f1-3ab8-f6e5c8bb59cf@broadcom.com>
Date:   Tue, 7 Jul 2020 08:47:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707064701.GC3500@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks

On 2020-07-06 11:47 p.m., Lee Jones wrote:
> Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
> 'struct sdhci_iproc_acpi_ids' becomes defined but unused.
>
> Fixes the following W=1 kernel build warning:
>
>   mmc/host/sdhci-iproc.c:297:36: warning: ‘sdhci_iproc_acpi_ids’ defined but not used [-Wunused-const-variable=]
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 225603148d7de..e2d8dfe90077e 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -294,12 +294,14 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>   
> +#ifdef CONFIG_ACPI
>   static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
>          { .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
>          { .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
>          { /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
> +#endif
>   
>   static int sdhci_iproc_probe(struct platform_device *pdev)
>   {

