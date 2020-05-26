Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57973C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287CD20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qanV7sDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgEZH4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgEZH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:56:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B6EC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:56:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r125so11728524lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AtWHuosc9HAs7V0XgYn9L7UDDWbHNp6VCR80p4XmsVw=;
        b=qanV7sDDW1MwY4EYyMAkOy/Tzpftn+EgnnyUedacmpn+L2FLjAspN9M5D2ByqHFZZQ
         pw2dJaJl9A1HU7KHplJfCJQTs2JLkHEzaSWZRkfGtW0i6zKSP1zfautFjniLFL6fnTFz
         DD/oqvMkZ1FSgH/OxzLWGMsqmjMWn31L1mHPLdcMDLaS0CMaWQVPJWeznY2BP788NUMm
         lDd9CAur1GA682oMaru/+s9DVAbVYRKZajWpQgTYRBfPwUsCcU81NVx88RiFMKq+kISI
         KJk+WuAQP8kz22C6cyQf4yamd46oZMPkCk5N9dZYIUBihSI6f+4KRgyeN+L4ZQXwR26d
         88gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AtWHuosc9HAs7V0XgYn9L7UDDWbHNp6VCR80p4XmsVw=;
        b=Zr5DMG0t6NWfScebY58k5Rn4XF5+S85EB3JuNG6ncU82QrkFJSAwgQaq1lMLhGp+yq
         iERxZwoN/+DlWmKrljq8THdwEECEntwNfs+Se2bmGzmAImdNoAcwYG9JHKDucBFkOO98
         ehz4SS0o63oGzGZZVWmOg92R/94pgqJXpaakyC857CvZ5cdjSdabtM3IyXT6WP0Dj0Ea
         50bzYYbZCcwsG815yOnyBWAiQnFC4jK5MgukHLjRHQNXLgi9z9TTj4l/i6McQlLwz+8l
         5kFendExNsdoskEANBU5Pzusp0zPEe4nwuAAccqXcy9OEjTwJFAZp4nmiGUFvMxeiZGK
         2Z/Q==
X-Gm-Message-State: AOAM531Qq35hosyx+xhlpw/mogteBGQr0KKqLNA7/Hh3USpAe4zMFLFh
        1QiBG3I+/KAxxWSb61o3t8k=
X-Google-Smtp-Source: ABdhPJxZGCDCooMNe8jLQcmljQQKcm3bwfAgWH53ylVHSOAVyG1ED1Ou+kiP4C98yecYCI6GWKQdPQ==
X-Received: by 2002:ac2:5457:: with SMTP id d23mr8834074lfn.18.1590479781207;
        Tue, 26 May 2020 00:56:21 -0700 (PDT)
Received: from a-barsegyan ([85.249.97.232])
        by smtp.gmail.com with ESMTPSA id f16sm251102lfa.10.2020.05.26.00.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:56:20 -0700 (PDT)
Date:   Tue, 26 May 2020 10:56:18 +0300
From:   Artur Barsegyan <a.barsegyan96@gmail.com>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     skutepov@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Lu Shuaibing <shuaibinglu@126.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/msg.c: wake up senders until there is a queue empty
 capacity
Message-ID: <20200526075618.GA19866@a-barsegyan>
References: <20200523203448.84235-1-a.barsegyan96@gmail.com>
 <0410a00b-fb20-cbaa-4a29-c7752a469fdd@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0410a00b-fb20-cbaa-4a29-c7752a469fdd@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Manfred!

Thank you, for your review. I've reviewed your patch.

I forgot about the case with different message types. At now with your patch,
a sender will force message consuming if that doesn't hold own capacity.

I have measured queue throughput and have pushed the results to:
https://github.com/artur-barsegyan/systemv_queue_research

But I'm confused about the next thought: in general loop in the do_msgsnd()
function, we doesn't check pipeline sending availability. Your case will be
optimized if we check the pipeline sending inside the loop.

On Sun, May 24, 2020 at 03:21:31PM +0200, Manfred Spraul wrote:
> Hello Artur,
> 
> On 5/23/20 10:34 PM, Artur Barsegyan wrote:
> > Take into account the total size of the already enqueued messages of
> > previously handled senders before another one.
> > 
> > Otherwise, we have serious degradation of receiver throughput for
> > case with multiple senders because another sender wakes up,
> > checks the queue capacity and falls into sleep again.
> > 
> > Each round-trip wastes CPU time a lot and leads to perceptible
> > throughput degradation.
> > 
> > Source code of:
> > 	- sender/receiver
> > 	- benchmark script
> > 	- ready graphics of before/after results
> > 
> > is located here: https://github.com/artur-barsegyan/systemv_queue_research
> 
> Thanks for analyzing the issue!
> 
> > Signed-off-by: Artur Barsegyan <a.barsegyan96@gmail.com>
> > ---
> >   ipc/msg.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/ipc/msg.c b/ipc/msg.c
> > index caca67368cb5..52d634b0a65a 100644
> > --- a/ipc/msg.c
> > +++ b/ipc/msg.c
> > @@ -214,6 +214,7 @@ static void ss_wakeup(struct msg_queue *msq,
> >   	struct msg_sender *mss, *t;
> >   	struct task_struct *stop_tsk = NULL;
> >   	struct list_head *h = &msq->q_senders;
> > +	size_t msq_quota_used = 0;
> >   	list_for_each_entry_safe(mss, t, h, list) {
> >   		if (kill)
> > @@ -233,7 +234,7 @@ static void ss_wakeup(struct msg_queue *msq,
> >   		 * move the sender to the tail on behalf of the
> >   		 * blocked task.
> >   		 */
> > -		else if (!msg_fits_inqueue(msq, mss->msgsz)) {
> > +		else if (!msg_fits_inqueue(msq, msq_quota_used + mss->msgsz)) {
> >   			if (!stop_tsk)
> >   				stop_tsk = mss->tsk;
> > @@ -241,6 +242,7 @@ static void ss_wakeup(struct msg_queue *msq,
> >   			continue;
> >   		}
> > +		msq_quota_used += mss->msgsz;
> >   		wake_q_add(wake_q, mss->tsk);
> 
> You have missed the case of a do_msgsnd() that doesn't enqueue the message:
> 
> Situation:
> 
> - 2 messages of type 1 in the queue (2x8192 bytes, queue full)
> 
> - 6 senders waiting to send messages of type 2
> 
> - 6 receivers waiting to get messages of type 2.
> 
> If now a receiver reads one message of type 1, then all 6 senders can send.
> 
> WIth your patch applied, only one sender sends the message to one receiver,
> and the remaining 10 tasks continue to sleep.
> 
> 
> Could you please check and (assuming that you agree) run your benchmarks
> with the patch applied?
> 
> --
> 
>     Manfred
> 
> 
> 

> From fe2f257b1950a19bf5c6f67e71aa25c2f13bcdc3 Mon Sep 17 00:00:00 2001
> From: Manfred Spraul <manfred@colorfullife.com>
> Date: Sun, 24 May 2020 14:47:31 +0200
> Subject: [PATCH 2/2] ipc/msg.c: Handle case of senders not enqueuing the
>  message
> 
> The patch "ipc/msg.c: wake up senders until there is a queue empty
> capacity" avoids the thundering herd problem by wakeing up
> only as many potential senders as there is free space in the queue.
> 
> This patch is a fix: If one of the senders doesn't enqueue its message,
> then a search for further potential senders must be performed.
> 
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>  ipc/msg.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/ipc/msg.c b/ipc/msg.c
> index 52d634b0a65a..f6d5188db38a 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -208,6 +208,12 @@ static inline void ss_del(struct msg_sender *mss)
>  		list_del(&mss->list);
>  }
>  
> +/*
> + * ss_wakeup() assumes that the stored senders will enqueue the pending message.
> + * Thus: If a woken up task doesn't send the enqueued message for whatever
> + * reason, then that task must call ss_wakeup() again, to ensure that no
> + * wakeup is lost.
> + */
>  static void ss_wakeup(struct msg_queue *msq,
>  		      struct wake_q_head *wake_q, bool kill)
>  {
> @@ -843,6 +849,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>  	struct msg_queue *msq;
>  	struct msg_msg *msg;
>  	int err;
> +	bool need_wakeup;
>  	struct ipc_namespace *ns;
>  	DEFINE_WAKE_Q(wake_q);
>  
> @@ -869,6 +876,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>  
>  	ipc_lock_object(&msq->q_perm);
>  
> +	need_wakeup = false;
>  	for (;;) {
>  		struct msg_sender s;
>  
> @@ -898,6 +906,13 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>  		/* enqueue the sender and prepare to block */
>  		ss_add(msq, &s, msgsz);
>  
> +		/* Enqueuing a sender is actually an obligation:
> +		 * The sender must either enqueue the message, or call
> +		 * ss_wakeup(). Thus track that we have added our message
> +		 * to the candidates for the message queue.
> +		 */
> +		need_wakeup = true;
> +
>  		if (!ipc_rcu_getref(&msq->q_perm)) {
>  			err = -EIDRM;
>  			goto out_unlock0;
> @@ -935,12 +950,18 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>  		msq->q_qnum++;
>  		atomic_add(msgsz, &ns->msg_bytes);
>  		atomic_inc(&ns->msg_hdrs);
> +
> +		/* we have fulfilled our obligation, no need for wakeup */
> +		need_wakeup = false;
>  	}
>  
>  	err = 0;
>  	msg = NULL;
>  
>  out_unlock0:
> +	if (need_wakeup)
> +		ss_wakeup(msq, &wake_q, false);
> +
>  	ipc_unlock_object(&msq->q_perm);
>  	wake_up_q(&wake_q);
>  out_unlock1:
> -- 
> 2.26.2
> 

