Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B20C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337602220A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587075262;
	bh=GxZQfPfLWVM3GiXkfRMb5hzBGoNR1/BGxlJTbhYRfAg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AYO+dW06KG62N+3K8n8oQBDdSfdfBn0EXLA+Gtat+DBAGBYHTW+q+pNHGtmi8ODqI
	 qhzF4Wy+xjbTgvIAIyTpZfvIGS4G+4WLSqrtdMrA/domM0+XlWKLHC4Pg+JzhSPjmR
	 AtOf9UL6Zu/Y70+cv8MuLOm4WXbHIaGXG2utSdtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgDPWOU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57887 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728918AbgDPWOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:14:20 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-iy6EfzOFMNWUpHa7q905TA-1; Thu, 16 Apr 2020 18:14:11 -0400
X-MC-Unique: iy6EfzOFMNWUpHa7q905TA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29A19800D53;
        Thu, 16 Apr 2020 22:14:09 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B9AE1000325;
        Thu, 16 Apr 2020 22:14:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH] perf tools: Add support to specify rXXX event withing pmu
Date:   Fri, 17 Apr 2020 00:14:05 +0200
Message-Id: <20200416221405.437788-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

The current rXXXX event specification creates event under
PERF_TYPE_RAW pmu type. This change allows to use rXXXX
within pmu syntax, so it's type is used via following
syntax:

  -e 'cpu/r3c/'
  -e 'cpum_cf/r0/'

The XXXX number goes directly to perf_event_attr::config the
same way as in '-e rXXXX' event. The perf_event_attr::type is
filled with pmu type.

Requested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.25.2

