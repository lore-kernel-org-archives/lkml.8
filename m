Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B20C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E664921941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YBm5YN/s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TRBbI9zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgIJJXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbgIJJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A978C061573;
        Thu, 10 Sep 2020 02:22:13 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlAPKhAPt7Ru9E88uu7h3W+YtKb9boFq9fZiHizVMUQ=;
        b=YBm5YN/s3eQZinHJZRNg0bfB8IswOE2GOB4XhUkXC1yz5+JBvtd44y6vdRQ7jq4W8kth/w
        R4uE3vYc8EL/xB3zZLvnA668nSG+Jtl01XFmzhJDQxQYSS2lS/MxzaZEbS0ityfztoeUwU
        sWOLshunyZ6D3Gtq2hNL0MN7oSWFg/u0D9s+IHM2PzWlbVwY8lIv86RTKZ5HkIwpRawxy0
        fXg3TaaokuJ6svEg9dK7SW2sfWlbk51sjpN7+na7IGmKlP5pDvdv6UmJcx0C3jmi2V5l4n
        TUX6QoTmtYkZhzvDOs3FJOTLJq4MbFNA9xSITuZBz2SV3xeLCZsv7axOs675QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlAPKhAPt7Ru9E88uu7h3W+YtKb9boFq9fZiHizVMUQ=;
        b=TRBbI9zq2vX4IXctMHa9D7bnSwOZHzeuWJDlIo9Cdk2ue3L7xzrm0m2b4YZEbSfUMwuCmn
        c50DwqGu9nzMmiDQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Support CPU offline/online
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-70-joro@8bytes.org>
References: <20200907131613.12703-70-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972356.20229.13010951780081767464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     094794f59720d7e877a1eeb372ecedeed6b441ab
Gitweb:        https://git.kernel.org/tip/094794f59720d7e877a1eeb372ecedeed6b441ab
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:16:10 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Support CPU offline/online

Add a play_dead handler when running under SEV-ES. This is needed
because the hypervisor can't deliver an SIPI request to restart the AP.
Instead, the kernel has to issue a VMGEXIT to halt the VCPU until the
hypervisor wakes it up again.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-70-joro@8bytes.org
---
 arch/x86/include/uapi/asm/svm.h |  1 +-
 arch/x86/kernel/sev-es.c        | 63 ++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 346b8a7..c1dcf3e 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -84,6 +84,7 @@
 /* SEV-ES software-defined VMGEXIT events */
 #define SVM_VMGEXIT_MMIO_READ			0x80000001
 #define SVM_VMGEXIT_MMIO_WRITE			0x80000002
+#define SVM_VMGEXIT_AP_HLT_LOOP			0x80000004
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 9ad36ce..d1bcd0d 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -29,6 +29,8 @@
 #include <asm/realmode.h>
 #include <asm/traps.h>
 #include <asm/svm.h>
+#include <asm/smp.h>
+#include <asm/cpu.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -518,6 +520,65 @@ static bool __init sev_es_setup_ghcb(void)
 	return true;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void sev_es_ap_hlt_loop(void)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+
+	ghcb = sev_es_get_ghcb(&state);
+
+	while (true) {
+		vc_ghcb_invalidate(ghcb);
+		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_HLT_LOOP);
+		ghcb_set_sw_exit_info_1(ghcb, 0);
+		ghcb_set_sw_exit_info_2(ghcb, 0);
+
+		sev_es_wr_ghcb_msr(__pa(ghcb));
+		VMGEXIT();
+
+		/* Wakeup signal? */
+		if (ghcb_sw_exit_info_2_is_valid(ghcb) &&
+		    ghcb->save.sw_exit_info_2)
+			break;
+	}
+
+	sev_es_put_ghcb(&state);
+}
+
+/*
+ * Play_dead handler when running under SEV-ES. This is needed because
+ * the hypervisor can't deliver an SIPI request to restart the AP.
+ * Instead the kernel has to issue a VMGEXIT to halt the VCPU until the
+ * hypervisor wakes it up again.
+ */
+static void sev_es_play_dead(void)
+{
+	play_dead_common();
+
+	/* IRQs now disabled */
+
+	sev_es_ap_hlt_loop();
+
+	/*
+	 * If we get here, the VCPU was woken up again. Jump to CPU
+	 * startup code to get it back online.
+	 */
+	start_cpu0();
+}
+#else  /* CONFIG_HOTPLUG_CPU */
+#define sev_es_play_dead	native_play_dead
+#endif /* CONFIG_HOTPLUG_CPU */
+
+#ifdef CONFIG_SMP
+static void __init sev_es_setup_play_dead(void)
+{
+	smp_ops.play_dead = sev_es_play_dead;
+}
+#else
+static inline void sev_es_setup_play_dead(void) { }
+#endif
+
 static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
@@ -566,6 +627,8 @@ void __init sev_es_init_vc_handling(void)
 		setup_vc_stacks(cpu);
 	}
 
+	sev_es_setup_play_dead();
+
 	/* Secondary CPUs use the runtime #VC handler */
 	initial_vc_handler = (unsigned long)safe_stack_exc_vmm_communication;
 }
