Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5638C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB6C208FE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgE3J5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgE3J5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F1C08C5CA;
        Sat, 30 May 2020 02:57:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyF0-0002s9-FT; Sat, 30 May 2020 11:57:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1FED31C032F;
        Sat, 30 May 2020 11:57:22 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:21 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/hw_breakpoint: Prevent data breakpoints on
 user_pcid_flush_mask
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526014221.2119-5-laijs@linux.alibaba.com>
References: <20200526014221.2119-5-laijs@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <159083264193.17951.13800361200842101495.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     87aa9b64e0ccb779db3970e2e9af1cc5930c2c3d
Gitweb:        https://git.kernel.org/tip/87aa9b64e0ccb779db3970e2e9af1cc5930c2c3d
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 29 May 2020 23:27:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:06 +02:00

x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask

The per-CPU user_pcid_flush_mask is used in the low level entry code. A
data breakpoint can cause #DB recursion. 

Protect the full cpu_tlbstate structure for simplicity.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200526014221.2119-5-laijs@linux.alibaba.com
Link: https://lkml.kernel.org/r/20200529213320.955117574@infradead.org

---
 arch/x86/kernel/hw_breakpoint.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f311bbf..fc1743a 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -33,6 +33,7 @@
 #include <asm/debugreg.h>
 #include <asm/user.h>
 #include <asm/desc.h>
+#include <asm/tlbflush.h>
 
 /* Per cpu debug control register value */
 DEFINE_PER_CPU(unsigned long, cpu_dr7);
@@ -264,6 +265,16 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 				(unsigned long)&per_cpu(cpu_tss_rw, cpu),
 				sizeof(struct tss_struct)))
 			return true;
+
+		/*
+		 * cpu_tlbstate.user_pcid_flush_mask is used for CPU entry.
+		 * If a data breakpoint on it, it will cause an unwanted #DB.
+		 * Protect the full cpu_tlbstate structure to be sure.
+		 */
+		if (within_area(addr, end,
+				(unsigned long)&per_cpu(cpu_tlbstate, cpu),
+				sizeof(struct tlb_state)))
+			return true;
 	}
 
 	return false;
