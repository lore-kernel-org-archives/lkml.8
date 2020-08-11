Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAFAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A59220768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mgi4l9Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgHKQp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgHKQpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:45:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C79EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:45:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so2142682pjx.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+u6gnCeWgAnf6Un1K5qbQxm4MSNlFFVkrtxRYNTa4wA=;
        b=mgi4l9MkxY2nMl+KwzHQbt4JpX/02zn8co0NW5FFXilO9SwvsO05LvTi7fG1RjdmOB
         YCUlUr3YTTQZfLrBa1RZMuzMHrXgdMv6lHcxph51NbD5uGUNX++4s+Z5SKkfSXp90JSe
         MGVYJ9wvzIsQ1H3TVRQDF4hn7B/gistjc/HA/Q5+dYLYzhU6WUJQlxozUqCKP3FE75JE
         mU+nmSUHMFovBxkgy75iHqcQu8hcgneaVyM8zqPAseGfjL8k6wOVYodSMD+eanoC9ZDt
         +gyXbmZurJOeIB4PpWEe+I1LKRglSyzbxr42XG6HLzLKEM7RSi6MfE+jpIQG7ChnwEs1
         yCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+u6gnCeWgAnf6Un1K5qbQxm4MSNlFFVkrtxRYNTa4wA=;
        b=uRcSEtqvY4Qz8r3hoQpV8D8XhQtRXeAy61ReqAWeDLaxJkexcZ9l32lWPauzhSEZrQ
         dnA0yZkkqSGmDKvkqSNJVg0FNND6B7v96UbYdFc5bypaVK1+ig1nCiOZY069Dy4P7GJz
         84N1KfDVuNnuBfArdhZRm1cElc1FvCfBE0qaAOhaEbQ9xSaiSx1NUD+aDu3z9+dFbNl0
         e5SYxnu7ZbQpvd9Kr5RlFqwYts7iMAlLe6+ebO/JpVy6/tA7z7gvjnDltPTyc0lzfU8M
         4DDZUEJ0+rRLAQ82i92aCHvvgxKdmxaCMybvDgis+bhwhFjPnNdgpZXO9XD9R8BFqTh8
         pHYg==
X-Gm-Message-State: AOAM530HLz42TveMqIflEHZyp0ecB/0/GLq15NIsEgk2peHLsfIYsFgb
        br+DPvgYXMw4Z5l2ptENjr0xbw==
X-Google-Smtp-Source: ABdhPJy00Yztk47tY8iwgI/wcQ3FdlwCOjlsi/uot40hsR/MeI0V+U7fH9t0jsOf+VhOwobefIO4/A==
X-Received: by 2002:a17:902:8307:: with SMTP id bd7mr1610841plb.159.1597164322967;
        Tue, 11 Aug 2020 09:45:22 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id nu14sm3335490pjb.19.2020.08.11.09.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:45:22 -0700 (PDT)
Subject: Re: [PATCH] task_work: only grab task signal lock when needed
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <0028d3ea-4d05-405f-b457-75c83d381d89@kernel.dk>
 <20200811152310.GF21797@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b43293f-2052-2bd8-80ef-eb936fe19b65@kernel.dk>
Date:   Tue, 11 Aug 2020 10:45:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811152310.GF21797@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 9:23 AM, Oleg Nesterov wrote:
> On 08/11, Jens Axboe wrote:
>>
>> --- a/kernel/task_work.c
>> +++ b/kernel/task_work.c
>> @@ -42,7 +42,8 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
>>  		set_notify_resume(task);
>>  		break;
>>  	case TWA_SIGNAL:
>> -		if (lock_task_sighand(task, &flags)) {
>> +		if (!(READ_ONCE(task->jobctl) & JOBCTL_TASK_WORK) &&
>> +		    lock_task_sighand(task, &flags)) {
> 
> Aaaaah, sorry Jens, now I think this is racy. So I am glad I didn't add
> this optimization into the initial version ;)
> 
> It is possible that JOBCTL_TASK_WORK is set but ->task_works == NULL. Say,
> task_work_add(TWA_SIGNAL) + task_work_cancel(), or the target task can call
> task_work_run() before it enters get_signal().
> 
> And in this case another task_work_add(tsk, TWA_SIGNAL) can actually race
> with get_signal() which does
> 
> 	current->jobctl &= ~JOBCTL_TASK_WORK;
> 	if (unlikely(current->task_works)) {
> 		spin_unlock_irq(&sighand->siglock);
> 		task_work_run();
> 
> nothing guarantees that get_signal() sees ->task_works != NULL. Probably
> this is what Jann meant.
> 
> We can probably add a barrier into get_signal() but I didn't sleep today,
> I'll try to think tomorrow.

Appreciate you looking into this! Would be pretty critical for me to get
this working.

-- 
Jens Axboe

