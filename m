Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5DBC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 16:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0E22075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVSJlqgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgIFQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgIFQGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 12:06:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83676C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 09:06:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so13299206lja.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BA+i5YGjfQG9eG4FsIBKaO49/ge9c9KPdPWriN/3fOs=;
        b=MVSJlqgI3vgMTxPFMAOo4i6tZp7umbOnF/kWvF8/51BSRtl3eNXGns3AlI3TFJPyg5
         GHo+xx1eScL55ZNik/VOxHI5x3T26obWH11G+Sf4IiooDl3rNNOF//kc9fFnkYBOeyjY
         pb7xA0rVwc791J5AtkYptA7jwAH2Rndp7+LmEHyvn7kQW+LUOqEpm6X6Das1mIp2Gq2I
         4sHDWgEteePirwpeicwVGmIFGUyNBVql12Dy+IIYQiBf8bhIl3SRsi5pfRw61LumlNX9
         GwOzRFfBEhWveanqmKZsB06hK9DEaS3wDoPM9Wqc/g5BqtO2Ef7IMDMir+DC35UQVSeL
         dZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BA+i5YGjfQG9eG4FsIBKaO49/ge9c9KPdPWriN/3fOs=;
        b=pziPayD8CcBa4fbZBy6zGe7VqA39Bw+xMHcbfxrswKvU3PhKQAF1xRlN6KZw4mrjIr
         FMpgQZKIFw0fEXpJvEJysBkO/axfoP7hAfIXnaPUwUzxOyddBgRFJOWe+RDk4hJ2th6j
         T0s0slEKmTvli63PmT9vNpgE1ktFEWkVsL4JhpP07bAEk3CVzC4t+J0OjXAqHrdeIAOi
         JexOgaHTYep9ADGXAWOykdfzGBkjcOlrbb+3bgY+Sw//dFxtR1RavvxQmjjFd6HbZrFQ
         ZijaAhB3fx/EtZYG+r2PmQj4hlz2GKF9C2+BNoSF7QOiYotFzK/yS7ktFsYue7eNx8L5
         0LDw==
X-Gm-Message-State: AOAM530y9eqWaJ1iFUyXYoS8mbMY2RxIhTdy/HNu9fixF9ttfajdN9K7
        yaDYPfwvLTj4qmucJ8odANa8jC6uG8DXXw==
X-Google-Smtp-Source: ABdhPJx7hnREyZW9/FGGeJrFCZUzpJ3hKtipPF9z1Usd5fG0DBL6XVIebLjWqf+O3j1wxXyNGOMQ5Q==
X-Received: by 2002:a2e:7a14:: with SMTP id v20mr8832285ljc.429.1599408401709;
        Sun, 06 Sep 2020 09:06:41 -0700 (PDT)
Received: from [192.168.8.100] (188.147.111.252.nat.umts.dynamic.t-mobile.pl. [188.147.111.252])
        by smtp.gmail.com with ESMTPSA id m1sm4887507lfr.32.2020.09.06.09.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 09:06:41 -0700 (PDT)
Subject: Re: [PATCH] mm/mmu_notifier.c: micro-optimization substitute kzalloc
 with kmalloc
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20200906114321.16493-1-mateusznosek0@gmail.com>
 <20200906142645.GA1976319@kernel.org>
From:   Mateusz Nosek <mateusznosek0@gmail.com>
Message-ID: <39c79454-9a97-2c06-3186-939c1f3a2b27@gmail.com>
Date:   Sun, 6 Sep 2020 18:06:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200906142645.GA1976319@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I performed simple benchmarks using custom kernel module with the code 
fragment in question 'copy-pasted' in there in both versions. In case of 
1k, 10k and 100k iterations the average time for kzalloc version was 5.1 
and for kmalloc 3.9, for each iterations number.
The time was measured using 'ktime_get(void)' function and the results 
given here are in ktime_t units.
The machine I use has 4 core Intel(R) Core(TM) i5-3470 CPU @ 3.20GHz CPU.

The performance increase happens, but as you wrote it is probably not 
really noticeable.
I have found 3 other places in kernel code with similar kzalloc related 
issues, none of which seems to be 'hot' code.
I leave the decision if this patch and potential others I would send 
regarding this issue, are worth applying to the community and maintainers.

Best regards,
Mateusz Nosek

On 9/6/2020 4:26 PM, Mike Rapoport wrote:
> Hi,
> 
> On Sun, Sep 06, 2020 at 01:43:21PM +0200, mateusznosek0@gmail.com wrote:
>> From: Mateusz Nosek <mateusznosek0@gmail.com>
>>
>> Most fields in struct pointed by 'subscriptions' are initialized explicitly
>> after the allocation. By changing kzalloc to kmalloc the call to memset
>> is avoided. As the only new code consists of 2 simple memory accesses,
>> the performance is increased.
> 
> Is there a measurable performance increase?
> 
> The __mmu_notifier_register() is not used that frequently to trade off
> robustness of kzalloc() for slight (if visible at all) performance gain.
> 
>> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
>> ---
>>   mm/mmu_notifier.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
>> index 4fc918163dd3..190e198dc5be 100644
>> --- a/mm/mmu_notifier.c
>> +++ b/mm/mmu_notifier.c
>> @@ -625,7 +625,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>>   		 * know that mm->notifier_subscriptions can't change while we
>>   		 * hold the write side of the mmap_lock.
>>   		 */
>> -		subscriptions = kzalloc(
>> +		subscriptions = kmalloc(
>>   			sizeof(struct mmu_notifier_subscriptions), GFP_KERNEL);
>>   		if (!subscriptions)
>>   			return -ENOMEM;
>> @@ -636,6 +636,8 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>>   		subscriptions->itree = RB_ROOT_CACHED;
>>   		init_waitqueue_head(&subscriptions->wq);
>>   		INIT_HLIST_HEAD(&subscriptions->deferred_list);
>> +		subscriptions->active_invalidate_ranges = 0;
>> +		subscriptions->has_itree = false;
>>   	}
>>   
>>   	ret = mm_take_all_locks(mm);
>> -- 
>> 2.20.1
>>
>>
> 
