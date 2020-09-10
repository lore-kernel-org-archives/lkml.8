Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14E0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C8421941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fYGRSAMR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8miQl2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgIJJit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgIJJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D69C061757;
        Thu, 10 Sep 2020 02:22:14 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JoPNXNLBsyEhUtHUT6JCTfcPaPR55B+KvWTtgjELRNo=;
        b=fYGRSAMRecM89JjXnxIlHEoYQAm+ry93aGFj4kuBzxKq8UBr1W/mWM2h8PeUiNeafO9H/7
        4YICcNqsmvn2iNUHUEfrMcXfh1sp1sUe2QEU9SBQxOOn9eu2wFwnDACEMg6BAbjf3tNWGW
        lNwjBcBXVgzdf6NAYQCwH+DUsCLxfDh8WrNN8N7uSCuL9AH7OLyg91RyyYHtfFjaiCaGin
        BQYrDJJ6XALz6mxcf/HuysBBCI5Avg73e3q/4GjXNNj9tg/uJu/5mjXQk9HXMUn4ldYK6X
        ZxB4YuAxCRIz454qC8QxkrDcxmW0lQvKx1tmoy0Ih1GSETD8VwyT/QhYwJn0FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JoPNXNLBsyEhUtHUT6JCTfcPaPR55B+KvWTtgjELRNo=;
        b=j8miQl2qX4Sj+Xbb7olJPd/fGrzHNTBbXUHKG92iz3DxwYN1kfJwZA+7tJZsxop7jA0xcb
        UhCEwjCa5LA/TuAA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/smpboot: Load TSS and getcpu GDT entry before
 loading IDT
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-68-joro@8bytes.org>
References: <20200907131613.12703-68-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972435.20229.954025378215732104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     520d030852b4c9babfce9a79d8b5320b6b5545e6
Gitweb:        https://git.kernel.org/tip/520d030852b4c9babfce9a79d8b5320b6b5545e6
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:16:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/smpboot: Load TSS and getcpu GDT entry before loading IDT

The IDT on 64-bit contains vectors which use paranoid_entry() and/or IST
stacks. To make these vectors work, the TSS and the getcpu GDT entry need
to be set up before the IDT is loaded.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-68-joro@8bytes.org
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/common.c     | 23 +++++++++++++++++++++++
 arch/x86/kernel/smpboot.c        |  2 +-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d8..615dd44 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -696,6 +696,7 @@ extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void load_percpu_segment(int);
 extern void cpu_init(void);
+extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
 
 static inline unsigned long get_debugctlmsr(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 81fba4d..beffea2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1863,6 +1863,29 @@ static inline void tss_setup_io_bitmap(struct tss_struct *tss)
 }
 
 /*
+ * Setup everything needed to handle exceptions from the IDT, including the IST
+ * exceptions which use paranoid_entry().
+ */
+void cpu_init_exception_handling(void)
+{
+	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	int cpu = raw_smp_processor_id();
+
+	/* paranoid_entry() gets the CPU number from the GDT */
+	setup_getcpu(cpu);
+
+	/* IST vectors need TSS to be set up. */
+	tss_setup_ist(tss);
+	tss_setup_io_bitmap(tss);
+	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
+
+	load_TR_desc();
+
+	/* Finally load the IDT */
+	load_current_idt();
+}
+
+/*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
  * and IDT. We reload them nevertheless, this function acts as a
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f5ef689..de776b2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -227,7 +227,7 @@ static void notrace start_secondary(void *unused)
 	load_cr3(swapper_pg_dir);
 	__flush_tlb_all();
 #endif
-	load_current_idt();
+	cpu_init_exception_handling();
 	cpu_init();
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
