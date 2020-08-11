Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3346206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqRD8Xzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHKDkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgHKDj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:39:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF23CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 20:39:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x15so1404646plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 20:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3PrVDtMQf169Kljc/JK35t0tZa58l2V+hE8WfvQXbUU=;
        b=WqRD8XzuFmI7FgOc+faxexmXkfNuYXIVbVbOKqCTiaiNPzlrpIsFQr73VqfAEE91Cx
         89CTb59eS3Jui5BRjC81pjCpdrCoshMc7PbhmzV2EnnSHcwphwvdolhKvTSTwGtszWUW
         PlQtwx+tWHnaWqUt9jMFIfABgfkqkBXSoZyelJHSRP1iYz8EXaI+uZipa/7NIbPcq3Va
         kp430q28wRFsNIC8c9z0kIxQJHjQHvaMCS4pGPFw3zSCfani4NbTOpE0kkGjkKPyr0Wi
         oJT6SiiTVED2QsYwdGnUTvmgRDAJ82yO9t7ST+NaZnhZF1aGab+0XquTxqt05DwHoY1D
         FGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3PrVDtMQf169Kljc/JK35t0tZa58l2V+hE8WfvQXbUU=;
        b=ukfJPOw35RV8QFPOUmnwb30hecPk9Ff4brPZEU+UUnZSBSbsTxWrniPjBJ6XtnIteW
         rxYlOWsfnExBamqZYX2Ufac7wMbbeqxyFETzCkh9wl7S3DzR7e/lb2LP4fd0VU8YTdc7
         +Jnceuuafz0p7QUbZo+vV/HyqKKl+1yDkRGlyrhMCJdYhokkjQQRdT49k5rLdQI1z2lm
         u2OZu5wRBei3Qm2LONersfr+8oo9L26xUfQCumvSrQPRQV1LFluyrJXCfOlYmXIsESFi
         JYwfHyzYki1vsMwF3DUhHHxf4BG2zXZEWORkWFfA0d+XXPfeuHCZ21c9TdKU7FQWwzIL
         mUUg==
X-Gm-Message-State: AOAM533W4BewPmcoTtD/jSHnQRbVwjO42eTYQTsBylAu+JhAdh2G/ztI
        wjAntAdG5+3vsqU/ZqRPK/YavXkd
X-Google-Smtp-Source: ABdhPJyDmCKTYLJxdjrbRIZwXqEy4A0yyylg1tUlqV7Oazn8ZssbRyyWa3LTHwFQ2yLIL9rx25VJmQ==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr26854678plo.184.1597117199088;
        Mon, 10 Aug 2020 20:39:59 -0700 (PDT)
Received: from [0.0.0.0] ([198.13.39.231])
        by smtp.gmail.com with ESMTPSA id v10sm7493997pff.192.2020.08.10.20.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 20:39:58 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Remove the duplicate check from
 group_has_capacity()
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <20200810010009.92758-1-arch0.zheng@gmail.com>
 <jhjwo26gxlb.mognet@arm.com>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <9425382c-2a42-57ca-512d-c93c589dc701@gmail.com>
Date:   Tue, 11 Aug 2020 11:39:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhjwo26gxlb.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/11 上午2:33, Valentin Schneider wrote:
> 
> On 10/08/20 02:00, Qi Zheng wrote:
>> 1. The group_has_capacity() function is only called in
>>     group_classify().
>> 2. The following inequality has already been checked in
>>     group_is_overloaded() which was also called in
>>     group_classify().
>>
>>        (sgs->group_capacity * imbalance_pct) <
>>                          (sgs->group_runnable * 100)
>>
> 
> Consider group_is_overloaded() returns false because of the first
> condition:
> 
>          if (sgs->sum_nr_running <= sgs->group_weight)
>                  return false;
> 
> then group_has_capacity() would be the first place where the group_runnable
> vs group_capacity comparison would be done.
> 
> Now in that specific case we'll actually only check it if
> 
>    sgs->sum_nr_running == sgs->group_weight
> 
> and the only case where the runnable vs capacity check can fail here is if
> there's significant capacity pressure going on. TBH this capacity pressure
> could be happening even when there are fewer tasks than CPUs, so I'm not
> sure how intentional that corner case is.

Maybe some cpus in sg->cpumask are no longer active at the == case,
which causes the significant capacity pressure?

> 
> 
> For the
> 
>      sgs->sum_nr_running > sgs->group_weight
> 
> case I agree with your patch, there just is that oddity at the == case.
> 
>> So just remove the duplicate check from group_has_capacity().
>>
>> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
>> ---
>>   kernel/sched/fair.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2ba8f230feb9..a41903fb327a 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8234,10 +8234,6 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>        if (sgs->sum_nr_running < sgs->group_weight)
>>                return true;
>>
>> -	if ((sgs->group_capacity * imbalance_pct) <
>> -			(sgs->group_runnable * 100))
>> -		return false;
>> -
>>        if ((sgs->group_capacity * 100) >
>>                        (sgs->group_util * imbalance_pct))
>>                return true;
