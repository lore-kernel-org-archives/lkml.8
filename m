Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE36C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBE32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgCKMV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:21:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:31410 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgCKMVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:21:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 05:21:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="234694363"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga007.fm.intel.com with ESMTP; 11 Mar 2020 05:21:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf intel-pt: Add Intel PT man page references
Date:   Wed, 11 Mar 2020 14:20:33 +0200
Message-Id: <20200311122034.3697-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311122034.3697-1-adrian.hunter@intel.com>
References: <20200311122034.3697-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add references to Intel PT man page in man pages of associated tools.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-inject.txt   | 3 ++-
 tools/perf/Documentation/perf-intel-pt.txt | 7 +++++++
 tools/perf/Documentation/perf-record.txt   | 2 +-
 tools/perf/Documentation/perf-report.txt   | 3 ++-
 tools/perf/Documentation/perf-script.txt   | 2 +-
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index a64d6588470e..70969ea73e01 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -66,4 +66,5 @@ include::itrace.txt[]
 
 SEE ALSO
 --------
-linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1]
+linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1],
+linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 7d743a98a9c1..456fdcbf26ac 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -998,3 +998,10 @@ Note that currently, software only supports redirecting at most one PEBS event.
 To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
 
 	perf script --itrace=oe
+
+
+SEE ALSO
+--------
+
+linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1],
+linkperf:perf-inject[1]
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b23a4012a606..7f4db7592467 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -589,4 +589,4 @@ appended unit character - B/K/M/G
 
 SEE ALSO
 --------
-linkperf:perf-stat[1], linkperf:perf-list[1]
+linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index db61f16ffa56..bd0a029d4c08 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -546,4 +546,5 @@ include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
 --------
-linkperf:perf-stat[1], linkperf:perf-annotate[1], linkperf:perf-record[1]
+linkperf:perf-stat[1], linkperf:perf-annotate[1], linkperf:perf-record[1],
+linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b057e47b..db6a36aac47e 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -429,4 +429,4 @@ include::itrace.txt[]
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
-linkperf:perf-script-python[1]
+linkperf:perf-script-python[1], linkperf:perf-intel-pt[1]
-- 
2.17.1

