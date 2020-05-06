Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE39C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27902068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778849;
	bh=CLSFyALrlVJZrnCPxP/hiiDK2uLWWJpb9CJtBS1rbEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tO9LsskUpwTAJLuQ78nPn1OTw1mphD69WKW+loDjFpFG3425KfPDFgwe20AgirD/N
	 T9H9vt9jE9iWe3mbeU+IQaPhtXyt+Gx+x9t1t2eTaX7CG+OOx9P82dM6LU1NJLsHWB
	 CfIUHADyp8ynFqVtmW0xLLCckPxGSHDWPIPtMJa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgEFP11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbgEFP1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC002068E;
        Wed,  6 May 2020 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778840;
        bh=CLSFyALrlVJZrnCPxP/hiiDK2uLWWJpb9CJtBS1rbEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxLhz90pkibTVaRl6Ry7sdgS91MgREjOZmJJ6Il12b+nQusZTxlIsiJqaURBYsv4j
         JwDOlvhTIr0hSKcr/0qcpEcOZIkehtBRyv/aRMISUr/mjpikkhBRM6+tLKd1obCukJ
         Q4XY6p96p9E/MdZ2Bf9S6cv8Kaavfl3+yGM6U6o4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 84/91] perf inject: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date:   Wed,  6 May 2020 12:22:27 -0300
Message-Id: <20200506152234.21977-85-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index aad007bfb581..53932db97a79 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -561,8 +561,7 @@ static void sig_handler(int sig __maybe_unused)
 	session_done = 1;
 }
 
-static int perf_evsel__check_stype(struct evsel *evsel,
-				   u64 sample_type, const char *sample_msg)
+static int evsel__check_stype(struct evsel *evsel, u64 sample_type, const char *sample_msg)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	const char *name = evsel__name(evsel);
@@ -625,7 +624,7 @@ static int __cmd_inject(struct perf_inject *inject)
 			const char *name = evsel__name(evsel);
 
 			if (!strcmp(name, "sched:sched_switch")) {
-				if (perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
+				if (evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
 					return -EINVAL;
 
 				evsel->handler = perf_inject__sched_switch;
-- 
2.21.1

