Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCF92076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE8F4eu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgHKNM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgHKNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:12:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 06:12:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so6690460pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZ9iduntohOD5MRWKGXE3NQwDvKnC/BQdlgFzYDcVCg=;
        b=TE8F4eu3B0uTZCmWX+baJY9caqGEcgZS9Ibz77pNiep8D7kqZbmgpJ8fRsP68Mq2A6
         P7tgGes4ixKX83YBlw2LTNVBHeu3Wl0wUZXhkUY5a32krwLV9jKWr+XDkjwm5U1Eap/k
         d3KY7FpiFKXGj3V/xHU8UWZpXutQkg8iw/ZTCqi38StguxoL38Aw1o8WmcGTArrJHL11
         9Bfs1J1r8fFgvuPljJTt1sqmAgAYIeWrS/9eqvq06C1rkXEh/eDCmWZBbaKT61/EHVqR
         CkfvKzcjTxi05D7nEq6teN+SHyvN4mfjgQboJmTkMLlYav8X2wBgFYKsFHimQTdpb5s3
         aFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZ9iduntohOD5MRWKGXE3NQwDvKnC/BQdlgFzYDcVCg=;
        b=FQ4Zv8WKPJzyL/W5pUsGC/U0ouwbhiMV9gD6icjFCXd+w+F+jXymNOBE9CQFOhkluf
         b9sOWSRhPooRc7shGtYJW0XDm0gfOKq8P6DiNnlKItenGcWAYPSfIaKed8E8iVKooo1i
         7pRKyAmy3V53BI9EiYSUrJuTLGFJTJzHMQcWtZbfEPcX94b3xLXS0VNYgmqGm9qSOJ2j
         XIARfA2zl0mtk1GPr/XkcESaTg1vledYpq4CsE82QmbOCNL+f9dKOP8oooufJcTVUZs/
         BLpU+HaJGz8G6dzEz3T3EECLHmJLasuBHIufCcx9786DotSFMYqnqANXsxBnZXsFxZWk
         e4Lg==
X-Gm-Message-State: AOAM5331Zm9B+k4pP1QLp7/5yDYTNfGuEhELADaWnQsoQQwfF10YiN9r
        s0qGCZneFvdH2GEKtvgQvVjTSY8X
X-Google-Smtp-Source: ABdhPJzag+6WSRDNu7ZNw4sns8gGX08sBi+Z9IMfaz/uThKA+RP5nIlholb6XTT8dwmceBQlzKmC6g==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr5978330pfn.62.1597151545250;
        Tue, 11 Aug 2020 06:12:25 -0700 (PDT)
Received: from [0.0.0.0] ([108.61.186.250])
        by smtp.gmail.com with ESMTPSA id w82sm26414844pff.7.2020.08.11.06.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 06:12:24 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Remove the duplicate check from
 group_has_capacity()
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <20200810010009.92758-1-arch0.zheng@gmail.com>
 <jhjwo26gxlb.mognet@arm.com> <9425382c-2a42-57ca-512d-c93c589dc701@gmail.com>
 <jhjv9hph3h7.mognet@arm.com> <01fe6a9b-fd3a-9b36-b2fa-6cea58415670@gmail.com>
 <jhjtux9gxh2.mognet@arm.com>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <905d8887-e79c-daf6-cbce-80fd0509e37d@gmail.com>
Date:   Tue, 11 Aug 2020 21:12:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhjtux9gxh2.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/11 下午8:48, Valentin Schneider wrote:
> 
> On 11/08/20 12:44, Qi Zheng wrote:
>> On 2020/8/11 下午6:38, Valentin Schneider wrote:
>>>
>>> On 11/08/20 04:39, Qi Zheng wrote:
>>>> On 2020/8/11 上午2:33, Valentin Schneider wrote:
>>>>>
>>>>> On 10/08/20 02:00, Qi Zheng wrote:
>>>>>> 1. The group_has_capacity() function is only called in
>>>>>>       group_classify().
>>>>>> 2. The following inequality has already been checked in
>>>>>>       group_is_overloaded() which was also called in
>>>>>>       group_classify().
>>>>>>
>>>>>>          (sgs->group_capacity * imbalance_pct) <
>>>>>>                            (sgs->group_runnable * 100)
>>>>>>
>>>>>
>>>>> Consider group_is_overloaded() returns false because of the first
>>>>> condition:
>>>>>
>>>>>            if (sgs->sum_nr_running <= sgs->group_weight)
>>>>>                    return false;
>>>>>
>>>>> then group_has_capacity() would be the first place where the group_runnable
>>>>> vs group_capacity comparison would be done.
>>>>>
>>>>> Now in that specific case we'll actually only check it if
>>>>>
>>>>>      sgs->sum_nr_running == sgs->group_weight
>>>>>
>>>>> and the only case where the runnable vs capacity check can fail here is if
>>>>> there's significant capacity pressure going on. TBH this capacity pressure
>>>>> could be happening even when there are fewer tasks than CPUs, so I'm not
>>>>> sure how intentional that corner case is.
>>>>
>>>> Maybe some cpus in sg->cpumask are no longer active at the == case,
>>>> which causes the significant capacity pressure?
>>>>
>>>
>>> That can only happen in that short window between deactivating a CPU and
>>> not having rebuilt the sched_domains yet, which sounds quite elusive.
>>>
>>
>> In fact, at the beginning, I added unlikely() here to hint the compiler:
>>
>> -	if ((sgs->group_capacity * imbalance_pct) <
>> -			(sgs->group_runnable * 100))
>> +	if (unlikely((sgs->group_capacity * imbalance_pct) <
>> +			(sgs->group_runnable * 100)))
>>
>> The corresponding patch is as follows:
>>
>>        [PATCH]sched/core: add unlikely in group_has_capacity()
>>
>> Do you think it is necessary?
> 
> The "unlikely" approach has the benefit of keeping all corner cases in
> place. I was tempted to say it could still make sense to get rid of the
> extra check entirely, given that it has an impact only when:
> 
> - sum_nr_running == group_weight
> - group capacity has been noticeably reduced
> 
> If sum_nr_running < group_weight, we won't evaluate it.
> If sum_nr_running > group_weight, we either won't call into
>    group_has_capacity() or we'll have checked it already in
>    group_overloaded().
> 
> That said, it does make very much sense to check it in that ==
> case. Vincent might have a different take on this, but right now I'd say
> the unlikely approach is the safest one of the two.
> 

So what should I do next? Do I resubmit a patch with unlikely() or
add your email to the old patch([PATCH]sched/core: add unlikely in
group_has_capacity())? Or continue to wait for suggestions from
other maintainers?
