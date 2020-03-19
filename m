Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A2C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D19F2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgCSONK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:13:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgCSOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsg-00021n-SL; Thu, 19 Mar 2020 15:10:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8404E1C22A3;
        Thu, 19 Mar 2020 15:10:42 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:42 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf intel-pt: Add Intel PT man page references
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200311122034.3697-3-adrian.hunter@intel.com>
References: <20200311122034.3697-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158462704226.28353.6034878729471080379.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     870d325b15fb31af031cec58b89c1fb099a94bc7
Gitweb:        https://git.kernel.org/tip/870d325b15fb31af031cec58b89c1fb099a94bc7
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 11 Mar 2020 14:20:33 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Mar 2020 11:00:09 -03:00

perf intel-pt: Add Intel PT man page references

Add references to Intel PT man page in man pages of associated tools.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200311122034.3697-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-inject.txt   | 3 ++-
 tools/perf/Documentation/perf-intel-pt.txt | 7 +++++++
 tools/perf/Documentation/perf-record.txt   | 2 +-
 tools/perf/Documentation/perf-report.txt   | 3 ++-
 tools/perf/Documentation/perf-script.txt   | 2 +-
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index a64d658..70969ea 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -66,4 +66,5 @@ include::itrace.txt[]
 
 SEE ALSO
 --------
-linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1]
+linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1],
+linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 7d743a9..456fdcb 100644
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
index b23a401..7f4db75 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -589,4 +589,4 @@ appended unit character - B/K/M/G
 
 SEE ALSO
 --------
-linkperf:perf-stat[1], linkperf:perf-list[1]
+linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index db61f16..bd0a029 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -546,4 +546,5 @@ include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
 --------
-linkperf:perf-stat[1], linkperf:perf-annotate[1], linkperf:perf-record[1]
+linkperf:perf-stat[1], linkperf:perf-annotate[1], linkperf:perf-record[1],
+linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b05..db6a36a 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -429,4 +429,4 @@ include::itrace.txt[]
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
-linkperf:perf-script-python[1]
+linkperf:perf-script-python[1], linkperf:perf-intel-pt[1]
