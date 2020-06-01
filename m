Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C432068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="jCEbzs7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFAOVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAOVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:21:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CBC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 07:20:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p5so1164wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VvB0BOoYF+uit5rTT4vDN7v/EavfPMMbVgYDfyoUFFI=;
        b=jCEbzs7uPN3A/lhsUQMgeDwc1bGtb3Gsb3JDRe0V1RAev6fVD27sLA64bNS467CM/i
         xvvlZO7nE04N6MHs/X831kxNVY6YSG3gy5rQ9Sj+lNVo3ByeNksv8Q/zYul5adBREjG9
         1LEXMugI1TQCB8EX1b/o/sQRFa/ZHpS4PlIGsmCGnh2NbKZAL3nmCbtBA7imCSrn7pI/
         QEPNq0B3IDFEy4EBxNjab114a+zhqNZ2aV6mgiFsap6/+GewP+QyqWvszXu3h3nqJSKV
         cQDXbhwH9tIyxjBYtLEP/zQRzdPb14fTnpv/U+cXtRkbVZE2AVBfmvf2r15QeMQuBtR6
         PJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VvB0BOoYF+uit5rTT4vDN7v/EavfPMMbVgYDfyoUFFI=;
        b=Rl9NstotYUZWU7KsEb9YxfCYLuk8UQ3SDcfxWGGTT0z4P8H4Jou+l/UO19TzJqYzWo
         pFUHXlaa10UQ9RSwsSGgCzH3bS7rX/zVtimmpoCN/0cW/DfQpZxnXVC61t42CuhdhKXM
         7vjrDtYZdmIdXD6O9aRCrKz1c1FVqqVUUhRWkCiaFFqpqdx047rd9AYiCXGGANlFlxUU
         llp44PWGgTgA5j3x160TsUNjMVFJvuvTQvKHMYi0LGdLclzQP1ULUEEc3B50V5Jils88
         l+uEs+rYKDE9/uATVqgm218VUocYMaVbeNs+NnatE0hGNeiDgbdYCtva339hGdQXU2Yl
         rMyw==
X-Gm-Message-State: AOAM532TLI6vmKda+C8cpcqFxtVHlR2HTln2Ud3E/Yc4+OzUOfJQ4zHj
        Bb4AL/cINGvmtdOVBaBw13wCLn2DVcA=
X-Google-Smtp-Source: ABdhPJyhVW80qOSO+eWeccj/OWWSqJ1S+u+1VQWZs0WgsscMHizI0zZuB43BL5l/GyJDJ04Ot0UZAw==
X-Received: by 2002:adf:cd08:: with SMTP id w8mr18565835wrm.36.1591021258156;
        Mon, 01 Jun 2020 07:20:58 -0700 (PDT)
Received: from linux.fritz.box (p200300d997098000c5267ea0e5331791.dip0.t-ipconnect.de. [2003:d9:9709:8000:c526:7ea0:e533:1791])
        by smtp.googlemail.com with ESMTPSA id l204sm13950228wmf.19.2020.06.01.07.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 07:20:57 -0700 (PDT)
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
 <4c9cc53a-ad71-2716-ecd9-7df78948519e@colorfullife.com>
 <20200527112257.GC12093@a-barsegyan> <20200601140244.GA24678@a-barsegyan>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <e11af136-270d-e902-22be-482c0ac50266@colorfullife.com>
Date:   Mon, 1 Jun 2020 16:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601140244.GA24678@a-barsegyan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artus,

On 6/1/20 4:02 PM, Artur Barsegyan wrote:
> Hi, Manfred.
>
> Did you get my last message?

Yes, I'm just too busy right now.

My plan/backlog is:

- the xarray patch from Matthew

- improve finding max_id in ipc_rmid(). Perhaps even remove max_id 
entirely and instead calculate it on demand.

- your patch to avoid waking up too many tasks, including my bugfix.


> On Wed, May 27, 2020 at 02:22:57PM +0300, Artur Barsegyan wrote:
>> [sorry for the duplicates — I have changed my email client]
>>
>> About your case:
>>
>> The new receiver puts at the end of the receivers list.
>> pipelined_send() starts from the beginning of the list and iterates until the end.
>>
>> If our queue is always full, each receiver should get a message because new receivers appends at the end.
>> In my vision: we waste some time in that loop but in general should increase the throughout. But it should be tested.
>>
>> Yes, I'm gonna implement it and make a benchmark. But maybe it should be done in another patch thread?

My biggest problem is always realistic benchmarks:

Do we optimize for code size/small amount of branches, or add special 
cases for things that we think could be common?

Avoiding thundering herds is always good, avoiding schedule() is always 
good.

Thus I would start with pipelined_receive, and then we would need 
feedback from apps that use sysv msg.

(old fakeroot is what I remember as test app)

>> On Wed, May 27, 2020 at 08:03:17AM +0200, Manfred Spraul wrote:
>>> Hello Artur,
>>>
>>> On 5/26/20 9:56 AM, Artur Barsegyan wrote:
>>>> Hello, Manfred!
>>>>
>>>> Thank you, for your review. I've reviewed your patch.
>>>>
>>>> I forgot about the case with different message types. At now with your patch,
>>>> a sender will force message consuming if that doesn't hold own capacity.
>>>>
>>>> I have measured queue throughput and have pushed the results to:
>>>> https://github.com/artur-barsegyan/systemv_queue_research
>>>>
>>>> But I'm confused about the next thought: in general loop in the do_msgsnd()
>>>> function, we doesn't check pipeline sending availability. Your case will be
>>>> optimized if we check the pipeline sending inside the loop.
>>> I don't get your concern, or perhaps this is a feature that I had always
>>> assumed as "normal":
>>>
>>> "msg_fits_inqueue(msq, msgsz)" is in the loop, this ensures progress.
>>>
>>> The rational is a design decision:
>>>
>>> The check for pipeline sending is only done if there would be space to store
>>> the message in the queue.
>>>
>>> I was afraid that performing the pipeline send immediately, without checking
>>> queue availability, could break apps:
>>>
>>> Some messages would arrive immediately (if there is a waiting receiver),
>>> other messages are stuck forever (since the queue is full).
>>>
>>> Initial patch: https://lkml.org/lkml/1999/10/3/5 (without any remarks about
>>> the design decision)
>>>
>>> The risk that I had seen was theoretical, I do not have any real bug
>>> reports. So we could change it.
>>>
>>> Perhaps: Go in the same direction as it was done for POSIX mqueue: implement
>>> pipelined receive.
>>>
>>>> On Sun, May 24, 2020 at 03:21:31PM +0200, Manfred Spraul wrote:
>>>>> Hello Artur,
>>>>>
>>>>> On 5/23/20 10:34 PM, Artur Barsegyan wrote:
>>>>>> Take into account the total size of the already enqueued messages of
>>>>>> previously handled senders before another one.
>>>>>>
>>>>>> Otherwise, we have serious degradation of receiver throughput for
>>>>>> case with multiple senders because another sender wakes up,
>>>>>> checks the queue capacity and falls into sleep again.
>>>>>>
>>>>>> Each round-trip wastes CPU time a lot and leads to perceptible
>>>>>> throughput degradation.
>>>>>>
>>>>>> Source code of:
>>>>>> 	- sender/receiver
>>>>>> 	- benchmark script
>>>>>> 	- ready graphics of before/after results
>>>>>>
>>>>>> is located here: https://github.com/artur-barsegyan/systemv_queue_research
>>>>> Thanks for analyzing the issue!
>>>>>
>>>>>> Signed-off-by: Artur Barsegyan <a.barsegyan96@gmail.com>
>>>>>> ---
>>>>>>     ipc/msg.c | 4 +++-
>>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/ipc/msg.c b/ipc/msg.c
>>>>>> index caca67368cb5..52d634b0a65a 100644
>>>>>> --- a/ipc/msg.c
>>>>>> +++ b/ipc/msg.c
>>>>>> @@ -214,6 +214,7 @@ static void ss_wakeup(struct msg_queue *msq,
>>>>>>     	struct msg_sender *mss, *t;
>>>>>>     	struct task_struct *stop_tsk = NULL;
>>>>>>     	struct list_head *h = &msq->q_senders;
>>>>>> +	size_t msq_quota_used = 0;
>>>>>>     	list_for_each_entry_safe(mss, t, h, list) {
>>>>>>     		if (kill)
>>>>>> @@ -233,7 +234,7 @@ static void ss_wakeup(struct msg_queue *msq,
>>>>>>     		 * move the sender to the tail on behalf of the
>>>>>>     		 * blocked task.
>>>>>>     		 */
>>>>>> -		else if (!msg_fits_inqueue(msq, mss->msgsz)) {
>>>>>> +		else if (!msg_fits_inqueue(msq, msq_quota_used + mss->msgsz)) {
>>>>>>     			if (!stop_tsk)
>>>>>>     				stop_tsk = mss->tsk;
>>>>>> @@ -241,6 +242,7 @@ static void ss_wakeup(struct msg_queue *msq,
>>>>>>     			continue;
>>>>>>     		}
>>>>>> +		msq_quota_used += mss->msgsz;
>>>>>>     		wake_q_add(wake_q, mss->tsk);
>>>>> You have missed the case of a do_msgsnd() that doesn't enqueue the message:
>>>>>
>>>>> Situation:
>>>>>
>>>>> - 2 messages of type 1 in the queue (2x8192 bytes, queue full)
>>>>>
>>>>> - 6 senders waiting to send messages of type 2
>>>>>
>>>>> - 6 receivers waiting to get messages of type 2.
>>>>>
>>>>> If now a receiver reads one message of type 1, then all 6 senders can send.
>>>>>
>>>>> WIth your patch applied, only one sender sends the message to one receiver,
>>>>> and the remaining 10 tasks continue to sleep.
>>>>>
>>>>>
>>>>> Could you please check and (assuming that you agree) run your benchmarks
>>>>> with the patch applied?
>>>>>
>>>>> --
>>>>>
>>>>>       Manfred
>>>>>
>>>>>
>>>>>
>>>>>   From fe2f257b1950a19bf5c6f67e71aa25c2f13bcdc3 Mon Sep 17 00:00:00 2001
>>>>> From: Manfred Spraul <manfred@colorfullife.com>
>>>>> Date: Sun, 24 May 2020 14:47:31 +0200
>>>>> Subject: [PATCH 2/2] ipc/msg.c: Handle case of senders not enqueuing the
>>>>>    message
>>>>>
>>>>> The patch "ipc/msg.c: wake up senders until there is a queue empty
>>>>> capacity" avoids the thundering herd problem by wakeing up
>>>>> only as many potential senders as there is free space in the queue.
>>>>>
>>>>> This patch is a fix: If one of the senders doesn't enqueue its message,
>>>>> then a search for further potential senders must be performed.
>>>>>
>>>>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>>>>> ---
>>>>>    ipc/msg.c | 21 +++++++++++++++++++++
>>>>>    1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/ipc/msg.c b/ipc/msg.c
>>>>> index 52d634b0a65a..f6d5188db38a 100644
>>>>> --- a/ipc/msg.c
>>>>> +++ b/ipc/msg.c
>>>>> @@ -208,6 +208,12 @@ static inline void ss_del(struct msg_sender *mss)
>>>>>    		list_del(&mss->list);
>>>>>    }
>>>>> +/*
>>>>> + * ss_wakeup() assumes that the stored senders will enqueue the pending message.
>>>>> + * Thus: If a woken up task doesn't send the enqueued message for whatever
>>>>> + * reason, then that task must call ss_wakeup() again, to ensure that no
>>>>> + * wakeup is lost.
>>>>> + */
>>>>>    static void ss_wakeup(struct msg_queue *msq,
>>>>>    		      struct wake_q_head *wake_q, bool kill)
>>>>>    {
>>>>> @@ -843,6 +849,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>>>>    	struct msg_queue *msq;
>>>>>    	struct msg_msg *msg;
>>>>>    	int err;
>>>>> +	bool need_wakeup;
>>>>>    	struct ipc_namespace *ns;
>>>>>    	DEFINE_WAKE_Q(wake_q);
>>>>> @@ -869,6 +876,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>>>>    	ipc_lock_object(&msq->q_perm);
>>>>> +	need_wakeup = false;
>>>>>    	for (;;) {
>>>>>    		struct msg_sender s;
>>>>> @@ -898,6 +906,13 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>>>>    		/* enqueue the sender and prepare to block */
>>>>>    		ss_add(msq, &s, msgsz);
>>>>> +		/* Enqueuing a sender is actually an obligation:
>>>>> +		 * The sender must either enqueue the message, or call
>>>>> +		 * ss_wakeup(). Thus track that we have added our message
>>>>> +		 * to the candidates for the message queue.
>>>>> +		 */
>>>>> +		need_wakeup = true;
>>>>> +
>>>>>    		if (!ipc_rcu_getref(&msq->q_perm)) {
>>>>>    			err = -EIDRM;
>>>>>    			goto out_unlock0;
>>>>> @@ -935,12 +950,18 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>>>>    		msq->q_qnum++;
>>>>>    		atomic_add(msgsz, &ns->msg_bytes);
>>>>>    		atomic_inc(&ns->msg_hdrs);
>>>>> +
>>>>> +		/* we have fulfilled our obligation, no need for wakeup */
>>>>> +		need_wakeup = false;
>>>>>    	}
>>>>>    	err = 0;
>>>>>    	msg = NULL;
>>>>>    out_unlock0:
>>>>> +	if (need_wakeup)
>>>>> +		ss_wakeup(msq, &wake_q, false);
>>>>> +
>>>>>    	ipc_unlock_object(&msq->q_perm);
>>>>>    	wake_up_q(&wake_q);
>>>>>    out_unlock1:
>>>>> -- 
>>>>> 2.26.2
>>>>>

