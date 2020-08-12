Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27797C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4A420756
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXGKT72c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHLAqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLAqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:46:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584FDC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:46:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so148555pgl.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gA6HLegMT64phMFVQ7NsDC7fLVLgch73XTGsvFwXIgw=;
        b=pXGKT72cahT5WV70cvriv9aH3+66DJ7j+Ttbt4+fL1ZubgYPJ0Z/DITZ8S5TDWDuHB
         VD1XmynvU4x0GLHhw/IlXyoaFwezAkQCnx4mSGkUaET9SUH6lI6OR4fAUcmvNW8OwDrQ
         EWkDa38ExEX59+uGVtyrOiLE4RYtvpPqkk+GJS5y2G08DL1KtZ9KdPFlAXAdNpgbi6u0
         r0d2PuBNnHQCtcsq8uXhYVvCiy3mocH3DU5qCE7NDh4BIwBxTCS1bKAoAd8Z2RZzty8C
         yIc/kgh16lBFjEFVtoTzeVwdwbAtUlVGilRnm0I1fV0ppJSdXYZrR4FeZIKk7rro9B7h
         xSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gA6HLegMT64phMFVQ7NsDC7fLVLgch73XTGsvFwXIgw=;
        b=jU0cnLPeXnS9QsWaSks8J6IOBmaXNC2qVrGVck+G+of/etJD6D6hij5Yl6a1bvcy5J
         grciL12+PnRNNqeHmuS91/FQy6n1sYXsBYLa1yp1rR3x+F7ljynH1/HyT4656hzS0/by
         6MX0s0cL76Tkn5PSj8aGYYq/cVf76S1Ep5ID2bTtDotZBUEXr+0TeQAyfHBLaxxbdqBC
         1uk3xj8zNlkb2MMCvqdSK6i0n57eyKbgq8KinaavZcUsh3WEhyMvaiQ/Cjg+fcZFaeNg
         MhSWM7414mXK2sZitMnPZ6VPsMbB++73ehbXlRxrX+dlXdjDZcfNfz4zQANIsLgUBLCP
         eiHA==
X-Gm-Message-State: AOAM533x8tuhdkXkequBU0Cnv7wOOgSf6ctuMX/VuhUcFKWOwOkKY6yR
        lOwSdUeyubhlRDM4lWacSq9F9Srh
X-Google-Smtp-Source: ABdhPJwbq0UEUcG155hy+w3lMEGqy9URmH6tXRoN7QcegvPvkorrERjM5drm4QT016fX1In3VqgHrQ==
X-Received: by 2002:a65:60d4:: with SMTP id r20mr2892267pgv.436.1597193184659;
        Tue, 11 Aug 2020 17:46:24 -0700 (PDT)
Received: from [0.0.0.0] ([108.61.186.250])
        by smtp.gmail.com with ESMTPSA id n3sm265067pfq.131.2020.08.11.17.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 17:46:24 -0700 (PDT)
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
 <jhjtux9gxh2.mognet@arm.com> <905d8887-e79c-daf6-cbce-80fd0509e37d@gmail.com>
 <jhjv9hp546d.mognet@arm.com>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <f41303b7-fca9-b70f-efff-3ff5e1fb786a@gmail.com>
Date:   Wed, 12 Aug 2020 08:46:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhjv9hp546d.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/12 上午4:16, Valentin Schneider wrote:
> 
> On 11/08/20 14:12, Qi Zheng wrote:
>> On 2020/8/11 下午8:48, Valentin Schneider wrote:
>>> On 11/08/20 12:44, Qi Zheng wrote:
>>>> In fact, at the beginning, I added unlikely() here to hint the compiler:
>>>>
>>>> -	if ((sgs->group_capacity * imbalance_pct) <
>>>> -			(sgs->group_runnable * 100))
>>>> +	if (unlikely((sgs->group_capacity * imbalance_pct) <
>>>> +			(sgs->group_runnable * 100)))
>>>>
>>>> The corresponding patch is as follows:
>>>>
>>>>         [PATCH]sched/core: add unlikely in group_has_capacity()
>>>>
>>>> Do you think it is necessary?
>>>
>>> The "unlikely" approach has the benefit of keeping all corner cases in
>>> place. I was tempted to say it could still make sense to get rid of the
>>> extra check entirely, given that it has an impact only when:
>>>
>>> - sum_nr_running == group_weight
>>> - group capacity has been noticeably reduced
>>>
>>> If sum_nr_running < group_weight, we won't evaluate it.
>>> If sum_nr_running > group_weight, we either won't call into
>>>     group_has_capacity() or we'll have checked it already in
>>>     group_overloaded().
>>>
>>> That said, it does make very much sense to check it in that ==
>>> case. Vincent might have a different take on this, but right now I'd say
>>> the unlikely approach is the safest one of the two.
>>>
>>
>> So what should I do next? Do I resubmit a patch with unlikely() or
>> add your email to the old patch([PATCH]sched/core: add unlikely in
>> group_has_capacity())? Or continue to wait for suggestions from
>> other maintainers?
> 
> I guess you can add a reply to the original thread where you had the
> unlikely() to point out *removing* the check isn't 100% harmless.
> 
> Vincent might want to have a look at it, but AFAIA he's on holidays ATM.
> 

Okay, I will reply to the old patch and add your email to it.
Thanks for your comments.

Yours,
Qi Zheng
