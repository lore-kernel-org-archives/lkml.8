Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80427C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA17206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383817;
	bh=U4eJSc8TgHW9W+/DL/Cn7uZVr23BQIsJEfDEdoHZsHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y4Koh3dWaMWinDJ6Lnl1LFztUvuW+ge/pa3Tmug2x8kNzzK9sO37j0kRGVsAJ4//W
	 UMhnOs10GuUGqboL2LF2aMtope4h3fnp4sUVbhPByMwACZTOTTPKoNLf54ER4Fqjc7
	 o34uMstfr4pcd9XeaLjXGeNTouP4OniN9bgkpJRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDTL44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgDTL4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28317218AC;
        Mon, 20 Apr 2020 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383808;
        bh=U4eJSc8TgHW9W+/DL/Cn7uZVr23BQIsJEfDEdoHZsHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+x2Ul1eZi7vB9Y5bUOHpzcXbCCLStAB8+8TD7Z8z7/hM7GcTr/GcDkgyn6vfewU5
         beozZJ+tEB92F+4K2h/rd6a1aWnd/9ufOtYtZaS8yLyUV1t294wPUhavuIAmAAkOTx
         PXZn+dbbPizW+kZg8FJnVHbWAc56AaG7JZGR+jXM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 46/60] perf parser: Add support to specify rXXX event with pmu
Date:   Mon, 20 Apr 2020 08:53:02 -0300
Message-Id: <20200420115316.18781-47-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

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
index cb23667531ab..376a50b3452d 100644
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
index 091c3aeccc27..902bd9d591a0 100644
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
index baa48f28d57d..c589fc42f058 100644
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
index 94f8bcd83582..e879eb257874 100644
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
-- 
2.21.1

