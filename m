Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD896C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876CD21582
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778845;
	bh=Tl3ZyFcnDa1wqHqcv/TK8gS4EVnqeqFf+LKXKn/4wEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fJgQbAcF645VwOsyzRm+DKvsnDIAnHgM6APs2S5uhHJd5jQBOMkfpcuy25y6ft4Yv
	 qClZS8tmT6DFQA4gkPd0GRUfYy/kUTfuHm3Z5apBpvhpcgxRy+W0T1idgsVuvqY1ea
	 HhEWWcBXM9jNE/ryBF22LFg7PZR7W7QAAO4J01XQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgEFP1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbgEFP1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B5724954;
        Wed,  6 May 2020 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778838;
        bh=Tl3ZyFcnDa1wqHqcv/TK8gS4EVnqeqFf+LKXKn/4wEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvFQ94Ns81g27EPiRuPQ1u2Iz5ensoCE2+ztCcSiujaYIo1dYpoQ57SxG67M+tRli
         XJehKzxmkafCE2/wGJDSkofLXaGCrqwevw0d83g+l3Q0iJ7TLU5ADylW9Kanb134e8
         yoxEa8JqEYmaOO9IWpQhs9Y8Ksbe1ZANI5w9ZncQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 83/91] perf annotate: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date:   Wed,  6 May 2020 12:22:26 -0300
Message-Id: <20200506152234.21977-84-acme@kernel.org>
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
 tools/perf/builtin-annotate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index b0e5a30755ce..d3e5a84f87a2 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -212,11 +212,9 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int perf_evsel__add_sample(struct evsel *evsel,
-				  struct perf_sample *sample,
-				  struct addr_location *al,
-				  struct perf_annotate *ann,
-				  struct machine *machine)
+static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
+			     struct addr_location *al, struct perf_annotate *ann,
+			     struct machine *machine)
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry *he;
@@ -278,7 +276,7 @@ static int process_sample_event(struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    perf_evsel__add_sample(evsel, sample, &al, ann, machine)) {
+	    evsel__add_sample(evsel, sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.21.1

