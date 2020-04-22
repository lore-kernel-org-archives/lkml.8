Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF2C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422C22084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bGb7bWj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDVLa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728072AbgDVLaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:30:24 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33556C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9B5Wbnq6rCPK+M1cbgaMO7Im/waoMKu33EAwcoj+MK0=; b=bGb7bWj9h9ufPkqP+WynA7+1DL
        bIFgFneW0iR08OGSKGurfb3heslztxCWUaK/s1eGIWHI30fxuIRRiVPk25REzyJ8lEFCnrFsEQ05j
        HFsYmK4zIie6JhF2n6sQfleeuAPmw3ADYzzjHEJXvzmWaZps+HsfFd8JnCGhtab09rJmIDYFB+SbJ
        j2EGl/edn8UjT63lQpuT5RPr1/zoO9Ljr3ANIljvklFB5h0zipfofmtEg6q5wXPj8BOJT79DaRDjq
        L8yYUs0O7Hl27hYz8Iuj4ziliCB+qZCUAYhee01WwxN7OdxPbqWAWsliix/QnmqapyY+uG/8mPUH9
        HW0hO7OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006rH-I1; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AE20307773;
        Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B4D64202801A5; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.266499893@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, airlied@redhat.com,
        alexander.deucher@amd.com, awalls@md.metrocast.net,
        axboe@kernel.dk, broonie@kernel.org, daniel.lezcano@linaro.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        herbert@gondor.apana.org.au, hverkuil@xs4all.nl,
        john.stultz@linaro.org, nico@fluxnic.net, paulmck@kernel.org,
        rafael.j.wysocki@intel.com, rmk+kernel@arm.linux.org.uk,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        wim@linux-watchdog.org
Subject: [PATCH 01/23] sched: Provide sched_set_fifo()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/sched.h |    3 +++
 kernel/sched/core.c   |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1631,6 +1631,9 @@ extern int idle_cpu(int cpu);
 extern int available_idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
+extern int sched_set_fifo(struct task_struct *p);
+extern int sched_set_fifo_low(struct task_struct *p);
+extern int sched_set_normal(struct task_struct *p, int nice);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5055,6 +5055,8 @@ static int _sched_setscheduler(struct ta
  * @policy: new policy.
  * @param: structure containing the new RT priority.
  *
+ * Use sched_set_fifo(), read its comment.
+ *
  * Return: 0 on success. An error code otherwise.
  *
  * NOTE that the task may be already dead.
@@ -5097,6 +5099,51 @@ int sched_setscheduler_nocheck(struct ta
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


