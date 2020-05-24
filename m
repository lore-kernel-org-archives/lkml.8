Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B265BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750C1207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="hKIiNI4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEXNVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgEXNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 09:21:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7818AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 06:21:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so17903775eje.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=PdKFnmHY5D0RuffzJcNxE/y6oL7p52+hcSK41C58lOQ=;
        b=hKIiNI4Jh2d+B9HaeqvDvmKuSVzkaVRu1EKvzOgXJGBGNohUAzvM2jtecL9iHUcoqa
         dFX+QMnieHeHAS4bQN/mjTTplFnsN6NSuyzIMfPAPhMerUEfrJ4tzwhJfDGrD1xboE8J
         HO9oG1p+sp7MbRIhtriETcLRnfm8BRDSUVWghXcZcg1oa5cFobiX3smvZbfA9v6NRnJH
         n7Ns5HTWy8jziosQzcMVllGW8Pm9QUpmWmAMu/IcNM9Y/2PIQK9ptMfbYg+b/hiPsgsw
         ia9GFZTt++fPjfQ7QaIsHtPDxq4y+3ugCx0XyGNcYzxUScGBrXr3bryTaR7+YdHvk2EA
         iZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=PdKFnmHY5D0RuffzJcNxE/y6oL7p52+hcSK41C58lOQ=;
        b=lMtYqq5b4onzDYkI2BKnM5D0YWV6n7ED87w42/W1E18kcAJkzvm+FBQhiLOzjnO1xf
         15NO35ZKdIJrAm+CcbL342NuaGGRXe9Fy3/qonK5g0V/Q6Fo37RXvUshN0TiZr06j030
         m3mB+ZLQ8I/elDBOERNYVMIYsS03mxFRsAkCKR8+nBvsrUp2P5MhDVQEeMvuKaGfPkAG
         pZXW69x3l54ROEBZjqWWl3rX4wCSRSSun+Y6Xze2kmqeYpO9NLZJG+RYSm92ACKjEL+i
         mJnmJW0gkdt3SrY88GkdoDWpMknGkbs7mMeVbxNvPTAGQ7YJH9XQUV5k8xksJ4ysmLOU
         G4xg==
X-Gm-Message-State: AOAM533N22ixI320hY/USEW+55mSne+b8rUT/+l+OZWndYW3Sz33l+xI
        SsaELgd0V+34U/eY4erswAhjKoKumTw=
X-Google-Smtp-Source: ABdhPJy/ZQhV8sPuh1CkWe7QFBRsuCGYzC3XSahcBFqZ/ow94G9O5slmnTUZqLe5Pa9c5QUovpwU8w==
X-Received: by 2002:a17:906:2448:: with SMTP id a8mr14752890ejb.310.1590326493684;
        Sun, 24 May 2020 06:21:33 -0700 (PDT)
Received: from linux.fritz.box (p200300d9974ddc00d11660c61940cb1c.dip0.t-ipconnect.de. [2003:d9:974d:dc00:d116:60c6:1940:cb1c])
        by smtp.googlemail.com with ESMTPSA id d22sm12948424ejb.15.2020.05.24.06.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 06:21:32 -0700 (PDT)
Subject: Re: [PATCH] ipc/msg.c: wake up senders until there is a queue empty
 capacity
To:     Artur Barsegyan <a.barsegyan96@gmail.com>
Cc:     skutepov@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Lu Shuaibing <shuaibinglu@126.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20200523203448.84235-1-a.barsegyan96@gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <0410a00b-fb20-cbaa-4a29-c7752a469fdd@colorfullife.com>
Date:   Sun, 24 May 2020 15:21:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523203448.84235-1-a.barsegyan96@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------32DD537C888A21B4AD1ED564"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------32DD537C888A21B4AD1ED564
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Artur,

On 5/23/20 10:34 PM, Artur Barsegyan wrote:
> Take into account the total size of the already enqueued messages of
> previously handled senders before another one.
>
> Otherwise, we have serious degradation of receiver throughput for
> case with multiple senders because another sender wakes up,
> checks the queue capacity and falls into sleep again.
>
> Each round-trip wastes CPU time a lot and leads to perceptible
> throughput degradation.
>
> Source code of:
> 	- sender/receiver
> 	- benchmark script
> 	- ready graphics of before/after results
>
> is located here: https://github.com/artur-barsegyan/systemv_queue_research

Thanks for analyzing the issue!

> Signed-off-by: Artur Barsegyan <a.barsegyan96@gmail.com>
> ---
>   ipc/msg.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ipc/msg.c b/ipc/msg.c
> index caca67368cb5..52d634b0a65a 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -214,6 +214,7 @@ static void ss_wakeup(struct msg_queue *msq,
>   	struct msg_sender *mss, *t;
>   	struct task_struct *stop_tsk = NULL;
>   	struct list_head *h = &msq->q_senders;
> +	size_t msq_quota_used = 0;
>   
>   	list_for_each_entry_safe(mss, t, h, list) {
>   		if (kill)
> @@ -233,7 +234,7 @@ static void ss_wakeup(struct msg_queue *msq,
>   		 * move the sender to the tail on behalf of the
>   		 * blocked task.
>   		 */
> -		else if (!msg_fits_inqueue(msq, mss->msgsz)) {
> +		else if (!msg_fits_inqueue(msq, msq_quota_used + mss->msgsz)) {
>   			if (!stop_tsk)
>   				stop_tsk = mss->tsk;
>   
> @@ -241,6 +242,7 @@ static void ss_wakeup(struct msg_queue *msq,
>   			continue;
>   		}
>   
> +		msq_quota_used += mss->msgsz;
>   		wake_q_add(wake_q, mss->tsk);

You have missed the case of a do_msgsnd() that doesn't enqueue the message:

Situation:

- 2 messages of type 1 in the queue (2x8192 bytes, queue full)

- 6 senders waiting to send messages of type 2

- 6 receivers waiting to get messages of type 2.

If now a receiver reads one message of type 1, then all 6 senders can send.

WIth your patch applied, only one sender sends the message to one 
receiver, and the remaining 10 tasks continue to sleep.


Could you please check and (assuming that you agree) run your benchmarks 
with the patch applied?

--

     Manfred




--------------32DD537C888A21B4AD1ED564
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-ipc-msg.c-Handle-case-of-senders-not-enqueuing-the-m.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ipc-msg.c-Handle-case-of-senders-not-enqueuing-the-m.pa";
 filename*1="tch"

From fe2f257b1950a19bf5c6f67e71aa25c2f13bcdc3 Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Sun, 24 May 2020 14:47:31 +0200
Subject: [PATCH 2/2] ipc/msg.c: Handle case of senders not enqueuing the
 message

The patch "ipc/msg.c: wake up senders until there is a queue empty
capacity" avoids the thundering herd problem by wakeing up
only as many potential senders as there is free space in the queue.

This patch is a fix: If one of the senders doesn't enqueue its message,
then a search for further potential senders must be performed.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/msg.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/ipc/msg.c b/ipc/msg.c
index 52d634b0a65a..f6d5188db38a 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -208,6 +208,12 @@ static inline void ss_del(struct msg_sender *mss)
 		list_del(&mss->list);
 }
 
+/*
+ * ss_wakeup() assumes that the stored senders will enqueue the pending message.
+ * Thus: If a woken up task doesn't send the enqueued message for whatever
+ * reason, then that task must call ss_wakeup() again, to ensure that no
+ * wakeup is lost.
+ */
 static void ss_wakeup(struct msg_queue *msq,
 		      struct wake_q_head *wake_q, bool kill)
 {
@@ -843,6 +849,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	struct msg_queue *msq;
 	struct msg_msg *msg;
 	int err;
+	bool need_wakeup;
 	struct ipc_namespace *ns;
 	DEFINE_WAKE_Q(wake_q);
 
@@ -869,6 +876,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 
 	ipc_lock_object(&msq->q_perm);
 
+	need_wakeup = false;
 	for (;;) {
 		struct msg_sender s;
 
@@ -898,6 +906,13 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 		/* enqueue the sender and prepare to block */
 		ss_add(msq, &s, msgsz);
 
+		/* Enqueuing a sender is actually an obligation:
+		 * The sender must either enqueue the message, or call
+		 * ss_wakeup(). Thus track that we have added our message
+		 * to the candidates for the message queue.
+		 */
+		need_wakeup = true;
+
 		if (!ipc_rcu_getref(&msq->q_perm)) {
 			err = -EIDRM;
 			goto out_unlock0;
@@ -935,12 +950,18 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 		msq->q_qnum++;
 		atomic_add(msgsz, &ns->msg_bytes);
 		atomic_inc(&ns->msg_hdrs);
+
+		/* we have fulfilled our obligation, no need for wakeup */
+		need_wakeup = false;
 	}
 
 	err = 0;
 	msg = NULL;
 
 out_unlock0:
+	if (need_wakeup)
+		ss_wakeup(msq, &wake_q, false);
+
 	ipc_unlock_object(&msq->q_perm);
 	wake_up_q(&wake_q);
 out_unlock1:
-- 
2.26.2


--------------32DD537C888A21B4AD1ED564--
