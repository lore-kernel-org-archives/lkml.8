Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D04C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E025207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FmmVucEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHMPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHMPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:07:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F63C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:07:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a5so7530889ioa.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/YTl5Y05aq7UDbYAfUoIvy9c2eHnrqw43JiYTVbNYGI=;
        b=FmmVucEmFmLF79LSOv72FcJjGhjUtCpG8E+YnVoqfP+0S3sMBXadxBLRhIA9AVTv2u
         5gFyz/TWmP63wXJB9jSnJUQXtAkAJTnffteOjsGhN/3BiCESvnQc5GPw5rcKXXIfzEK7
         cNLwcOtPDlZL9sRwKiborUaOwHVKOCFGIK1pr1Keu0gaSePS2SDIROuVMVAU6AIpmDFZ
         gppOaBc8I7EHnx7lPt7AW1VEVH0srkyOF0LVyjv8+wpCVXA5KiQ4qUFpWh+xf30E0PeU
         vV/0UUqR9RGfjL5AfPBZK0jqdFdVZk6rBALZ72NYJiHeSZB+QwbIQd95updF/u1+7oex
         IMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/YTl5Y05aq7UDbYAfUoIvy9c2eHnrqw43JiYTVbNYGI=;
        b=cQnTwFsgFfTX5PDHDM49Kp0FKO4e4fMZ/hOPbeYarKNe3NoZ1narAoBsQHNSsYQ5Ao
         T/FiOQa/aO8feRh+tuAbudXnveTSPudVb+9/Bhqcid7qy7tsJ8mgZuLFGErHYqdWppVT
         VqlIQLr174+9WOJHeO0HEcaCz4sGfEqg7pdpCDow/V0zn1occ/+7z0NrWyQOiebO3yhE
         NiGZpPXZOfoytZPPyaIJvjGUIhT8eK7LMCgtdFbm1zzaaGZBypIblsnYAOwjaFnjSYRY
         TnbE26Sjx3KfXxKXfNmQm9X2K9Qq4yY8CXObzDq6ZjP3yC8Vr7oFtH5+vOgrgLDUZflS
         OzvQ==
X-Gm-Message-State: AOAM533XP0UaUrz2NAGHCofSsW9gz31VAHj54WTmywTF+nytwg30fAKU
        RrV+Cj6UfO8mCwU45n1kl1VIHYr6zEw=
X-Google-Smtp-Source: ABdhPJykBTgvyIjEsO5moU59AhcGyjN78RVonsS/VZ0v1PrxDsVjv70w8As0ZgbLR1exaRaDxAWirQ==
X-Received: by 2002:a6b:7a41:: with SMTP id k1mr5021158iop.92.1597331235071;
        Thu, 13 Aug 2020 08:07:15 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p77sm2943083ill.39.2020.08.13.08.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:07:14 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] task_work: only grab task signal lock when needed
Message-ID: <90d18cac-019e-eb49-8b33-32066d4e24aa@kernel.dk>
Date:   Thu, 13 Aug 2020 09:07:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If JOBCTL_TASK_WORK is already set on the targeted task, then we need
not go through {lock,unlock}_task_sighand() to set it again and queue
a signal wakeup. This is safe as we're checking it _after_ adding the
new task_work with cmpxchg().

The ordering is as follows:

task_work_add()                         get_signal()
--------------------------------------------------------------
STORE(task->task_works, new_work);      STORE(task->jobctl);
mb();                                   mb();
LOAD(task->jobctl);                     LOAD(task->task_works);

This speeds up TWA_SIGNAL handling quite a bit, which is important now
that io_uring is relying on it for all task_work deliveries.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jann Horn <jannh@google.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/kernel/signal.c b/kernel/signal.c
index 6f16f7c5d375..42b67d2cea37 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2541,7 +2541,21 @@ bool get_signal(struct ksignal *ksig)
 
 relock:
 	spin_lock_irq(&sighand->siglock);
-	current->jobctl &= ~JOBCTL_TASK_WORK;
+	/*
+	 * Make sure we can safely read ->jobctl() in task_work add. As Oleg
+	 * states:
+	 *
+	 * It pairs with mb (implied by cmpxchg) before READ_ONCE. So we
+	 * roughly have
+	 *
+	 *	task_work_add:				get_signal:
+	 *	STORE(task->task_works, new_work);	STORE(task->jobctl);
+	 *	mb();					mb();
+	 *	LOAD(task->jobctl);			LOAD(task->task_works);
+	 *
+	 * and we can rely on STORE-MB-LOAD [ in task_work_add].
+	 */
+	smp_store_mb(current->jobctl, current->jobctl & ~JOBCTL_TASK_WORK);
 	if (unlikely(current->task_works)) {
 		spin_unlock_irq(&sighand->siglock);
 		task_work_run();
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 5c0848ca1287..613b2d634af8 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -42,7 +42,13 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
 		set_notify_resume(task);
 		break;
 	case TWA_SIGNAL:
-		if (lock_task_sighand(task, &flags)) {
+		/*
+		 * Only grab the sighand lock if we don't already have some
+		 * task_work pending. This pairs with the smp_store_mb()
+		 * in get_signal(), see comment there.
+		 */
+		if (!(READ_ONCE(task->jobctl) & JOBCTL_TASK_WORK) &&
+		    lock_task_sighand(task, &flags)) {
 			task->jobctl |= JOBCTL_TASK_WORK;
 			signal_wake_up(task, 0);
 			unlock_task_sighand(task, &flags);

-- 
Jens Axboe

