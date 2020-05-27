Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D27C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C762078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="Z+AYYC0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgE0GDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0GDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:03:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA7BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:03:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l27so4385272ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7qKjQxL2XP05Y8Q3gHqKw/6AL/z3G6LOk5SG9OyHIwU=;
        b=Z+AYYC0FGgTK7EK1/afykkpDqmDnkDWp/pEq2hOqd8lJRXG8o3KyGeQhGLoCAb9fay
         E4Bauu2ZDzRqCc8gp1gEuYjrhJNIfgVL+0hYhNT4UYbZHZ0daaiU2Rz4puksjZFt70nv
         tjITryo1dUAd9CW9cCgdzSkxUj+4MqI9Dtn3h0OpnVWJulNV7ee18vooK9MT4lQOEW2H
         M/HGVC0T+8bSchBD5ZpwKoZRrcf3UdHJGBp10+CnBfIzj5a9XylXUN99rjVQICLwFEgd
         mTb9gyghZ8+eRM4zuA+8GljDV7Q7RRB4G2VXFMXufKiQRzEjFUSuH93OXhp7HVt6OCmX
         UNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7qKjQxL2XP05Y8Q3gHqKw/6AL/z3G6LOk5SG9OyHIwU=;
        b=n4Wd66s0PrL2HvMm6a344lQqZXXqmJ7sMFEUMGwMEb55+KYshP0NYepItNwjWLXNql
         QhhNMDrWgvxQCNZ71xKFST7IO2iJVExVEUsMulhax9cG2120IfA7BjAl+KShUk7FCHIm
         a2A4pp04SEGUtuzEWnuvO8fIuoJjOmIFhy+MIPaMweEyOM2VrpDuTGhhQPsoTNYV5lDW
         UNtNcTbtS5zVw0XcpH/Z8wlMRrs/oR+Ncozu6NFSyCFV8+UYtA8lX3sF7Cr0Y3/+u3PR
         /5MIHk72fp3wsTWiNNWHXm5BVXO9cfU2NcpF7+iWqs0TWBFBxfxncWLKzgdCEJCc91cH
         oe/w==
X-Gm-Message-State: AOAM530qU3SfXVHYK6rMXF7Bc8Fpx6WTE3KuYBB08j5ej8Mrols24mBz
        wC3c/MWBckDJ9RVg9Rllcq2gANHy09PXpQ==
X-Google-Smtp-Source: ABdhPJzVtorDWJLgubuEdKo1A/yNS7G/3KK2+skpP/dlyCs/95qFfode/Fg0tcMo1AJGTwPfrfpYpA==
X-Received: by 2002:a17:906:4553:: with SMTP id s19mr1684874ejq.543.1590559399672;
        Tue, 26 May 2020 23:03:19 -0700 (PDT)
Received: from linux.fritz.box (p200300d99704730090a6e4d69e0f1db5.dip0.t-ipconnect.de. [2003:d9:9704:7300:90a6:e4d6:9e0f:1db5])
        by smtp.googlemail.com with ESMTPSA id e8sm1466033edk.42.2020.05.26.23.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 23:03:19 -0700 (PDT)
Subject: Re: [PATCH] ipc/msg.c: wake up senders until there is a queue empty
 capacity
To:     Artur Barsegyan <a.barsegyan96@gmail.com>
Cc:     skutepov@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Lu Shuaibing <shuaibinglu@126.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20200523203448.84235-1-a.barsegyan96@gmail.com>
 <0410a00b-fb20-cbaa-4a29-c7752a469fdd@colorfullife.com>
 <20200526075618.GA19866@a-barsegyan>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <4c9cc53a-ad71-2716-ecd9-7df78948519e@colorfullife.com>
Date:   Wed, 27 May 2020 08:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526075618.GA19866@a-barsegyan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Artur,

On 5/26/20 9:56 AM, Artur Barsegyan wrote:
> Hello, Manfred!
>
> Thank you, for your review. I've reviewed your patch.
>
> I forgot about the case with different message types. At now with your patch,
> a sender will force message consuming if that doesn't hold own capacity.
>
> I have measured queue throughput and have pushed the results to:
> https://github.com/artur-barsegyan/systemv_queue_research
>
> But I'm confused about the next thought: in general loop in the do_msgsnd()
> function, we doesn't check pipeline sending availability. Your case will be
> optimized if we check the pipeline sending inside the loop.

I don't get your concern, or perhaps this is a feature that I had always 
assumed as "normal":

"msg_fits_inqueue(msq, msgsz)" is in the loop, this ensures progress.

The rational is a design decision:

The check for pipeline sending is only done if there would be space to 
store the message in the queue.

I was afraid that performing the pipeline send immediately, without 
checking queue availability, could break apps:

Some messages would arrive immediately (if there is a waiting receiver), 
other messages are stuck forever (since the queue is full).

Initial patch: https://lkml.org/lkml/1999/10/3/5 (without any remarks 
about the design decision)

The risk that I had seen was theoretical, I do not have any real bug 
reports. So we could change it.

Perhaps: Go in the same direction as it was done for POSIX mqueue: 
implement pipelined receive.

> On Sun, May 24, 2020 at 03:21:31PM +0200, Manfred Spraul wrote:
>> Hello Artur,
>>
>> On 5/23/20 10:34 PM, Artur Barsegyan wrote:
>>> Take into account the total size of the already enqueued messages of
>>> previously handled senders before another one.
>>>
>>> Otherwise, we have serious degradation of receiver throughput for
>>> case with multiple senders because another sender wakes up,
>>> checks the queue capacity and falls into sleep again.
>>>
>>> Each round-trip wastes CPU time a lot and leads to perceptible
>>> throughput degradation.
>>>
>>> Source code of:
>>> 	- sender/receiver
>>> 	- benchmark script
>>> 	- ready graphics of before/after results
>>>
>>> is located here: https://github.com/artur-barsegyan/systemv_queue_research
>> Thanks for analyzing the issue!
>>
>>> Signed-off-by: Artur Barsegyan <a.barsegyan96@gmail.com>
>>> ---
>>>    ipc/msg.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/ipc/msg.c b/ipc/msg.c
>>> index caca67368cb5..52d634b0a65a 100644
>>> --- a/ipc/msg.c
>>> +++ b/ipc/msg.c
>>> @@ -214,6 +214,7 @@ static void ss_wakeup(struct msg_queue *msq,
>>>    	struct msg_sender *mss, *t;
>>>    	struct task_struct *stop_tsk = NULL;
>>>    	struct list_head *h = &msq->q_senders;
>>> +	size_t msq_quota_used = 0;
>>>    	list_for_each_entry_safe(mss, t, h, list) {
>>>    		if (kill)
>>> @@ -233,7 +234,7 @@ static void ss_wakeup(struct msg_queue *msq,
>>>    		 * move the sender to the tail on behalf of the
>>>    		 * blocked task.
>>>    		 */
>>> -		else if (!msg_fits_inqueue(msq, mss->msgsz)) {
>>> +		else if (!msg_fits_inqueue(msq, msq_quota_used + mss->msgsz)) {
>>>    			if (!stop_tsk)
>>>    				stop_tsk = mss->tsk;
>>> @@ -241,6 +242,7 @@ static void ss_wakeup(struct msg_queue *msq,
>>>    			continue;
>>>    		}
>>> +		msq_quota_used += mss->msgsz;
>>>    		wake_q_add(wake_q, mss->tsk);
>> You have missed the case of a do_msgsnd() that doesn't enqueue the message:
>>
>> Situation:
>>
>> - 2 messages of type 1 in the queue (2x8192 bytes, queue full)
>>
>> - 6 senders waiting to send messages of type 2
>>
>> - 6 receivers waiting to get messages of type 2.
>>
>> If now a receiver reads one message of type 1, then all 6 senders can send.
>>
>> WIth your patch applied, only one sender sends the message to one receiver,
>> and the remaining 10 tasks continue to sleep.
>>
>>
>> Could you please check and (assuming that you agree) run your benchmarks
>> with the patch applied?
>>
>> --
>>
>>      Manfred
>>
>>
>>
>>  From fe2f257b1950a19bf5c6f67e71aa25c2f13bcdc3 Mon Sep 17 00:00:00 2001
>> From: Manfred Spraul <manfred@colorfullife.com>
>> Date: Sun, 24 May 2020 14:47:31 +0200
>> Subject: [PATCH 2/2] ipc/msg.c: Handle case of senders not enqueuing the
>>   message
>>
>> The patch "ipc/msg.c: wake up senders until there is a queue empty
>> capacity" avoids the thundering herd problem by wakeing up
>> only as many potential senders as there is free space in the queue.
>>
>> This patch is a fix: If one of the senders doesn't enqueue its message,
>> then a search for further potential senders must be performed.
>>
>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>> ---
>>   ipc/msg.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/ipc/msg.c b/ipc/msg.c
>> index 52d634b0a65a..f6d5188db38a 100644
>> --- a/ipc/msg.c
>> +++ b/ipc/msg.c
>> @@ -208,6 +208,12 @@ static inline void ss_del(struct msg_sender *mss)
>>   		list_del(&mss->list);
>>   }
>>   
>> +/*
>> + * ss_wakeup() assumes that the stored senders will enqueue the pending message.
>> + * Thus: If a woken up task doesn't send the enqueued message for whatever
>> + * reason, then that task must call ss_wakeup() again, to ensure that no
>> + * wakeup is lost.
>> + */
>>   static void ss_wakeup(struct msg_queue *msq,
>>   		      struct wake_q_head *wake_q, bool kill)
>>   {
>> @@ -843,6 +849,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>   	struct msg_queue *msq;
>>   	struct msg_msg *msg;
>>   	int err;
>> +	bool need_wakeup;
>>   	struct ipc_namespace *ns;
>>   	DEFINE_WAKE_Q(wake_q);
>>   
>> @@ -869,6 +876,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>   
>>   	ipc_lock_object(&msq->q_perm);
>>   
>> +	need_wakeup = false;
>>   	for (;;) {
>>   		struct msg_sender s;
>>   
>> @@ -898,6 +906,13 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>   		/* enqueue the sender and prepare to block */
>>   		ss_add(msq, &s, msgsz);
>>   
>> +		/* Enqueuing a sender is actually an obligation:
>> +		 * The sender must either enqueue the message, or call
>> +		 * ss_wakeup(). Thus track that we have added our message
>> +		 * to the candidates for the message queue.
>> +		 */
>> +		need_wakeup = true;
>> +
>>   		if (!ipc_rcu_getref(&msq->q_perm)) {
>>   			err = -EIDRM;
>>   			goto out_unlock0;
>> @@ -935,12 +950,18 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>   		msq->q_qnum++;
>>   		atomic_add(msgsz, &ns->msg_bytes);
>>   		atomic_inc(&ns->msg_hdrs);
>> +
>> +		/* we have fulfilled our obligation, no need for wakeup */
>> +		need_wakeup = false;
>>   	}
>>   
>>   	err = 0;
>>   	msg = NULL;
>>   
>>   out_unlock0:
>> +	if (need_wakeup)
>> +		ss_wakeup(msq, &wake_q, false);
>> +
>>   	ipc_unlock_object(&msq->q_perm);
>>   	wake_up_q(&wake_q);
>>   out_unlock1:
>> -- 
>> 2.26.2
>>

