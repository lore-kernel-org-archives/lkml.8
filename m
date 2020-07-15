Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D0C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306AF2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/9Hf/LT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGOVng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgGOVn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:43:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65AFC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:43:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x184so4602348ybx.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ml+sd9PV8EvUQ7KhKL77+R7Whg5aSMZ83owFPqGx5e8=;
        b=M/9Hf/LTNpql/NGtl2rSNbltCgdU1qoTHNtmZZUDdz0zlA0Aa06tg9Kkwk7FHflyJS
         isS2O8ZMpKycgy1QcsYrUqiI3Zdb/BQOQ7t+hVTG+qAOzNUZAE6SqqIm2r+qfLtDrHYN
         qPgIK0EKZdOrAewBpkokymRzmBm16vTyias/uArmk+hlpgIqB8JLMDvW3TsA3/URW4Ip
         JlkT8QPtzTuvT6ZhsQiWisV5ujGrv6bNErH1zNUaaAef9VaC04g91+QgZ+C85PDs+U12
         xZ0fvZGtpFoI4O95ol4TMYUTXzjYDAtvJyKg43cqjVvlZPCxHJzMAhTiVZW8lOdlA9w5
         YVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ml+sd9PV8EvUQ7KhKL77+R7Whg5aSMZ83owFPqGx5e8=;
        b=sP8uosfWQ2bXdsHkiio5mxQhIRqQUE5wCglIe4yqQ/Jyo+f/n4s6+Go1wGnBVMNVG5
         Fw/ot9UZCdwXgST4sbTEdAcvFHQBIHAU6Wd40rvIqCUuLQ4iRt9qK0VCnK3D261MwFc4
         xeXiUoCsM28lrETREQhNp8S03RsGSDDPTbkZkFF6xjBZtGtYznkIWVOLTlm8FWYxqOXJ
         IwMdTsK9NYyoNUXIyTb5recKSUf0UrLS888iNROm/VDjGD2CVYTDLzzjXPBaWjeL1yxb
         zAxode2UeRiixHLqjR2D9rkjRMUfuHiojaK/40icjEbCJ/24DF7+0uDJ8aXxfTpBv5dc
         vqdw==
X-Gm-Message-State: AOAM533aCUwFh6QslHngRzd4CbUfLIMzAjhU79xO3hNc9asTsGHG63Ti
        8fIdhfoLhpMGWgD35JT1n1ShhcqJwyU=
X-Google-Smtp-Source: ABdhPJynHiusihyK/x2cYRfD3Qc6KyMIcpBUhTWUSKqKGSV5IUy21FYmh6OBCc+FPihODrmESwIwn7GbZ8k=
X-Received: by 2002:a25:ac02:: with SMTP id w2mr1734259ybi.57.1594849408882;
 Wed, 15 Jul 2020 14:43:28 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:43:12 -0700
In-Reply-To: <20200715214312.2266839-1-haoluo@google.com>
Message-Id: <20200715214312.2266839-3-haoluo@google.com>
Mime-Version: 1.0
References: <20200715214312.2266839-1-haoluo@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Test __ksym externs with BTF
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend ksyms.c selftest to make sure BTF enables direct loads of ksyms.

Note that test is done against the kernel btf extended with kernel VARs.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/testing/selftests/bpf/prog_tests/ksyms.c |  2 ++
 tools/testing/selftests/bpf/progs/test_ksyms.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
index e3d6777226a8..0e7f3bc3b0ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -65,6 +65,8 @@ void test_ksyms(void)
 	      "got %llu, exp %llu\n", data->out__btf_size, btf_size);
 	CHECK(data->out__per_cpu_start != 0, "__per_cpu_start",
 	      "got %llu, exp %llu\n", data->out__per_cpu_start, (__u64)0);
+	CHECK(data->out__rq_cpu != 0, "rq_cpu",
+	      "got %llu, exp %llu\n", data->out__rq_cpu, (__u64)0);
 
 cleanup:
 	test_ksyms__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/testing/selftests/bpf/progs/test_ksyms.c
index 6c9cbb5a3bdf..e777603757e5 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 
+#include "vmlinux.h"
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
@@ -9,11 +10,13 @@ __u64 out__bpf_link_fops = -1;
 __u64 out__bpf_link_fops1 = -1;
 __u64 out__btf_size = -1;
 __u64 out__per_cpu_start = -1;
+__u64 out__rq_cpu = -1;
 
 extern const void bpf_link_fops __ksym;
 extern const void __start_BTF __ksym;
 extern const void __stop_BTF __ksym;
 extern const void __per_cpu_start __ksym;
+extern const void runqueues __ksym;
 /* non-existing symbol, weak, default to zero */
 extern const void bpf_link_fops1 __ksym __weak;
 
@@ -29,4 +32,15 @@ int handler(const void *ctx)
 	return 0;
 }
 
+SEC("tp_btf/sys_enter")
+int handler_tp_btf(const void *ctx)
+{
+	const struct rq *rq = &runqueues;
+
+	/* rq now points to the runqueue of cpu 0. */
+	out__rq_cpu = rq->cpu;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.27.0.389.gc38d7665816-goog

