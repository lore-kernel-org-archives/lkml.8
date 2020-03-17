Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DDBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289012075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480870;
	bh=WDzW/6IlXlzFq93dLLRrCKazbLkCKNesXVlVIJMJvE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLCB2bdcNP7fJJsgb1SJRyJgIO5OnGZ0yOo8/E5VCR15NZ5hknLnjtryvlME+Vsr4
	 5ck5R8TP0Kf2zsR2yGXgPS0JkIrIw0JcgljVmGpCviVuw60LedDbO3ZGNs8XXd77/A
	 GtC+EDN4HIoJ6wXeQX9AeyziEIBW8YCy/vB8rlMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgCQVe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbgCQVe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D75442076E;
        Tue, 17 Mar 2020 21:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480867;
        bh=WDzW/6IlXlzFq93dLLRrCKazbLkCKNesXVlVIJMJvE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpk8OS+9YgFVEdDPn9z6nGEe0ovR4NN81wYTJBWI2PJZflS+AqS3NcPhot9r8GwzH
         8f9PEN5xeaKDuqdqG/PVbUCkpSpM+kbFdA+lyl6ZqkDBvmF6R6KXZnAi1D2lkuZsqZ
         XQm4nSfAaqXzUl8WkKCPyaNlKD1xhVDhlyfhS6VU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/23] perf report: Fix no branch type statistics report issue
Date:   Tue, 17 Mar 2020 18:32:58 -0300
Message-Id: <20200317213259.15494-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previously we could get the report of branch type statistics.

For example:

  # perf record -j any,save_type ...
  # t perf report --stdio

  #
  # Branch Statistics:
  #
  COND_FWD:  40.6%
  COND_BWD:   4.1%
  CROSS_4K:  24.7%
  CROSS_2M:  12.3%
      COND:  44.7%
    UNCOND:   0.0%
       IND:   6.1%
      CALL:  24.5%
       RET:  24.7%

But now for the recent perf, it can't report the branch type statistics.

It's a regression issue caused by commit 40c39e304641 ("perf report: Fix
a no annotate browser displayed issue"), which only counts the branch
type statistics for browser mode.

This patch moves the branch_type_count() outside of ui__has_annotation()
checking, then branch type statistics can work for stdio mode.

Fixes: 40c39e304641 ("perf report: Fix a no annotate browser displayed issue")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200313134607.12873-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index d7c905f7520f..5f4045df76f4 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -186,24 +186,23 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 {
 	struct hist_entry *he = iter->he;
 	struct report *rep = arg;
-	struct branch_info *bi;
+	struct branch_info *bi = he->branch_info;
 	struct perf_sample *sample = iter->sample;
 	struct evsel *evsel = iter->evsel;
 	int err;
 
+	branch_type_count(&rep->brtype_stat, &bi->flags,
+			  bi->from.addr, bi->to.addr);
+
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 	if (err)
 		goto out;
 
 	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
 
-	branch_type_count(&rep->brtype_stat, &bi->flags,
-			  bi->from.addr, bi->to.addr);
-
 out:
 	return err;
 }
-- 
2.21.1

