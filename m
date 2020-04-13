Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C0720656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2Pj+9rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbgDMXzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390309AbgDMXzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 19:55:22 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE2C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:55:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id s19so650360pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+4rFnX02gj14fuJltOp8b6tx4JnqFsAhBYMqq+dskm8=;
        b=V2Pj+9rqbJ6+JXga562hk45vktjRQkUkDiy0oBfSI1RI5qub7/7ckyNrqiWyQs/Tn1
         DFowFUvIEO0v76R08sWihTEswVIBptf58gDrVJH0XsYXNxEVpt8CMnzLvQUMSjkcKYML
         TQXoNx1Nfzn61EwjknwVbSa1vupDLBhbEB9ZEM77wByW8CMv85WmmYUr2t3uEQ02BQE2
         2IN3dnGSPW6xHyIb1hqOe7VyhhVVSJ9RHuyFQbWdufIchmklBz+OpgTuMgMC0PQ4JZUx
         akvkzDJaP9NXF4PJpxKXQv5edTK7dl774rR0QyVP7cIDLH6gGt1ONrN0r5xipDkBMiaX
         Cpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+4rFnX02gj14fuJltOp8b6tx4JnqFsAhBYMqq+dskm8=;
        b=aRkI5x0XDaf/D3q4/iWSsKrp5GyEDV6h+gt6VmLMfsU4y5/5evHQ7hlj47MGVcAGQ2
         ppwZxBHu/0nCUgAP2/s8QliI0yceasBHOvvfqATxYaG5zLuVz0C6/GRYrZ/X1exGHSrL
         a2g1CL3SqwF5qj90GNayHwucLKR/qpjw4dedODQ759yLiVwcwJal9xV40X3RjKLnIb1N
         XYg6ZxTKIkp1P8DkJi21kuZOhtMJhZMywoBqndDgR/3+yRX7Puoy6kKIKSksn9fmgKNO
         zR3Af4ffdDKAil610G1ykStFAumgPoMNhZPQA7XrnwWls/w7a8MFBxHEoYCH/p3tuACB
         z8lA==
X-Gm-Message-State: AGi0PuZtZQfGZePUyEnfEDpHb2/ia1CIiNA5t7ch+31W/O+xEAQ4CpDJ
        0tcIwp/PAOzBkVaKlB02tnMJXn5wrifT
X-Google-Smtp-Source: APiQypLBf+cIzoYAbQ41Tj88P0cngrpnOWGou23Er6A8Po4w+vQmv2SPCfQMgxbgBqXIf8ujSH+jk0lhrZRI
X-Received: by 2002:a17:90a:30e7:: with SMTP id h94mr22650088pjb.186.1586822122091;
 Mon, 13 Apr 2020 16:55:22 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:55:15 -0700
Message-Id: <20200413235515.221467-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] perf stat: force error in fallback on :k events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

When it is not possible for a non-privilege perf command
to monitor at the kernel level (:k), the fallback code forces
a :u. That works if the event was previously monitoring both levels.
But if the event was already constrained to kernel only, then it does
not make sense to restrict it to user only.
Given the code works by exclusion, a kernel only event would have:
attr->exclude_user = 1
The fallback code would add:
attr->exclude_kernel = 1;

In the end the end would not monitor in either the user level or kernel
level. In other words, it would count nothing.

An event programmed to monitor kernel only cannot be switched to user only
without seriously warning the user.

This patch forces an error in this case to make it clear the request
cannot really be satisfied.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d23db6755f51..d1e8862b86ce 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2446,6 +2446,13 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 		char *new_name;
 		const char *sep = ":";
 
+		if (evsel->core.attr.exclude_user) {
+			scnprintf(msg, msgsize,
+"kernel.perf_event_paranoid=%d, event set to exclude user, so cannot also exclude kernel",
+				paranoid);
+			return false;
+		}
+
 		/* Is there already the separator in the name. */
 		if (strchr(name, '/') ||
 		    strchr(name, ':'))
-- 
2.26.0.110.g2183baf09c-goog

