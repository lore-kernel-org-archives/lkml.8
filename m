Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D52C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D862467A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgAJRyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:54:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59163 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbgAJRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTK-0001m8-8M; Fri, 10 Jan 2020 18:53:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BBD291C2D5D;
        Fri, 10 Jan 2020 18:53:17 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:17 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tests bp_signal: Show expected versus obtained values
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-c951j3gvrgnrsyg7ki7pwkiz@git.kernel.org>
References: <tip-c951j3gvrgnrsyg7ki7pwkiz@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879762.30329.2741458358842867256.tip-bot2@tip-bot2>
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

Commit-ID:     6ae9c10b7cd50ac9080880204f8d9ff6381b2869
Gitweb:        https://git.kernel.org/tip/6ae9c10b7cd50ac9080880204f8d9ff6381b2869
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 05 Dec 2019 16:09:59 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:09 -03:00

perf tests bp_signal: Show expected versus obtained values

To help understand failures.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c951j3gvrgnrsyg7ki7pwkiz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 415903b..da8ec1e 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -263,20 +263,20 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 		if (count1 == 11)
 			pr_debug("failed: RF EFLAG recursion issue detected\n");
 		else
-			pr_debug("failed: wrong count for bp1%lld\n", count1);
+			pr_debug("failed: wrong count for bp1: %lld, expected 1\n", count1);
 	}
 
 	if (overflows != 3)
-		pr_debug("failed: wrong overflow hit\n");
+		pr_debug("failed: wrong overflow (%d) hit, expected 3\n", overflows);
 
 	if (overflows_2 != 3)
-		pr_debug("failed: wrong overflow_2 hit\n");
+		pr_debug("failed: wrong overflow_2 (%d) hit, expected 3\n", overflows_2);
 
 	if (count2 != 3)
-		pr_debug("failed: wrong count for bp2\n");
+		pr_debug("failed: wrong count for bp2 (%lld), expected 3\n", count2);
 
 	if (count3 != 2)
-		pr_debug("failed: wrong count for bp3\n");
+		pr_debug("failed: wrong count for bp3 (%lld), expected 2\n", count3);
 
 	return count1 == 1 && overflows == 3 && count2 == 3 && overflows_2 == 3 && count3 == 2 ?
 		TEST_OK : TEST_FAIL;
