Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F186C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E5424957
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778584;
	bh=3poGCfoHv6RLLha8vGccUZROKWq5eBnytzRzET+Ssd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ikrFM2QaxHmldvfJXBm+BHaQzl+jSc4WM+NQNg6n+FbyiH6rl3ceRzaSBkg8n+Ofa
	 QphHLhBEtvzLR8YXuLrN+46PyewcKHwpodCP0X73ol8e+nYs5NCWbt5ruWdDKD4BXt
	 1LgAfOEnjFwuBxPweQzCtp6kwsD62hPaYNZu+aG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgEFPXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgEFPXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C5C21582;
        Wed,  6 May 2020 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778580;
        bh=3poGCfoHv6RLLha8vGccUZROKWq5eBnytzRzET+Ssd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXT998eti5eWUvuxsbgcaCP35OWxFGXlHvTcR7T3W9ef3T/KYY1lzj9InLqN36m4W
         /4vsgre181tKIVSRJ8FlJFP0rars9nU0+D940z9hJk2nV/5WAW6BOwPw+7C6soTuR7
         XKJp1eaEk1Kh66mGyLafJjrJt2q50ZHwTIhUgrhg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/91] perf stat: Zero all the 'ena' and 'run' array slot stats for interval mode
Date:   Wed,  6 May 2020 12:21:08 -0300
Message-Id: <20200506152234.21977-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

As the code comments in perf_stat_process_counter() say, we calculate
counter's data every interval, and the display code shows ps->res_stats
avg value. We need to zero the stats for interval mode.

But the current code only zeros the res_stats[0], it doesn't zero the
res_stats[1] and res_stats[2], which are for ena and run of counter.

This patch zeros the whole res_stats[] for interval mode.

Fixes: 51fd2df1e882 ("perf stat: Fix interval output values")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200409070755.17261-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5f26137b8d60..242476eb808c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -368,8 +368,10 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	 * interval mode, otherwise overall avg running
 	 * averages will be shown for each interval.
 	 */
-	if (config->interval)
-		init_stats(ps->res_stats);
+	if (config->interval) {
+		for (i = 0; i < 3; i++)
+			init_stats(&ps->res_stats[i]);
+	}
 
 	if (counter->per_pkg)
 		zero_per_pkg(counter);
-- 
2.21.1

