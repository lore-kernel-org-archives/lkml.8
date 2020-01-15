Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB905C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42C42081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IxGdPI5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgAOWmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:42:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35007 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbgAOWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:42:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so8886548pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+991qKRW7+Cp2nAUlxdIP+8FrY+lRzQcWUE4ll7SL8=;
        b=IxGdPI5GNHi5DWG2+XA4G5yeyqkMwAe7HpBRiRYZWnViPpvq3c2nd05Vux6xaQKywV
         ZDf5mmnu2IJY1XFKdDW+5im4J+0TtWs5B5vNXYLu618fPYGHtYQn4aTex3nb0S6Acwnd
         fXPc695OPMhrtvhd2SEU1cWWXgo0ugiD+GXlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+991qKRW7+Cp2nAUlxdIP+8FrY+lRzQcWUE4ll7SL8=;
        b=c8nWdYLXMLrmV49jxBWolFGJ/w2w2SxfGdRSyo56VRqYDIXTioyL/CDx0R5dDUgNi4
         6+fXXIKSW/S0KcZzAndGZgYhaISmxLdbKUpiiOsM/diVQ/btcyeeG30FAxp+kLJwID0Z
         4EVXAZs8W6f8a1Nxf42TxFBPbb1JVZKPzVzdaleVz9jNJvkaC5ckc8XcWjSaLggxhqa1
         puxsyyoD5eX4yxj6Qnle9EvXFVneUJs+kAoBQZYhsWLc4FsN/Ti6PGZ34Q2OMTIBpwI7
         4jMs6dWQ+DY58sKna4u0itqFc7l/QbB2rY8eVgnaKWUkjHl/8Ob/m9WjLhwpBwTDxtIn
         kjKQ==
X-Gm-Message-State: APjAAAVN6iCkvJT1cihV1DgYO65rsXqibvfB3BLgJ83CAoZDqiOAOFyJ
        jS6Mdae861LV+Ff7oyGwRnn9/WTC4UE=
X-Google-Smtp-Source: APXvYqwSUk+CRzkBzqO71Y2+REyY8+FnGlawUMJKvsukdUgpudEny2HFw1Uh/xDaMZi4B+goHlT9TQ==
X-Received: by 2002:a63:303:: with SMTP id 3mr35707495pgd.372.1579128155759;
        Wed, 15 Jan 2020 14:42:35 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e1sm23186209pfl.98.2020.01.15.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:42:35 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [PATCH 2/2] rcuperf: Measure memory footprint during kfree_rcu() test (v4)
Date:   Wed, 15 Jan 2020 17:42:25 -0500
Message-Id: <20200115224225.246061-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200115224225.246061-1-joel@joelfernandes.org>
References: <20200115224225.246061-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During changes to kfree_rcu() code, we often check the amount of free
memory.  As an alternative to checking this manually, this commit adds a
measurement in the test itself.  It measures four times during the test
for available memory, digitally filters these measurements to produce a
running average with a weight of 0.5, and compares this digitally
filtered value with the amount of available memory at the beginning of
the test.

We apply the digital filter only once we are more than 25% into the
test. At the 25% mark, we just read available memory and don't apply any
filtering. This prevents the first sample from skewing the results
as we would not consider memory readings that were before memory was
allocated.

A sample run shows something like:

Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
v1->v2: Minor corrections
v1->v3: Use long long to prevent 32-bit system's overflow
	Handle case where some threads start later than others.
	Start measuring only once 25% into the test. Slightly more accurate.
v3->v4: Simplified test more. Using simple average.

 kernel/rcu/rcuperf.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 1fd0cc72022e..c41f009acbbb 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/err.h>
@@ -616,14 +617,17 @@ DEFINE_KFREE_OBJ(32); // goes on kmalloc-64 slab
 DEFINE_KFREE_OBJ(64); // goes on kmalloc-96 slab
 DEFINE_KFREE_OBJ(96); // goes on kmalloc-128 slab
 
+long long mem_begin;
+
 static int
 kfree_perf_thread(void *arg)
 {
 	int i, loop = 0;
 	long me = (long)arg;
 	void *alloc_ptr;
-
 	u64 start_time, end_time;
+	long mem_samples = 0;
+	long long mem_during = 0;
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
@@ -638,7 +642,17 @@ kfree_perf_thread(void *arg)
 			b_rcu_gp_test_started = cur_ops->get_gp_seq();
 	}
 
+	// Prevent "% 0" error below.
+	if (kfree_loops < 4)
+		kfree_loops = 4;
+
 	do {
+		// Start measuring only from when we are at least 25% into the test.
+		if ((loop != 0) && (loop % (kfree_loops / 4) == 0)) {
+			mem_during = mem_during + si_mem_available();
+			mem_samples++;
+		}
+
 		for (i = 0; i < kfree_alloc_num; i++) {
 			int kfree_type = i % 4;
 
@@ -671,6 +685,8 @@ kfree_perf_thread(void *arg)
 		cond_resched();
 	} while (!torture_must_stop() && ++loop < kfree_loops);
 
+	mem_during = (mem_during / mem_samples);
+
 	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
 		end_time = ktime_get_mono_fast_ns();
 
@@ -679,9 +695,13 @@ kfree_perf_thread(void *arg)
 		else
 			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
 
-		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
+		// The "memory footprint" field represents how much in-flight
+		// memory is allocated during the test and waiting to be freed.
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
 		       (unsigned long long)(end_time - start_time), kfree_loops,
-		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
+		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
+		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
+
 		if (shutdown) {
 			smp_mb(); /* Assign before wake. */
 			wake_up(&shutdown_wq);
@@ -753,6 +773,8 @@ kfree_perf_init(void)
 		goto unwind;
 	}
 
+	mem_begin = si_mem_available();
+
 	for (i = 0; i < kfree_nrealthreads; i++) {
 		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
 						  kfree_reader_tasks[i]);
-- 
2.25.0.rc1.283.g88dfdc4193-goog
