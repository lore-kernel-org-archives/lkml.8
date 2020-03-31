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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE84C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE76A20838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUYTZLh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgCaMGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:06:10 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56291 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbgCaMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:06:10 -0400
Received: by mail-pj1-f67.google.com with SMTP id fh8so979299pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t3s/VyfIuN88XmQbt4LtAx88/o8uoI4xPIOjtF8N7a8=;
        b=TUYTZLh0mZkdBxBpmk1035sLwQw5a5koO5WsnCz1sAWv5zA+WcIY/3mDPUvZftp9fw
         xi6tnrpsfIxaWtvqhTcrC8G6FmPkMFvn0RyJcMZ3Puft3rPZM4kBiyQ6jkVdiZj5pfzH
         x5x+tJFdNE+2rh1pzfN1WvYhksO3zmRDBQgnu4JwC99OgMBkotNnlRMOO9G8Nf9bN4sG
         XFTND6XXnsLfXJ/pY8yq5cUZoFVLIokM5LKgKV4+bnIFHSDQ8rcV7YnTgGOS169TU6f4
         E6MLPninDc9+2VlKm/7y9lrzMqf4OXxpIbdmTXhPhRvz3i0jINJxEvOR5MehCNVHF5w9
         FGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t3s/VyfIuN88XmQbt4LtAx88/o8uoI4xPIOjtF8N7a8=;
        b=UFKGeZUO8yVkdsZ/FWI6Cn5y3DR8r6r51qF4M99XtnAk4XgjqFiy6N7W9T/1ScO/WZ
         HgI5sD6AfvHKLkkaa19nqK60cm/qOA4QIYkoAHnKdua3D7rTdKA5lapnHIJoYAydZ6d3
         9m0/gFGa+efqCJVMMm652dom4nTnEaqoFQDCG7zaC/JU7yWpTKUitorppcsyYeQL6NId
         VVL07QB++qZUbaaTYH1QF3m7YRFzCuz1eybCk8h4ZUJI4jAqRWzOPNCo5zgWuMqB+nkq
         sEyP+qLRgKECq7U4At9k+ttJ4Bj5UbwpltK0js+Cp+h81Z7Undy+dmWBKFcCNwT/lh57
         iC3g==
X-Gm-Message-State: ANhLgQ03i0Azyd7A8MMkweL14vqSBfI3jNotZBpAGW4JBNsx5Mm+fgw5
        4oyzdSnLOJq+aqz1yWawT68=
X-Google-Smtp-Source: ADFU+vv/ie2Pk8JnGrq9pWhB0Z6fgO1RmRJAXLAFlkvgKUPI9v2YF6YNkPPaC2ByRXft1s+fzA4h2w==
X-Received: by 2002:a17:902:ff14:: with SMTP id f20mr16489249plj.206.1585656369062;
        Tue, 31 Mar 2020 05:06:09 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:18:efed::a31c])
        by smtp.gmail.com with ESMTPSA id b2sm1770763pjc.6.2020.03.31.05.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 05:06:08 -0700 (PDT)
Subject: Re: [PATCH V2] x86/Hyper-V: don't allocate clockevent device when
 synthetic timer is unavailable
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org
References: <20200331021738.2572-1-Tianyu.Lan@microsoft.com>
 <87sgho22ki.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <eaa37ee8-8d16-95a5-c1b3-360fb8af58b5@gmail.com>
Date:   Tue, 31 Mar 2020 20:06:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87sgho22ki.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2020 7:20 PM, Vitaly Kuznetsov wrote:
> ltykernel@gmail.com writes:
> 
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Current code initializes clock event data structure for syn timer
>> even when it's unavailable. Fix it.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>> Change since v1:
>> 	Update title and commit log.
>>
>>   drivers/hv/hv.c | 15 +++++++++------
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
> Thank you for fixing the subject! I had one more question on the
> previous version which still stands: which tree is this patch for?
> Upstream, clockevent allocation has moved to
> drivers/clocksource/hyperv_timer.c and the code there is different.
> 
Yes, I just noticed I fixed an issue on the old code after Michael 
reminded me. Sorry for noise. Please ignore it.

