Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBDEC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFB72074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHVOE/Ke";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4EROLSC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGXIdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgGXIdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19560C0619D3;
        Fri, 24 Jul 2020 01:33:46 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ItdLe78RJmNMD/yQ8OptSY30ouY9oH+mj9NBjC46O3g=;
        b=hHVOE/Kei+nse8yKqqmrCpvdFBBwwGxoqL3YBq4CJ1UGwcFVn9ZugPiQXS9mcJbCT8DpiZ
        QF43ELP+pNncBGTSxAwLRqYWLcyOUfV+kP5P6Ro20X9RRaz50DeDK+2wk6rTdEJLfiHbr9
        isUnWfUQGXIXopk5euXN/9H8KCzpybe7r7vRI4EJ7Qjv4zwXUwZ3vnGHRnXzJy4fMjqnTM
        LmngR5PYYbyASRSW+p2HAKoUV9la2X2RnJa2uS+NzluvQfTVuPj6T+WP0ZlQ7n3xxAhgUH
        Mxf7EktqXp404HiUgTAYQGsUuRy1VSAnOq4H7w3dOdVF3EHxsi8fVGQYnZVKuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ItdLe78RJmNMD/yQ8OptSY30ouY9oH+mj9NBjC46O3g=;
        b=4EROLSC6YDQRM1XacwyY6dKhIxqNyFNnM7kmCYThwAIPNzwc0xog5HxlGMoNdxoDOuGnZ7
        Hj4ckJOyjo8WmeBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,powerclamp: Convert to sched_set_fifo()
Cc:     rafael.j.wysocki@intel.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962396.4006.15991666303480448525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     a2bee0662f72fcbd248a424a1453dd946dcdaf3d
Gitweb:        https://git.kernel.org/tip/a2bee0662f72fcbd248a424a1453dd946dcdaf3d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:23 +02:00

sched,powerclamp: Convert to sched_set_fifo()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: rafael.j.wysocki@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index f74b247..b0eb5ec 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -70,9 +70,6 @@ static unsigned int control_cpu; /* The cpu assigned to collect stat and update
 				  */
 static bool clamping;
 
-static const struct sched_param sparam = {
-	.sched_priority = MAX_USER_RT_PRIO / 2,
-};
 struct powerclamp_worker_data {
 	struct kthread_worker *worker;
 	struct kthread_work balancing_work;
@@ -488,7 +485,7 @@ static void start_power_clamp_worker(unsigned long cpu)
 	w_data->cpu = cpu;
 	w_data->clamping = true;
 	set_bit(cpu, cpu_clamping_mask);
-	sched_setscheduler(worker->task, SCHED_FIFO, &sparam);
+	sched_set_fifo(worker->task);
 	kthread_init_work(&w_data->balancing_work, clamp_balancing_func);
 	kthread_init_delayed_work(&w_data->idle_injection_work,
 				  clamp_idle_injection_func);
