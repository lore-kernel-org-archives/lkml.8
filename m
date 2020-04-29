Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086F1C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D3C21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgD2PHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:07:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:48798 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgD2PHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:45 -0400
IronPort-SDR: 0FOOCTnUNuOhykcQJ0guIMDfB58wbIlc8XGIDTazBrBAKAS5cpPv71oqiCd/JF9Hzzxz21cW9m
 tQt/pFbAyHFw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:44 -0700
IronPort-SDR: 5BnTGG5zCQTtUdUVMSk2NCkUyVgBFwz+hNG0hMcW4lrP+g6nxK04nqQ8gnkqaSJ3mmvGZFuDXX
 hJ9/cgolr6lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227470"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] perf intel-pt: Update documentation about using /proc/kcore
Date:   Wed, 29 Apr 2020 18:07:51 +0300
Message-Id: <20200429150751.12570-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation to reflect the advent of the --kcore option for
'perf record'.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 782eb8a65caf..eb8b7d42591a 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -69,22 +69,22 @@ And profiled with 'perf report' e.g.
 To also trace kernel space presents a problem, namely kernel self-modifying
 code.  A fairly good kernel image is available in /proc/kcore but to get an
 accurate image a copy of /proc/kcore needs to be made under the same conditions
-as the data capture.  A script perf-with-kcore can do that, but beware that the
-script makes use of 'sudo' to copy /proc/kcore.  If you have perf installed
-locally from the source tree you can do:
+as the data capture. 'perf record' can make a copy of /proc/kcore if the option
+--kcore is used, but access to /proc/kcore is restricted e.g.
 
-	~/libexec/perf-core/perf-with-kcore record pt_ls -e intel_pt// -- ls
+	sudo perf record -o pt_ls --kcore -e intel_pt// -- ls
 
-which will create a directory named 'pt_ls' and put the perf.data file and
-copies of /proc/kcore, /proc/kallsyms and /proc/modules into it.  Then to use
-'perf report' becomes:
+which will create a directory named 'pt_ls' and put the perf.data file (named
+simply 'data') and copies of /proc/kcore, /proc/kallsyms and /proc/modules into
+it.  The other tools understand the directory format, so to use 'perf report'
+becomes:
 
-	~/libexec/perf-core/perf-with-kcore report pt_ls
+	sudo perf report -i pt_ls
 
 Because samples are synthesized after-the-fact, the sampling period can be
 selected for reporting. e.g. sample every microsecond
 
-	~/libexec/perf-core/perf-with-kcore report pt_ls --itrace=i1usge
+	sudo perf report pt_ls --itrace=i1usge
 
 See the sections below for more information about the --itrace option.
 
-- 
2.17.1

