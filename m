Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8126C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BB120884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d3SGD0CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGBUtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:49:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2CBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:49:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so30039361wrn.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wom8WLHjfL3Q8VlfcUPECxzZe9g1W+gEf0ik/X56Z/Q=;
        b=d3SGD0CBMF/xD10eb7Ube4/02nWKnG5B2G/Qo/a2Ht860voJLXOnDIO0bmS3dNyq91
         zQQaOHymx7jDdyKsA9wgIZKhiuEedFmsZlv93IPfP2HXZcG+3foqg/lEK5eXZYHBUPQ1
         mlNMjDIW1m0Ksccj1zdN/vCfsx2UxgbN9gct4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wom8WLHjfL3Q8VlfcUPECxzZe9g1W+gEf0ik/X56Z/Q=;
        b=UP15FPYrNrILgJCRoLq4g4kX20AVAwvH4nZKQb5NjCttCes8luiclSHUrUrHDov7Vt
         ircZxDmfI8ARBi/3E/8tR1p6fXogBdwMOY7qtnKCOwitVcBjUH/UDVLfpY96NtXHGyBH
         E1et8qXMzERNKCzcYSjWAzaucScQkAbEp0flIs0kOOVsrIsemcwA3Gz+OqXk67dfe9pa
         gBA7QgTzauCjKyBh0ozdQY7rD/7h1YUGXyicDGtjndHq9oe3uO2XXGv/FCtajJuxfzLm
         66R5LxfzWr4eVgm1aM9d8aXJjsde1FWki9bURtDRW+s97ECprJFP/JeE1KtnjxIFadfi
         NoGw==
X-Gm-Message-State: AOAM531TB0MoOf80JDuSnh7uuUxwb7JfHlTJlhhVoeBWVlHjxIO2kMRK
        wYnSru6Q42WtQlNcHHXyZ7FvM74OFjs8LA==
X-Google-Smtp-Source: ABdhPJxtA/2UYvPFmcoCOjprUjTVjn63lRIydkAoEW2AsGRYSN1zgGxBHlr0G2YhtBN0+mtt9RC0RQ==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr33438657wru.341.1593722979286;
        Thu, 02 Jul 2020 13:49:39 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t4sm12192617wmf.4.2020.07.02.13.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 13:49:38 -0700 (PDT)
Subject: Re: [PATCH 15/15] mmc: host: sdhci-iproc: Tell the compiler that ACPI
 functions may not be used
To:     Lee Jones <lee.jones@linaro.org>
Cc:     ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200701124702.908713-1-lee.jones@linaro.org>
 <20200701124702.908713-16-lee.jones@linaro.org>
 <3a32b98c-45c6-6f8d-0853-161f91e65b57@broadcom.com>
 <20200702201348.GT1179328@dell>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <28024d96-5687-cb5a-e3c9-86e9831f6ca5@broadcom.com>
Date:   Thu, 2 Jul 2020 13:49:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702201348.GT1179328@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-07-02 1:13 p.m., Lee Jones wrote:
> On Thu, 02 Jul 2020, Scott Branden wrote:
>
>> Hi Lee,
>>
>> On 2020-07-01 5:47 a.m., Lee Jones wrote:
>>> ... as is the case when !CONFIG_ACPI.
>>>
>>> Fixes the following W=1 kernel build warning:
>>>
>>>    mmc/host/sdhci-iproc.c:297:36: warning: ‘sdhci_iproc_acpi_ids’ defined but not used [-Wunused-const-variable=]
>>>
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: Ray Jui <rjui@broadcom.com>
>>> Cc: Scott Branden <sbranden@broadcom.com>
>>> Cc: bcm-kernel-feedback-list@broadcom.com
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>    drivers/mmc/host/sdhci-iproc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>>> index 225603148d7de..9c7d130205edd 100644
>>> --- a/drivers/mmc/host/sdhci-iproc.c
>>> +++ b/drivers/mmc/host/sdhci-iproc.c
>>> @@ -294,7 +294,7 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
>>>    };
>>>    MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>> Would it better to compile this in if CONFIG_ACPI is defined instead?
>> #if CONFIG_ACPI
> Literally can't win.
>
>   https://lore.kernel.org/linux-arm-kernel/CAGb2v66Ws4WNPZbOYQvikKoozj_2WjzS-Jq-o2VxT77=k0vODw@mail.gmail.com/
>
> Damned if we do, damned if we don't. ;)
This is very minor in this one change here, but it's just more bloat of 
things that really should be compiled out if they're not used.
I don't understand why __maybe_unused would be preferred approach - 
unless it is not linked in when it is not used?
>
>>> -static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
>>> +static const struct acpi_device_id __maybe_unused sdhci_iproc_acpi_ids[] = {
>>>    	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
>>>    	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
>>>    	{ /* sentinel */ }

