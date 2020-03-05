Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140DEC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADE92072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jt6RQ8Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCEUDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:03:05 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:44436 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbgCEUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:03:04 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2C420C10DA;
        Thu,  5 Mar 2020 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583438583; bh=EKwbyzY3XBPQ6iAgNco3btTgOVO5oLf9gzGrqqpLQDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jt6RQ8Txu63PQ75IYUCUHmEMRIOHQZrv4llKEMrzvd/USvavsgoKFErqmKgwOHxe2
         oad2IxA0dldY+ZotlqiP8joulYmbYZhjYDIWFinRiOY6t7nqmlfbLg/lPKCZULpYvz
         jyJ0hXWpTyMsfK1dpFkP/ZCYhz15yhakl9C25+VpWfkXIsdjxCyTn5wDXorLV+wWln
         Vcsm4iw4CYCIU0TXYPOzqIm/+ywA7YPXyk8/25OLRH4TjdUVkIIcTRzhgWD4aC3fMC
         bAoqvb3OvWhhh7MIP/FrLriNuy2uEvxWkud99RE8g0nG5aEbdX4pQUL+AM18hGSCvh
         64Ht0hAemrvUg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 85226A006D;
        Thu,  5 Mar 2020 20:03:01 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 4/4] ARC: allow userspace DSP applications to use AGU extensions
Date:   Thu,  5 Mar 2020 23:02:52 +0300
Message-Id: <20200305200252.14278-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
References: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to run DSP-enabled userspace applications with AGU
(address generation unit) extensions we additionally need to
save and restore following registers at context switch:
 * AGU_AP*
 * AGU_OS*
 * AGU_MOD*

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                |  9 +++++++++
 arch/arc/include/asm/arcregs.h  | 12 ++++++++++++
 arch/arc/include/asm/asserts.h  | 10 ++++++++++
 arch/arc/include/asm/dsp-impl.h | 24 ++++++++++++++++++++++++
 arch/arc/include/asm/dsp.h      |  5 +++++
 arch/arc/kernel/setup.c         |  6 ++++++
 6 files changed, 66 insertions(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index eb3bcb206882..ff306246d0f8 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -445,6 +445,15 @@ config ARC_DSP_USERSPACE
 	help
 	  DSP extension presence in HW, support save / restore DSP registers to
 	  run DSP-enabled userspace applications
+
+config ARC_DSP_AGU_USERSPACE
+	bool "Support DSP with AGU for userspace apps"
+	select ARC_HAS_ACCL_REGS
+	select ARC_DSP_HANDLED
+	select ARC_DSP_SAVE_RESTORE_REGS
+	help
+	  DSP and AGU extensions presence in HW, support save / restore DSP
+	  and AGU registers to run DSP-enabled userspace applications
 endchoice
 
 config ARC_IRQ_NO_AUTOSAVE
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index aee1ee263065..2162023195c5 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -132,6 +132,18 @@
 #define ARC_AUX_DSP_CTRL	0x59F
 #define ARC_AUX_DSP_FFT_CTRL	0x59E
 
+#define ARC_AUX_AGU_BUILD	0xCC
+#define ARC_AUX_AGU_AP0		0x5C0
+#define ARC_AUX_AGU_AP1		0x5C1
+#define ARC_AUX_AGU_AP2		0x5C2
+#define ARC_AUX_AGU_AP3		0x5C3
+#define ARC_AUX_AGU_OS0		0x5D0
+#define ARC_AUX_AGU_OS1		0x5D1
+#define ARC_AUX_AGU_MOD0	0x5E0
+#define ARC_AUX_AGU_MOD1	0x5E1
+#define ARC_AUX_AGU_MOD2	0x5E2
+#define ARC_AUX_AGU_MOD3	0x5E3
+
 #ifndef __ASSEMBLY__
 
 #include <soc/arc/aux.h>
diff --git a/arch/arc/include/asm/asserts.h b/arch/arc/include/asm/asserts.h
index 3314efbeb528..108f33be6aa5 100644
--- a/arch/arc/include/asm/asserts.h
+++ b/arch/arc/include/asm/asserts.h
@@ -10,6 +10,7 @@
 /* Helpers to sanitize config options. */
 
 void chk_opt_strict(char *opt_name, bool hw_exists, bool opt_ena);
+void chk_opt_weak(char *opt_name, bool hw_exists, bool opt_ena);
 
 /*
  * Check required config option:
@@ -21,4 +22,13 @@ void chk_opt_strict(char *opt_name, bool hw_exists, bool opt_ena);
 	chk_opt_strict(#opt_name, hw_exists, IS_ENABLED(opt_name));	\
 })
 
+/*
+ * Check optional config option:
+ *  - panic in case of OPT enabled but corresponding HW absent.
+*/
+#define CHK_OPT_WEAK(opt_name, hw_exists)				\
+({									\
+	chk_opt_weak(#opt_name, hw_exists, IS_ENABLED(opt_name));	\
+})
+
 #endif /* __ASM_ARC_ASSERTS_H */
diff --git a/arch/arc/include/asm/dsp-impl.h b/arch/arc/include/asm/dsp-impl.h
index 8380f7bede81..e1aa212ca6eb 100644
--- a/arch/arc/include/asm/dsp-impl.h
+++ b/arch/arc/include/asm/dsp-impl.h
@@ -103,6 +103,21 @@ static inline void dsp_save_restore(struct task_struct *prev,
 
 	DSP_AUX_SAVE_RESTORE(saveto, readfrom, DSP_BFLY0);
 	DSP_AUX_SAVE_RESTORE(saveto, readfrom, DSP_FFT_CTRL);
+
+#ifdef CONFIG_ARC_DSP_AGU_USERSPACE
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_AP0);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_AP1);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_AP2);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_AP3);
+
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_OS0);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_OS1);
+
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_MOD0);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_MOD1);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_MOD2);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_MOD3);
+#endif /* CONFIG_ARC_DSP_AGU_USERSPACE */
 }
 
 #else /* !CONFIG_ARC_DSP_SAVE_RESTORE_REGS */
@@ -117,9 +132,18 @@ static inline bool dsp_exist(void)
 	return !!bcr.ver;
 }
 
+static inline bool agu_exist(void)
+{
+	struct bcr_generic bcr;
+
+	READ_BCR(ARC_AUX_AGU_BUILD, bcr);
+	return !!bcr.ver;
+}
+
 static inline void dsp_config_check(void)
 {
 	CHK_OPT_STRICT(CONFIG_ARC_DSP_HANDLED, dsp_exist());
+	CHK_OPT_WEAK(CONFIG_ARC_DSP_AGU_USERSPACE, agu_exist());
 }
 
 #endif /* __ASEMBLY__ */
diff --git a/arch/arc/include/asm/dsp.h b/arch/arc/include/asm/dsp.h
index b016f4d2a09f..202c78e56704 100644
--- a/arch/arc/include/asm/dsp.h
+++ b/arch/arc/include/asm/dsp.h
@@ -17,6 +17,11 @@
  */
 struct dsp_callee_regs {
 	unsigned long ACC0_GLO, ACC0_GHI, DSP_BFLY0, DSP_FFT_CTRL;
+#ifdef CONFIG_ARC_DSP_AGU_USERSPACE
+	unsigned long AGU_AP0, AGU_AP1, AGU_AP2, AGU_AP3;
+	unsigned long AGU_OS0, AGU_OS1;
+	unsigned long AGU_MOD0, AGU_MOD1, AGU_MOD2, AGU_MOD3;
+#endif
 };
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 1ed1528d9045..b2b1cb645d9e 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -399,6 +399,12 @@ void chk_opt_strict(char *opt_name, bool hw_exists, bool opt_ena)
 		panic("Disable %s, hardware NOT present\n", opt_name);
 }
 
+void chk_opt_weak(char *opt_name, bool hw_exists, bool opt_ena)
+{
+	if (!hw_exists && opt_ena)
+		panic("Disable %s, hardware NOT present\n", opt_name);
+}
+
 static void arc_chk_core_config(void)
 {
 	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
-- 
2.21.1

