Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CEAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7695E2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mmcFQ9FR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Emajyw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGXIeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36554 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgGXIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:55 -0400
Date:   Fri, 24 Jul 2020 08:33:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+dDWHFLZ4l0hThSLsBWw2QW24eiRiI8ZTUtsnOR1CPg=;
        b=mmcFQ9FRmzSmjvjTcZJdfIOcx+B3lmTsfKyGUF/Pv2nhN+Z8sC4mFp+ESYqIAjqLL7qM4h
        smUAUGNdCbC8PkxkBmiFyebTqXNLwv/zQShBu/xz1zliLjj436NVv1KLUV3WIkckeemXYc
        31W5vcHg7ge5ruEf+k+M8tfz9aLZa/FvXH2ZfcY9Og/BhPrX10t4EAADmmFKkeWan0vjI1
        3ai/t3Ke7noIzLDHJ+L0NlV6vmPz+V2kSyhN4iR+bnXPHLyYUBRWiaxvvl1T/vc22vOalg
        1BJ0T7ZP6LO4soxszr7X0yqNBQ0tO3N+UwdgeWiApzbFR+tIRTZ8yefmU7Ujng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+dDWHFLZ4l0hThSLsBWw2QW24eiRiI8ZTUtsnOR1CPg=;
        b=1Emajyw3/5FJ1uN1AxpJcnuFdE0ySFnTE/Tu54SnTSLom7sni2PTCxGIVp6Z/wpjnbJGfD
        +dCduf6+9ltHfNDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched: Provide sched_set_fifo()
Cc:     airlied@redhat.com, alexander.deucher@amd.com,
        awalls@md.metrocast.net, axboe@kernel.dk, broonie@kernel.org,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        hannes@cmpxchg.org, herbert@gondor.apana.org.au,
        hverkuil@xs4all.nl, john.stultz@linaro.org, nico@fluxnic.net,
        paulmck@kernel.org, rafael.j.wysocki@intel.com,
        rmk+kernel@arm.linux.org.uk, sudeep.holla@arm.com,
        tglx@linutronix.de, ulf.hansson@linaro.org, wim@linux-watchdog.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557963214.4006.16818994245868035978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     7318d4cc14c8c8a5dde2b0b72ea50fd2545f0b7a
Gitweb:        https://git.kernel.org/tip/7318d4cc14c8c8a5dde2b0b72ea50fd2545f0b7a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:20 +02:00

sched: Provide sched_set_fifo()

SCHED_FIFO (or any static priority scheduler) is a broken scheduler
model; it is fundamentally incapable of resource management, the one
thing an OS is actually supposed to do.

It is impossible to compose static priority workloads. One cannot take
two well designed and functional static priority workloads and mash
them together and still expect them to work.

Therefore it doesn't make sense to expose the priority field; the
kernel is fundamentally incapable of setting a sensible value, it
needs systems knowledge that it doesn't have.

Take away sched_setschedule() / sched_setattr() from modules and
replace them with:

  - sched_set_fifo(p); create a FIFO task (at prio 50)
  - sched_set_fifo_low(p); create a task higher than NORMAL,
	which ends up being a FIFO task at prio 1.
  - sched_set_normal(p, nice); (re)set the task to normal

This stops the proliferation of randomly chosen, and irrelevant, FIFO
priorities that dont't really mean anything anyway.

The system administrator/integrator, whoever has insight into the
actual system design and requirements (userspace) can set-up
appropriate priorities if and when needed.

Cc: airlied@redhat.com
Cc: alexander.deucher@amd.com
Cc: awalls@md.metrocast.net
Cc: axboe@kernel.dk
Cc: broonie@kernel.org
Cc: daniel.lezcano@linaro.org
Cc: gregkh@linuxfoundation.org
Cc: hannes@cmpxchg.org
Cc: herbert@gondor.apana.org.au
Cc: hverkuil@xs4all.nl
Cc: john.stultz@linaro.org
Cc: nico@fluxnic.net
Cc: paulmck@kernel.org
Cc: rafael.j.wysocki@intel.com
Cc: rmk+kernel@arm.linux.org.uk
Cc: sudeep.holla@arm.com
Cc: tglx@linutronix.de
Cc: ulf.hansson@linaro.org
Cc: wim@linux-watchdog.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/sched.h |  3 +++-
 kernel/sched/core.c   | 47 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aa..b792b8f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1653,6 +1653,9 @@ extern int idle_cpu(int cpu);
 extern int available_idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
+extern int sched_set_fifo(struct task_struct *p);
+extern int sched_set_fifo_low(struct task_struct *p);
+extern int sched_set_normal(struct task_struct *p, int nice);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0208b71..40d3939 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5124,6 +5124,8 @@ static int _sched_setscheduler(struct task_struct *p, int policy,
  * @policy: new policy.
  * @param: structure containing the new RT priority.
  *
+ * Use sched_set_fifo(), read its comment.
+ *
  * Return: 0 on success. An error code otherwise.
  *
  * NOTE that the task may be already dead.
@@ -5166,6 +5168,51 @@ int sched_setscheduler_nocheck(struct task_struct *p, int policy,
 }
 EXPORT_SYMBOL_GPL(sched_setscheduler_nocheck);
 
+/*
+ * SCHED_FIFO is a broken scheduler model; that is, it is fundamentally
+ * incapable of resource management, which is the one thing an OS really should
+ * be doing.
+ *
+ * This is of course the reason it is limited to privileged users only.
+ *
+ * Worse still; it is fundamentally impossible to compose static priority
+ * workloads. You cannot take two correctly working static prio workloads
+ * and smash them together and still expect them to work.
+ *
+ * For this reason 'all' FIFO tasks the kernel creates are basically at:
+ *
+ *   MAX_RT_PRIO / 2
+ *
+ * The administrator _MUST_ configure the system, the kernel simply doesn't
+ * know enough information to make a sensible choice.
+ */
+int sched_set_fifo(struct task_struct *p)
+{
+	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 };
+	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
+}
+EXPORT_SYMBOL_GPL(sched_set_fifo);
+
+/*
+ * For when you don't much care about FIFO, but want to be above SCHED_NORMAL.
+ */
+int sched_set_fifo_low(struct task_struct *p)
+{
+	struct sched_param sp = { .sched_priority = 1 };
+	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
+}
+EXPORT_SYMBOL_GPL(sched_set_fifo_low);
+
+int sched_set_normal(struct task_struct *p, int nice)
+{
+	struct sched_attr attr = {
+		.sched_policy = SCHED_NORMAL,
+		.sched_nice = nice,
+	};
+	return sched_setattr_nocheck(p, &attr);
+}
+EXPORT_SYMBOL_GPL(sched_set_normal);
+
 static int
 do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
