Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956BAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE12207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQhql6ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbgE0LXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388143AbgE0LXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:23:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D076C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:23:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id e125so14245768lfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s/PJjsd1zwpechCxHQc9NmzYqMK/24CIDdqfcai4x8Q=;
        b=fQhql6oxUbrAPFGrNp0pYvlEZqIlsuO+DfOQyQ0B43bk1z2jssM5+OtQa7e3CWxU5G
         OHXcZTf8655p1Ls++3BdLQneGY610ZwUYYJODnj72CK/p+TCbaO2COU8ije0CrykozFx
         uzyRRs95Lhw46znk8fULArmsWZOG00s7DKgaT4uXqpBM6JGzV4kQZnyK8g3sBkFF4pNo
         DdjvqtxDC3dS4ozIjdyGhwfmc3GIggebpImOFi7+rjGZUcl8B7wL1E+SjmwE3d/JjT8C
         paybtubghOQaLewYVHoi/+Bcsse9jpcgIMSM/Db7VjmqkcSHJLt9DX4OyXwx91LjRp1l
         40aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s/PJjsd1zwpechCxHQc9NmzYqMK/24CIDdqfcai4x8Q=;
        b=Pk7mp8xmar9yZSPWQ4An+bVozPUH5VLhdzMar2cxA1mVXbalJ4gSzc+2PsGwWl7She
         YMZdVqat+1XW8OsPHbWqZMAWrqLc13fKcgc/bsL6aH40biF/Grj+kc7fyu1I5mH0asdm
         YIbPMOW5rAONszY7tlRLDl7ce0J0njZXgTLSMukg9Cs+ew9AOvYSZO+n0DFPAD91OzOB
         PXyZy+Az1bxCCjdXV/Hxn741TzjNRGmbSP87YJDcQpBMSjjqwyD8RRwxZTfHSihx14ud
         YDltujGwMn3NdP+fFXrAzk8YNTtVEp+e7mHasT7Xk59ouBMQe0JWF2IydcAypREqh0L6
         l4YA==
X-Gm-Message-State: AOAM532qrFjBvgOM45e+8NaiZhI7L4UZKhoCjZsJVyWMh29JfgOERi8H
        ufXAL+HuA0J7yAgx/OrcA2Y=
X-Google-Smtp-Source: ABdhPJyI299AQv/VUAGruQkYxZ5D49is4LjTwYpEP0+dSbbP/LzrE3Fn9XnGKEeUWrxSL0UTOG4ljg==
X-Received: by 2002:a19:c751:: with SMTP id x78mr2921094lff.82.1590578579957;
        Wed, 27 May 2020 04:22:59 -0700 (PDT)
Received: from a-barsegyan ([85.249.97.232])
        by smtp.gmail.com with ESMTPSA id q26sm634791ljj.84.2020.05.27.04.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 04:22:59 -0700 (PDT)
Date:   Wed, 27 May 2020 14:22:57 +0300
From:   Artur Barsegyan <a.barsegyan96@gmail.com>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     skutepov@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Lu Shuaibing <shuaibinglu@126.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/msg.c: wake up senders until there is a queue empty
 capacity
Message-ID: <20200527112257.GC12093@a-barsegyan>
References: <20200523203448.84235-1-a.barsegyan96@gmail.com>
 <0410a00b-fb20-cbaa-4a29-c7752a469fdd@colorfullife.com>
 <20200526075618.GA19866@a-barsegyan>
 <4c9cc53a-ad71-2716-ecd9-7df78948519e@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c9cc53a-ad71-2716-ecd9-7df78948519e@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for the duplicates — I have changed my email client]

About your case:

The new receiver puts at the end of the receivers list.
pipelined_send() starts from the beginning of the list and iterates until the end.

If our queue is always full, each receiver should get a message because new receivers appends at the end.
In my vision: we waste some time in that loop but in general should increase the throughout. But it should be tested.

Yes, I'm gonna implement it and make a benchmark. But maybe it should be done in another patch thread?

On Wed, May 27, 2020 at 08:03:17AM +0200, Manfred Spraul wrote:
> Hello Artur,
> 
> On 5/26/20 9:56 AM, Artur Barsegyan wrote:
> > Hello, Manfred!
> > 
> > Thank you, for your review. I've reviewed your patch.
> > 
> > I forgot about the case with different message types. At now with your patch,
> > a sender will force message consuming if that doesn't hold own capacity.
> > 
> > I have measured queue throughput and have pushed the results to:
> > https://github.com/artur-barsegyan/systemv_queue_research
> > 
> > But I'm confused about the next thought: in general loop in the do_msgsnd()
> > function, we doesn't check pipeline sending availability. Your case will be
> > optimized if we check the pipeline sending inside the loop.
> 
> I don't get your concern, or perhaps this is a feature that I had always
> assumed as "normal":
> 
> "msg_fits_inqueue(msq, msgsz)" is in the loop, this ensures progress.
> 
> The rational is a design decision:
> 
> The check for pipeline sending is only done if there would be space to store
> the message in the queue.
> 
> I was afraid that performing the pipeline send immediately, without checking
> queue availability, could break apps:
> 
> Some messages would arrive immediately (if there is a waiting receiver),
> other messages are stuck forever (since the queue is full).
> 
> Initial patch: https://lkml.org/lkml/1999/10/3/5 (without any remarks about
> the design decision)
> 
> The risk that I had seen was theoretical, I do not have any real bug
> reports. So we could change it.
> 
> Perhaps: Go in the same direction as it was done for POSIX mqueue: implement
> pipelined receive.
> 
> > On Sun, May 24, 2020 at 03:21:31PM +0200, Manfred Spraul wrote:
> > > Hello Artur,
> > > 
> > > On 5/23/20 10:34 PM, Artur Barsegyan wrote:
> > > > Take into account the total size of the already enqueued messages of
> > > > previously handled senders before another one.
> > > > 
> > > > Otherwise, we have serious degradation of receiver throughput for
> > > > case with multiple senders because another sender wakes up,
> > > > checks the queue capacity and falls into sleep again.
> > > > 
> > > > Each round-trip wastes CPU time a lot and leads to perceptible
> > > > throughput degradation.
> > > > 
> > > > Source code of:
> > > > 	- sender/receiver
> > > > 	- benchmark script
> > > > 	- ready graphics of before/after results
> > > > 
> > > > is located here: https://github.com/artur-barsegyan/systemv_queue_research
> > > Thanks for analyzing the issue!
> > > 
> > > > Signed-off-by: Artur Barsegyan <a.barsegyan96@gmail.com>
> > > > ---
> > > >    ipc/msg.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/ipc/msg.c b/ipc/msg.c
> > > > index caca67368cb5..52d634b0a65a 100644
> > > > --- a/ipc/msg.c
> > > > +++ b/ipc/msg.c
> > > > @@ -214,6 +214,7 @@ static void ss_wakeup(struct msg_queue *msq,
> > > >    	struct msg_sender *mss, *t;
> > > >    	struct task_struct *stop_tsk = NULL;
> > > >    	struct list_head *h = &msq->q_senders;
> > > > +	size_t msq_quota_used = 0;
> > > >    	list_for_each_entry_safe(mss, t, h, list) {
> > > >    		if (kill)
> > > > @@ -233,7 +234,7 @@ static void ss_wakeup(struct msg_queue *msq,
> > > >    		 * move the sender to the tail on behalf of the
> > > >    		 * blocked task.
> > > >    		 */
> > > > -		else if (!msg_fits_inqueue(msq, mss->msgsz)) {
> > > > +		else if (!msg_fits_inqueue(msq, msq_quota_used + mss->msgsz)) {
> > > >    			if (!stop_tsk)
> > > >    				stop_tsk = mss->tsk;
> > > > @@ -241,6 +242,7 @@ static void ss_wakeup(struct msg_queue *msq,
> > > >    			continue;
> > > >    		}
> > > > +		msq_quota_used += mss->msgsz;
> > > >    		wake_q_add(wake_q, mss->tsk);
> > > You have missed the case of a do_msgsnd() that doesn't enqueue the message:
> > > 
> > > Situation:
> > > 
> > > - 2 messages of type 1 in the queue (2x8192 bytes, queue full)
> > > 
> > > - 6 senders waiting to send messages of type 2
> > > 
> > > - 6 receivers waiting to get messages of type 2.
> > > 
> > > If now a receiver reads one message of type 1, then all 6 senders can send.
> > > 
> > > WIth your patch applied, only one sender sends the message to one receiver,
> > > and the remaining 10 tasks continue to sleep.
> > > 
> > > 
> > > Could you please check and (assuming that you agree) run your benchmarks
> > > with the patch applied?
> > > 
> > > --
> > > 
> > >      Manfred
> > > 
> > > 
> > > 
> > >  From fe2f257b1950a19bf5c6f67e71aa25c2f13bcdc3 Mon Sep 17 00:00:00 2001
> > > From: Manfred Spraul <manfred@colorfullife.com>
> > > Date: Sun, 24 May 2020 14:47:31 +0200
> > > Subject: [PATCH 2/2] ipc/msg.c: Handle case of senders not enqueuing the
> > >   message
> > > 
> > > The patch "ipc/msg.c: wake up senders until there is a queue empty
> > > capacity" avoids the thundering herd problem by wakeing up
> > > only as many potential senders as there is free space in the queue.
> > > 
> > > This patch is a fix: If one of the senders doesn't enqueue its message,
> > > then a search for further potential senders must be performed.
> > > 
> > > Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> > > ---
> > >   ipc/msg.c | 21 +++++++++++++++++++++
> > >   1 file changed, 21 insertions(+)
> > > 
> > > diff --git a/ipc/msg.c b/ipc/msg.c
> > > index 52d634b0a65a..f6d5188db38a 100644
> > > --- a/ipc/msg.c
> > > +++ b/ipc/msg.c
> > > @@ -208,6 +208,12 @@ static inline void ss_del(struct msg_sender *mss)
> > >   		list_del(&mss->list);
> > >   }
> > > +/*
> > > + * ss_wakeup() assumes that the stored senders will enqueue the pending message.
> > > + * Thus: If a woken up task doesn't send the enqueued message for whatever
> > > + * reason, then that task must call ss_wakeup() again, to ensure that no
> > > + * wakeup is lost.
> > > + */
> > >   static void ss_wakeup(struct msg_queue *msq,
> > >   		      struct wake_q_head *wake_q, bool kill)
> > >   {
> > > @@ -843,6 +849,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
> > >   	struct msg_queue *msq;
> > >   	struct msg_msg *msg;
> > >   	int err;
> > > +	bool need_wakeup;
> > >   	struct ipc_namespace *ns;
> > >   	DEFINE_WAKE_Q(wake_q);
> > > @@ -869,6 +876,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
> > >   	ipc_lock_object(&msq->q_perm);
> > > +	need_wakeup = false;
> > >   	for (;;) {
> > >   		struct msg_sender s;
> > > @@ -898,6 +906,13 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
> > >   		/* enqueue the sender and prepare to block */
> > >   		ss_add(msq, &s, msgsz);
> > > +		/* Enqueuing a sender is actually an obligation:
> > > +		 * The sender must either enqueue the message, or call
> > > +		 * ss_wakeup(). Thus track that we have added our message
> > > +		 * to the candidates for the message queue.
> > > +		 */
> > > +		need_wakeup = true;
> > > +
> > >   		if (!ipc_rcu_getref(&msq->q_perm)) {
> > >   			err = -EIDRM;
> > >   			goto out_unlock0;
> > > @@ -935,12 +950,18 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
> > >   		msq->q_qnum++;
> > >   		atomic_add(msgsz, &ns->msg_bytes);
> > >   		atomic_inc(&ns->msg_hdrs);
> > > +
> > > +		/* we have fulfilled our obligation, no need for wakeup */
> > > +		need_wakeup = false;
> > >   	}
> > >   	err = 0;
> > >   	msg = NULL;
> > >   out_unlock0:
> > > +	if (need_wakeup)
> > > +		ss_wakeup(msq, &wake_q, false);
> > > +
> > >   	ipc_unlock_object(&msq->q_perm);
> > >   	wake_up_q(&wake_q);
> > >   out_unlock1:
> > > -- 
> > > 2.26.2
> > > 
> 
