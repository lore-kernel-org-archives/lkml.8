Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A1C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5ED42068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778903;
	bh=LQDTzOd/ysvnrBZ6lZ6sOLo2BASgBis6FcwBPgV1Feo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AV/iFM8XCb0Fcr13W3zItRIIAwmD8Jx0FpCsTSNuA9iaq7qq+kiE4s7FkRAhKJ9Yu
	 1F6Wi6QVzwbnziDYGwtHqMJ+73TxNYKAf+NBOw25+xci9T336Q8FP7oX9AaIypqlUK
	 lzj83jp990Z7YRlusAglh9vdxgNoLd92QB094ric=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgEFP0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbgEFP0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF7F21744;
        Wed,  6 May 2020 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778800;
        bh=LQDTzOd/ysvnrBZ6lZ6sOLo2BASgBis6FcwBPgV1Feo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B10jqUxIo8eQZ+DtHhRsF9z8TUSw20EYDExwMV64hrqvA2SUT4YTddR13hh8DujgV
         tVph7KEnk75Tbp74ikQ68qLp2uFECRsb9JM/ebv0MaFi5NqMEKlQPJtu/eUS0Noxo0
         2i6d3tsSDmhnAENcL4CyvEhhBwiJ4V1jUK6LYOTw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 68/91] perf evsel: Ditch perf_evsel__cmp(), not used for quite a while
Date:   Wed,  6 May 2020 12:22:11 -0300
Message-Id: <20200506152234.21977-69-acme@kernel.org>
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

In 4c358d5cf361 ("perf stat: Replace transaction event possition check
with id check") all its uses were removed, so ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4246cadaf96e..8d61109087a1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -265,12 +265,6 @@ static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
 	       (e1->core.attr.config == e2->core.attr.config);
 }
 
-#define perf_evsel__cmp(a, b)			\
-	((a) &&					\
-	 (b) &&					\
-	 (a)->core.attr.type == (b)->core.attr.type &&	\
-	 (a)->core.attr.config == (b)->core.attr.config)
-
 int perf_evsel__read_counter(struct evsel *evsel, int cpu, int thread);
 
 int __perf_evsel__read_on_cpu(struct evsel *evsel,
-- 
2.21.1

