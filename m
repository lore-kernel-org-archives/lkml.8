Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956DBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F8024673
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbgCDLB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:01:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbgCDLB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:01:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j9Rmg-0001YS-5g; Wed, 04 Mar 2020 12:01:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB4CC1C21B2;
        Wed,  4 Mar 2020 12:01:49 +0100 (CET)
Date:   Wed, 04 Mar 2020 11:01:49 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tests bp_account: Make global variable static
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158331970957.28353.16382895991011482208.tip-bot2@tip-bot2>
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

Commit-ID:     cff20b3151ccab690715cb6cf0f5da5cccb32adf
Gitweb:        https://git.kernel.org/tip/cff20b3151ccab690715cb6cf0f5da5cccb32adf
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 02 Mar 2020 11:13:19 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 02 Mar 2020 11:15:07 -03:00

perf tests bp_account: Make global variable static

To fix the build with newer gccs, that without this patch exit with:

    LD       /tmp/build/perf/tests/perf-in.o
  ld: /tmp/build/perf/tests/bp_account.o:/git/perf/tools/perf/tests/bp_account.c:22: multiple definition of `the_var'; /tmp/build/perf/tests/bp_signal.o:/git/perf/tools/perf/tests/bp_signal.c:38: first defined here
  make[4]: *** [/git/perf/tools/build/Makefile.build:145: /tmp/build/perf/tests/perf-in.o] Error 1

First noticed in fedora:rawhide/32 with:

  [perfbuilder@a5ff49d6e6e4 ~]$ gcc --version
  gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8)

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_account.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index d0b9353..489b506 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -19,7 +19,7 @@
 #include "../perf-sys.h"
 #include "cloexec.h"
 
-volatile long the_var;
+static volatile long the_var;
 
 static noinline int test_function(void)
 {
