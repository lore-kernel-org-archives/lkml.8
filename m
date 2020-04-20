Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29B0C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93144218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383741;
	bh=4Ibcbil+kVZDtrWxqM+PwTKg7AVpk/st230fd46atPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rohyw/bWcSsayk9BnZdEn1MO4HhJNNUh2XZRorhIHeh9XI/RR2Y0o0GSXl+VZSnWF
	 uyZEDjuxgqg39SZrqmzTq1SH8Y+cyU7UfOXKxY/AZT9Xu7tlJgADUqfcGbCyfZ6lv1
	 qdL3lP/EEePEkyXBiInPLpMTdsoBuRHYpQmPVlEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgDTLzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgDTLzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:55:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2252071C;
        Mon, 20 Apr 2020 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383737;
        bh=4Ibcbil+kVZDtrWxqM+PwTKg7AVpk/st230fd46atPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pt5Yp3mXyoYFsFMNs2rEJLJHLEBv3wXcVrthdkrZ/tdR7a0mJnAVsYFvwMbAIhjpk
         T2QarmCizDDuaQDV4o+ck+zm7AB0FrQlQ9F9rOvofptxzRal7pYQ1JUdb2X4N6Kf29
         Cn+mlQe70NcrvBJYMxpCVUQPd1EXAzkzvLiq5p2g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/60] perf intel-pt: Implement ->evsel_is_auxtrace() callback
Date:   Mon, 20 Apr 2020 08:52:42 -0300
Message-Id: <20200420115316.18781-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 23c8289c2472..db25c77d82f3 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2715,6 +2715,15 @@ static void intel_pt_free(struct perf_session *session)
 	free(pt);
 }
 
+static bool intel_pt_evsel_is_auxtrace(struct perf_session *session,
+				       struct evsel *evsel)
+{
+	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
+					   auxtrace);
+
+	return evsel->core.attr.type == pt->pmu_type;
+}
+
 static int intel_pt_process_auxtrace_event(struct perf_session *session,
 					   union perf_event *event,
 					   struct perf_tool *tool __maybe_unused)
@@ -3310,6 +3319,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	pt->auxtrace.flush_events = intel_pt_flush;
 	pt->auxtrace.free_events = intel_pt_free_events;
 	pt->auxtrace.free = intel_pt_free;
+	pt->auxtrace.evsel_is_auxtrace = intel_pt_evsel_is_auxtrace;
 	session->auxtrace = &pt->auxtrace;
 
 	if (dump_trace)
-- 
2.21.1

