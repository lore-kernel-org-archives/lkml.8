Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F415C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCF321927
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579871;
	bh=hqTYac1zqlyJDPaAEG6Fyc+y1JupKz26eb4ITX31SLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RfdcL7MGlHeJU99Qtq7rmI3JCByFYQJA6KjVJvJX6ZD5hMvcCauBcakigBEFYVp8B
	 MzahnENiwofIhC26x3pXgNFD59Ggxm6GItXwR/QsA2qpvEy/k/QutkcvAqnBANBT+m
	 vI1fqfd+ZSGH8vgbDy6Ap9HTwkdxbwvaaZUnNJZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392553AbgFSPRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392519AbgFSPRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC95206DB;
        Fri, 19 Jun 2020 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579860;
        bh=hqTYac1zqlyJDPaAEG6Fyc+y1JupKz26eb4ITX31SLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=leAzHyOg79VsEBrn36ZVAbjeL+th7yduoQ4LEz2gBaI3hGjg93TLqhsHSur8xs+2Q
         k0WzeiJNqR+BFtm+H/XadjZyEkqORT28a5jjQMZSUaycJPf6MFBXfrmVgwYiOsftES
         +g2YRFMSL3Z0Ddni8CvpcGiqVGRL93SULRQ5vUyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 032/376] libperf evlist: Fix a refcount leak
Date:   Fri, 19 Jun 2020 16:29:10 +0200
Message-Id: <20200619141711.872753519@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit 4599d292128d89e4cf866a0ea9a9b047a2de8418 ]

Memory leaks found by applying LLVM's libfuzzer on the tools/perf
parse_events function.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200319023101.82458-2-irogers@google.com
[ Did a minor adjustment due to some other previous patch having already set evlist->all_cpus to NULL at perf_evlist__exit() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/perf/evlist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 5b9f2ca50591..62130d28652d 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -125,6 +125,7 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
 void perf_evlist__exit(struct perf_evlist *evlist)
 {
 	perf_cpu_map__put(evlist->cpus);
+	perf_cpu_map__put(evlist->all_cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
 	evlist->threads = NULL;
-- 
2.25.1



