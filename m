Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC72C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC7A21531
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgE3J5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgE3J5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73864C08C5C9;
        Sat, 30 May 2020 02:57:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyF2-0002sy-7B; Sat, 30 May 2020 11:57:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9A60A1C04D6;
        Sat, 30 May 2020 11:57:23 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:23 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/hw_breakpoint: Add within_area() to check data
 breakpoints
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526014221.2119-2-laijs@linux.alibaba.com>
References: <20200526014221.2119-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <159083264350.17951.12589206057870235057.tip-bot2@tip-bot2>
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

Commit-ID:     83f7a80367e99cca0023be95538635abacec07ae
Gitweb:        https://git.kernel.org/tip/83f7a80367e99cca0023be95538635abacec07ae
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 29 May 2020 23:27:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:05 +02:00

x86/hw_breakpoint: Add within_area() to check data breakpoints

Add a within_area() helper to checking whether the data breakpoints overlap
with cpu_entry_area.

It will be used to completely prevent data breakpoints on GDT, IDT, or TSS.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200526014221.2119-2-laijs@linux.alibaba.com
Link: https://lkml.kernel.org/r/20200529213320.784524504@infradead.org

---
 arch/x86/kernel/hw_breakpoint.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 9ddf441..c149c7b 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -228,13 +228,22 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 }
 
 /*
+ * Checks whether the range [addr, end], overlaps the area [base, base + size).
+ */
+static inline bool within_area(unsigned long addr, unsigned long end,
+			       unsigned long base, unsigned long size)
+{
+	return end >= base && addr < (base + size);
+}
+
+/*
  * Checks whether the range from addr to end, inclusive, overlaps the CPU
  * entry area range.
  */
 static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
 {
-	return end >= CPU_ENTRY_AREA_BASE &&
-	       addr < (CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_TOTAL_SIZE);
+	return within_area(addr, end, CPU_ENTRY_AREA_BASE,
+			   CPU_ENTRY_AREA_TOTAL_SIZE);
 }
 
 static int arch_build_bp_info(struct perf_event *bp,
