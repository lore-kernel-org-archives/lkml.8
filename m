Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB265C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9847820678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veyQdRgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbgDNQQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391336AbgDNQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:15:55 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E276C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:15:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h16so124584pgb.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cUPr7bvGKvzCuMLjVFQf9BJZDbVobDelnnwAUu/BEcs=;
        b=veyQdRgm5ED1YZoLKUTWNmpetkd1zO7FMV5EkD0EgFarK/PBRnORp8N7qWuIocyHPN
         ZSHWYcHkHWI1P19AvVyMsXvTDpyaDVbGjpWUUT5WjuowIGz0QFajFqZumQcYNBArbPhz
         NGojZutXjgc40nYcBIfNIlz+j/MHoXnQgwqTA9bMD7swUUub5Q6/TZgrX5inOD8orplr
         KxPSuV+LyTPEVuhmZx2X6h4yHFTQ8y9OP4Fq30iePeYMLkbrztW1BTENzjbg+iZ+cByq
         25friTrl0PodKRrHy5dz8RbCcpLf5xkSJuOcyPPS++nkNbM6wEe6mcpjTlK2QZbXKajj
         V1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cUPr7bvGKvzCuMLjVFQf9BJZDbVobDelnnwAUu/BEcs=;
        b=nZTEGe1lE9sd7Cdi+1pI5FImnZGmJAckhE04CwQXD2PtAjCeyW+vRSEJJWdEyYiR8p
         FXi/TrkKf7MbTBoXcBlTKB3eI/pJLVAZhltd5Y/3FK3uYx68l7FufqRhG08T4WgMYhpp
         g/t1UpNTBYxIEtbugD4tlRYVT7rgdHEobaqmH9UcuPKgO+uTid7DYLCERq22czlGlLDN
         INY9veDJJRKg9dYZCAQh115NGznjuIsEOJLCwXHvjHicMRN183OWK4oan8GrYk83YnPx
         51WIIUQdPiFUIb2cGwSGT5PGnpCVOhJq2wFDZd7oiDjHRz4C2Byv34Lg1f2OQlA3Uh1a
         SSFg==
X-Gm-Message-State: AGi0PuZB+plIWCAL/HlxHyjZILrnCJx0lvtm435dkFX34tZn0My0sq1G
        gzfx68Rmwh01maCZpxGuZnH0nLFeiQYD
X-Google-Smtp-Source: APiQypIZg79JuUfoCHwk9K5THFa0VnYUUHhX6JbhEyCkTLJtkPSy+72mDazA0TjUcm/b0c5xmdutcD/vQpsb
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr965312pjb.109.1586880955033;
 Tue, 14 Apr 2020 09:15:55 -0700 (PDT)
Date:   Tue, 14 Apr 2020 09:15:50 -0700
Message-Id: <20200414161550.225588-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v2] perf stat: force error in fallback on :k events
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

Behavior with paranoid 1:
$ sudo bash -c "echo 1 > /proc/sys/kernel/perf_event_paranoid"
$ perf stat -e cycles:k sleep 1

 Performance counter stats for 'sleep 1':

         1,520,413      cycles:k

       1.002361664 seconds time elapsed

       0.002480000 seconds user
       0.000000000 seconds sys

Old behavior with paranoid 2:
$ sudo bash -c "echo 2 > /proc/sys/kernel/perf_event_paranoid"
$ perf stat -e cycles:k sleep 1
 Performance counter stats for 'sleep 1':

                 0      cycles:ku

       1.002358127 seconds time elapsed

       0.002384000 seconds user
       0.000000000 seconds sys

New behavior with paranoid 2:
$ sudo bash -c "echo 2 > /proc/sys/kernel/perf_event_paranoid"
$ perf stat -e cycles:k sleep 1
Error:
You may not have permission to collect stats.

Consider tweaking /proc/sys/kernel/perf_event_paranoid,
which controls use of the performance events system by
unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).

The current value is 2:

  -1: Allow use of (almost) all events by all users
      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>= 0: Disallow ftrace function tracepoint by users without CAP_PERFMON or CAP_SYS_ADMIN
      Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN
>= 1: Disallow CPU event access by users without CAP_PERFMON or CAP_SYS_ADMIN
>= 2: Disallow kernel profiling by users without CAP_PERFMON or CAP_SYS_ADMIN

To make this setting permanent, edit /etc/sysctl.conf too, e.g.:

        kernel.perf_event_paranoid = -1

v2 of this patch addresses the review feedback from jolsa@redhat.com.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d23db6755f51..b4e8bcb5ab05 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2446,6 +2446,10 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 		char *new_name;
 		const char *sep = ":";
 
+		/* If event has exclude user then don't exclude kernel. */
+		if (evsel->core.attr.exclude_user)
+			return false;
+
 		/* Is there already the separator in the name. */
 		if (strchr(name, '/') ||
 		    strchr(name, ':'))
-- 
2.26.0.110.g2183baf09c-goog

