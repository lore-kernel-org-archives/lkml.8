Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F3FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243D120848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bQqCSEzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgCCOKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:10:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38229 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgCCOKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:10:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id t11so4508022wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjj2AUiojfdL3aSmwoSiGLpePTvBoxxUzefZJf0lBxI=;
        b=bQqCSEzMzaOIY36ctJ1G9ckpnHqwyRAYQ0d/bc3qPqZY+tBOHW8m98mKF1cPguCLmh
         3aTeYTr3Md5IZcIL/tRAKOutCXKMxyQwkVAEXArXwC3Y7eM9+dxpwfGGRMzmHcCVQ1oU
         aV0W7S7yMlqU1DddlAHBErNpcJK+Qgu5Wal8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjj2AUiojfdL3aSmwoSiGLpePTvBoxxUzefZJf0lBxI=;
        b=cKWz54HLfFYQQmWAxjIC8hwxJVV5MROMIbvdRVFjwmkCQkY0ikWEZmkOTtYSE3xa4g
         xGTp1J+wwCGC9pPYAwy/7SEJKRA/6kncl7sqBj8EWmb9O8W+Kct6NxzAc08eZoBoHMs3
         cnGHgzND3SaED925JLEh36pXjtj9IEzd7lcpU1JAp1A+814wa3SWlmb++DHOaGgrPO2j
         YtuB32/fmy7WAGmvnS2up9FluPC3J7tlEirwBK8qgYGWi+Qq4J6bnxMFMy7cnErC3SGO
         pnoIiSP32N9Q2nri7Ks9HJJn5+9DbA4wY/MG91ELjm4tioxNcVodf0L351YoGsd45phx
         7uzA==
X-Gm-Message-State: ANhLgQ0tHj4oG8LdE8a5zd6PzUT/0evqm72LMZcVkW7UX9ltw6PG/Z6g
        aZdCluS/T2fLLLSEwcP73UzWAYy5omE=
X-Google-Smtp-Source: ADFU+vtO/WKI1Lwi3aVh17KEDOsr7UjQXTmaJdVsa2Y9uy6308LrUiySCgGn/3R19yzNjv0bD09xXQ==
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr5432964wrp.335.1583244606551;
        Tue, 03 Mar 2020 06:10:06 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:2811:c80d:9375:bf8a])
        by smtp.gmail.com with ESMTPSA id h20sm11746823wrc.47.2020.03.03.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:10:06 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 7/7] bpf: Add selftests for BPF_MODIFY_RETURN
Date:   Tue,  3 Mar 2020 15:09:50 +0100
Message-Id: <20200303140950.6355-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303140950.6355-1-kpsingh@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Test for two scenarios:

  * When the fmod_ret program returns 0, the original function should
    be called along with fentry and fexit programs.
  * When the fmod_ret program returns a non-zero value, the original
    function should not be called, no side effect should be observed and
    fentry and fexit programs should be called.

The result from the kernel function call and whether a side-effect is
observed is returned via the retval attr of the BPF_PROG_TEST_RUN (bpf)
syscall.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 net/bpf/test_run.c                            | 23 ++++++-
 .../selftests/bpf/prog_tests/modify_return.c  | 65 +++++++++++++++++++
 .../selftests/bpf/progs/modify_return.c       | 49 ++++++++++++++
 3 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/modify_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fb54b45285b4..642b6a46210b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -10,6 +10,7 @@
 #include <net/bpf_sk_storage.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <linux/error-injection.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/bpf_test_run.h>
@@ -143,6 +144,14 @@ int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
 	return a + (long)b + c + d + (long)e + f;
 }
 
+int noinline bpf_modify_return_test(int a, int *b)
+{
+	*b += 1;
+	return a + *b;
+}
+
+ALLOW_ERROR_INJECTION(bpf_modify_return_test, ERRNO);
+
 static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
 			   u32 headroom, u32 tailroom)
 {
@@ -168,7 +177,9 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr)
 {
-	int err = -EFAULT;
+	u16 side_effect = 0, ret = 0;
+	int b = 2, err = -EFAULT;
+	u32 retval = 0;
 
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
@@ -181,12 +192,20 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111)
 			goto out;
 		break;
+	case BPF_MODIFY_RETURN:
+		ret = bpf_modify_return_test(1, &b);
+		if (b != 2)
+			side_effect = 1;
+		break;
 	default:
 		goto out;
 	}
 
-	return 0;
+	retval = (u32)side_effect << 16 | ret;
+	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
+		goto out;
 
+	return 0;
 out:
 	trace_bpf_test_finish(&err);
 	return err;
diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
new file mode 100644
index 000000000000..beab9a37f35c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <test_progs.h>
+#include "modify_return.skel.h"
+
+#define LOWER(x) (x & 0xffff)
+#define UPPER(x) (x >> 16)
+
+
+static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
+{
+	struct modify_return *skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	__u16 side_effect;
+	__s16 ret;
+
+	skel = modify_return__open_and_load();
+	if (CHECK(!skel, "skel_load", "modify_return skeleton failed\n"))
+		goto cleanup;
+
+	err = modify_return__attach(skel);
+	if (CHECK(err, "modify_return", "attach failed: %d\n", err))
+		goto cleanup;
+
+	skel->bss->input_retval = input_retval;
+	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0, NULL, 0,
+				&retval, &duration);
+
+	CHECK(err, "test_run", "err %d errno %d\n", err, errno);
+
+	side_effect = UPPER(retval);
+	ret  = LOWER(retval);
+
+	CHECK(ret != want_ret, "test_run",
+	      "unexpected ret: %d, expected: %d\n", ret, want_ret);
+	CHECK(side_effect != want_side_effect, "modify_return",
+	      "unexpected side_effect: %d\n", side_effect);
+
+	CHECK(skel->bss->fentry_result != 1, "modify_return",
+	      "fentry failed\n");
+	CHECK(skel->bss->fexit_result != 1, "modify_return",
+	      "fexit failed\n");
+	CHECK(skel->bss->fmod_ret_result != 1, "modify_return",
+	      "fmod_ret failed\n");
+
+cleanup:
+	modify_return__destroy(skel);
+}
+
+void test_modify_return(void)
+{
+	run_test(0 /* input_retval */,
+		 1 /* want_side_effect */,
+		 4 /* want_ret */);
+	run_test(-EINVAL /* input_retval */,
+		 0 /* want_side_effect */,
+		 -EINVAL /* want_ret */);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/modify_return.c b/tools/testing/selftests/bpf/progs/modify_return.c
new file mode 100644
index 000000000000..8b7466a15c6b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/modify_return.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+static int sequence = 0;
+__s32 input_retval = 0;
+
+__u64 fentry_result = 0;
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(fentry_test, int a, __u64 b)
+{
+	sequence++;
+	fentry_result = (sequence == 1);
+	return 0;
+}
+
+__u64 fmod_ret_result = 0;
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
+{
+	sequence++;
+	/* This is the first fmod_ret program, the ret passed should be 0 */
+	fmod_ret_result = (sequence == 2 && ret == 0);
+	return input_retval;
+}
+
+__u64 fexit_result = 0;
+SEC("fexit/bpf_modify_return_test")
+int BPF_PROG(fexit_test, int a, __u64 b, int ret)
+{
+	sequence++;
+	/* If the input_reval is non-zero a successful modification should have
+	 * occurred.
+	 */
+	if (input_retval)
+		fexit_result = (sequence == 3 && ret == input_retval);
+	else
+		fexit_result = (sequence == 3 && ret == 4);
+
+	return 0;
+}
-- 
2.20.1

