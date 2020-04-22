Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76155C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83ADC20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgDVMRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbgDVMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6AC03C1A8;
        Wed, 22 Apr 2020 05:17:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJZ-0007gE-E2; Wed, 22 Apr 2020 14:17:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0EBB91C02FC;
        Wed, 22 Apr 2020 14:17:17 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:16 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf parser: Add support to specify rXXX event with pmu
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416221405.437788-1-jolsa@kernel.org>
References: <20200416221405.437788-1-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158755783661.28353.6391984772128473787.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3a6c51e4d66cf2fbc05583247b2d2f1179e8a74c
Gitweb:        https://git.kernel.org/tip/3a6c51e4d66cf2fbc05583247b2d2f1179e8a74c
Author:        Jiri Olsa <jolsa@redhat.com>
AuthorDate:    Fri, 17 Apr 2020 00:14:05 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf parser: Add support to specify rXXX event with pmu

The current rXXXX event specification creates event under PERF_TYPE_RAW
pmu type. This change allows to use rXXXX within pmu syntax, so it's
type is used via the following syntax:

  -e 'cpu/r3c/'
  -e 'cpum_cf/r0/'

The XXXX number goes directly to perf_event_attr::config the same way as
in '-e rXXXX' event. The perf_event_attr::type is filled with pmu type.

Committer testing:

So, lets see what goes in perf_event_attr::config for, say, the
'instructions' PERF_TYPE_HARDWARE (0) event, first we should look at how
to encode this event as a PERF_TYPE_RAW event for this specific CPU, an
AMD Ryzen 5:

  # cat /sys/devices/cpu/events/instructions
  event=0xc0
  #

Then try with it _and_ the instruction, just to see that they are close
enough:

  # perf stat -e rc0,instructions sleep 1

   Performance counter stats for 'sleep 1':

             919,794      rc0
             919,898      instructions

         1.000754579 seconds time elapsed

         0.000715000 seconds user
         0.000000000 seconds sys
  #

Now we should try, before this patch, the PMU event encoding:

  # perf stat -e cpu/rc0/ sleep 1
  event syntax error: 'cpu/rc0/'
                           \___ unknown term

  valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,percore
  #

Now with this patch, the three ways of specifying the 'instructions' CPU
counter are accepted:

  # perf stat -e cpu/rc0/,rc0,instructions sleep 1

   Performance counter stats for 'sleep 1':

             892,948      cpu/rc0/
             893,052      rc0
             893,156      instructions

         1.000931819 seconds time elapsed

         0.000916000 seconds user
         0.000000000 seconds sys

  #

Requested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200416221405.437788-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt |  5 +++++
 tools/perf/tests/parse-events.c        | 17 ++++++++++++++++-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/parse-events.y         |  9 +++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index cb23667..376a50b 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -115,6 +115,11 @@ raw encoding of 0x1A8 can be used:
  perf stat -e r1a8 -a sleep 1
  perf record -e r1a8 ...
 
+It's also possible to use pmu syntax:
+
+ perf record -e r1a8 -a sleep 1
+ perf record -e cpu/r1a8/ ...
+
 You should refer to the processor specific documentation for getting these
 details. Some of them are referenced in the SEE ALSO section below.
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 091c3ae..902bd9d 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1356,6 +1356,16 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 	return 0;
 }
 
+static int test__checkevent_raw_pmu(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	return 0;
+}
+
 static int test__sym_event_slash(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -1750,7 +1760,12 @@ static struct evlist_test test__events_pmu[] = {
 		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.check = test__checkevent_complex_name,
 		.id    = 3,
-	}
+	},
+	{
+		.name  = "software/r1a/",
+		.check = test__checkevent_raw_pmu,
+		.id    = 4,
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index baa48f2..c589fc4 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -286,6 +286,7 @@ no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
+r{num_raw_hex}		{ return raw(yyscanner); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 94f8bcd..e879eb2 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -706,6 +706,15 @@ event_term
 }
 
 event_term:
+PE_RAW
+{
+	struct parse_events_term *term;
+
+	ABORT_ON(parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_CONFIG,
+					NULL, $1, false, &@1, NULL));
+	$$ = term;
+}
+|
 PE_NAME '=' PE_NAME
 {
 	struct parse_events_term *term;
