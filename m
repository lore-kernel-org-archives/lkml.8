Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F34FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B46222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/BNBWxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgBNHvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:51:47 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33575 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgBNHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:51:44 -0500
Received: by mail-pg1-f202.google.com with SMTP id 37so5581219pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=szU115WvSWvJtnD3Q0C0oG/l57SmEaFkdoKqrNjRdV8=;
        b=Y/BNBWxCUfSbPCWHjfaTOxLsz6itSO62ryj9JnsaeOvhVgXfTnL3dr9nKDfpjzCDi7
         kF+6kniAI11TzLlA6VF5Gw9ugFTcO/sjRBj0LKt9oO2DR2rBCT90OZ+ndVdQ/SK7K4xB
         rhjICCQnxUx2JpO13SYSVhwH+wQCtQm/LlL3ycUpDlHn6of5ZTWPMFFBkFukxZsiSnaQ
         5csClHDrDWIyjbOBYsagLfujnpJQF4+E7os73CyWxhBFIU00x41drwnLzNXT5twKuhoa
         HlHY009gTg0eJ+PBY9sXt6pCW7fUORW5bVAFfVTo7XupuDv8djv5yXCadPDyN5UIJTZr
         Renw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=szU115WvSWvJtnD3Q0C0oG/l57SmEaFkdoKqrNjRdV8=;
        b=nDZdf0XT2lQyksWFASjg5+Z/wUUxVFFQT+MzEDvsxfDVPMozcpGk3911YSWWyBnYCF
         nHyEDSB7ziOrp5+i47D593LDUBEX5Gw6koiVe5aBuXTGbwoyd0+zQmiMbp0g3r9vSg+z
         ItjK9bLCAkJjFKGsx7gMDLf6Fiyt5ERHL+2YCebswx0ApOaO+FCCDGWO0WF99ZKtSrBv
         AhjxTntqIzb6MSTCsuZ5q3qtlHec7f70c5eiHNOt22spqHqeUYgYWP9sp0hBGUoghaIM
         +maXGVun8nSsqpA99Jl5+f4f2h+fn4E/X+d90dj/WfJ+fxEOG/DKiTeDOWYlUHU9IXjM
         ZfMA==
X-Gm-Message-State: APjAAAUpFJ9GGvkQ5WEfZfyPNzSZ3QaBa0MweNOI+1PYb3JFL7TGsV/t
        Rlz7rgbc8bnS8vv4EKb9PSe15l/1uQXr
X-Google-Smtp-Source: APXvYqzABkeuRnkRUjXwZpYhEjgvaBdCQJTn4BeymrZPN/Pf/OvbTlPdGQMilU6XlP6mIcAAszYUafRohd0V
X-Received: by 2002:a63:e309:: with SMTP id f9mr2079309pgh.391.1581666703576;
 Thu, 13 Feb 2020 23:51:43 -0800 (PST)
Date:   Thu, 13 Feb 2020 23:51:28 -0800
In-Reply-To: <20200214075133.181299-1-irogers@google.com>
Message-Id: <20200214075133.181299-2-irogers@google.com>
Mime-Version: 1.0
References: <20191206231539.227585-1-irogers@google.com> <20200214075133.181299-1-irogers@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 1/6] perf/cgroup: Reorder perf_cgroup_connect()
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Move perf_cgroup_connect() after perf_event_alloc(), such that we can
find/use the PMU's cpu context.
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f1f77de7247..9bd2af954c54 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10804,12 +10804,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (!has_branch_stack(event))
 		event->attr.branch_sample_type = 0;
 
-	if (cgroup_fd != -1) {
-		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
-		if (err)
-			goto err_ns;
-	}
-
 	pmu = perf_init_event(event);
 	if (IS_ERR(pmu)) {
 		err = PTR_ERR(pmu);
@@ -10831,6 +10825,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		goto err_pmu;
 	}
 
+	if (cgroup_fd != -1) {
+		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
+		if (err)
+			goto err_pmu;
+	}
+
 	err = exclusive_event_init(event);
 	if (err)
 		goto err_pmu;
@@ -10891,12 +10891,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	exclusive_event_destroy(event);
 
 err_pmu:
+	if (is_cgroup_event(event))
+		perf_detach_cgroup(event);
 	if (event->destroy)
 		event->destroy(event);
 	module_put(pmu->module);
 err_ns:
-	if (is_cgroup_event(event))
-		perf_detach_cgroup(event);
 	if (event->ns)
 		put_pid_ns(event->ns);
 	if (event->hw.target)
-- 
2.25.0.265.gbab2e86ba0-goog

