Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CF5205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NDiJILio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgHSNXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgHSNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:18:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A90AC061350
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:18:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so1108880pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EmsrMsejrteUQOaXizHGkEi5KXQjT4dl2svL7ypPlBc=;
        b=NDiJILiosqIAscQE8wZykt6DbpS7YBnnC+G3dZiskRWDg56ceYJOsQGdMhN8aJ4v1s
         eHtvgj/ZL8A6RoCJXjYGmEYhfXmChtBRxTJh+UMFZz0aeP1OXPlfuYqfHga4NDkZFxL0
         GBL7tBDtP5vCG5nmKKHK5L/WJ0VcgLapSq4BYLtZ4LVj/FCx3VTQN9zaDe7EFZbvc8Mz
         SMwVHM8sTcJNWruEnCVdBaUOPDvmnwYyRYSPbTKMq5/90/nz+ym7LR/rfGTQorWOlkh+
         H3m+gUJTPN9DK1nksrYMnmY9YKoE7PsnMs5/zysG/SoRwSZ8WVfHvXoajcrNEtAu0F+7
         +pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EmsrMsejrteUQOaXizHGkEi5KXQjT4dl2svL7ypPlBc=;
        b=W3TlEV9dHX5XCgfOfqmuGsqhHNMP4wdymYi1sldXEqGDZ3NmsKefEbzaY+cvTeCaA7
         34YqNbJuUBiql0vSMPQ1UG/spqINZs4AueEfz9tN16YyN2ciFgYYU5IeJXXTkF84BJze
         x/oiDZ53Bv3Iqbn+TgVRxvPMkDMtxuHQHXBmHRR7yvgOSsEhhudy5pFfG4+xXr3Stz8c
         y8HJcdHV3HpbgjrcimJavG92iVjQMHum2DJtZdR2sHzmYnr5yxrTh2O/+r1/+54abmPr
         8h2JLDkBh6bfB1Tdwab8fVZOi+CoFnxByV+VVD8XSYp2zkVSACOjcznRIDYllHKoSduO
         eg3g==
X-Gm-Message-State: AOAM5319JMFfM8Fvo+F5CDb4+y+xD7yI68MjB+miXeu4a1ouyCfQ4I8b
        69p2DpnRa+QMXwfukZm6+tCb9yOLFWlL8tlXfbo=
X-Google-Smtp-Source: ABdhPJyNNi7hvHginyDtQT0al1nbw/1nudCMk8Buqpi5CRRYPre01hagxHuWYAwWwaYdZCciL1m4xg==
X-Received: by 2002:a17:90a:630c:: with SMTP id e12mr3989898pjj.17.1597843094764;
        Wed, 19 Aug 2020 06:18:14 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l22sm3010080pjy.31.2020.08.19.06.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 06:18:14 -0700 (PDT)
Subject: Re: [RFC PATCH] sched: Invoke io_wq_worker_sleeping() with enabled
 preemption
To:     peterz@infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200819123758.6v45rj2gvojddsnn@linutronix.de>
 <20200819131507.GC2674@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f26205ac-9da9-253e-ea43-db2417714a94@kernel.dk>
Date:   Wed, 19 Aug 2020 07:18:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819131507.GC2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 6:15 AM, peterz@infradead.org wrote:
> On Wed, Aug 19, 2020 at 02:37:58PM +0200, Sebastian Andrzej Siewior wrote:
> 
>> I don't see a significant reason why this lock should become a
>> raw_spinlock_t therefore I suggest to move it after the
>> tsk_is_pi_blocked() check.
> 
>> Any feedback on this vs raw_spinlock_t?
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>  fs/io-wq.c          |  8 ++++----
>>  kernel/sched/core.c | 10 +++++-----
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 3bbb60b97c73c..b76c0f27bd95e 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4694,18 +4694,18 @@ static inline void sched_submit_work(struct task_struct *tsk)
>>  	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
>>  	 * requires it.
>>  	 */
>> -	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
>> +	if (tsk->flags & PF_WQ_WORKER) {
>>  		preempt_disable();
>> -		if (tsk->flags & PF_WQ_WORKER)
>> -			wq_worker_sleeping(tsk);
>> -		else
>> -			io_wq_worker_sleeping(tsk);
>> +		wq_worker_sleeping(tsk);
>>  		preempt_enable_no_resched();
>>  	}
>>  
>>  	if (tsk_is_pi_blocked(tsk))
>>  		return;
>>  
>> +	if (tsk->flags & PF_IO_WORKER)
>> +		io_wq_worker_sleeping(tsk);
>> +
> 
> Urgh, so this adds a branch in what is normally considered a fairly hot
> path.
>
> 
> I'm thinking that the raw_spinlock_t option would permit leaving that
> single:
> 
> 	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER))
> 
> branch intact?

Yes, the raw spinlock would do it, and leave the single branch intact
in the hot path. I'd be fine with going that route for io-wq.


-- 
Jens Axboe

