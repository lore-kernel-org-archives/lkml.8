Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D2C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FEA2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgDXN6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:58:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgDXN6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:58:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63408C14;
        Fri, 24 Apr 2020 06:58:14 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6389A3F68F;
        Fri, 24 Apr 2020 06:58:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] firmware/psci: Make PSCI checker not bother with parking
Date:   Fri, 24 Apr 2020 14:56:56 +0100
Message-Id: <20200424135657.32519-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200424135657.32519-1-valentin.schneider@arm.com>
References: <20200424135657.32519-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kthread_stop() unconditionally calls kthread_unpark(). For kthreads
with KTHREAD_IS_PER_CPU, this leads to waiting for
wait_task_inactive(TASK_PARKED) before re-binding them. This is required
mainly for smpboot threads, as they are parked before their respective CPU
comes online which causes their affinity mask to be reset.

For users of kthread_create_on_cpu(), this means they must park their
threads before stopping them, which is a bit silly. While we could change
kthread_unpark() to only do the rebind if it is required, using
kthread_create_on_cpu() for anything else than smpboot threads is risky:
they won't get parked/unparked during a hotplug cycle, so their affinity
will just be reset as soon as their respective CPU goes out.

The PSCI checker only lives during initcalls and explicitly points out
that it cannot exist concurrently with hotplug operations, so let's just
make it use kthread_create_on_node() + kthread_bind() (similar to what
e.g. RCU torture does).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/firmware/psci/psci_checker.c | 32 +++++++++++-----------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index a5279a430274..fa7bb1e8a461 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -347,19 +347,12 @@ static int suspend_test_thread(void *arg)
 	if (atomic_dec_return_relaxed(&nb_active_threads) == 0)
 		complete(&suspend_threads_done);
 
-	for (;;) {
-		/* Needs to be set first to avoid missing a wakeup. */
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (kthread_should_park())
-			break;
-		schedule();
-	}
+	while (!kthread_should_stop())
+		schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
 
 	pr_info("CPU %d suspend test results: success %d, shallow states %d, errors %d\n",
 		cpu, nb_suspend, nb_shallow_sleep, nb_err);
 
-	kthread_parkme();
-
 	return nb_err;
 }
 
@@ -395,13 +388,15 @@ static int suspend_tests(void)
 			continue;
 		}
 
-		thread = kthread_create_on_cpu(suspend_test_thread,
-					       (void *)(long)cpu, cpu,
-					       "psci_suspend_test");
-		if (IS_ERR(thread))
+		thread = kthread_create_on_node(suspend_test_thread,
+						(void *)(long)cpu, cpu_to_node(cpu),
+						"psci_suspend_test/%d", cpu);
+		if (IS_ERR(thread)) {
 			pr_err("Failed to create kthread on CPU %d\n", cpu);
-		else
+		} else {
 			threads[nb_threads++] = thread;
+			kthread_bind(thread, cpu);
+		}
 	}
 
 	if (nb_threads < 1) {
@@ -418,17 +413,14 @@ static int suspend_tests(void)
 	 */
 	for (i = 0; i < nb_threads; ++i)
 		wake_up_process(threads[i]);
-	complete_all(&suspend_threads_started);
 
+	complete_all(&suspend_threads_started);
 	wait_for_completion(&suspend_threads_done);
 
-
 	/* Stop and destroy all threads, get return status. */
-	for (i = 0; i < nb_threads; ++i) {
-		err += kthread_park(threads[i]);
+	for (i = 0; i < nb_threads; ++i)
 		err += kthread_stop(threads[i]);
-	}
- out:
+out:
 	cpuidle_resume_and_unlock();
 	kfree(threads);
 	return err;
-- 
2.24.0

