Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A855C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B50E20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XY11zWkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgICWeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgICWds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:33:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48BC061258
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:33:47 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l1so2708957qvr.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UW/0PGzjXFNLpgvsGBdXGPzkiQxfa78I9ft59r2N/eQ=;
        b=XY11zWkKXAZxLJ9vRo4yHPqTSberWaYsHouzkHd91K67vZInZlS3w/HGq0e6ogCBTk
         aWV/sMHfo1eQcJyerLI7GnKlBBw6dHNIXyb9+HBOVcwN4Eu6Gh7ZeoqqjsVoIQ2cqiA/
         l9HJMYtuh5JT7LSWyWGQ78IAh6eOablm9ZpDUtYYfF0qFpYPnFP9sy8f3LYaHENDesw8
         RXTn1dRHAmB893UlWGp5fxDBkKWRTOHqCRg/bm8MagpTOlA2yQbjin2MthfK9TUctbPA
         03frbeRjM5BqgZSvjOTX8CFPwOmR8n5DJUoMvzjb+ymNh9bJR14WAChjo1380b2tzIr7
         oCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UW/0PGzjXFNLpgvsGBdXGPzkiQxfa78I9ft59r2N/eQ=;
        b=bCu35HMGZfdzhwUFGqz41Ccl3lZJTnf0HasNXq3nNgz7K6a/WQOg9qOqRcnf+09W34
         AyxvXbcD38xFiTce/nxASiO8mIvbGgJ20HGrE+QIB0naCsmTaEiMo7UVd7YolQG7F6fQ
         7ddGvpaWbYbQP0LiDuoGVcpyhii3Id2gs7OeRzYu2jPdC1pVpXTWvaVsXimJCfn/vr7m
         dt9uKYZFt/QSVkmURoziw3iyL1qpGh0vcC2PWdwENHTtXOOl7AhaltQX0fT9uKKmrlhb
         tBVeyi6KdDwin5/PAogIy36huaNg5r+GPO82K4Q9KlFoTIbZeRfh0Y2vuoqYTP49/+vj
         zZmA==
X-Gm-Message-State: AOAM532MUvqFdkMDMelvy0rxZxLSt6kCjhhamnimfrj35GGamK12NGGm
        gqGpvJDVQwO7Z/MqujDZG7Dqc5rg+6k=
X-Google-Smtp-Source: ABdhPJwMqcx89txh5tXQBtUtjcZyiaptSRj7S1RflllH58s5G4zJUG+EC8RwDGjZKEdQQ1HYDhpzgYctmw0=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a0c:c712:: with SMTP id w18mr4106712qvi.7.1599172426915;
 Thu, 03 Sep 2020 15:33:46 -0700 (PDT)
Date:   Thu,  3 Sep 2020 15:33:32 -0700
In-Reply-To: <20200903223332.881541-1-haoluo@google.com>
Message-Id: <20200903223332.881541-7-haoluo@google.com>
Mime-Version: 1.0
References: <20200903223332.881541-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH bpf-next v2 6/6] bpf/selftests: Test for bpf_per_cpu_ptr() and bpf_this_cpu_ptr()
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test bpf_per_cpu_ptr() and bpf_this_cpu_ptr(). Test two paths in the
kernel. If the base pointer points to a struct, the returned reg is
of type PTR_TO_BTF_ID. Direct pointer dereference can be applied on
the returned variable. If the base pointer isn't a struct, the
returned reg is of type PTR_TO_MEM, which also supports direct pointer
dereference.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../selftests/bpf/prog_tests/ksyms_btf.c      | 10 +++++++
 .../selftests/bpf/progs/test_ksyms_btf.c      | 26 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
index 7b6846342449..22cc642dbc0e 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
@@ -58,6 +58,16 @@ void test_ksyms_btf(void)
 	CHECK(data->out__bpf_prog_active != bpf_prog_active_addr, "bpf_prog_active",
 	      "got %llu, exp %llu\n", data->out__bpf_prog_active, bpf_prog_active_addr);
 
+	CHECK(data->out__rq_cpu == -1, "rq_cpu",
+	      "got %u, exp != -1\n", data->out__rq_cpu);
+	CHECK(data->out__percpu_bpf_prog_active == -1, "percpu_bpf_prog_active",
+	      "got %d, exp != -1\n", data->out__percpu_bpf_prog_active);
+
+	CHECK(data->out__this_rq_cpu == -1, "this_rq_cpu",
+	      "got %u, exp != -1\n", data->out__this_rq_cpu);
+	CHECK(data->out__this_bpf_prog_active == -1, "this_bpf_prog_active",
+	      "got %d, exp != -1\n", data->out__this_bpf_prog_active);
+
 cleanup:
 	test_ksyms_btf__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf.c
index e04e31117f84..02d564349892 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms_btf.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf.c
@@ -8,15 +8,41 @@
 __u64 out__runqueues = -1;
 __u64 out__bpf_prog_active = -1;
 
+__u32 out__rq_cpu = -1; /* percpu struct fields */
+int out__percpu_bpf_prog_active = -1; /* percpu int */
+
+__u32 out__this_rq_cpu = -1;
+int out__this_bpf_prog_active = -1;
+
 extern const struct rq runqueues __ksym; /* struct type global var. */
 extern const int bpf_prog_active __ksym; /* int type global var. */
 
 SEC("raw_tp/sys_enter")
 int handler(const void *ctx)
 {
+	struct rq *rq;
+	int *active;
+	__u32 cpu;
+
 	out__runqueues = (__u64)&runqueues;
 	out__bpf_prog_active = (__u64)&bpf_prog_active;
 
+	cpu = bpf_get_smp_processor_id();
+
+	/* test bpf_per_cpu_ptr() */
+	rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, cpu);
+	if (rq)
+		out__rq_cpu = rq->cpu;
+	active = (int *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
+	if (active)
+		out__percpu_bpf_prog_active = *active;
+
+	/* test bpf_this_cpu_ptr */
+	rq = (struct rq *)bpf_this_cpu_ptr(&runqueues);
+	out__this_rq_cpu = rq->cpu;
+	active = (int *)bpf_this_cpu_ptr(&bpf_prog_active);
+	out__this_bpf_prog_active = *active;
+
 	return 0;
 }
 
-- 
2.28.0.526.ge36021eeef-goog

