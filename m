Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A65C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7225A20787
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCTM6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35599 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgCTM6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDt-0003h0-MB; Fri, 20 Mar 2020 13:58:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 44FB21C22BE;
        Fri, 20 Mar 2020 13:58:01 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:00 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add box_offsets for
 free-running counters
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584470314-46657-1-git-send-email-kan.liang@linux.intel.com>
References: <1584470314-46657-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158470908097.28353.2804105982601442401.tip-bot2@tip-bot2>
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

Commit-ID:     bc88a2fe216a51e8ab46d61f89d0c1b5a400470e
Gitweb:        https://git.kernel.org/tip/bc88a2fe216a51e8ab46d61f89d0c1b5a400470e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 17 Mar 2020 11:38:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:23 +01:00

perf/x86/intel/uncore: Add box_offsets for free-running counters

The offset between uncore boxes of free-running counters varies, e.g.
IIO free-running counters on Ice Lake server.

Add box_offsets, an array of offsets between adjacent uncore boxes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1584470314-46657-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 1204dcc..b30429f 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -154,6 +154,7 @@ struct freerunning_counters {
 	unsigned int box_offset;
 	unsigned int num_counters;
 	unsigned int bits;
+	unsigned *box_offsets;
 };
 
 struct pci2phy_map {
@@ -310,7 +311,9 @@ unsigned int uncore_freerunning_counter(struct intel_uncore_box *box,
 
 	return pmu->type->freerunning[type].counter_base +
 	       pmu->type->freerunning[type].counter_offset * idx +
-	       pmu->type->freerunning[type].box_offset * pmu->pmu_idx;
+	       (pmu->type->freerunning[type].box_offsets ?
+	        pmu->type->freerunning[type].box_offsets[pmu->pmu_idx] :
+	        pmu->type->freerunning[type].box_offset * pmu->pmu_idx);
 }
 
 static inline
