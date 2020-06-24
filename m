Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A639C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F2E20823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="QYlpPesP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406182AbgFXSxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406133AbgFXSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:53:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE9C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:53:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so514728plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYqVZJBHTf88KT57Y1RFK0U5MEy7rji47z/yWhBE4x8=;
        b=QYlpPesPnFxYnyNaFLfKnfiIlkqU78d5bVK1dxA34I40KpR2UXQ+GokI424ea9Me88
         0ibRtsvzjve1SKFevhuWL+cxgpZbyVQuaHkQD5OC5ew29A+bEphY72kF+dABpfLOcQL2
         75fmHmVkvcPqsx54gyXa9X5Cs3sWRt7XzZ2hL0AZL2GZF4dx9QJeK2RMVmyxHTlcchfr
         UW75Nwd8zy0y6rVO9qtFfYKuQRObIKHET6k79AypfJNqoKc5zSKEbJq6law5KeYt2E/7
         XF5lZqL/z704g4Bh0tgeYkxEgHuahmqRySUAOJkiwmGZwe09174Y5qXRkoskQNnSasMa
         P3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYqVZJBHTf88KT57Y1RFK0U5MEy7rji47z/yWhBE4x8=;
        b=nV+BlBCTfoP6m4xQV63K/LSLWmrbtDdgYkxrWO7v3Np1Sd4qdjDuFCBbdkQsgXdxAN
         v8ZcqXgWKlGlspgS1uGFqQMhO7Tq5N7VD0FEU3E6bVo5Y0IF0thAqXce9wO0bYD6AUWA
         lSXake22YPT4RHgxm0zaTYCUTrFwv36jTSpAuzBZeEddcmHMgLMRCf+l32jVQQ2EgEtp
         nNbosErgaHrIU8rLC/8N7qnc3ijqT/dTaqFpv3lzjAEjayXEfn6ykeUCpLxqKbwXSmsg
         z/hpkwdQ06PuUVrnJKrCwTCSApk94Ahmsr0GmAhwETMOavgD21K54Oimkahc+YiWfzLP
         9uMQ==
X-Gm-Message-State: AOAM530Y9h/bHf5vHnyI6EPvTMASpvRXys3XUKNudUa88IrBHFj22DGR
        uZLkF3IA5Y/37YgN7fxS2o808hfzWTlr4hlV
X-Google-Smtp-Source: ABdhPJztNThteTpietWAcl+7/lGSU5BopkBSOrnxJdBG752/xcMwHPBRCVLYEnOOEpFqxHjh7lO2IQ==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr16089689plo.191.1593024796355;
        Wed, 24 Jun 2020 11:53:16 -0700 (PDT)
Received: from posk-x1c.lan (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id q10sm22295815pfk.86.2020.06.24.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:53:15 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>
Subject: [RFC PATCH 3/3] selftests/futex: add futex_swap selftest
Date:   Wed, 24 Jun 2020 11:52:47 -0700
Message-Id: <20200624185247.13269-4-posk@posk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624185247.13269-1-posk@posk.io>
References: <20200624185247.13269-1-posk@posk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

This is the final RFC patch in FUTEX_SWAP patchset. It
adds a test/benchmark to validate behavior and
compare performance of a new FUTEX_SWAP futex operation.

Detailed API design and behavior considerations are provided
in the commit messages of the previous two patches.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   1 +
 .../selftests/futex/functional/futex_swap.c   | 209 ++++++++++++++++++
 .../selftests/futex/include/futextest.h       |  19 ++
 4 files changed, 230 insertions(+)
 create mode 100644 tools/testing/selftests/futex/functional/futex_swap.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 0efcd494daab..d661ef0946cc 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -2,6 +2,7 @@
 futex_requeue_pi
 futex_requeue_pi_mismatched_ops
 futex_requeue_pi_signal_restart
+futex_swap
 futex_wait_private_mapped_file
 futex_wait_timeout
 futex_wait_uninitialized_heap
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 23207829ec75..6992fac38b15 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_FILES := \
 	futex_requeue_pi \
 	futex_requeue_pi_signal_restart \
 	futex_requeue_pi_mismatched_ops \
+	futex_swap \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file
 
diff --git a/tools/testing/selftests/futex/functional/futex_swap.c b/tools/testing/selftests/futex/functional/futex_swap.c
new file mode 100644
index 000000000000..9034d04372d3
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_swap.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <errno.h>
+#include <getopt.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include "atomic.h"
+#include "futextest.h"
+
+/* The futex the main thread waits on. */
+futex_t futex_main = FUTEX_INITIALIZER;
+/* The futex the other thread wats on. */
+futex_t futex_other = FUTEX_INITIALIZER;
+
+/* The number of iterations to run (>1 => run benchmarks. */
+static int cfg_iterations = 1;
+
+/* If != 0, print diagnostic messages. */
+static int cfg_verbose;
+
+/* If == 0, do not use validation_counter. Useful for benchmarking. */
+static int cfg_validate = 1;
+
+/* How to swap threads. */
+#define SWAP_WAKE_WAIT 1
+#define SWAP_SWAP 2
+
+/* Futex values. */
+#define FUTEX_WAITING 0
+#define FUTEX_WAKEUP 1
+
+/* An atomic counter used to validate proper swapping. */
+static atomic_t validation_counter;
+
+void futex_swap_op(int mode, futex_t *futex_this, futex_t *futex_that)
+{
+	int ret;
+
+	switch (mode) {
+	case SWAP_WAKE_WAIT:
+		futex_set(futex_this, FUTEX_WAITING);
+		futex_set(futex_that, FUTEX_WAKEUP);
+		futex_wake(futex_that, 1, FUTEX_PRIVATE_FLAG);
+		futex_wait(futex_this, FUTEX_WAITING, NULL, FUTEX_PRIVATE_FLAG);
+		if (*futex_this != FUTEX_WAKEUP) {
+			fprintf(stderr, "unexpected futex_this value on wakeup\n");
+			exit(1);
+		}
+		break;
+
+	case SWAP_SWAP:
+		futex_set(futex_this, FUTEX_WAITING);
+		futex_set(futex_that, FUTEX_WAKEUP);
+		ret = futex_swap(futex_this, FUTEX_WAITING, NULL,
+				 futex_that, FUTEX_PRIVATE_FLAG);
+		if (ret < 0 && errno == ENOSYS) {
+			/* futex_swap not implemented */
+			perror("futex_swap");
+			exit(1);
+		}
+		if (*futex_this != FUTEX_WAKEUP) {
+			fprintf(stderr, "unexpected futex_this value on wakeup\n");
+			exit(1);
+		}
+		break;
+
+	default:
+		fprintf(stderr, "unknown mode in %s\n", __func__);
+		exit(1);
+	}
+}
+
+void *other_thread(void *arg)
+{
+	int mode = *((int *)arg);
+	int counter;
+
+	if (cfg_verbose)
+		printf("%s started\n", __func__);
+
+	futex_wait(&futex_other, 0, NULL, FUTEX_PRIVATE_FLAG);
+
+	for (counter = 0; counter < cfg_iterations; ++counter) {
+		if (cfg_validate) {
+			int prev = 2 * counter + 1;
+
+			if (prev != atomic_cmpxchg(&validation_counter, prev,
+						   prev + 1)) {
+				fprintf(stderr, "swap validation failed\n");
+				exit(1);
+			}
+		}
+		futex_swap_op(mode, &futex_other, &futex_main);
+	}
+
+	if (cfg_verbose)
+		printf("%s finished: %d iteration(s)\n", __func__, counter);
+
+	return NULL;
+}
+
+void run_test(int mode)
+{
+	struct timespec start, stop;
+	int ret, counter;
+	pthread_t thread;
+	uint64_t duration;
+
+	futex_set(&futex_other, FUTEX_WAITING);
+	atomic_set(&validation_counter, 0);
+	ret = pthread_create(&thread, NULL, &other_thread, &mode);
+	if (ret) {
+		perror("pthread_create");
+		exit(1);
+	}
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &start);
+	if (ret) {
+		perror("clock_gettime");
+		exit(1);
+	}
+
+	for (counter = 0; counter < cfg_iterations; ++counter) {
+		if (cfg_validate) {
+			int prev = 2 * counter;
+
+			if (prev != atomic_cmpxchg(&validation_counter, prev,
+						   prev + 1)) {
+				fprintf(stderr, "swap validation failed\n");
+				exit(1);
+			}
+		}
+		futex_swap_op(mode, &futex_main, &futex_other);
+	}
+	if (cfg_validate && validation_counter.val != 2 * cfg_iterations) {
+		fprintf(stderr, "final swap validation failed\n");
+		exit(1);
+	}
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &stop);
+	if (ret) {
+		perror("clock_gettime");
+		exit(1);
+	}
+
+	duration = (stop.tv_sec - start.tv_sec) * 1000000000LL +
+	stop.tv_nsec - start.tv_nsec;
+	if (cfg_verbose || cfg_iterations > 1) {
+		printf("completed %d swap and back iterations in %lu ns: %lu ns per swap\n",
+			cfg_iterations, duration,
+			duration / (cfg_iterations * 2));
+	}
+
+	/* The remote thread is blocked; send it the final wake. */
+	futex_set(&futex_other, FUTEX_WAKEUP);
+	futex_wake(&futex_other, 1, FUTEX_PRIVATE_FLAG);
+	if (pthread_join(thread, NULL)) {
+		perror("pthread_join");
+		exit(1);
+	}
+}
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -h    Display this help message\n");
+	printf("  -i N  Use N iterations to benchmark\n");
+	printf("  -n    Do not validate swapping correctness\n");
+	printf("  -v    Print diagnostic messages\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "hi:nv")) != -1) {
+		switch (c) {
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'i':
+			cfg_iterations = atoi(optarg);
+			break;
+		case 'n':
+			cfg_validate = 0;
+			break;
+		case 'v':
+			cfg_verbose = 1;
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	printf("\n\n------- running SWAP_WAKE_WAIT -----------\n\n");
+	run_test(SWAP_WAKE_WAIT);
+	printf("PASS\n");
+
+	printf("\n\n------- running SWAP_SWAP -----------\n\n");
+	run_test(SWAP_SWAP);
+	printf("PASS\n");
+
+	return 0;
+}
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..4d6a0a18445a 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -38,6 +38,9 @@ typedef volatile u_int32_t futex_t;
 #ifndef FUTEX_CMP_REQUEUE_PI
 #define FUTEX_CMP_REQUEUE_PI		12
 #endif
+#ifndef FUTEX_SWAP
+#define FUTEX_SWAP			13
+#endif
 #ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
 #define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
@@ -46,6 +49,9 @@ typedef volatile u_int32_t futex_t;
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
 #endif
+#ifndef FUTEX_SWAP_PRIVATE
+#define FUTEX_SWAP_PRIVATE		(FUTEX_WAIT_WAKE | FUTEX_PRIVATE_FLAG)
+#endif
 
 /**
  * futex() - SYS_futex syscall wrapper
@@ -204,6 +210,19 @@ futex_cmp_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
 		     val, opflags);
 }
 
+/**
+ * futex_swap() - block on uaddr and wake one task blocked on uaddr2.
+ * @uaddr:	futex to block the current task on
+ * @timeout:	relative timeout for the current task block
+ * @uaddr2:	futex to wake tasks at (can be the same as uaddr)
+ */
+static inline int
+futex_swap(futex_t *uaddr, futex_t val, struct timespec *timeout,
+	   futex_t *uaddr2, int opflags)
+{
+	return futex(uaddr, FUTEX_SWAP, val, timeout, uaddr2, 0, opflags);
+}
+
 /**
  * futex_cmpxchg() - atomic compare and exchange
  * @uaddr:	The address of the futex to be modified
-- 
2.25.1

