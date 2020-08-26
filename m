Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F25EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF2E207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JQsYqt9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZXCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgHZXCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 19:02:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 16:02:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q2so3468123ybo.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=et/UFlijeTnkcTF5HsUJkethOI/YyNciPaOhWERts3k=;
        b=JQsYqt9Ajd+S4Vp/KUVFvquxdDQwUN29GR+/2HKG4eXLM7zawsF+AqFpmNqduQfDnj
         w6J390LvTsA9T3wonPJjRuI60UECK7Ny9992Z+j+3/m9kNEbAfqFnCZuuh5ywE+tB0Uv
         jaWAtBrwQDKrSGZZPsR7UAMkdsQ6vaVN+31gSCYxzB91BqMf0Jc4WoWtcWHI+EwUW0e1
         YjiRe9Ig5J4oW/5rtLjByRUMrjCgZn5omJ2dvGOpLxFAdmvOaDsaZEwZ8X5mRbwpr65U
         mtPELl9nNa0fTVzUpvxBXOuYyL+stUcJEuhUqiXPd89mYE2h9/qXlabtzLfmOpMwnhzB
         co2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=et/UFlijeTnkcTF5HsUJkethOI/YyNciPaOhWERts3k=;
        b=U6iukcquXrKScV0rL8zYzzp1ZpO1Qb17uH5EcC94l8I8TeyMzag/48n0YnVBE+uG/5
         SVDWc4ZOqKC43ckO0oobUbOcrkSfdnfJMU0Q7+hkSRmH02q3UhikwvSDFiKiSEp13gTo
         QQzb7Y72sBRpWZI3zRuh5TI3/r7URLL2XFtbP7Nsl2c+/j66k12hE186YQnzS+82a07l
         ZEFRLtG/HW1HJxvA9BaGIczCJ9uVKXFCBg6Jb2AKULRXESpWaQA4RCbCtcC/oCtkQypu
         ov/pLtj6U5JRm4HGjGzXKdgTxNDvlfpdvbvgxom1KXBIAIsVDZ03daWMue1AdFxMRy0W
         ce/A==
X-Gm-Message-State: AOAM533nFfsw6X0AGAQ4135YLi63uKHKk4+wCeIZLmFQBLxobs/ixn4A
        avntqWA9uRhNvCJwUAqeO3MQedlA
X-Google-Smtp-Source: ABdhPJx+X02kS6CBPboVPGFsX7V73Sm/jA+y4U1gqelJ5oJJ1xuvCo6qbrt0aU1/4AkSVUr6gabUgjAC
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe09:7598])
 (user=posk job=sendgmr) by 2002:a25:5556:: with SMTP id j83mr26924448ybb.385.1598482951918;
 Wed, 26 Aug 2020 16:02:31 -0700 (PDT)
Date:   Wed, 26 Aug 2020 16:02:25 -0700
In-Reply-To: <20200826230225.3782486-1-posk@google.com>
Message-Id: <20200826230225.3782486-2-posk@google.com>
Mime-Version: 1.0
References: <20200826230225.3782486-1-posk@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 2/2 v5] rseq/selftests: test MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
From:   Peter Oskolkov <posk@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on Google-internal RSEQ work done by
Paul Turner and Andrew Hunter.

This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
The test quite often fails without the previous patch in this patchset,
but consistently passes with it.

v3: added rseq_offset_deref_addv() to x86_64 to make the test
    more explicit; on other architectures I kept using existing
    rseq_cmpeqv_cmpeqv_storev() as I have no easy way to test
    there.  Added a comment explaining why the test works this way.
v4: skipped the test if rseq_offset_deref_addv() is not present
    (that is, on all architectures other than x86_64).

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 .../selftests/rseq/basic_percpu_ops_test.c    | 187 ++++++++++++++++++
 tools/testing/selftests/rseq/rseq-x86.h       |  57 ++++++
 2 files changed, 244 insertions(+)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index eb3f6db36d36..e6e10ba4b9ed 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -3,16 +3,24 @@
 #include <assert.h>
 #include <pthread.h>
 #include <sched.h>
+#include <stdatomic.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stddef.h>
+#include <syscall.h>
+#include <unistd.h>
 
 #include "rseq.h"
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
+/* The local <linux/membarrier.h> may not contain the commands below. */
+#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ	(1<<7)
+#define MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ	(1<<8)
+#define MEMBARRIER_CMD_FLAG_CPU		(1<<0)
+
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
@@ -289,6 +297,183 @@ void test_percpu_list(void)
 	assert(sum == expected_sum);
 }
 
+struct test_membarrier_thread_args {
+	int stop;
+	intptr_t percpu_list_ptr;
+};
+
+/* Worker threads modify data in their "active" percpu lists. */
+void *test_membarrier_worker_thread(void *arg)
+{
+	struct test_membarrier_thread_args *args =
+		(struct test_membarrier_thread_args *)arg;
+	const int iters = 10 * 1000 * 1000;
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	/* Wait for initialization. */
+	while (!atomic_load(&args->percpu_list_ptr)) {}
+
+	for (i = 0; i < iters; ++i) {
+		int ret;
+
+		do {
+			int cpu = rseq_cpu_start();
+
+			ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
+							128 * cpu, 1, cpu);
+		} while (rseq_unlikely(ret));
+	}
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+void test_membarrier_init_percpu_list(struct percpu_list *list)
+{
+	int i;
+
+	memset(list, 0, sizeof(*list));
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_list_node *node;
+
+		node = malloc(sizeof(*node));
+		assert(node);
+		node->data = 0;
+		node->next = NULL;
+		list->c[i].head = node;
+	}
+}
+
+void test_membarrier_free_percpu_list(struct percpu_list *list)
+{
+	int i;
+
+	for (i = 0; i < CPU_SETSIZE; i++)
+		free(list->c[i].head);
+}
+
+static int sys_membarrier(int cmd, int flags, int cpu_id)
+{
+	return syscall(__NR_membarrier, cmd, flags, cpu_id);
+}
+
+/*
+ * The manager thread swaps per-cpu lists that worker threads see,
+ * and validates that there are no unexpected modifications.
+ */
+void *test_membarrier_manager_thread(void *arg)
+{
+	struct test_membarrier_thread_args *args =
+		(struct test_membarrier_thread_args *)arg;
+	struct percpu_list list_a, list_b;
+	intptr_t expect_a = 0, expect_b = 0;
+	int cpu_a = 0, cpu_b = 0;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	/* Init lists. */
+	test_membarrier_init_percpu_list(&list_a);
+	test_membarrier_init_percpu_list(&list_b);
+
+	atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
+
+	while (!atomic_load(&args->stop)) {
+		/* list_a is "active". */
+		cpu_a = rand() % CPU_SETSIZE;
+		/*
+		 * As list_b is "inactive", we should never see changes
+		 * to list_b.
+		 */
+		if (expect_b != atomic_load(&list_b.c[cpu_b].head->data)) {
+			fprintf(stderr, "Membarrier test failed\n");
+			abort();
+		}
+
+		/* Make list_b "active". */
+		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
+		sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			       MEMBARRIER_CMD_FLAG_CPU, cpu_a);
+		/*
+		 * Cpu A should now only modify list_b, so we values
+		 * in list_a should be stable.
+		 */
+		expect_a = atomic_load(&list_a.c[cpu_a].head->data);
+
+		cpu_b = rand() % CPU_SETSIZE;
+		/*
+		 * As list_a is "inactive", we should never see changes
+		 * to list_a.
+		 */
+		if (expect_a != atomic_load(&list_a.c[cpu_a].head->data)) {
+			fprintf(stderr, "Membarrier test failed\n");
+			abort();
+		}
+
+		/* Make list_a "active". */
+		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
+		sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			       MEMBARRIER_CMD_FLAG_CPU, cpu_b);
+		/* Remember a value from list_b. */
+		expect_b = atomic_load(&list_b.c[cpu_b].head->data);
+	}
+
+	test_membarrier_free_percpu_list(&list_a);
+	test_membarrier_free_percpu_list(&list_b);
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
+void test_membarrier(void)
+{
+#ifndef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+	fprintf(stderr, "rseq_offset_deref_addv is not implemented on this architecture. "
+			"Skipping membarrier test.\n");
+	return;
+#else
+	struct test_membarrier_thread_args thread_args;
+	pthread_t worker_threads[CPU_SETSIZE];
+	pthread_t manager_thread;
+	int i;
+
+	sys_membarrier(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ, 0, 0);
+
+	thread_args.stop = 0;
+	thread_args.percpu_list_ptr = 0;
+	pthread_create(&manager_thread, NULL,
+		       test_membarrier_manager_thread, &thread_args);
+
+	for (i = 0; i < CPU_SETSIZE; i++)
+		pthread_create(&worker_threads[i], NULL,
+		       test_membarrier_worker_thread, &thread_args);
+
+	for (i = 0; i < CPU_SETSIZE; i++)
+		pthread_join(worker_threads[i], NULL);
+
+	atomic_store(&thread_args.stop, 1);
+	pthread_join(manager_thread, NULL);
+#endif
+}
+
 int main(int argc, char **argv)
 {
 	if (rseq_register_current_thread()) {
@@ -300,6 +485,8 @@ int main(int argc, char **argv)
 	test_percpu_spinlock();
 	printf("percpu_list\n");
 	test_percpu_list();
+	printf("membarrier\n");
+	test_membarrier();
 	if (rseq_unregister_current_thread()) {
 		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
 			errno, strerror(errno));
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index b2da6004fe30..640411518e46 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -279,6 +279,63 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 #endif
 }
 
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __attribute__((always_inline))
+int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+#endif
+		/* get p+v */
+		"movq %[ptr], %%rbx\n\t"
+		"addq %[off], %%rbx\n\t"
+		/* get pv */
+		"movq (%%rbx), %%rcx\n\t"
+		/* *pv += inc */
+		"addq %[inc], (%%rcx)\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_abi]		"r" (&__rseq_abi),
+		  /* final store input */
+		  [ptr]			"m" (*ptr),
+		  [off]			"er" (off),
+		  [inc]			"er" (inc)
+		: "memory", "cc", "rax", "rbx", "rcx"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 				 intptr_t *v2, intptr_t newv2,
-- 
2.28.0.297.g1956fa8f8d-goog

