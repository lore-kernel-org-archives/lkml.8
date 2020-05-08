Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DDCC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D190D24970
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgEHNJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730477AbgEHNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A1C05BD43;
        Fri,  8 May 2020 06:05:17 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gc-0007Ul-C1; Fri, 08 May 2020 15:05:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A88671C04CF;
        Fri,  8 May 2020 15:04:56 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:56 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf intel-pt: Update documentation about using /proc/kcore
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429150751.12570-10-adrian.hunter@intel.com>
References: <20200429150751.12570-10-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158894309660.8414.744004103071020836.tip-bot2@tip-bot2>
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

Commit-ID:     6dd912cbadb9f9746a525c74f09c0e36cee13ee2
Gitweb:        https://git.kernel.org/tip/6dd912cbadb9f9746a525c74f09c0e36cee13ee2
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 29 Apr 2020 18:07:51 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf intel-pt: Update documentation about using /proc/kcore

Update documentation to reflect the advent of the --kcore option for
'perf record'.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 782eb8a..eb8b7d4 100644
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
 
