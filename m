Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3825C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF7C206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkeKTutk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHLBt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLBt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:49:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B71C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 18:49:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so336840pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 18:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7FL9PUCw0cmrNCErD8UvM723hdL3ytuz7zhjvic+M1I=;
        b=FkeKTutkYedgFQum0FbHtLTusgFDEiCjRa9Lh54MC9qpgQ6QAMT77CDL9CP5hC8qKy
         OK7GXFGHwkNONYmrxd83JzjkcuUkobC1rj9+E4IZ0mCBNEFE4C4tJjBuGQB1vV8O4ght
         nu8/Oegdt3+HQ66o2kKLgqF2VcN/vijz3r81Y6kvMtnfvzJvBaass3BB+aMKK/T86kZx
         2KkbqwuWJ3W4BVoRk0JLTfS0+tXmVoz0MtZJw3Y8nrO5RsMI8j3HDLFpsvAPvYf84b/D
         snb5ndHAp4eBjEyLKogajod6+dVIvdyQdDuNB7N8+QuFO+xo/zc/TUJ4HwePhYVnI8yq
         HgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7FL9PUCw0cmrNCErD8UvM723hdL3ytuz7zhjvic+M1I=;
        b=kspkkDjuymEMBB+vMeXfEbCGMIfiXDvIglwxfN/bclp27RhA7RAsTtnuCGWgliar+S
         H00krhWllaA4JJyA0YmyxGFqMg9EjJPgqPwOQEfxb+/uvuhwgaXPcN5+4f5pGZ4mGxHk
         VwUqNOI4BSKf/GL3+rAyW5xC6MGbmN+7Rdy0XDjbEa6v3n5x3AoIjbfiu2BaoRhX7puL
         beKW4uaacNcPxrpD9ECj1Yt6oM2poPNTsZLWE5Om+rS6GmXaDyy+t0NnWzmD04SCj+H8
         cdVjsRBS9DNdPSoX5SXbyoyElK6P4vZ/hSSgnc3eJLCL27p73h7cyBpeA9wZyEMLuj75
         qn4g==
X-Gm-Message-State: AOAM532VjM1ovxVUp1EK3TY5+ZSefnnAwwiY4mcUDRyfz3Y1l1DlHUsv
        Mr+oirC8+dttnh8TfFYOiVWS5rIe
X-Google-Smtp-Source: ABdhPJwxUJOLIFD6wyoP8Jt9pzcIUgQUtpbyA5zPkp6lOHEqzceLZ8zOkeeSNnPd5XcgsbNxwhbg8Q==
X-Received: by 2002:a17:90a:6807:: with SMTP id p7mr3874803pjj.42.1597196995917;
        Tue, 11 Aug 2020 18:49:55 -0700 (PDT)
Received: from [0.0.0.0] ([108.61.186.250])
        by smtp.gmail.com with ESMTPSA id gj2sm247534pjb.21.2020.08.11.18.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 18:49:55 -0700 (PDT)
Subject: Re: [PATCH] sched/core: add unlikely in group_has_capacity()
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <20200730135423.232776-1-arch0.zheng@gmail.com>
 <20200806144533.GA2123716@gmail.com>
 <2d271bf3-69c1-e5fd-b7a9-f766ff26ed62@gmail.com>
Message-ID: <32e6e7dd-38cb-3317-138e-e337093e3173@gmail.com>
Date:   Wed, 12 Aug 2020 09:49:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d271bf3-69c1-e5fd-b7a9-f766ff26ed62@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/7 上午10:47, Qi Zheng wrote:
> Yeah, because of the following two points, I also think
> the probability is 0%:
> a) the sd is protected by rcu lock, and load_balance()
>     func is between rcu_read_lock() and rcu_read_unlock().
> b) the sgs is a local variable.
> 
> So in the group_classify(), the env->sd->imbalance_pct and
> the sgs will not be changed. May I remove the duplicate check
> from group_has_capacity() and resubmit a patch?
> 
> Yours,
> Qi Zheng
> 
> On 2020/8/6 下午10:45, Ingo Molnar wrote:
>>
>> * Qi Zheng <arch0.zheng@gmail.com> wrote:
>>
>>> 1. The group_has_capacity() function is only called in
>>>     group_classify().
>>> 2. Before calling the group_has_capacity() function,
>>>     group_is_overloaded() will first judge the following
>>>     formula, if it holds, the group_classify() will directly
>>>     return the group_overloaded.
>>>
>>>     (sgs->group_capacity * imbalance_pct) <
>>>                          (sgs->group_runnable * 100)
>>>
>>> Therefore, when the group_has_capacity() is called, the
>>> probability that the above formalu holds is very small. Hint
>>> compilers about that.
>>>
>>> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
>>> ---
>>>   kernel/sched/fair.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 2ba8f230feb9..9074fd5e23b2 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -8234,8 +8234,8 @@ group_has_capacity(unsigned int imbalance_pct, 
>>> struct sg_lb_stats *sgs)
>>>       if (sgs->sum_nr_running < sgs->group_weight)
>>>           return true;
>>> -    if ((sgs->group_capacity * imbalance_pct) <
>>> -            (sgs->group_runnable * 100))
>>> +    if (unlikely((sgs->group_capacity * imbalance_pct) <
>>> +            (sgs->group_runnable * 100)))
>>>           return false;
>>
>> Isn't the probability that this second check will match around 0%?
>>
>> I.e. wouldn't the right fix be to remove the duplicate check from
>> group_has_capacity(), because it's already been checked in
>> group_classify()? Maybe while leaving a comment in place?
>>
>> Thanks,
>>
>>     Ingo
>>

Hi,

As Valentin and I discussed in the patch below, simply removing the
check may not be completely harmless.

	[PATCH]sched/fair: Remove the duplicate check from
					group_has_capacity() :
	-	if ((sgs->group_capacity * imbalance_pct) <
	-			(sgs->group_runnable * 100))
	-		return false;


If sum_nr_running < group_weight, we won't evaluate it.
If sum_nr_running > group_weight, we either won't call into
   group_has_capacity() or we'll have checked it already in
   group_overloaded().
But in the case of sum_nr_running == group_weight, we can
run to this check.

Although I also think it is unlikely to cause the significant
capacity pressure at the == case, but I'm not sure whether there
are some special scenarios. such as some cpus in sg->cpumask are
no longer active, or other scenarios?

So adding the unlikely() in group_has_capacity() may be the safest
way.

Add Valentin Schneider <valentin.schneider@arm.com>.

Yours,
Qi Zheng
