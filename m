Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8798C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BCA207D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cp+/esIZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPxhG4Rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGDRtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 13:49:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40540 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 13:49:12 -0400
Date:   Sat, 04 Jul 2020 17:49:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593884950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyT8hkQlhVSj6KK8bDYHft0bbGZKUG7cdvK5Ql2oBEk=;
        b=Cp+/esIZ1NBLvhXGIhXL4XCo8lg4r4WZ/Iuk9PfZJJaXLvIlX57JQY+OvexePMrOvbPgXm
        ABK9ssFB8b7V9JZMH7j3xR1KANRm/VDNvEOARor5ZrBLlcxKpkLgFEclQT6wazKyyrKm8L
        d5zoTWbjf5cXVUGqDBiGt1xtHb4IdY+sajxx7b7PqpdxW2nGm75Imnrch8uZf0JeIfvKqv
        dgpQgLLrMw8HiGNw1aokf0/nanM/2TEbNttq1MiwC8lQFt7OZjV3VcOz22PQmf0LKRRnQf
        b31VsjZWprpL3IVegbgW/uvyYyym2hB4LlpYt+OYYbfG+gEWv1c1sGwKVLWEmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593884950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyT8hkQlhVSj6KK8bDYHft0bbGZKUG7cdvK5Ql2oBEk=;
        b=JPxhG4RxpDTkhyU805vAlyGjka1batxkqxegjWicD+YbpRYZgvTwWQ3PRi6HHd34uEFqAP
        rkn1kaUjN8lle1CQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ldt: Disable 16-bit segments on Xen PV
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <92b2975459dfe5929ecf34c3896ad920bd9e3f2d.1593795633.git.luto@kernel.org>
References: <92b2975459dfe5929ecf34c3896ad920bd9e3f2d.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159388494850.4006.16547568050354289956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cc801833a171163edb6385425349ba8903bd1b20
Gitweb:        https://git.kernel.org/tip/cc801833a171163edb6385425349ba8903bd1b20
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 03 Jul 2020 10:02:57 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 04 Jul 2020 19:47:26 +02:00

x86/ldt: Disable 16-bit segments on Xen PV

Xen PV doesn't implement ESPFIX64, so they don't work right.  Disable
them.  Also print a warning the first time anyone tries to use a
16-bit segment on a Xen PV guest that would otherwise allow it
to help people diagnose this change in behavior.

This gets us closer to having all x86 selftests pass on Xen PV.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/92b2975459dfe5929ecf34c3896ad920bd9e3f2d.1593795633.git.luto@kernel.org

---
 arch/x86/kernel/ldt.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 8748321..34e918a 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -29,6 +29,8 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable_areas.h>
 
+#include <xen/xen.h>
+
 /* This is a multiple of PAGE_SIZE. */
 #define LDT_SLOT_STRIDE (LDT_ENTRIES * LDT_ENTRY_SIZE)
 
@@ -543,6 +545,37 @@ static int read_default_ldt(void __user *ptr, unsigned long bytecount)
 	return bytecount;
 }
 
+static bool allow_16bit_segments(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_16BIT))
+		return false;
+
+#ifdef CONFIG_XEN_PV
+	/*
+	 * Xen PV does not implement ESPFIX64, which means that 16-bit
+	 * segments will not work correctly.  Until either Xen PV implements
+	 * ESPFIX64 and can signal this fact to the guest or unless someone
+	 * provides compelling evidence that allowing broken 16-bit segments
+	 * is worthwhile, disallow 16-bit segments under Xen PV.
+	 */
+	if (xen_pv_domain()) {
+		static DEFINE_MUTEX(xen_warning);
+		static bool warned;
+
+		mutex_lock(&xen_warning);
+		if (!warned) {
+			pr_info("Warning: 16-bit segments do not work correctly in a Xen PV guest\n");
+			warned = true;
+		}
+		mutex_unlock(&xen_warning);
+
+		return false;
+	}
+#endif
+
+	return true;
+}
+
 static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 {
 	struct mm_struct *mm = current->mm;
@@ -574,7 +607,7 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 		/* The user wants to clear the entry. */
 		memset(&ldt, 0, sizeof(ldt));
 	} else {
-		if (!IS_ENABLED(CONFIG_X86_16BIT) && !ldt_info.seg_32bit) {
+		if (!ldt_info.seg_32bit && !allow_16bit_segments()) {
 			error = -EINVAL;
 			goto out;
 		}
