Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483B2C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D052073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480851;
	bh=e0Y8v9vF6r0KuhxxkQcrALVR9k+NKRkcI9tfZZQf2p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sInabmLhynrlfeW6moL/UlSW9dtblQscoF80qTl7kSl7AFzap2nfbyDoZyZ9K8eyS
	 f8CkxStH97o/BhC5LJLrm1r3yRjiAMrDF25COurWutJuiO4/AiL7cDCo3j0nbp+FnH
	 Hz0MI6JaRU/JjFyH/N2yPT2zapF4DFjf3Ke+BrGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCQVeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgCQVeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5F720752;
        Tue, 17 Mar 2020 21:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480848;
        bh=e0Y8v9vF6r0KuhxxkQcrALVR9k+NKRkcI9tfZZQf2p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zewes46JcTahU+/4S9L9Zsmp73dDPI5m+9J9N52Ysn3EAg4RYcwNPvO1KwR+qAyeA
         eX1sv7+VbmH/zs9SVV8z9r7uAamdS2Tz9EqW5dz5Q+eEoILpVAypQJ8r6mA/sktekA
         82A4pLeVW6Lg0TRfLnLTmVref/auzzloDDYQOV7s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 16/23] perf intel-pt: Add Intel PT man page references
Date:   Tue, 17 Mar 2020 18:32:52 -0300
Message-Id: <20200317213259.15494-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
2.21.1

