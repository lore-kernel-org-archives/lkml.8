Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4387EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FB02072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XnJz21Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgCEUDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:03:03 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:44432 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgCEUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:03:03 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D8D60C10CC;
        Thu,  5 Mar 2020 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583438582; bh=vxL14RdUad0AnLPPemYFpGsISJKfQ55yThyifBwET8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnJz21DwzKGw0x3UKAblbca30zUHfRj9ndM/wWr1LmbEJT/u5QTfB68FTfSI14iM7
         L6CwM9Davxn8xBS8vzWpCUw0XTwUi7Ma6uz2avYtFw8d7jG/BSMtUk0vD9lM5jyxyb
         mlu61OKu4SDj9jLPe8H7wrWNo1lmdixRfZuHtnGHsMZCp3J62jop+LVH7iRj543P9N
         6jaHCIgAI2PA57OMp45wJC/89xkBAJmslKt3cdWps9WDOQ9U2IPLu5Rs7ShnMnFLqy
         4X5EUqy+Sbf3R1eAC7f1scLNTdgAYFMTtvwkMES2o8xBqEZXgPheXQS9ePInBd2UGd
         F6yFY5H90Dj3w==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id E903BA0061;
        Thu,  5 Mar 2020 20:02:59 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 1/4] ARC: add helpers to sanitize config options
Date:   Thu,  5 Mar 2020 23:02:49 +0300
Message-Id: <20200305200252.14278-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
References: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll use this macro in coming patches extensively.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/asserts.h | 24 ++++++++++++++++++++++++
 arch/arc/kernel/setup.c        | 25 ++++++++++++-------------
 2 files changed, 36 insertions(+), 13 deletions(-)
 create mode 100644 arch/arc/include/asm/asserts.h

diff --git a/arch/arc/include/asm/asserts.h b/arch/arc/include/asm/asserts.h
new file mode 100644
index 000000000000..3314efbeb528
--- /dev/null
+++ b/arch/arc/include/asm/asserts.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+ */
+#ifndef __ASM_ARC_ASSERTS_H
+#define __ASM_ARC_ASSERTS_H
+
+/* Helpers to sanitize config options. */
+
+void chk_opt_strict(char *opt_name, bool hw_exists, bool opt_ena);
+
+/*
+ * Check required config option:
+ *  - panic in case of OPT enabled but corresponding HW absent.
+ *  - warn in case of OPT disabled but corresponding HW exists.
+*/
+#define CHK_OPT_STRICT(opt_name, hw_exists)				\
+({									\
+	chk_opt_strict(#opt_name, hw_exists, IS_ENABLED(opt_name));	\
+})
+
+#endif /* __ASM_ARC_ASSERTS_H */
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index aa41af6ef4ac..820c0cfb0702 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <uapi/linux/mount.h>
 #include <asm/sections.h>
 #include <asm/arcregs.h>
+#include <asm/asserts.h>
 #include <asm/tlb.h>
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -389,11 +390,18 @@ static char *arc_extn_mumbojumbo(int cpu_id, char *buf, int len)
 	return buf;
 }
 
+void chk_opt_strict(char *opt_name, bool hw_exists, bool opt_ena)
+{
+	if (hw_exists && !opt_ena)
+		pr_warn(" ! Enable %s for working apps\n", opt_name);
+	else if (!hw_exists && opt_ena)
+		panic("Disable %s, hardware NOT present\n", opt_name);
+}
+
 static void arc_chk_core_config(void)
 {
 	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
-	int saved = 0, present = 0;
-	char *opt_nm = NULL;
+	int present = 0;
 
 	if (!cpu->extn.timer0)
 		panic("Timer0 is not present!\n");
@@ -425,23 +433,14 @@ static void arc_chk_core_config(void)
 	 */
 
 	if (is_isa_arcompact()) {
-		opt_nm = "CONFIG_ARC_FPU_SAVE_RESTORE";
-		saved = IS_ENABLED(CONFIG_ARC_FPU_SAVE_RESTORE);
-
 		/* only DPDP checked since SP has no arch visible regs */
 		present = cpu->extn.fpu_dp;
+		CHK_OPT_STRICT(CONFIG_ARC_FPU_SAVE_RESTORE, present);
 	} else {
-		opt_nm = "CONFIG_ARC_HAS_ACCL_REGS";
-		saved = IS_ENABLED(CONFIG_ARC_HAS_ACCL_REGS);
-
 		/* Accumulator Low:High pair (r58:59) present if DSP MPY or FPU */
 		present = cpu->extn_mpy.dsp | cpu->extn.fpu_sp | cpu->extn.fpu_dp;
+		CHK_OPT_STRICT(CONFIG_ARC_HAS_ACCL_REGS, present);
 	}
-
-	if (present && !saved)
-		pr_warn("Enable %s for working apps\n", opt_nm);
-	else if (!present && saved)
-		panic("Disable %s, hardware NOT present\n", opt_nm);
 }
 
 /*
-- 
2.21.1

