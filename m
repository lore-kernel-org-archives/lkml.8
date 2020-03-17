Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7484C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9571420736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCQMHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:07:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCQMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:07:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEB0Z-0000Eo-Af; Tue, 17 Mar 2020 13:07:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E84A01C2291;
        Tue, 17 Mar 2020 13:07:42 +0100 (CET)
Date:   Tue, 17 Mar 2020 12:07:42 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Prepare L3 thread mask code for Family 19h
Cc:     Kim Phillips <kim.phillips@amd.com>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313231024.17601-1-kim.phillips@amd.com>
References: <20200313231024.17601-1-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <158444686267.28353.9866951198015085818.tip-bot2@tip-bot2>
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

Commit-ID:     4dcc3df82573a946c620dda5fb00e27c7b080105
Gitweb:        https://git.kernel.org/tip/4dcc3df82573a946c620dda5fb00e27c7b080105
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Fri, 13 Mar 2020 18:10:22 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Mar 2020 13:00:29 +01:00

perf/amd/uncore: Prepare L3 thread mask code for Family 19h

In order to better accommodate the upcoming Family 19h, given
the 80-char line limit, move the existing code into a new
l3_thread_slice_mask() function.

No functional changes.

 [ bp: Touchups. ]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200313231024.17601-1-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index a6ea07f..2abcb1a 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -180,6 +180,20 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 	hwc->idx = -1;
 }
 
+/*
+ * Convert logical CPU number to L3 PMC Config ThreadMask format
+ */
+static u64 l3_thread_slice_mask(int cpu)
+{
+	int thread = 2 * (cpu_data(cpu).cpu_core_id % 4);
+
+	if (smp_num_siblings > 1)
+		thread += cpu_data(cpu).apicid & 1;
+
+	return (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
+		AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
+}
+
 static int amd_uncore_event_init(struct perf_event *event)
 {
 	struct amd_uncore *uncore;
@@ -209,15 +223,8 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * SliceMask and ThreadMask need to be set for certain L3 events in
 	 * Family 17h. For other events, the two fields do not affect the count.
 	 */
-	if (l3_mask && is_llc_event(event)) {
-		int thread = 2 * (cpu_data(event->cpu).cpu_core_id % 4);
-
-		if (smp_num_siblings > 1)
-			thread += cpu_data(event->cpu).apicid & 1;
-
-		hwc->config |= (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
-				AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
-	}
+	if (l3_mask && is_llc_event(event))
+		hwc->config |= l3_thread_slice_mask(event->cpu);
 
 	uncore = event_to_amd_uncore(event);
 	if (!uncore)
