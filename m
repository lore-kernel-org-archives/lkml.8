Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE8FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A42D218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383744;
	bh=B8TK3JQZYMUyhS8PYl5YqRDlU6E03SI5xl5k54AIv2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EAbo9JEhuqVBLefyhYFzuLNCHGadJKyYM49l64NJzyZR0+s8UcyVLE48ZEuo5pXde
	 +9MLRwfPgSLNmVZvFSJmZJkKnPx0nlAyut0dBGFAJG1k6bDOr6xoPQn0WFH/+l9oQK
	 ojzn4Ply5o2rh9ENlvQiDEIrh9+rKRZLFqrBd7z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgDTLzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgDTLzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:55:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C81EE21D94;
        Mon, 20 Apr 2020 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383740;
        bh=B8TK3JQZYMUyhS8PYl5YqRDlU6E03SI5xl5k54AIv2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yr0Ci0uK/uftbhRQxvsEpqtFCz0bckuMb6uH4AxDaMa3E2azn9mxSVigsMxNtSqcU
         DrMYMS8MBuWt46LD288bfU3JH/+2WiMchGW6vV1BBcI9UlkOgMzEfGghVvwtSe1NqT
         pfui3D+ngflKzW4K3DqKRZRa6wItRi91jrK5Bm7U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/60] perf intel-bts: Implement ->evsel_is_auxtrace() callback
Date:   Mon, 20 Apr 2020 08:52:43 -0300
Message-Id: <20200420115316.18781-28-acme@kernel.org>
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
Link: http://lore.kernel.org/lkml/20200401101613.6201-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-bts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 34cb380d19a3..059e1c805ed0 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -728,6 +728,15 @@ static void intel_bts_free(struct perf_session *session)
 	free(bts);
 }
 
+static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
+					struct evsel *evsel)
+{
+	struct intel_bts *bts = container_of(session->auxtrace, struct intel_bts,
+					     auxtrace);
+
+	return evsel->core.attr.type == bts->pmu_type;
+}
+
 struct intel_bts_synth {
 	struct perf_tool dummy_tool;
 	struct perf_session *session;
@@ -883,6 +892,7 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	bts->auxtrace.flush_events = intel_bts_flush;
 	bts->auxtrace.free_events = intel_bts_free_events;
 	bts->auxtrace.free = intel_bts_free;
+	bts->auxtrace.evsel_is_auxtrace = intel_bts_evsel_is_auxtrace;
 	session->auxtrace = &bts->auxtrace;
 
 	intel_bts_print_info(&auxtrace_info->priv[0], INTEL_BTS_PMU_TYPE,
-- 
2.21.1

