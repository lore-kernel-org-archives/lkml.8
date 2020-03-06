Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AAFC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676DB2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCFOmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgCFOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEBC-0006Q3-JR; Fri, 06 Mar 2020 15:42:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BD5771C21DC;
        Fri,  6 Mar 2020 15:42:14 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:14 -0000
From:   "tip-bot2 for Peter Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] MIPS: smp: Remove tick_broadcast_count
Cc:     Peter Xu <peterx@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191216213125.9536-3-peterx@redhat.com>
References: <20191216213125.9536-3-peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <158350573449.28353.9285827555774109054.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     e188f0a50f637391f440b9bf0a1066db71a20889
Gitweb:        https://git.kernel.org/tip/e188f0a50f637391f440b9bf0a1066db71a20889
Author:        Peter Xu <peterx@redhat.com>
AuthorDate:    Mon, 16 Dec 2019 16:31:24 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 13:42:28 +01:00

MIPS: smp: Remove tick_broadcast_count

Now smp_call_function_single_async() provides the protection that
we'll return with -EBUSY if the csd object is still pending, then we
don't need the tick_broadcast_count counter any more.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20191216213125.9536-3-peterx@redhat.com
---
 arch/mips/kernel/smp.c |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f510c00..0def624 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -696,29 +696,22 @@ EXPORT_SYMBOL(flush_tlb_one);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 
-static DEFINE_PER_CPU(atomic_t, tick_broadcast_count);
 static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd);
 
 void tick_broadcast(const struct cpumask *mask)
 {
-	atomic_t *count;
 	call_single_data_t *csd;
 	int cpu;
 
 	for_each_cpu(cpu, mask) {
-		count = &per_cpu(tick_broadcast_count, cpu);
 		csd = &per_cpu(tick_broadcast_csd, cpu);
-
-		if (atomic_inc_return(count) == 1)
-			smp_call_function_single_async(cpu, csd);
+		smp_call_function_single_async(cpu, csd);
 	}
 }
 
 static void tick_broadcast_callee(void *info)
 {
-	int cpu = smp_processor_id();
 	tick_receive_broadcast();
-	atomic_set(&per_cpu(tick_broadcast_count, cpu), 0);
 }
 
 static int __init tick_broadcast_init(void)
