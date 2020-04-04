Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E56C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E271208FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgDDIlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:41:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41403 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDIlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN6-0000yv-U3; Sat, 04 Apr 2020 10:41:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 753DF1C0243;
        Sat,  4 Apr 2020 10:41:44 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:44 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf build-test: Honour JOBS to override detection
 of number of cores
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200330130301.GA31702@kernel.org>
References: <20200330130301.GA31702@kernel.org>
MIME-Version: 1.0
Message-ID: <158598970410.28353.5745644296944614276.tip-bot2@tip-bot2>
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

Commit-ID:     7b1642f2fc1e1f20948e806b7ce319f660633342
Gitweb:        https://git.kernel.org/tip/7b1642f2fc1e1f20948e806b7ce319f660633342
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Mar 2020 09:32:41 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf build-test: Honour JOBS to override detection of number of cores

When one does:

  $ make -C tools/perf build-test

The makefile in tools/perf/tests/ will, just like the main one, detect
how many cores are in the system and use it with -j.

Sometimes we may need to override that, for instance, when using
icecream or distcc to use multiple machines in the build process, then
we need to, as with the main makefile, use:

  $ make JOBS=N -C tools/perf build-test

Fix the tests makefile to honour that.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200330130301.GA31702@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index c850d16..5d0c3a9 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -28,9 +28,13 @@ endif
 
 PARALLEL_OPT=
 ifeq ($(SET_PARALLEL),1)
-  cores := $(shell (getconf _NPROCESSORS_ONLN || egrep -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
-  ifeq ($(cores),0)
-    cores := 1
+  ifeq ($(JOBS),)
+    cores := $(shell (getconf _NPROCESSORS_ONLN || egrep -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
+    ifeq ($(cores),0)
+      cores := 1
+    endif
+  else
+    cores=$(JOBS)
   endif
   PARALLEL_OPT="-j$(cores)"
 endif
