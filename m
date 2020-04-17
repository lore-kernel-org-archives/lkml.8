Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6EFC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3062076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZ9QoXVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgDQS2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgDQS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:28:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8108CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:28:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q142so2670761pfc.21
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DjQXy2exWjwriNyUC2GIvM8LP+AR/h3G20HFwsfL+JI=;
        b=mZ9QoXVpKwSqhEdbDfiIzZW4ahvQi+7hy1ql2g3/YWA/QEwjtqan+6LJ7nYDMAtUWa
         NM4L4L+FfYeJTxbuEZEX1NEyO4wGn7erzDJmXGRnnk5wyJ09W+n8IMs0gGiJAb+bEGZr
         2Ij4P1hkNjngCzhGcgxOjTDGWcdk7+/U5YDrz3ArZs6+TsFbk1GyfM5RyWqOKRz6T31L
         oSeS+T7VPEwrUahfHB6UlRhvna+ZbN1LEMiYG1J2imGr2tJ1Cx6gmw81Y8tSpEQO2ixY
         uhsTQgd1uaoZfJI0Pc5L267Jqus2bdn4ZSmHZEpj46RElCoPD26yGDuJSkAyO/HzFUMe
         iDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DjQXy2exWjwriNyUC2GIvM8LP+AR/h3G20HFwsfL+JI=;
        b=gHa2Kl/6tm6q3WTRYrpSkJIEMRUEeyYtK01fIvJEkQi5o4f3ZXI/27gEpswXB05kc8
         no6o42L9LISj6cympX87sjaWtg4oC+hGJ565wUbB3IolPOD4ULfX8jtm/nZEY1/fWLaA
         ZUStnqFIuTPpmktnj4tc/y4HQ7x5bR8dxXJsl3VunVN3K/PmG0AmciZCaKOnngA26+JS
         YGLkGzV0oCOZYaxV0UQ0LcEWBlbPv4wsKOEyGAHrcR6YsRl5Ce3oLf1tucjrMZC58hAC
         VTCPeo3If6E0VWUVpC/Y5P7GVmn2qKzMyMcYXnkeinYAKXhIo5qW0Dmdgi8meMEiTFry
         bxlw==
X-Gm-Message-State: AGi0Pubrbk69yw2sgkmqYELwi3ZhKBJqsYZp/xCjudY61yMrUPAfMHMW
        gEKbvjGnMB6Itn1+F4u2zE3Yiqo+oFUv
X-Google-Smtp-Source: APiQypIzIEWLUk4Q/iplve4QGMaQej0FMSmSlAPFi1efUfUDBJ3mX9lYC+by5M40wHZJyehuhza86jwjzVP3
X-Received: by 2002:a17:90b:2385:: with SMTP id mr5mr4843060pjb.172.1587148132890;
 Fri, 17 Apr 2020 11:28:52 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:28:42 -0700
Message-Id: <20200417182842.12522-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] perf/core: fix parent pid/tid in task exit events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        KP Singh <kpsingh@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current logic yields the child task as the parent.

Before:
$ perf record bash -c "perf list > /dev/null"
$ perf script -D |grep 'FORK\|EXIT'
4387036190981094 0x5a70 [0x30]: PERF_RECORD_FORK(10472:10472):(10470:10470)
4387036606207580 0xf050 [0x30]: PERF_RECORD_EXIT(10472:10472):(10472:10472)
4387036607103839 0x17150 [0x30]: PERF_RECORD_EXIT(10470:10470):(10470:10470)
                                                   ^
  Note the repeated values here -------------------/

After:
383281514043 0x9d8 [0x30]: PERF_RECORD_FORK(2268:2268):(2266:2266)
383442003996 0x2180 [0x30]: PERF_RECORD_EXIT(2268:2268):(2266:2266)
383451297778 0xb70 [0x30]: PERF_RECORD_EXIT(2266:2266):(2265:2265)

Reported-by: KP Singh <kpsingh@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bc9b98a9af9a..633b4ae72ed5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7491,10 +7491,17 @@ static void perf_event_task_output(struct perf_event *event,
 		goto out;
 
 	task_event->event_id.pid = perf_event_pid(event, task);
-	task_event->event_id.ppid = perf_event_pid(event, current);
-
 	task_event->event_id.tid = perf_event_tid(event, task);
-	task_event->event_id.ptid = perf_event_tid(event, current);
+
+	if (task_event->event_id.header.type == PERF_RECORD_EXIT) {
+		task_event->event_id.ppid = perf_event_pid(event,
+							task->real_parent);
+		task_event->event_id.ptid = perf_event_pid(event,
+							task->real_parent);
+	} else {  /* PERF_RECORD_FORK */
+		task_event->event_id.ppid = perf_event_pid(event, current);
+		task_event->event_id.ptid = perf_event_tid(event, current);
+	}
 
 	task_event->event_id.time = perf_event_clock(event);
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

