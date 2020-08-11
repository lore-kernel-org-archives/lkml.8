Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4BEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D442075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnMGkbgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgHKLop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgHKLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:44:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:44:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u128so7471368pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E9/Gn2BYTtg0fftmkD/JQ2PemUERpx/D1H7mcSwK9lU=;
        b=fnMGkbgTMkCApfYlMDsh9AdtDZjpTHKg/sagdIWVtAuoFjLSXUXqwp2kIqnlortDKg
         4HB5PiR0IFjoyMkp9ZrIaqMLzh6Y3WDhCV5G4Y6QgTMsDEVtN8ycw5IStsYREEibvs9a
         6VuR2n50pf3A1QAsoQYpjNBeyjLi8lAvLCZCQcE/mvKeuK/9NNMY1EmIMcR4t1MiW32K
         zeypZBDoR2gCXodVHpkD2TEN9pdEWx/K4ywcbnhK8x+DEpS+x/kkv4qLS9nfibxF0mTK
         g6grQoEcXpJ+TnL7q0bhK/s3r+0YV7rNvB6RJQq/9dbhTgMeAUUMi2CfTb4O9VWdZ4V+
         /UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9/Gn2BYTtg0fftmkD/JQ2PemUERpx/D1H7mcSwK9lU=;
        b=Fvt/0Htjzoy8TJZN0apn1wgi6cxldKeYlAawvCQaZnGcbkCX2vfaNrWGdI7LX6pYvd
         HxpkBVfmbnTROv4YzOgpWPLUvAcew6v/LI5luy6dIlyIaYWpkYLCWPzVF8axE9QEolUJ
         k+sGJ52HzI42UQMMiApclwd+r2V2zu+/v7hPqLZgxHvaiYoqkn3ZbmdgunJrTdo/CAzA
         UcrG1sIXTiWRegQLTMnhWOQ56c5WpdBGIIs74PaJ8KLWGnQqw598gevMdeahBnDrVInT
         8Tqm24saL+t14juMAawksoSpAjI/blCPSJ0ymNqA4GKMWLIiWEBjNN/CN/WMMC3YUijz
         E+Ow==
X-Gm-Message-State: AOAM531VtaZ95qFNhDaWOQtRhFSNhKXI7050ncCX6ImmYIKXxTljvCuB
        FAEjeQxp19cZ1+stMi2wUOOPOePT
X-Google-Smtp-Source: ABdhPJy/3T0L5BqBc+Wy51PsyDe8j6Cnilr0lTOfkUTjJVSAefE1U6S2NGbVT7FIHz3yK0cMc7KeUQ==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr491334pga.142.1597146282376;
        Tue, 11 Aug 2020 04:44:42 -0700 (PDT)
Received: from [0.0.0.0] ([108.61.186.250])
        by smtp.gmail.com with ESMTPSA id d128sm25537158pfa.24.2020.08.11.04.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 04:44:41 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Remove the duplicate check from
 group_has_capacity()
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <20200810010009.92758-1-arch0.zheng@gmail.com>
 <jhjwo26gxlb.mognet@arm.com> <9425382c-2a42-57ca-512d-c93c589dc701@gmail.com>
 <jhjv9hph3h7.mognet@arm.com>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <01fe6a9b-fd3a-9b36-b2fa-6cea58415670@gmail.com>
Date:   Tue, 11 Aug 2020 19:44:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhjv9hph3h7.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/11 下午6:38, Valentin Schneider wrote:
> 
> On 11/08/20 04:39, Qi Zheng wrote:
>> On 2020/8/11 上午2:33, Valentin Schneider wrote:
>>>
>>> On 10/08/20 02:00, Qi Zheng wrote:
>>>> 1. The group_has_capacity() function is only called in
>>>>      group_classify().
>>>> 2. The following inequality has already been checked in
>>>>      group_is_overloaded() which was also called in
>>>>      group_classify().
>>>>
>>>>         (sgs->group_capacity * imbalance_pct) <
>>>>                           (sgs->group_runnable * 100)
>>>>
>>>
>>> Consider group_is_overloaded() returns false because of the first
>>> condition:
>>>
>>>           if (sgs->sum_nr_running <= sgs->group_weight)
>>>                   return false;
>>>
>>> then group_has_capacity() would be the first place where the group_runnable
>>> vs group_capacity comparison would be done.
>>>
>>> Now in that specific case we'll actually only check it if
>>>
>>>     sgs->sum_nr_running == sgs->group_weight
>>>
>>> and the only case where the runnable vs capacity check can fail here is if
>>> there's significant capacity pressure going on. TBH this capacity pressure
>>> could be happening even when there are fewer tasks than CPUs, so I'm not
>>> sure how intentional that corner case is.
>>
>> Maybe some cpus in sg->cpumask are no longer active at the == case,
>> which causes the significant capacity pressure?
>>
> 
> That can only happen in that short window between deactivating a CPU and
> not having rebuilt the sched_domains yet, which sounds quite elusive.
> 

In fact, at the beginning, I added unlikely() here to hint the compiler:

-	if ((sgs->group_capacity * imbalance_pct) <
-			(sgs->group_runnable * 100))
+	if (unlikely((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100)))

The corresponding patch is as follows:

	[PATCH]sched/core: add unlikely in group_has_capacity()

Do you think it is necessary?
