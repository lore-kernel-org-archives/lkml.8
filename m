Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34872C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD6C20775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILPx1sD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgG1I5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgG1I5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:57:46 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977E8C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:57:46 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h185so13461653qke.21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IVtLohkvByKB7JQB020jNAQ7r9C7DnrPnxkFeMwHiBg=;
        b=ILPx1sD1aeCN5pgPHt6ku/fuzS99/H+/XGMBQBA2hzytqWTNktD8E/6HCP0/yX9i1T
         2TooIupqnMv5VhTLeb96j+zNbNV5AYkDQ75e2iFi2Wxc7e9y61IOzVd+fjq35qqA8flZ
         FynkrlFSxEhFhB6tGUZoAk2ARc6Nb0dBs8F0kKJ8dXqKaDXh6d7Wc/Cuu21gWoDAtZP4
         U/I161H80tGB6kZdUf6csdFJydudxvYVcpYOs+611R+/20uMhTmkFCPPUZ4N/bjsy0BA
         5denHP9eh6G39bv0dA0RcgHQxuoSfvnN/mb3JHb45F2yruZ+GwTBbBXoRbzdgP6snUP9
         FRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IVtLohkvByKB7JQB020jNAQ7r9C7DnrPnxkFeMwHiBg=;
        b=eEPjs5iTZgDB0VcsVRskxSs8qLM/u6HSdbtjWdU+d5SPjuAToM/YaGpSvl5LAZ4jVs
         oSIP/WGqrE8+BOaKDDXBJtQ0o0BaiYtQpMYbPA/qsHKWRi/7HtBm7SAlaixzKbm8c/RP
         fcsXWbLPPcxO6LsROcWSixWIIPPFe15rMTW+l86dlQIQ46wXpvlwKXMoV3RyAID7ks8e
         V16faYJek0w9yCXQcEpzJrprcrAK2evgEzVT5g9Aa+3gCahoF3voL3153d1FmkpQyWCu
         r2bIxCykgowztcmrZyb3rXG1kLDPQMAjt2+xnT0MaiS4+JyBA2MJRkuyWM4GOKuMOeuM
         U6nQ==
X-Gm-Message-State: AOAM531tD+701OvN0NpGnH+tNWW1nycOXFYk0CbDOTL+SROifMxZSFnE
        eD0jrrUIhcbMHYEs+gWE2s/Od09Fc1Mr
X-Google-Smtp-Source: ABdhPJyIgZfHKin1LciLIxcez8jCJhgJc1/oP9abqQ9PyLso35BvRfcms5FT1PFpPfJJHdGFfVZVBuLsMYOD
X-Received: by 2002:ad4:5912:: with SMTP id ez18mr25041443qvb.24.1595926665680;
 Tue, 28 Jul 2020 01:57:45 -0700 (PDT)
Date:   Tue, 28 Jul 2020 01:57:34 -0700
In-Reply-To: <20200728085734.609930-1-irogers@google.com>
Message-Id: <20200728085734.609930-6-irogers@google.com>
Mime-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 5/5] perf test: Leader sampling shouldn't clear sample period
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test that a sibling with leader sampling doesn't have its period
cleared.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/attr/README             |  1 +
 tools/perf/tests/attr/test-record-group2 | 29 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tools/perf/tests/attr/test-record-group2

diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
index 6cd408108595..a36f49fb4dbe 100644
--- a/tools/perf/tests/attr/README
+++ b/tools/perf/tests/attr/README
@@ -49,6 +49,7 @@ Following tests are defined (with perf commands):
   perf record --call-graph fp kill              (test-record-graph-fp)
   perf record --group -e cycles,instructions kill (test-record-group)
   perf record -e '{cycles,instructions}' kill   (test-record-group1)
+  perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
   perf record -D kill                           (test-record-no-delay)
   perf record -i kill                           (test-record-no-inherit)
   perf record -n kill                           (test-record-no-samples)
diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
new file mode 100644
index 000000000000..6b9f8d182ce1
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-group2
@@ -0,0 +1,29 @@
+[config]
+command = record
+args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
+ret     = 1
+
+[event-1:base-record]
+fd=1
+group_fd=-1
+config=0|1
+sample_period=1234000
+sample_type=87
+read_format=12
+inherit=0
+freq=0
+
+[event-2:base-record]
+fd=2
+group_fd=1
+config=0|1
+sample_period=6789000
+sample_type=87
+read_format=12
+disabled=0
+inherit=0
+mmap=0
+comm=0
+freq=0
+enable_on_exec=0
+task=0
-- 
2.28.0.163.g6104cc2f0b6-goog

