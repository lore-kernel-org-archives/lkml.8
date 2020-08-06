Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A966AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DC120786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPp8gYow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgHFRHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgHFRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9880C06179E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 10:05:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e4so7219025pgv.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H3dGzahstvfIu8LFQ0q2SpynGz08Mul/xIBFXR8P1IE=;
        b=KPp8gYowjhn3T+7qizpLEfCg0waltPeddgh0U5j1xFoAtXpr0bzT/0Eq48eG9u8jI8
         3ocjWmhhmTnTvq00jJR4mTx7UUTquRGMWm62RIx/lTYOuc7TBgsWGRUFUnT2PafnODC8
         UmxTCZ93Nz3rwGT3V+ps5CHqAqUPUueE+3RwuE4xD3NwIdzxJcoeipV/Q6F/ZK43p5Hb
         BQg5PVLcO1VGbG03VIFvoIB+oqUNLRvHQye9onUJjN/0V7A958GDbstFIUOm1CYoAWlF
         OWzzRCIprRmnwcze2nKDSL0KgMhU9ZlwfW9kVChL255YbnBi7Ll1DLzy7ljIZCZ3nyxn
         05tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H3dGzahstvfIu8LFQ0q2SpynGz08Mul/xIBFXR8P1IE=;
        b=OQ7roNT14o810bxjEQ037a+lwruRgjB1vCuHgZbOGsMzOzkBhFc5pzMJYvVvPcokR2
         rbtE7JUREUx1OIjlCoJX42G04zZmd2eNxcGhc/glw9XXkmB7lV5e3DvxsFYZBa25wZF0
         7YXecoA1yZqGTZsF9G3oDzaJqXqynSUMbkyE0MQ63pxEwxqzKhqeWPM9S3f5stbwqLse
         z6CrQ0vTcy8FwOZqwdb6JRF+4uQ1EVwGKCtdgTNdgosOARYNCcTTM3QRoQQWirlFuT8f
         KtPdxj6VD6YEhxC3MeuTgEWwZllhCRgjtaqqVS+2thqgrOlgnZ0K9fwqBNaTXspijwtC
         BpxQ==
X-Gm-Message-State: AOAM532niGs3yG8eS6drTFOvwkFZ/RSAHUzPXPkRIPKdZKNOHsuO6xCM
        WJujF7INF2mijZZkXuaJeea1ujXO
X-Google-Smtp-Source: ABdhPJwE8nAASukMgb+9LvSC30OpQ5i9OVImgRmmoUGIhkFG8zZGO/pwVDIh5D3QrK0T/HJyZqp0wekK
X-Received: by 2002:a65:5349:: with SMTP id w9mr7745181pgr.243.1596733550192;
 Thu, 06 Aug 2020 10:05:50 -0700 (PDT)
Date:   Thu,  6 Aug 2020 10:05:44 -0700
In-Reply-To: <20200806170544.382140-1-posk@google.com>
Message-Id: <20200806170544.382140-2-posk@google.com>
Mime-Version: 1.0
References: <20200806170544.382140-1-posk@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 2/2 v2] rseq/selftests: test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
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

This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU.
The test quite often fails without the previous patch in this patchset,
but consistently passes with it.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 .../selftests/rseq/basic_percpu_ops_test.c    | 181 ++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index eb3f6db36d36..147c80deac19 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -3,16 +3,21 @@
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
 
+#define MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU	(1<<7)
+
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
@@ -289,6 +294,180 @@ void test_percpu_list(void)
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
+	for (i = 0; i < iters; ++i) {
+		while (true) {
+			int cpu, ret;
+			struct percpu_list *list_ptr = (struct percpu_list *)
+				atomic_load(&args->percpu_list_ptr);
+
+			if (!list_ptr)
+				continue;  /* Not yet initialized. */
+
+			cpu = rseq_cpu_start();
+			struct percpu_list_node *node = list_ptr->c[cpu].head;
+			const intptr_t prev = node->data;
+
+			ret = rseq_cmpeqv_cmpeqv_storev(&node->data, prev,
+					&args->percpu_list_ptr,
+					(intptr_t)list_ptr, prev + 1, cpu);
+			if (!ret)
+				break;  /* Success. */
+		}
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
+static int sys_membarrier(int cmd, int flags)
+{
+	return syscall(__NR_membarrier, cmd, flags);
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
+		sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, cpu_a);
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
+		sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, cpu_b);
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
+	struct test_membarrier_thread_args thread_args;
+	pthread_t worker_threads[CPU_SETSIZE];
+	pthread_t manager_thread;
+	int i;
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
+}
+
 int main(int argc, char **argv)
 {
 	if (rseq_register_current_thread()) {
@@ -300,6 +479,8 @@ int main(int argc, char **argv)
 	test_percpu_spinlock();
 	printf("percpu_list\n");
 	test_percpu_list();
+	printf("membarrier\n");
+	test_membarrier();
 	if (rseq_unregister_current_thread()) {
 		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
 			errno, strerror(errno));
-- 
2.28.0.163.g6104cc2f0b6-goog

