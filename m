Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B665FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BEE8214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596828767;
	bh=kDp40vrc9e/hVscQy5eI4TJT4qyiubBBWVTsEBD9jpc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Nd7vwA3HxUo3k0g24EXmdHwORhhG03aED0LmX9GPFQ50k796WuJpX3Jx9Bf/JWI5G
	 cszmolpD8UzQfBnv2xMHVFNVyNwN7jXQTbPoh8dvumhlzLjyshbSwZ6a3RMI7N60kl
	 LqHvjcPz4dTt7Ywhs02E/zHnj5QlcGk97kPqP85Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHGTcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:32:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39402 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgHGTcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:32:45 -0400
Received: by mail-io1-f68.google.com with SMTP id z6so3020426iow.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3h0tB6KwL/1zsM8Iqv08PPXT2hN0xRM0rpK7r3CHFs=;
        b=G1lv9d3iOqxULWbmTXoH9ssSZ9+icPWWlZtwEU11klYGH9OdTZuStMGCD2Nd1OcN7j
         hDL/UiF1YftdIMeWkRdjFywacZ3gJ/5zdLah5yehEEGJiQOldlQG8GXX5/picxOvSGOW
         oY2VOEOrVHX43OX4m1E+mnRDi5IvwOwvktZJO1KduGrAf5YkRNC0DrDHPayl4PVjmBXp
         3t6vWMcUfmC9CDb2li82JDOjBeN0JD71sj9/TYVRpZx4oltrbMIKsjJT4EzSgDeex9Tr
         FMVFFN6PyYqjbCk58kEi7iKFpYeTY/BwaUHmInqPICycIewjrFcRTzcUz4ao7Ey4U2YQ
         2VQA==
X-Gm-Message-State: AOAM532nSI/Vv0FIaMhbzPZ5Ko4UEC0cyBwhAhIrIyBLHAAzKNJzvGMT
        SVggRKLQ2pZbxlJrWhPg7Q==
X-Google-Smtp-Source: ABdhPJws4XJ73LOIOQTnvLHovOoGVM5K20z1z11ZGD2ftDqp098XlalQncOdbJTPC7AAHuP7nh6hrQ==
X-Received: by 2002:a05:6602:221a:: with SMTP id n26mr5927822ion.170.1596828763908;
        Fri, 07 Aug 2020 12:32:43 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id z9sm4975142ilm.78.2020.08.07.12.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:32:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] libperf: Fix man page typos
Date:   Fri,  7 Aug 2020 13:32:41 -0600
Message-Id: <20200807193241.3904545-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix various typos and inconsistent capitalization of CPU in the libperf
man pages.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/lib/perf/Documentation/libperf-counting.txt | 14 ++++++++------
 tools/lib/perf/Documentation/libperf-sampling.txt | 13 +++++++------
 tools/lib/perf/Documentation/libperf.txt          |  4 ++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf-counting.txt b/tools/lib/perf/Documentation/libperf-counting.txt
index cae9757f49c1..8b75efcd67ce 100644
--- a/tools/lib/perf/Documentation/libperf-counting.txt
+++ b/tools/lib/perf/Documentation/libperf-counting.txt
@@ -7,13 +7,13 @@ libperf-counting - counting interface
 
 DESCRIPTION
 -----------
-The counting interface provides API to meassure and get count for specific perf events.
+The counting interface provides API to measure and get count for specific perf events.
 
 The following test tries to explain count on `counting.c` example.
 
 It is by no means complete guide to counting, but shows libperf basic API for counting.
 
-The `counting.c` comes with libbperf package and can be compiled and run like:
+The `counting.c` comes with libperf package and can be compiled and run like:
 
 [source,bash]
 --
@@ -26,7 +26,8 @@ count 176242, enabled 176242, run 176242
 It requires root access, because of the `PERF_COUNT_SW_CPU_CLOCK` event,
 which is available only for root.
 
-The `counting.c` example monitors two events on the current process and displays their count, in a nutshel it:
+The `counting.c` example monitors two events on the current process and displays
+their count, in a nutshell it:
 
 * creates events
 * adds them to the event list
@@ -152,7 +153,7 @@ Configure event list with the thread map and open events:
 --
 
 Both events are created as disabled (note the `disabled = 1` assignment above),
-so we need to enable the whole list explicitely (both events).
+so we need to enable the whole list explicitly (both events).
 
 From this moment events are counting and we can do our workload.
 
@@ -167,7 +168,8 @@ When we are done we disable the events list.
  79         perf_evlist__disable(evlist);
 --
 
-Now we need to get the counts from events, following code iterates throught the events list and read counts:
+Now we need to get the counts from events, following code iterates through the
+events list and read counts:
 
 [source,c]
 --
@@ -178,7 +180,7 @@ Now we need to get the counts from events, following code iterates throught the
  85         }
 --
 
-And finaly cleanup.
+And finally cleanup.
 
 We close the whole events list (both events) and remove it together with the threads map:
 
diff --git a/tools/lib/perf/Documentation/libperf-sampling.txt b/tools/lib/perf/Documentation/libperf-sampling.txt
index d71a7b4fcf5f..d6ca24f6ef78 100644
--- a/tools/lib/perf/Documentation/libperf-sampling.txt
+++ b/tools/lib/perf/Documentation/libperf-sampling.txt
@@ -8,13 +8,13 @@ libperf-sampling - sampling interface
 
 DESCRIPTION
 -----------
-The sampling interface provides API to meassure and get count for specific perf events.
+The sampling interface provides API to measure and get count for specific perf events.
 
 The following test tries to explain count on `sampling.c` example.
 
 It is by no means complete guide to sampling, but shows libperf basic API for sampling.
 
-The `sampling.c` comes with libbperf package and can be compiled and run like:
+The `sampling.c` comes with libperf package and can be compiled and run like:
 
 [source,bash]
 --
@@ -33,7 +33,8 @@ cpu   0, pid   4465, tid   4470, ip         7f84fe0ebebf, period             176
 
 It requires root access, because it uses hardware cycles event.
 
-The `sampling.c` example profiles/samples all CPUs with hardware cycles, in a nutshel it:
+The `sampling.c` example profiles/samples all CPUs with hardware cycles, in a
+nutshell it:
 
 - creates events
 - adds them to the event list
@@ -90,7 +91,7 @@ Once the setup is complete we start by defining cycles event using the `struct p
  36         };
 --
 
-Next step is to prepare cpus map.
+Next step is to prepare CPUs map.
 
 In this case we will monitor all the available CPUs:
 
@@ -152,7 +153,7 @@ Once the events list is open, we can create memory maps AKA perf ring buffers:
 --
 
 The event is created as disabled (note the `disabled = 1` assignment above),
-so we need to enable the events list explicitely.
+so we need to enable the events list explicitly.
 
 From this moment the cycles event is sampling.
 
@@ -212,7 +213,7 @@ Each sample needs to get parsed:
 106                                 cpu, pid, tid, ip, period);
 --
 
-And finaly cleanup.
+And finally cleanup.
 
 We close the whole events list (both events) and remove it together with the threads map:
 
diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 5a6bb512789d..0c74c30ed23a 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -29,7 +29,7 @@ SYNOPSIS
   void libperf_init(libperf_print_fn_t fn);
 --
 
-*API to handle cpu maps:*
+*API to handle CPU maps:*
 
 [source,c]
 --
@@ -217,7 +217,7 @@ Following objects are key to the libperf interface:
 
 [horizontal]
 
-struct perf_cpu_map:: Provides a cpu list abstraction.
+struct perf_cpu_map:: Provides a CPU list abstraction.
 
 struct perf_thread_map:: Provides a thread list abstraction.
 
-- 
2.25.1

