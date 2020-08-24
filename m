Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098E3207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259152;
	bh=IF5nfiHipkq+Pu0fcMTYDw8w2uTN6DtQ/0OPb5Wh6Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J4xmVMBqYCRrBhMg82ko/9Lmul/x7svsBdoDH9YYK+dCrqZFw3o2LYbW0ZVuLjYUh
	 OixmRIXwlIQ52B96SShQbxDyYAmpOekScYnTaaj5oW0uiUWLsW8qpBpMpeL6bLF62u
	 6WmDgjB0p2OtlG/hPF8KUpjgZKksm3RCKWQwk99Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgHXIwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbgHXIwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:52:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733582072D;
        Mon, 24 Aug 2020 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259137;
        bh=IF5nfiHipkq+Pu0fcMTYDw8w2uTN6DtQ/0OPb5Wh6Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=viCVitd7x1BshNUotRfHfQYjEKbKGCTWkDuLoYNkHFKw4fNgDfki1kR6Z99Qpvbw1
         HvhEdVKE6Wssuy13sMcbs4A545bW7l/UkRSG6cF5PLLh/8D3etk68xRvPgVnqgqnAR
         H+XXkZL363XgMm4JZNTSpiPEn/ffjATCedJ7cjhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/39] tracing: Clean up the hwlat binding code
Date:   Mon, 24 Aug 2020 10:31:04 +0200
Message-Id: <20200824082348.745810260@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082348.445866152@linuxfoundation.org>
References: <20200824082348.445866152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit f447c196fe7a3a92c6396f7628020cb8d564be15 ]

Instead of initializing the affinity of the hwlat kthread in the thread
itself, simply set up the initial affinity at thread creation. This
simplifies the code.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_hwlat.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 5fe23f0ee7db6..158af5ddbc3aa 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -268,24 +268,13 @@ out:
 static struct cpumask save_cpumask;
 static bool disable_migrate;
 
-static void move_to_next_cpu(bool initmask)
+static void move_to_next_cpu(void)
 {
-	static struct cpumask *current_mask;
+	struct cpumask *current_mask = &save_cpumask;
 	int next_cpu;
 
 	if (disable_migrate)
 		return;
-
-	/* Just pick the first CPU on first iteration */
-	if (initmask) {
-		current_mask = &save_cpumask;
-		get_online_cpus();
-		cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
-		put_online_cpus();
-		next_cpu = cpumask_first(current_mask);
-		goto set_affinity;
-	}
-
 	/*
 	 * If for some reason the user modifies the CPU affinity
 	 * of this thread, than stop migrating for the duration
@@ -302,7 +291,6 @@ static void move_to_next_cpu(bool initmask)
 	if (next_cpu >= nr_cpu_ids)
 		next_cpu = cpumask_first(current_mask);
 
- set_affinity:
 	if (next_cpu >= nr_cpu_ids) /* Shouldn't happen! */
 		goto disable;
 
@@ -332,12 +320,10 @@ static void move_to_next_cpu(bool initmask)
 static int kthread_fn(void *data)
 {
 	u64 interval;
-	bool initmask = true;
 
 	while (!kthread_should_stop()) {
 
-		move_to_next_cpu(initmask);
-		initmask = false;
+		move_to_next_cpu();
 
 		local_irq_disable();
 		get_sample();
@@ -368,13 +354,27 @@ static int kthread_fn(void *data)
  */
 static int start_kthread(struct trace_array *tr)
 {
+	struct cpumask *current_mask = &save_cpumask;
 	struct task_struct *kthread;
+	int next_cpu;
+
+	/* Just pick the first CPU on first iteration */
+	current_mask = &save_cpumask;
+	get_online_cpus();
+	cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
+	put_online_cpus();
+	next_cpu = cpumask_first(current_mask);
 
 	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
 		return -ENOMEM;
 	}
+
+	cpumask_clear(current_mask);
+	cpumask_set_cpu(next_cpu, current_mask);
+	sched_setaffinity(kthread->pid, current_mask);
+
 	hwlat_kthread = kthread;
 	wake_up_process(kthread);
 
-- 
2.25.1



