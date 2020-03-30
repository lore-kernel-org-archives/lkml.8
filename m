Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A2AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B508020781
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCFxQqLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgC3OPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:15:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37871 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3OPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:15:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id h72so8648458pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LHpYxloEox5M+OYYOazQjYBzXSAVfO7j8aplQ6oJYxQ=;
        b=gCFxQqLyhNPSjgmGxHuNq222H5JbO4wINP0HDWUv/Z7j/x4noY9JNjTJKyLiT1xUX2
         GlbnZnsa96CbEpJWZINoGbvqeT8mMoZ3IFE5dICmW1vvh5aZbxuMCW2HVsmza8+lUPWR
         HEA7xVUAcafFMa/NsZqoeOCSFxGhtwd+jg9lmFx/ajbisFwnzefgunUel+mbBrHLE2dS
         AShUCx2tjdxiEUzL9nLs0pT1ZoaUhOQNkWp4KcgWoY8o5ZaJMMlv0Wpt9lVK7fXV3r+V
         ykrMUPvpGwy62iG0r5rzv+S+s+GZzXyeZFLr7LmRGPokojc+ICfCBUmZDNxYjm4fDgQ3
         Z0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LHpYxloEox5M+OYYOazQjYBzXSAVfO7j8aplQ6oJYxQ=;
        b=J/kGT1uTPZenyABuTIl8bmAonVBeY3pfLWHfXM6UzSNZ9Klwsb0OY7xOrhaMPuLyTO
         zQSSUKXVzId55f7Lb5GqsodEyr4Lnhf/660tztFKhg26o2PdSC9VRC4eooeqwAvEpWBw
         Eyc8tO62j3Xlnkhr8AgfWItCsn4vFaMPXig4Zve6uo+tdyw6itfCvKcQObYc+si3Vb6x
         qakKvKJsTsSCeuKs4Of4fF4WRFe2UEL2OqutTSnU2vqu9maRBLlheNt2SvGlzVzZoZM+
         awgA5NbVllqEuun9U4RwDrlSrT5zmgIUPUAFP+pFbhcAQ+G+XPbQJILLIeMyoVLub+9n
         wRnA==
X-Gm-Message-State: ANhLgQ2AKpK0Giwpld3i4Nc0Et5iGiZ7sMwUZFDpnrrCZAZmdU5BYwpZ
        AWuvMW9ne7l5UfnQSORiPMw=
X-Google-Smtp-Source: ADFU+vvKGPTUFjrDtOV4CTd4oVb3E0pEsG6rV4uN/Ex30RjVponCRhDiEw4xU9duZ/HJajUqJXue+Q==
X-Received: by 2002:a62:7c8b:: with SMTP id x133mr12784696pfc.229.1585577701224;
        Mon, 30 Mar 2020 07:15:01 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:18:efed::a31c])
        by smtp.gmail.com with ESMTPSA id b3sm9762367pgs.69.2020.03.30.07.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 07:15:00 -0700 (PDT)
Subject: Re: [PATCH] x86/Hyper-V: Initialize Syn timer clock even when it's
 not available
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
References: <20200330140950.12714-1-Tianyu.Lan@microsoft.com>
Message-ID: <afe8f1a1-a33c-b1cc-3c22-34c6155ac0b1@gmail.com>
Date:   Mon, 30 Mar 2020 22:14:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330140950.12714-1-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for wrong title. Please ignore it.

On 3/30/2020 10:09 PM, ltykernel@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Current code initializes clock event data structure for syn timer
> even when it's available or not. Fix it.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   drivers/hv/hv.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 632d25674e7f..2e893768fc76 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -212,13 +212,16 @@ int hv_synic_alloc(void)
>   		tasklet_init(&hv_cpu->msg_dpc,
>   			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
>   
> -		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
> -					  GFP_KERNEL);
> -		if (hv_cpu->clk_evt == NULL) {
> -			pr_err("Unable to allocate clock event device\n");
> -			goto err;
> +		if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> +			hv_cpu->clk_evt =
> +				kzalloc(sizeof(struct clock_event_device),
> +						  GFP_KERNEL);
> +			if (hv_cpu->clk_evt == NULL) {
> +				pr_err("Unable to allocate clock event device\n");
> +				goto err;
> +			}
> +			hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
>   		}
> -		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
>   
>   		hv_cpu->synic_message_page =
>   			(void *)get_zeroed_page(GFP_ATOMIC);
> 
