Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C34C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E902053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="mGckqmPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgG1Q7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbgG1Q7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:59:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77645C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:59:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l12so1153486pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KQYlcxozd9Duw66kIKYSE/eVpF+aVfn6tBYwJQECVPA=;
        b=mGckqmPq+IwwMfU2VheWzyGeHzihI/ri9tN13FNCnb0nhcfKLQgZjzptIBGl1qoZmM
         oFSkn3j/K4HRePJPElGwzYF2cMQhKZ8ATb30Eqzo2W3dZmrsnJDUi8MzgrWn6B9CKU20
         hkHsdPDz2StUvJrfTbvKRDhPEiPp9GModb1UHVo56GZUZNcBCgXlMq171rBzgS991pOC
         aMFUwb9YiW4xeMNd/YuR8MBC8dRaptT7Bs6xMOv8DgUcch/DQfrw1k/VfUu1UcHitUVs
         k4jfAbHS6b77SoZlQyVGQiSuZayE99M25amdkXS/qANpJQQzXJVuh/H3rV2fmf5qvLKl
         1fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KQYlcxozd9Duw66kIKYSE/eVpF+aVfn6tBYwJQECVPA=;
        b=LgXq/i6IqQ75L2dqVwa9uMSsVKSYapc/xW910KL0AD/BQb8tMGBgMPl6QQZ6tCLyEs
         w6+ja7YGYdoy8c93m+uATOaHsqN07shXowtTTvg2ZCpZUa0akZcJdukUjF3Uly77Qgb+
         4UIiSF/RszDjAUD4h5G/rtUGuVg2sdMgbzHOBFFuYTgBBnCDCjXa9I9ChpDZCMtmod76
         ZnDfgfuujZo5/WiRBLZ0FGTH5PfH0+hZWNZC8F53beIXfEfi2mQkda6pOE0xjoWvORGm
         jj3rpwVTN5LXlrzCi7oS3zDCaXgppqHp7E1bdjPlGoJJ4ASgA576A49EljfndmGIIyvw
         09zQ==
X-Gm-Message-State: AOAM53183w89PDOb+H9xSbOYBWpYSBUWQdzu2LZRX2dHqS/+cfetA4yA
        1Oj/tBF+1uTT16c1aF93idBQNQ==
X-Google-Smtp-Source: ABdhPJxP8vSt8aHJiXR/kiImLXFg9jqf2AgDWwPDn8RM1kT+YjuOUuZgm4428rbcOHrwE7ra3NqqHQ==
X-Received: by 2002:a63:4c48:: with SMTP id m8mr25701415pgl.290.1595955578011;
        Tue, 28 Jul 2020 09:59:38 -0700 (PDT)
Received: from [10.255.143.11] ([103.136.221.69])
        by smtp.gmail.com with ESMTPSA id k7sm18914041pgh.46.2020.07.28.09.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 09:59:37 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 1/2] ftrace: clear module from hash of all
 ftrace ops
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20200728102720.46837-1-zhouchengming@bytedance.com>
 <20200728085320.6b04e03f@oasis.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <557fa115-1247-e058-4a18-e73f6fb7d636@bytedance.com>
Date:   Wed, 29 Jul 2020 00:59:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728085320.6b04e03f@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/28 下午8:53, Steven Rostedt 写道:
> On Tue, 28 Jul 2020 18:27:19 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
>
>> We should clear module from hash of all ops on ftrace_ops_list when
>> module going, or the ops including these modules will be matched
>> wrongly by new module loaded later.
> This is really up to the owner of the hash and not the registered
> system.

Agreed!

But ftrace is a very core and independent mechanism of kernel, it's hard to

make sure any user of ftrace, like kprobe, livepatch will handle module 
going correctly.

At least for now, kprobe does not handle that correctly...

So I think it's safer to fix it too in ftrace : )

>
> If we want, we could register some kind of callback table for all
> ftrace_ops to have this updated, but the current code is incorrect.
>
> Like:
>
>   register_ftrace_ops_hash()
>
> Where the hash will get updated on module removal.

Thanks for the suggestion, so in this new function, all ftrace_ops 
func_hash on

ftrace_ops_list will get updated on module removal.

>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   kernel/trace/ftrace.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 1903b80db6eb..fca01a168ae5 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -6223,18 +6223,20 @@ clear_mod_from_hash(struct ftrace_page *pg, struct ftrace_hash *hash)
>>   /* Clear any records from hashs */
>>   static void clear_mod_from_hashes(struct ftrace_page *pg)
>>   {
>> -	struct trace_array *tr;
>> +	struct ftrace_ops *op;
>>   
>> -	mutex_lock(&trace_types_lock);
>> -	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
>> -		if (!tr->ops || !tr->ops->func_hash)
> The tr->ops hashes are persistent without being registered. They match
> what's in set_ftrace_filter and similar files.
>
> Your patch just introduced a bug, because those hashes now would not
> get updated if the ops were not registered.
>
> i.e.
>
>   # echo some_module_function > set_ftrace_filter
>   # rmmod module_with_that_function
>   # insmod module_with_same_address_of_function
>   # echo function > current_tracer
>
> Now the tr->ops->hash would still have the function of the original
> module.

I thought all ftrace_ops has non empty func_hash are on the ftrace 
global list...

Well, so I just leave this function unmodified.

Just call that new function register_ftrace_ops_hash() from 
ftrace_release_mod.

Thanks!

>
> Either have all owners of ftrace_ops handle this case, or add a helper
> function to handle it for them. But using ftarce_ops_list is the wrong
> place to do it.
>
> -- Steve
>
>
>> +	mutex_lock(&ftrace_lock);
>> +
>> +	do_for_each_ftrace_op(op, ftrace_ops_list) {
>> +		if (!op->func_hash)
>>   			continue;
>> -		mutex_lock(&tr->ops->func_hash->regex_lock);
>> -		clear_mod_from_hash(pg, tr->ops->func_hash->filter_hash);
>> -		clear_mod_from_hash(pg, tr->ops->func_hash->notrace_hash);
>> -		mutex_unlock(&tr->ops->func_hash->regex_lock);
>> -	}
>> -	mutex_unlock(&trace_types_lock);
>> +		mutex_lock(&op->func_hash->regex_lock);
>> +		clear_mod_from_hash(pg, op->func_hash->filter_hash);
>> +		clear_mod_from_hash(pg, op->func_hash->notrace_hash);
>> +		mutex_unlock(&op->func_hash->regex_lock);
>> +	} while_for_each_ftrace_op(op);
>> +
>> +	mutex_unlock(&ftrace_lock);
>>   }
>>   
>>   static void ftrace_free_mod_map(struct rcu_head *rcu)
