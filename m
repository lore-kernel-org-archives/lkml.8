Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FFDC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B918320CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778694;
	bh=8mzaT6eitfbQESbuHF9yySGY0pxoqWPnaZp6wYNDBjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CnyOY2S+1id/En3iwolSKvkYsyZiMVBd/7y7qs5NjNDXBcjZZ8FUHY0H3ubMTkkQY
	 kJEuBEvBWeMd035XA4ji1quUniEbBOukZbOat+k0YfbeDK0V8eM24truJ20GNhBgBM
	 KfOee4ZIkESBSn/50huCCDzV15tPStv0BkbxZJiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgEFPYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbgEFPYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D9620A8B;
        Wed,  6 May 2020 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778690;
        bh=8mzaT6eitfbQESbuHF9yySGY0pxoqWPnaZp6wYNDBjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1SoV4vh2GR0TFKwDFq/i1DA9Ox8o8V5lOyNoOVpejx9JrIQ4+WnMuUs3N6e/0Qd2
         e+8FLt5CEMYM1BG8o1cvGn0koGxhHVCNmY6cLotyRNDUujqa/o7+FqQVDui+kT2acd
         pncn9uZoxazPYXXzFOeOLbeEQ+EoW0e1XDy5Fz5w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/91] perf parse-events: Fix memory leaks found on parse_events
Date:   Wed,  6 May 2020 12:21:37 -0300
Message-Id: <20200506152234.21977-35-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

free_list_evsel() deals with tools/perf/ evsels, not with libperf
perf_evsels, use the right destructor and avoid a leak, as
evsel__delete() will delete something perf_evsel__delete() doesn't.

Signed-off-by: Ian Rogers <irogers@google.com>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200319023101.82458-1-irogers@google.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e879eb257874..6ece67ed244a 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -44,7 +44,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 
 	list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
 		list_del_init(&evsel->core.node);
-		perf_evsel__delete(evsel);
+		evsel__delete(evsel);
 	}
 	free(list_evsel);
 }
-- 
2.21.1

