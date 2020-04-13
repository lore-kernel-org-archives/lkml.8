Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B13C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3BA2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586796853;
	bh=kjNU8gkJH0MuwVzru11aJkVZj5ZBZx/fNWrBzMDaFgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bjab8YrJMzuZkmiQJuHR6nEfCssylXj9CiiphqZypXu2XhC7/eAHEI7BBLlzS8+WX
	 A/DgAEwTLkzXZ3V77tu2mZKocxv9/nXXStjPLvMFZFXZrXcTyMoLLb5j1w31/YFXk/
	 Bh1zm8+SC61Ela4a8WrRqEtAiIMFy6O7iCEfy1Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbgDMQyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732081AbgDMQyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:54:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E64020780;
        Mon, 13 Apr 2020 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796841;
        bh=kjNU8gkJH0MuwVzru11aJkVZj5ZBZx/fNWrBzMDaFgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mz4uQ/YK8YJhnI/pvdkgxfXEZhFiWywHOmkozgRZ+gus4GkUjlWLtTm0WG7YuqvDU
         tsFKpHTvBTtY9DvzfeXM6KwKLULIhNPvANVBtkEdk2dYzbV0+EjdFIYuEcM0upa+WB
         ZX5kQXYXakwDCa+TPJ+4gKHaloLjk+/xC8f0U18g=
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
Subject: [PATCH 22/26] perf stat: Fix no metric header if --per-socket and --metric-only set
Date:   Mon, 13 Apr 2020 13:51:59 -0300
Message-Id: <20200413165203.1816-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We received a report that was no metric header displayed if --per-socket
and --metric-only were both set.

It's hard for script to parse the perf-stat output. This patch fixes this
issue.

Before:

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
  ^C
   Performance counter stats for 'system wide':

  S0        8                  2.6

         2.215270071 seconds time elapsed

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
  #           time socket cpus
       1.000411692 S0        8                  2.2
       2.001547952 S0        8                  3.4
       3.002446511 S0        8                  3.4
       4.003346157 S0        8                  4.0
       5.004245736 S0        8                  0.3

After:

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
  ^C
   Performance counter stats for 'system wide':

                               CPI
  S0        8                  2.1

         1.813579830 seconds time elapsed

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
  #           time socket cpus                  CPI
       1.000415122 S0        8                  3.2
       2.001630051 S0        8                  2.9
       3.002612278 S0        8                  4.3
       4.003523594 S0        8                  3.0
       5.004504256 S0        8                  3.7

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200331180226.25915-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 0fd713d3674f..03ecb8cd0eec 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -803,8 +803,11 @@ static void generic_metric(struct perf_stat_config *config,
 				     out->force_header ?
 				     (metric_name ? metric_name : name) : "", 0);
 		}
-	} else
-		print_metric(config, ctxp, NULL, NULL, "", 0);
+	} else {
+		print_metric(config, ctxp, NULL, NULL,
+			     out->force_header ?
+			     (metric_name ? metric_name : name) : "", 0);
+	}
 
 	for (i = 1; i < pctx.num_ids; i++)
 		zfree(&pctx.ids[i].name);
-- 
2.21.1

