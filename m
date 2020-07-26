Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60EAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD32720658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595749984;
	bh=xyERqov+T7Gr8JD4LEPjEGWkplunt9RzwEon8Qr9zCM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gCvxWBKSRc4UwWSSoswOTYoxgQ6NPk+McSm7u/qFuXA/+StrNqZodn5Ehkj8mFAhA
	 qs3i3agvfvXH8DEftU0SR8UYOhpLjyVncwenWNUZrkgE0bQWLDRDc8b57D0tQkfsB7
	 65LnBY2JZvW1Qy98eKOlTc4TADm6VCzpr2WQUUZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGZHw6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:52:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgGZHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:52:57 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-gVKgZ9nPPTypYmXIln7SRA-1; Sun, 26 Jul 2020 03:52:50 -0400
X-MC-Unique: gVKgZ9nPPTypYmXIln7SRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 819318017FB;
        Sun, 26 Jul 2020 07:52:48 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A04F560BEC;
        Sun, 26 Jul 2020 07:52:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCHv2 1/2] perf tools: Allow r0x<HEX> event syntax
Date:   Sun, 26 Jul 2020 09:52:43 +0200
Message-Id: <20200726075244.1191481-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Acked-by: Ian Rogers <irogers@google.com>
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

