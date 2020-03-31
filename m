Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96748C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DB4206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRwnd3Q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgCaBro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 21:47:44 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51331 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgCaBro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 21:47:44 -0400
Received: by mail-pj1-f66.google.com with SMTP id w9so415967pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 18:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UpB1U8UKWiq62j367un43EKBFMcPdAcS2CCdpbcdj5g=;
        b=rRwnd3Q+/K7GUz1KqhJpsqM5TKuifHL29DE4+s4HIRQcp3BUcKgjsMXYlNE+fxxUUR
         Un3xX902i0Ruh0XR/RzD/CNgDWUzdqXFX8RPJx1B9RawpI85LnhUTAmtwTVNcycX5JKB
         XQzaODmkf5wLCwtKBpCxaSsIEOtTas0QVU3qP5Qit+ihGFiop0G4QqvoVmwfzBlRJAZk
         2DaJ277tJ5/fArAGPSKSLv9KtqtcHi0mD+FQCuvDfmR/N43+bCbxfqI3ClbqbahN6euL
         6rizcaUrDGlzeACSCHrDDP9uPOd9WFQyubTQvs93nZw/qD09txqPMq5Lzm8NkFlHYa5m
         wd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UpB1U8UKWiq62j367un43EKBFMcPdAcS2CCdpbcdj5g=;
        b=GdiEW/wkA6VFLdiECAk5xz1KEE+u9ll9atZysrR5QCm0a4Y3XQFhVsihaVtrJT8JCF
         4gw/qzzJMbOMOjn7cTGarlvvkCudsHsuGjAbHa7whqA3SXsiEElQ5rfgQ+LRWDP/rlsz
         W8cPCho7urIFVKRYTcLUjEmO8b4k9FjO1mvNtstlWGQOC1x57nyDhNhxuCcM1LALaBQJ
         EVT6vRjiWoYq+Q8bD9bzwaiESAatTHW5UN764A0uFQaN3LKsQOXfLOg3bS9sWs5had3M
         qQOQNXDvD/Od718UeTx9fsB8DRbkMc76bSvAOhqQqXQ3OZqmydKx4BubSAMt6OWrwXkS
         T/MQ==
X-Gm-Message-State: ANhLgQ0WOTs48XO1y/ab5kdKX2Fbv6nUdTOWQaFUgAVvrlYHmsxYZynN
        YoM2+bVCCoPuKjVrFWpuUkA=
X-Google-Smtp-Source: ADFU+vv8BSGdbavs2Hov/tawhora8KeuW5yRc9VYjhPkUHGT4das0ikDjzFi6zXXec/X/y9yAPhUVA==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17mr14466026plo.53.1585619262926;
        Mon, 30 Mar 2020 18:47:42 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id c207sm11171917pfb.47.2020.03.30.18.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 18:47:42 -0700 (PDT)
Subject: Re: [Update PATCH] x86/Hyper-V: Initialize Syn timer clock when it's
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org
References: <20200330141708.12822-1-Tianyu.Lan@microsoft.com>
 <87d08t3mnn.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <01238d57-3eee-ddee-0fa8-7e387709abbb@gmail.com>
Date:   Tue, 31 Mar 2020 09:47:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87d08t3mnn.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly:
     Thanks for your review.

On 3/30/2020 11:09 PM, Vitaly Kuznetsov wrote:
> ltykernel@gmail.com writes:
> 
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Current code initializes clock event data structure for syn timer
>> even when it's not available. Fix it.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>> - Fix the wrong title.
> 
> The new one is ... weird too :-)
> 
> I think it was supposed to be something like "x86/Hyper-V: don't
> allocate clockevent device when synthetic timer is unavailable"

Good suggestion. Will update in the next version.
> 
>>   
>>   drivers/hv/hv.c | 15 +++++++++------
> 
> Which tree is this patch for? Upstream clockevent allocation has moved
> to drivers/clocksource/hyperv_timer.c
> 
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index 632d25674e7f..2e893768fc76 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -212,13 +212,16 @@ int hv_synic_alloc(void)
>>   		tasklet_init(&hv_cpu->msg_dpc,
>>   			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
>>   
>> -		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
>> -					  GFP_KERNEL);
>> -		if (hv_cpu->clk_evt == NULL) {
>> -			pr_err("Unable to allocate clock event device\n");
>> -			goto err;
>> +		if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
>> +			hv_cpu->clk_evt =
>> +				kzalloc(sizeof(struct clock_event_device),
>> +						  GFP_KERNEL);
>> +			if (hv_cpu->clk_evt == NULL) {
>> +				pr_err("Unable to allocate clock event device\n");
>> +				goto err;
>> +			}
>> +			hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
>>   		}
>> -		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
>>   
>>   		hv_cpu->synic_message_page =
>>   			(void *)get_zeroed_page(GFP_ATOMIC);
> 
