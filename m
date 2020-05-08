Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246BAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F8B24969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgEHNFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730419AbgEHNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0737C05BD10;
        Fri,  8 May 2020 06:05:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2go-0007a1-AV; Fri, 08 May 2020 15:05:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DDF701C0826;
        Fri,  8 May 2020 15:05:00 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:00 -0000
From:   "tip-bot2 for Konstantin Khlebnikov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Fix reading new topology attribute "core_cpus"
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <158817718710.747528.11009278875028211991.stgit@buzz>
References: <158817718710.747528.11009278875028211991.stgit@buzz>
MIME-Version: 1.0
Message-ID: <158894310080.8414.7942977053863010593.tip-bot2@tip-bot2>
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

Commit-ID:     846de4371fdfddfa49481e3d04884539870dc127
Gitweb:        https://git.kernel.org/tip/846de4371fdfddfa49481e3d04884539870dc127
Author:        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate:    Wed, 29 Apr 2020 19:19:47 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf tools: Fix reading new topology attribute "core_cpus"

Check if access("devices/system/cpu/cpu%d/topology/core_cpus", F_OK)
fails, which will happen unless the current directory is "/sys".

Simply try to read this file first.

Fixes: 0ccdb8407a46 ("perf tools: Apply new CPU topology sysfs attributes")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/158817718710.747528.11009278875028211991.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/smt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 3b791ef..8481842 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -24,13 +24,13 @@ int smt_on(void)
 
 		snprintf(fn, sizeof fn,
 			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
-		if (access(fn, F_OK) == -1) {
+		if (sysfs__read_str(fn, &str, &strlen) < 0) {
 			snprintf(fn, sizeof fn,
 				"devices/system/cpu/cpu%d/topology/thread_siblings",
 				cpu);
+			if (sysfs__read_str(fn, &str, &strlen) < 0)
+				continue;
 		}
-		if (sysfs__read_str(fn, &str, &strlen) < 0)
-			continue;
 		/* Entry is hex, but does not have 0x, so need custom parser */
 		siblings = strtoull(str, NULL, 16);
 		free(str);
