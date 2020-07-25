Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F812206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595679615;
	bh=KaTQvsTEIFtOB1cQHAsUX10SltS7lQqN3GpX7sQ5GPY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=O/H3vqhPoh5ODP/ycurqonOuTLRP5wit6cZmUX0sBC6jTbwGOTu2BAln2L3b0WGvi
	 2j1La2aCPSu4GDSQRaHpHdoYC0zmvOvVfKuhHRmNoLMwrRQI3ehW9n+L5mkju7JqPm
	 0e+K2PmLMJjwQ6OCF56bVwxcEc7F+XAJ57z1PtJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGYMUO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:20:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49518 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726613AbgGYMUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:20:13 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-OmdSWnoBOd-4mKuThhLMSQ-1; Sat, 25 Jul 2020 08:20:09 -0400
X-MC-Unique: OmdSWnoBOd-4mKuThhLMSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64777106B243;
        Sat, 25 Jul 2020 12:20:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E38E05D9DC;
        Sat, 25 Jul 2020 12:20:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2] perf tools: Allow r0x<HEX> event syntax
Date:   Sat, 25 Jul 2020 14:19:58 +0200
Message-Id: <20200725121959.1181869-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to specify raw event with 'r0<HEX>' syntax within
pmu term syntax like:

  -e cpu/r0xdead/

It will be used to specify raw events in cases where they conflict
with real pmu terms, like 'read', which is valid raw event syntax,
but also a possible pmu term name as reported by Jin Yao.

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-list.txt | 1 +
 tools/perf/tests/parse-events.c        | 5 +++++
 tools/perf/util/parse-events.l         | 1 +
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 376a50b3452d..10ed539a8859 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -119,6 +119,7 @@ It's also possible to use pmu syntax:
 
  perf record -e r1a8 -a sleep 1
  perf record -e cpu/r1a8/ ...
+ perf record -e cpu/r0x1a8/ ...
 
 You should refer to the processor specific documentation for getting these
 details. Some of them are referenced in the SEE ALSO section below.
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 895188b63f96..5aaddcb0058a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1766,6 +1766,11 @@ static struct evlist_test test__events_pmu[] = {
 		.check = test__checkevent_raw_pmu,
 		.id    = 4,
 	},
+	{
+		.name  = "software/r0x1a/",
+		.check = test__checkevent_raw_pmu,
+		.id    = 4,
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 56912c9641f5..44c85fea5d00 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -293,6 +293,7 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 r{num_raw_hex}		{ return raw(yyscanner); }
+r0x{num_raw_hex}	{ return raw(yyscanner); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-- 
2.25.4

