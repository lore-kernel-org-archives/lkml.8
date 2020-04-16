Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFBFC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3075D20857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437723AbgDPQVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:21:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:24257 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405707AbgDPQVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:21:30 -0400
IronPort-SDR: cx837X40+qVtFt2KbdS4sifpGIp2faYRbVnEscVncFFntOrBkB1Zk8vXvvXc5xv64LZhVcloVm
 Aw3sgkphw7/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:21:29 -0700
IronPort-SDR: MUpfP6odjF0JmE7yBQEnKYqWp82J/1I5DsHVtGe9n3He3T/wGVi+0+UwRr1IN3OuEuXhHv2/A3
 OoBv5VZQjNIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="253915577"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2020 09:21:29 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5FC583018C4; Thu, 16 Apr 2020 09:21:29 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1] perf parse: Avoid false uncore matches
Date:   Thu, 16 Apr 2020 09:21:19 -0700
Message-Id: <20200416162119.619956-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The PMU matching adds an implicit '*' to match multiple instances of PMUs.
But this causes problems when the user specified an explicit number,
in this case longer numbers with the same prefix could be matched too,
which is not intended.

Check for the number case and avoid the extra wildcard.

Also this fixes a memory leak with the pattern match. We would not
free the allocated pattern.

Before:

$ perf stat --no-merge -e cha_1// -a sleep 1

 Performance counter stats for 'system wide':

       698,393,431      uncore_cha_1//
       698,395,491      uncore_cha_14//
       698,393,873      uncore_cha_12//
       698,392,975      uncore_cha_10//
       698,391,167      uncore_cha_17//
       698,390,371      uncore_cha_15//
       698,389,007      uncore_cha_13//
       698,388,069      uncore_cha_11//
       698,386,991      uncore_cha_16//

       1.001343184 seconds time elapsed

After

$ ./perf stat --no-merge -e cha_1// -a sleep 1

 Performance counter stats for 'system wide':

       741,490,611      uncore_cha_1//

       1.000847326 seconds time elapsed

$

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/parse-events.y | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 94f8bcd83582..f38c90756476 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -286,7 +286,8 @@ PE_NAME opt_pmu_config
 		parse_events_terms__delete(orig_terms);	\
 		free(list);				\
 		free($1);				\
-		free(pattern);				\
+		if ($1 != pattern)			\
+			free(pattern);			\
 		YYABORT;				\
 	} while(0)
 
@@ -303,7 +304,9 @@ PE_NAME opt_pmu_config
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
-		if (asprintf(&pattern, "%s*", $1) < 0)
+		if ($1[0] && isdigit($1[strlen($1) - 1]))
+			pattern = $1;
+		else if (asprintf(&pattern, "%s*", $1) < 0)
 			CLEANUP_YYABORT;
 
 		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
@@ -320,6 +323,8 @@ PE_NAME opt_pmu_config
 				parse_events_terms__delete(terms);
 			}
 		}
+		if ($1 != pattern)
+			free(pattern);
 
 		if (!ok)
 			CLEANUP_YYABORT;
-- 
2.24.1

