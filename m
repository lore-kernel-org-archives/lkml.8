Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B577C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C6520791
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgH2KyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:54:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:17379 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgH2KvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:51:06 -0400
IronPort-SDR: Lde55gVD5idSMifCUzcI+/j9tE0tD9W+rn1DJJBsvj3G+oVl8DYPXVBtvXMH6yz5edsNz2CwTv
 AebJG9VvdtVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="174838405"
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="174838405"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 03:51:06 -0700
IronPort-SDR: yE+eA3Vo+1a254ts7m8PmmutACFQAGpiK26rXpUHMdcJnukZteCMbbcVF/zg7lLuCOEqw1bmvV
 aMTQ8K8L96Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="313853181"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2020 03:51:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] perf intel-pt: Document snapshot control command
Date:   Sat, 29 Aug 2020 13:50:15 +0300
Message-Id: <20200829105015.10800-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829105015.10800-1-adrian.hunter@intel.com>
References: <20200829105015.10800-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation descibes snapshot mode.  Update it to include the new
snapshot control command.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index d5a266d7f15b..b4414f75ad0b 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -558,7 +558,7 @@ The mmap size and auxtrace mmap size are displayed if the -vv option is used e.g
 Intel PT modes of operation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Intel PT can be used in 2 modes:
+Intel PT can be used in 3 modes:
 	full-trace mode
 	sample mode
 	snapshot mode
@@ -571,7 +571,8 @@ Sample mode attaches a Intel PT sample to other events e.g.
 
 	perf record --aux-sample -e intel_pt//u -e branch-misses:u
 
-Snapshot mode captures the available data when a signal is sent e.g.
+Snapshot mode captures the available data when a signal is sent or "snapshot"
+control command is issued. e.g. using a signal
 
 	perf record -v -e intel_pt//u -S ./loopy 1000000000 &
 	[1] 11435
@@ -582,7 +583,23 @@ Note that the signal sent is SIGUSR2.
 Note that "Recording AUX area tracing snapshot" is displayed because the -v
 option is used.
 
-The 2 modes cannot be used together.
+The advantage of using "snapshot" control command is that the access is
+controlled by access to a FIFO e.g.
+
+	$ mkfifo perf.control
+	$ mkfifo perf.ack
+	$ cat perf.ack &
+	[1] 15235
+	$ sudo ~/bin/perf record --control perf.control,perf.ack -S -e intel_pt//u -- sleep 60 &
+	[2] 15243
+	$ ps -e | grep perf
+	15244 pts/1    00:00:00 perf
+	$ kill -USR2 15244
+	bash: kill: (15244) - Operation not permitted
+	$ echo snapshot > perf.control
+	ack
+
+The 3 Intel PT modes of operation cannot be used together.
 
 
 Buffer handling
-- 
2.17.1

