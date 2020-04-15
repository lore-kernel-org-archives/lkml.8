Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57C0C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E8B206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896081AbgDOJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895888AbgDOJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B42C061A41;
        Wed, 15 Apr 2020 02:49:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg3-0005tr-3L; Wed, 15 Apr 2020 11:49:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B858F1C0081;
        Wed, 15 Apr 2020 11:49:50 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:50 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Make threshold bank setting hotplug robust
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403161943.1458-8-bp@alien8.de>
References: <20200403161943.1458-8-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694419038.28353.2865247426167350990.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a037f3ca0ea0a660e3f961431095a88674b8f3c4
Gitweb:        https://git.kernel.org/tip/a037f3ca0ea0a660e3f961431095a88674b8f3c4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 31 Mar 2020 13:16:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:50:19 +02:00

x86/mce/amd: Make threshold bank setting hotplug robust

Handle the cases when the CPU goes offline before the bank
setting/reading happens.

 [ bp: Write commit message. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200403161943.1458-8-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/amd.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 16e7aea..15c87b8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -386,6 +386,10 @@ static void threshold_restart_bank(void *_tr)
 	struct thresh_restart *tr = _tr;
 	u32 hi, lo;
 
+	/* sysfs write might race against an offline operation */
+	if (this_cpu_read(threshold_banks))
+		return;
+
 	rdmsr(tr->b->address, lo, hi);
 
 	if (tr->b->threshold_limit < (hi & THRESHOLD_MAX))
@@ -1085,7 +1089,8 @@ store_interrupt_enable(struct threshold_block *b, const char *buf, size_t size)
 	memset(&tr, 0, sizeof(tr));
 	tr.b		= b;
 
-	smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1);
+	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+		return -ENODEV;
 
 	return size;
 }
@@ -1109,7 +1114,8 @@ store_threshold_limit(struct threshold_block *b, const char *buf, size_t size)
 	b->threshold_limit = new;
 	tr.b = b;
 
-	smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1);
+	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+		return -ENODEV;
 
 	return size;
 }
@@ -1118,7 +1124,9 @@ static ssize_t show_error_count(struct threshold_block *b, char *buf)
 {
 	u32 lo, hi;
 
-	rdmsr_on_cpu(b->cpu, b->address, &lo, &hi);
+	/* CPU might be offline by now */
+	if (rdmsr_on_cpu(b->cpu, b->address, &lo, &hi))
+		return -ENODEV;
 
 	return sprintf(buf, "%u\n", ((hi & THRESHOLD_MAX) -
 				     (THRESHOLD_MAX - b->threshold_limit)));
