Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB73EC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08A920787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503551AbgDPJMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502363AbgDPIb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADFBC025483;
        Thu, 16 Apr 2020 01:31:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOzvp-0000qW-7L; Thu, 16 Apr 2020 10:31:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB17A1C0481;
        Thu, 16 Apr 2020 10:31:29 +0200 (CEST)
Date:   Thu, 16 Apr 2020 08:31:29 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf stat: Fix no metric header if --per-socket
 and --metric-only set
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200331180226.25915-1-yao.jin@linux.intel.com>
References: <20200331180226.25915-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158702588951.28353.3843175338082747310.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8358f698ec9d8467ad00c045e4d83c3e4acc7db4
Gitweb:        https://git.kernel.org/tip/8358f698ec9d8467ad00c045e4d83c3e4acc7db4
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Wed, 01 Apr 2020 02:02:26 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Apr 2020 08:49:26 -03:00

perf stat: Fix no metric header if --per-socket and --metric-only set

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
index 0fd713d..03ecb8c 100644
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
