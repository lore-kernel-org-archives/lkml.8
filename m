Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612DDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC40206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PQF+y8KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgGBTmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:42:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 12:42:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so29900098wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=boCB++59YR1MS+YXDEsix8grOvspQ3z1Y08y0ZLgZ3M=;
        b=PQF+y8KNYwb22Q8KdP3OAcdMJA4IqMbKEHL0VW2HKOSAifxvWv7JV3/2jSaAMwQKmC
         yyrqxksTOJuDhBpap8LABoL21w9yiPKPgAcBHvQ6mQUqZd1ObsFhLXukaTkela0tkKkY
         u+xQcjPcxExrm1ORvBwlxnQ2Op6CsKYkAjzms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=boCB++59YR1MS+YXDEsix8grOvspQ3z1Y08y0ZLgZ3M=;
        b=TlAudpFjifSpcoXiLaJ8CI9Or4KPdPLNkYZae8fJece5JkXYVUk0emuPF3L3uY4QDf
         9UJTw365PsfCTWrctrPjcG54x4BULZMGwXzHpzFQTcVfgHLiBkNH4A5SHjN2cR22svIH
         zYooRmA5haCcc03Hgv3E975f+oOu7lSMhnA5HGtJR4DGDIKXtd3+9hxiQndcySMVsEbp
         6bOiyZztbg78GWS85kD0VKR3bN76am2dH1fF4sO7RVyVsJ1uquA8FQ5KWUAdtjXsnTCJ
         BwWHvhENoaA561fOsgsypPiEH5dduG23yf0JBvywqiWPA1nB4iKyX4KSfeLZpflbJ/QQ
         vJ/A==
X-Gm-Message-State: AOAM533KVSTzlaW0hRnokyN3M3W95S1Yr5uAtPkuP7NziSS1tWKXNyp5
        1mC5P4dUpWFpZfrPcDsNJN78NA==
X-Google-Smtp-Source: ABdhPJzMRYhWDDE1A6uTlQOnn160yt2vebFmKVc0TguTYEF2G0upJ3FMfPQL5UatjdrLA7BjMU02Bw==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr35078507wmk.171.1593718965566;
        Thu, 02 Jul 2020 12:42:45 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y6sm11965936wmy.0.2020.07.02.12.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 12:42:44 -0700 (PDT)
Subject: Re: [PATCH 15/15] mmc: host: sdhci-iproc: Tell the compiler that ACPI
 functions may not be used
To:     Lee Jones <lee.jones@linaro.org>, ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200701124702.908713-1-lee.jones@linaro.org>
 <20200701124702.908713-16-lee.jones@linaro.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3a32b98c-45c6-6f8d-0853-161f91e65b57@broadcom.com>
Date:   Thu, 2 Jul 2020 12:42:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701124702.908713-16-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 2020-07-01 5:47 a.m., Lee Jones wrote:
> ... as is the case when !CONFIG_ACPI.
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
> ---
>   drivers/mmc/host/sdhci-iproc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 225603148d7de..9c7d130205edd 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -294,7 +294,7 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>   
Would it better to compile this in if CONFIG_ACPI is defined instead?
#if CONFIG_ACPI
> -static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
> +static const struct acpi_device_id __maybe_unused sdhci_iproc_acpi_ids[] = {
>   	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
>   	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
>   	{ /* sentinel */ }

