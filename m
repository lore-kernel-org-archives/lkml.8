Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A7EC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503A92082E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBFONd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:13:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40436 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:13:33 -0500
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f5:7989:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 86CF629527B;
        Thu,  6 Feb 2020 14:13:26 +0000 (GMT)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     kernel@collabora.com, krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, peterz@infradead.org, dvhart@infradead.org,
        mingo@redhat.com, z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 2/4] selftests: futex: Add FUTEX_WAIT_MULTIPLE timeout test
Date:   Thu,  6 Feb 2020 11:10:49 -0300
Message-Id: <20200206141051.6124-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206141051.6124-1-andrealmeid@collabora.com>
References: <20200206141051.6124-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Add test for timeout when waiting for multiple futexes. Skip the test if
it's a x32 application and the kernel returned the approtiaded error,
since this ABI is not supported for this operation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Co-developed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_timeout.c     | 38 ++++++++++++++++++-
 .../selftests/futex/include/futextest.h       | 22 +++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index ee55e6d389a3..2a63e1c2cfb6 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -11,6 +11,7 @@
  *
  * HISTORY
  *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
+ *      2019-Dec-13: Add WAIT_MULTIPLE test by Krisman <krisman@collabora.com>
  *
  *****************************************************************************/
 
@@ -41,6 +42,8 @@ int main(int argc, char *argv[])
 {
 	futex_t f1 = FUTEX_INITIALIZER;
 	struct timespec to;
+	time_t secs;
+	struct futex_wait_block fwb = {&f1, f1, 0};
 	int res, ret = RET_PASS;
 	int c;
 
@@ -65,7 +68,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
@@ -79,8 +82,39 @@ int main(int argc, char *argv[])
 	if (!res || errno != ETIMEDOUT) {
 		fail("futex_wait returned %d\n", ret < 0 ? errno : ret);
 		ret = RET_FAIL;
+	} else
+		ksft_test_result_pass("futex_wait timeout succeeds\n");
+
+	info("Calling futex_wait_multiple on f1: %u @ %p\n", f1, &f1);
+
+	/* Setup absolute time */
+	ret = clock_gettime(CLOCK_REALTIME, &to);
+	secs = (to.tv_nsec + timeout_ns) / 1000000000;
+	to.tv_nsec = ((int64_t)to.tv_nsec + timeout_ns) % 1000000000;
+	to.tv_sec += secs;
+	info("to.tv_sec  = %ld\n", to.tv_sec);
+	info("to.tv_nsec = %ld\n", to.tv_nsec);
+
+	res = futex_wait_multiple(&fwb, 1, &to,
+				  FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME);
+
+#ifdef __ILP32__
+	if (res == -1 && errno == ENOSYS) {
+		ksft_test_result_skip("futex_wait_multiple not supported at x32\n");
+	} else {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
 	}
+#else
+	if (!res || errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
+	} else
+		ksft_test_result_pass("futex_wait_multiple timeout succeeds\n");
+#endif /* __ILP32__ */
 
-	print_result(TEST_NAME, ret);
+	ksft_print_cnts();
 	return ret;
 }
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..bb103bef4557 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -38,6 +38,14 @@ typedef volatile u_int32_t futex_t;
 #ifndef FUTEX_CMP_REQUEUE_PI
 #define FUTEX_CMP_REQUEUE_PI		12
 #endif
+#ifndef FUTEX_WAIT_MULTIPLE
+#define FUTEX_WAIT_MULTIPLE		13
+struct futex_wait_block {
+	futex_t *uaddr;
+	futex_t val;
+	__u32 bitset;
+};
+#endif
 #ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
 #define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
@@ -80,6 +88,20 @@ futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int opflags)
 	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
 }
 
+/**
+ * futex_wait_multiple() - block on several futexes with optional timeout
+ * @fwb:	wait block user space address
+ * @count:	number of entities at fwb
+ * @timeout:	absolute timeout
+ */
+static inline int
+futex_wait_multiple(struct futex_wait_block *fwb, int count,
+		    struct timespec *timeout, int opflags)
+{
+	return futex(fwb, FUTEX_WAIT_MULTIPLE, count, timeout, NULL, 0,
+		     opflags);
+}
+
 /**
  * futex_wake() - wake one or more tasks blocked on uaddr
  * @nr_wake:	wake up to this many tasks
-- 
2.25.0

