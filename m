Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906EEC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320020736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCQMHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:07:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCQMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:07:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEB0Y-0000Ek-Tp; Tue, 17 Mar 2020 13:07:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9037C1C2290;
        Tue, 17 Mar 2020 13:07:42 +0100 (CET)
Date:   Tue, 17 Mar 2020 12:07:42 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Make L3 thread mask code more readable
Cc:     Kim Phillips <kim.phillips@amd.com>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313231024.17601-2-kim.phillips@amd.com>
References: <20200313231024.17601-2-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <158444686229.28353.2736088400656740915.tip-bot2@tip-bot2>
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

Commit-ID:     9689dbbeaea884d19e3085439c6a247ef986b2af
Gitweb:        https://git.kernel.org/tip/9689dbbeaea884d19e3085439c6a247ef986b2af
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Fri, 13 Mar 2020 18:10:23 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Mar 2020 13:00:49 +01:00

perf/amd/uncore: Make L3 thread mask code more readable

Convert the l3_thread_slice_mask() function to use the more readable
topology_* helper functions, more intuitive variable names like shift
and thread_mask, and BIT_ULL().

No functional changes.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200313231024.17601-2-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 2abcb1a..07af497 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -185,13 +185,16 @@ static void amd_uncore_del(struct perf_event *event, int flags)
  */
 static u64 l3_thread_slice_mask(int cpu)
 {
-	int thread = 2 * (cpu_data(cpu).cpu_core_id % 4);
+	u64 thread_mask, core = topology_core_id(cpu);
+	unsigned int shift, thread = 0;
 
-	if (smp_num_siblings > 1)
-		thread += cpu_data(cpu).apicid & 1;
+	if (topology_smt_supported() && !topology_is_primary_thread(cpu))
+		thread = 1;
 
-	return (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
-		AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
+	shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
+	thread_mask = BIT_ULL(shift);
+
+	return AMD64_L3_SLICE_MASK | thread_mask;
 }
 
 static int amd_uncore_event_init(struct perf_event *event)
