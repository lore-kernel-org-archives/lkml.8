Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E05C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3EE206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0EVcEkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgEOG5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgEOG4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:56:43 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:42 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j6so1658331qvn.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HRcsgixZKIGHXE809MZwKkXe7/yWNFRQw3Pqfn6iPQ4=;
        b=j0EVcEkUBLjPQgdo3WSyM3qJ84Z+fbTZaJe/5D+JTuRP4nQM87i/fzxocDWW33TKP0
         KWVRqqAGrHS/zckUbOO9aOYW+AaTF0WycfWPgIQKnZu7I0pMHT3WB9nv/r7FCKd43QtM
         /lbxGNGZCFS8wXUCTC6hR9ecRXJvX65b67ftpeDTLYb9RtQCN0azwYHUXxOAIWjXlDqT
         EWrj9dO3op7IaLqNKerRK5f3alhUP6wi/TiEgXjMbeRw+ipFRXzYJrZhgZOEjbz0BlQy
         YcgLhsTOSNZ3P0u0hFLaYgsgbRoQF/ejZU30j5+INhQHqe4p+07dP/KWEpDVvRk5ABj4
         UyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HRcsgixZKIGHXE809MZwKkXe7/yWNFRQw3Pqfn6iPQ4=;
        b=Ym96JWKOV4SNS0qUn/+n11QOYTgtlegCYcwPdHCv7JaQxjrg0H9xMcKcQCHA+jLrSa
         9JUdwA3JDbLsv1obnWoREla8H5ijDjdST4CBrOXKjwniujTnHlAVWCOc4RI8t5cJY6vW
         maArsGRGCeQH+P+jXpi6TpIsg90lrfx4VZIlioFqcU/jE0ylCpXdKbOp4fJXVGBeNCx3
         RpZIlMlg729wxAGAaKVpB8qTk6UaVghDflhAB1cePLM7MGgWH8WgBR+3az61aQxp5iy6
         40E7VAOzVYZrjGATBYaJxIZvm+PHvQOAL3rcoo7MdyUvVtz/W2dyQO6dtHqLpFWZjsEw
         h0Dw==
X-Gm-Message-State: AOAM533moMBsocuOLMhvGoffy7bYQ/elFWOj1ipSKVADXw5KX3f2F2mB
        pO7uarbP4IxqiLdeCZaHFiUCmrh95b8n
X-Google-Smtp-Source: ABdhPJwSFLjEFtRA2Y0gUBr1G22pIPriwKT5ufbbnoybsN93DW5fiomOe6xfzfWE6tcnEJeXnwfNiLMlj5N8
X-Received: by 2002:ad4:5903:: with SMTP id ez3mr2102437qvb.105.1589525802128;
 Thu, 14 May 2020 23:56:42 -0700 (PDT)
Date:   Thu, 14 May 2020 23:56:22 -0700
In-Reply-To: <20200515065624.21658-1-irogers@google.com>
Message-Id: <20200515065624.21658-7-irogers@google.com>
Mime-Version: 1.0
References: <20200515065624.21658-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 6/8] perf test: Provide a subtest callback to ask for the
 reason for skipping a subtest
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Paul Clarke <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now subtests can inform why a test was skipped. The upcoming patch
improvint PMU event metric testing will use it.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200513212933.41273-1-irogers@google.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 11 +++++++++--
 tools/perf/tests/tests.h        |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3471ec52ea11..baee735e6aa5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -429,8 +429,15 @@ static int test_and_print(struct test *t, bool force_skip, int subtest)
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
-	case TEST_SKIP:
-		color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
+	case TEST_SKIP: {
+		const char *skip_reason = NULL;
+		if (t->subtest.skip_reason)
+			skip_reason = t->subtest.skip_reason(subtest);
+		if (skip_reason)
+			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", skip_reason);
+		else
+			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
+	}
 		break;
 	case TEST_FAIL:
 	default:
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index d6d4ac34eeb7..88e45aeab94f 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -34,6 +34,7 @@ struct test {
 		bool skip_if_fail;
 		int (*get_nr)(void);
 		const char *(*get_desc)(int subtest);
+		const char *(*skip_reason)(int subtest);
 	} subtest;
 	bool (*is_supported)(void);
 	void *priv;
-- 
2.26.2.761.g0e0b3e54be-goog

