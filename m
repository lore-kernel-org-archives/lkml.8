Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39486C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF0E21744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQZleGvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgHGCsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHGCsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:48:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11414C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 19:48:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so351624plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LKKFO8Tzu39Pe/grAi9ricjZsix/arUC2ARb2Kp9eTk=;
        b=aQZleGvbnZ4Ols4bCVGy5QryoQc2t8V4+OZOpkT3um7boWswys09u/CSUNl+ZItjPp
         3kgmE9s7uHueBnD5AmweeGATbMV+LvMYfsZ/8+tMqsxPxEMnjmRDNqT62a0dbaZDUOeY
         5Mx9ta/CAsWXVAmhA+8dIiaH6bK6Juu6H9y8ypWt+WsSrjGMDm3goPU+An7yCnxn8KY2
         7I2Gvn2VduBigA/5B04nS+aeA575AXPNrnnpRvs55IxSwX1xcUQGltSK/11OiZs8S0nQ
         4kWpK1wfSIgesCCJYjDD2fYBJxlfdp7cK1cQtLfnc136GkSMbtU4XslJmzC3pQ9qRYA6
         bXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKKFO8Tzu39Pe/grAi9ricjZsix/arUC2ARb2Kp9eTk=;
        b=G2UW3DFpjfK861uBhaPFRoYYMZTtg4gFjOSwiYsOjlOxfMof02mu0UUioSJaKU83hY
         lxPs13Ni/KFvbmtVUGM6FOJXSr167qzZwruAxUpY8WHM/YbmG/k/i9+uCsmZRw8H8Xaq
         FmdkeUvdP3HGQwKpx4123yyW2B6YMuVIioagaOdh9CX2Iy3MQGFU2DOillLOML40L5tv
         wb4MK980HoJ3gaFz6ByPJ2SFrBJ+th9r3lUy2Qpz0ckMg9NBCn9BNvrzEggXwb2DgHhO
         GjxYrfFWswkEhWf1fT83Ppc/LJT0BQQSrpHB1HxKoktCyYTeyxEvzJ//eVSfkVgxP7Uh
         wU2g==
X-Gm-Message-State: AOAM531NIVoiSkigYikyQmF8ztg4B19EIf+oiq2/0yHSKESHAJY16oWt
        Uffq/OIhsoWXceN0AN5NaqBFZHKO
X-Google-Smtp-Source: ABdhPJzEhfg/sYJSzmYdimDnSqwhSHx2gyfUqKV+gc6VtOnFnoayyYJoKVJU8864vMQNeG7TZ8aXDQ==
X-Received: by 2002:a17:90b:816:: with SMTP id bk22mr11490149pjb.185.1596768482034;
        Thu, 06 Aug 2020 19:48:02 -0700 (PDT)
Received: from [0.0.0.0] ([167.99.75.144])
        by smtp.gmail.com with ESMTPSA id f27sm9888192pfk.217.2020.08.06.19.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 19:48:01 -0700 (PDT)
Subject: Re: [PATCH] sched/core: add unlikely in group_has_capacity()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <20200730135423.232776-1-arch0.zheng@gmail.com>
 <20200806144533.GA2123716@gmail.com>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <2d271bf3-69c1-e5fd-b7a9-f766ff26ed62@gmail.com>
Date:   Fri, 7 Aug 2020 10:47:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806144533.GA2123716@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, because of the following two points, I also think
the probability is 0%:
a) the sd is protected by rcu lock, and load_balance()
    func is between rcu_read_lock() and rcu_read_unlock().
b) the sgs is a local variable.
	
So in the group_classify(), the env->sd->imbalance_pct and
the sgs will not be changed. May I remove the duplicate check
from group_has_capacity() and resubmit a patch?

Yours,
Qi Zheng

On 2020/8/6 下午10:45, Ingo Molnar wrote:
> 
> * Qi Zheng <arch0.zheng@gmail.com> wrote:
> 
>> 1. The group_has_capacity() function is only called in
>>     group_classify().
>> 2. Before calling the group_has_capacity() function,
>>     group_is_overloaded() will first judge the following
>>     formula, if it holds, the group_classify() will directly
>>     return the group_overloaded.
>>
>> 	(sgs->group_capacity * imbalance_pct) <
>>                          (sgs->group_runnable * 100)
>>
>> Therefore, when the group_has_capacity() is called, the
>> probability that the above formalu holds is very small. Hint
>> compilers about that.
>>
>> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
>> ---
>>   kernel/sched/fair.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2ba8f230feb9..9074fd5e23b2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8234,8 +8234,8 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>   	if (sgs->sum_nr_running < sgs->group_weight)
>>   		return true;
>>   
>> -	if ((sgs->group_capacity * imbalance_pct) <
>> -			(sgs->group_runnable * 100))
>> +	if (unlikely((sgs->group_capacity * imbalance_pct) <
>> +			(sgs->group_runnable * 100)))
>>   		return false;
> 
> Isn't the probability that this second check will match around 0%?
> 
> I.e. wouldn't the right fix be to remove the duplicate check from
> group_has_capacity(), because it's already been checked in
> group_classify()? Maybe while leaving a comment in place?
> 
> Thanks,
> 
> 	Ingo
> 
