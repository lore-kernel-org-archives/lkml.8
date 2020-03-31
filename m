Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB04C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93912145D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgDABaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:30:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:12721 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731588AbgDABaQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 21:30:16 -0400
IronPort-SDR: atMNJzQbiAD9/0pQRguxCjE4r0xut++via/Usws1avYTDyii1F4znAPdBFlQ7J+jssE/KQ7w5c
 sP6cgyCrbCdw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 18:30:15 -0700
IronPort-SDR: Wdg65KYjrayINv+syHGqV/dhqyBK+pNZ+A0IvwDBAMhGPs4RsSPGuF7vQDYdvk/KfxZzilJe1s
 /MOpN9efi1kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,329,1580803200"; 
   d="scan'208";a="272969363"
Received: from kbl-ppc.sh.intel.com ([10.239.159.47])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2020 18:30:13 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Fix no metric header if --per-socket and --metric-only set
Date:   Wed,  1 Apr 2020 02:02:26 +0800
Message-Id: <20200331180226.25915-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.17.1

