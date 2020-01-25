Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98FEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898312071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="dcevVc3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgAYQLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:11:04 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:35168 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgAYQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:11:02 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 8E5C82E12EE;
        Sat, 25 Jan 2020 19:10:59 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id ckiFFFI2uC-Ax3CXLwZ;
        Sat, 25 Jan 2020 19:10:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1579968659; bh=44fHVouwi5LD9SCyellukLtpG8f0/zZLKzv9A7Sq6Pc=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=dcevVc3lNxcETA/MScN7EA4EJ7gbyN5C6lL+1gVzc87rh4rIc1b4omLtRGGzdWwfI
         3a2fhZY/z323MyanYlarsqHRYjJWM/ubw8xcrZEXkd4JbfSnnnwz9BGXBqhNh7igWG
         2Lqgcg5RTAO/GlenBrhkYYO1d7jaObd15emourpg=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6910::1:5])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id V9Khqo05OL-AxWaIBKm;
        Sat, 25 Jan 2020 19:10:59 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/2] perf evswitch: Add --switch-on-delay/--switch-off-delay
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Sat, 25 Jan 2020 19:10:58 +0300
Message-ID: <157996865889.8036.14494483070194089718.stgit@buzz>
In-Reply-To: <157996865709.8036.5145089242955353200.stgit@buzz>
References: <157996865709.8036.5145089242955353200.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events set by --switch-on/--switch-off make effect immediately. This patch
adds controllable delay for them. Repeated switch event restarts delay.
This allows collect samples while periodic signal pulses (switch-off-delay)
or start when pulse stops beating (switch-on-delay).

This example highlights where IRQs are disabled longer than for 5ms.
Cycles is a NMI samples by PMU and cpu-clock is a software timer samples:
when cpu-clock stops ticking this means IRQs are disabled.

# perf top -C 0 --event cycles --event cpu-clock --switch-on cpu-clock
 --switch-on-delay 5 --switch-off cpu-clock --sort symbol -g -F 1000 -d 10

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/perf/Documentation/perf-report.txt |    6 ++++++
 tools/perf/Documentation/perf-script.txt |    6 ++++++
 tools/perf/Documentation/perf-top.txt    |    6 ++++++
 tools/perf/Documentation/perf-trace.txt  |    6 ++++++
 tools/perf/builtin-report.c              |    2 +-
 tools/perf/builtin-script.c              |    2 +-
 tools/perf/builtin-top.c                 |    2 +-
 tools/perf/builtin-trace.c               |    2 +-
 tools/perf/util/evswitch.c               |   22 ++++++++++++++++++----
 tools/perf/util/evswitch.h               |    9 ++++++++-
 10 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8dbe2119686a..b83c0f700345 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -448,6 +448,12 @@ OPTIONS
 --switch-off EVENT_NAME::
 	Stop considering events after this event is found.
 
+--switch-on-delay::
+	Msecs to delay switch-on after last ocurrence of on-event.
+
+--switch-off-delay::
+	Msecs to delay switch-off after last ocurrence of off-event.
+
 --show-on-off-events::
 	Show the --switch-on/off events too. This has no effect in 'perf report' now
 	but probably we'll make the default not to show the switch-on/off events
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b057e47b..ba3dbe64f1e5 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -423,6 +423,12 @@ include::itrace.txt[]
 --switch-off EVENT_NAME::
 	Stop considering events after this event is found.
 
+--switch-on-delay::
+	Msecs to delay switch-on after last ocurrence of on-event.
+
+--switch-off-delay::
+	Msecs to delay switch-off after last ocurrence of off-event.
+
 --show-on-off-events::
 	Show the --switch-on/off events too.
 
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 5596129a71cf..0fe1795f62fb 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -297,6 +297,12 @@ Default is to monitor all CPUS.
 --switch-off EVENT_NAME::
 	Stop considering events after this event is found.
 
+--switch-on-delay::
+	Msecs to delay switch-on after last ocurrence of on-event.
+
+--switch-off-delay::
+	Msecs to delay switch-off after last ocurrence of off-event.
+
 --show-on-off-events::
 	Show the --switch-on/off events too. This has no effect in 'perf top' now
 	but probably we'll make the default not to show the switch-on/off events
diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index abc9b5d83312..df9e9333fc39 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -191,6 +191,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 --switch-off EVENT_NAME::
 	Stop considering events after this event is found.
 
+--switch-on-delay::
+	Msecs to delay switch-on after last ocurrence of on-event.
+
+--switch-off-delay::
+	Msecs to delay switch-off after last ocurrence of off-event.
+
 --show-on-off-events::
 	Show the --switch-on/off events too.
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f03120c641c0..451bf03120b7 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -261,7 +261,7 @@ static int process_sample_event(struct perf_tool *tool,
 	if (rep->cpu_list && !test_bit(sample->cpu, rep->cpu_bitmap))
 		return 0;
 
-	if (evswitch__discard(&rep->evswitch, evsel))
+	if (evswitch__discard(&rep->evswitch, evsel, sample->time))
 		return 0;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e2406b291c1c..ba7b08126e72 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1861,7 +1861,7 @@ static void process_event(struct perf_script *script,
 	if (!show_event(sample, evsel, thread, al))
 		return;
 
-	if (evswitch__discard(&script->evswitch, evsel))
+	if (evswitch__discard(&script->evswitch, evsel, sample->time))
 		return;
 
 	++es->samples;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 795e353de095..daea6934a97b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1151,7 +1151,7 @@ static int deliver_event(struct ordered_events *qe,
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
-		if (evswitch__discard(&top->evswitch, evsel))
+		if (evswitch__discard(&top->evswitch, evsel, sample.time))
 			return 0;
 		++top->samples;
 	}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 46a72ecac427..51478d64752e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3083,7 +3083,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 		return;
 	}
 
-	if (evswitch__discard(&trace->evswitch, evsel))
+	if (evswitch__discard(&trace->evswitch, evsel, sample->time))
 		return;
 
 	trace__set_base_time(trace, evsel, sample);
diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index 3ba72f743d3c..6573e91fabdc 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -3,26 +3,40 @@
 
 #include "evswitch.h"
 #include "evlist.h"
+#include <linux/time64.h>
 
-bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
+bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel, u64 time)
 {
-	if (evswitch->on && evswitch->discarding) {
+	bool discard = evswitch->discarding ||
+		perf_time__skip_sample(&evswitch->time_range, time);
+
+	if (evswitch->on && discard) {
 		if (evswitch->on != evsel)
 			return true;
 
 		evswitch->discarding = false;
 
+		if (evswitch->on_delay) {
+			evswitch->time_range.start = time +
+				evswitch->on_delay * NSEC_PER_MSEC;
+			evswitch->time_range.end = 0;
+		}
+
 		if (!evswitch->show_on_off_events)
 			return true;
 
 		return false;
 	}
 
-	if (evswitch->off && !evswitch->discarding) {
+	if (evswitch->off && !discard) {
 		if (evswitch->off != evsel)
 			return false;
 
-		evswitch->discarding = true;
+		if (evswitch->off_delay)
+			evswitch->time_range.end = time +
+				evswitch->off_delay * NSEC_PER_MSEC;
+		else
+			evswitch->discarding = true;
 
 		if (!evswitch->show_on_off_events)
 			return true;
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index fd30460b6218..2746082c7dc9 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -5,6 +5,7 @@
 
 #include <stdbool.h>
 #include <stdio.h>
+#include "util/time-utils.h"
 
 struct evsel;
 struct evlist;
@@ -12,19 +13,25 @@ struct evlist;
 struct evswitch {
 	struct evsel *on, *off;
 	const char   *on_name, *off_name;
+	unsigned int on_delay, off_delay;
 	bool	     discarding;
+	struct perf_time_interval time_range;
 	bool	     show_on_off_events;
 };
 
 int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp);
 
-bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
+bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel, u64 time);
 
 #define OPTS_EVSWITCH(evswitch)								  \
 	OPT_STRING(0, "switch-on", &(evswitch)->on_name,				  \
 		   "event", "Consider events after the ocurrence of this event"),	  \
 	OPT_STRING(0, "switch-off", &(evswitch)->off_name,				  \
 		   "event", "Stop considering events after the ocurrence of this event"), \
+	OPT_UINTEGER(0, "switch-on-delay", &(evswitch)->on_delay,			  \
+		   "ms to delay switch-on after last ocurrence of on-event"),	  \
+	OPT_UINTEGER(0, "switch-off-delay", &(evswitch)->off_delay,			  \
+		   "ms to delay switch-off after last ocurrence of off-event"),  \
 	OPT_BOOLEAN(0, "show-on-off-events", &(evswitch)->show_on_off_events,		  \
 		    "Show the on/off switch events, used with --switch-on and --switch-off")
 

