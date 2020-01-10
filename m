Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64EC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5682469A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAJR7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgAJR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ4-00028o-QA; Fri, 10 Jan 2020 18:59:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 61B7D1C2D6B;
        Fri, 10 Jan 2020 18:59:18 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:18 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm/vmalloc: Add empty <asm/vmalloc.h> headers and use
 them from <linux/vmalloc.h>
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867915825.30329.14197641774716750430.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1f059dfdf5d170dccbac92193be2fee3c1763384
Gitweb:        https://git.kernel.org/tip/1f059dfdf5d170dccbac92193be2fee3c1763384
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 28 Nov 2019 08:19:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

mm/vmalloc: Add empty <asm/vmalloc.h> headers and use them from <linux/vmalloc.h>

In the x86 MM code we'd like to untangle various types of historic
header dependency spaghetti, but for this we'd need to pass to
the generic vmalloc code various vmalloc related defines that
customarily come via the <asm/page.h> low level arch header.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/alpha/include/asm/vmalloc.h      | 4 ++++
 arch/arc/include/asm/vmalloc.h        | 4 ++++
 arch/arm/include/asm/vmalloc.h        | 4 ++++
 arch/arm64/include/asm/vmalloc.h      | 4 ++++
 arch/c6x/include/asm/vmalloc.h        | 4 ++++
 arch/csky/include/asm/vmalloc.h       | 4 ++++
 arch/h8300/include/asm/vmalloc.h      | 4 ++++
 arch/hexagon/include/asm/vmalloc.h    | 4 ++++
 arch/ia64/include/asm/vmalloc.h       | 4 ++++
 arch/m68k/include/asm/vmalloc.h       | 4 ++++
 arch/microblaze/include/asm/vmalloc.h | 4 ++++
 arch/mips/include/asm/vmalloc.h       | 4 ++++
 arch/nds32/include/asm/vmalloc.h      | 4 ++++
 arch/nios2/include/asm/vmalloc.h      | 4 ++++
 arch/openrisc/include/asm/vmalloc.h   | 4 ++++
 arch/parisc/include/asm/vmalloc.h     | 4 ++++
 arch/powerpc/include/asm/vmalloc.h    | 4 ++++
 arch/riscv/include/asm/vmalloc.h      | 4 ++++
 arch/s390/include/asm/vmalloc.h       | 4 ++++
 arch/sh/include/asm/vmalloc.h         | 4 ++++
 arch/sparc/include/asm/vmalloc.h      | 4 ++++
 arch/um/include/asm/vmalloc.h         | 4 ++++
 arch/unicore32/include/asm/vmalloc.h  | 4 ++++
 arch/x86/include/asm/vmalloc.h        | 4 ++++
 arch/xtensa/include/asm/vmalloc.h     | 4 ++++
 include/linux/vmalloc.h               | 2 ++
 26 files changed, 102 insertions(+)
 create mode 100644 arch/alpha/include/asm/vmalloc.h
 create mode 100644 arch/arc/include/asm/vmalloc.h
 create mode 100644 arch/arm/include/asm/vmalloc.h
 create mode 100644 arch/arm64/include/asm/vmalloc.h
 create mode 100644 arch/c6x/include/asm/vmalloc.h
 create mode 100644 arch/csky/include/asm/vmalloc.h
 create mode 100644 arch/h8300/include/asm/vmalloc.h
 create mode 100644 arch/hexagon/include/asm/vmalloc.h
 create mode 100644 arch/ia64/include/asm/vmalloc.h
 create mode 100644 arch/m68k/include/asm/vmalloc.h
 create mode 100644 arch/microblaze/include/asm/vmalloc.h
 create mode 100644 arch/mips/include/asm/vmalloc.h
 create mode 100644 arch/nds32/include/asm/vmalloc.h
 create mode 100644 arch/nios2/include/asm/vmalloc.h
 create mode 100644 arch/openrisc/include/asm/vmalloc.h
 create mode 100644 arch/parisc/include/asm/vmalloc.h
 create mode 100644 arch/powerpc/include/asm/vmalloc.h
 create mode 100644 arch/riscv/include/asm/vmalloc.h
 create mode 100644 arch/s390/include/asm/vmalloc.h
 create mode 100644 arch/sh/include/asm/vmalloc.h
 create mode 100644 arch/sparc/include/asm/vmalloc.h
 create mode 100644 arch/um/include/asm/vmalloc.h
 create mode 100644 arch/unicore32/include/asm/vmalloc.h
 create mode 100644 arch/x86/include/asm/vmalloc.h
 create mode 100644 arch/xtensa/include/asm/vmalloc.h

diff --git a/arch/alpha/include/asm/vmalloc.h b/arch/alpha/include/asm/vmalloc.h
new file mode 100644
index 0000000..0a9a366
--- /dev/null
+++ b/arch/alpha/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_ALPHA_VMALLOC_H
+#define _ASM_ALPHA_VMALLOC_H
+
+#endif /* _ASM_ALPHA_VMALLOC_H */
diff --git a/arch/arc/include/asm/vmalloc.h b/arch/arc/include/asm/vmalloc.h
new file mode 100644
index 0000000..973095a
--- /dev/null
+++ b/arch/arc/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_ARC_VMALLOC_H
+#define _ASM_ARC_VMALLOC_H
+
+#endif /* _ASM_ARC_VMALLOC_H */
diff --git a/arch/arm/include/asm/vmalloc.h b/arch/arm/include/asm/vmalloc.h
new file mode 100644
index 0000000..a9b3718
--- /dev/null
+++ b/arch/arm/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_ARM_VMALLOC_H
+#define _ASM_ARM_VMALLOC_H
+
+#endif /* _ASM_ARM_VMALLOC_H */
diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
new file mode 100644
index 0000000..2ca708a
--- /dev/null
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_ARM64_VMALLOC_H
+#define _ASM_ARM64_VMALLOC_H
+
+#endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/arch/c6x/include/asm/vmalloc.h b/arch/c6x/include/asm/vmalloc.h
new file mode 100644
index 0000000..26c6c66
--- /dev/null
+++ b/arch/c6x/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_C6X_VMALLOC_H
+#define _ASM_C6X_VMALLOC_H
+
+#endif /* _ASM_C6X_VMALLOC_H */
diff --git a/arch/csky/include/asm/vmalloc.h b/arch/csky/include/asm/vmalloc.h
new file mode 100644
index 0000000..43dca63
--- /dev/null
+++ b/arch/csky/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_CSKY_VMALLOC_H
+#define _ASM_CSKY_VMALLOC_H
+
+#endif /* _ASM_CSKY_VMALLOC_H */
diff --git a/arch/h8300/include/asm/vmalloc.h b/arch/h8300/include/asm/vmalloc.h
new file mode 100644
index 0000000..08a55c1
--- /dev/null
+++ b/arch/h8300/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_H8300_VMALLOC_H
+#define _ASM_H8300_VMALLOC_H
+
+#endif /* _ASM_H8300_VMALLOC_H */
diff --git a/arch/hexagon/include/asm/vmalloc.h b/arch/hexagon/include/asm/vmalloc.h
new file mode 100644
index 0000000..7b04609
--- /dev/null
+++ b/arch/hexagon/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_HEXAGON_VMALLOC_H
+#define _ASM_HEXAGON_VMALLOC_H
+
+#endif /* _ASM_HEXAGON_VMALLOC_H */
diff --git a/arch/ia64/include/asm/vmalloc.h b/arch/ia64/include/asm/vmalloc.h
new file mode 100644
index 0000000..a2b5114
--- /dev/null
+++ b/arch/ia64/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_IA64_VMALLOC_H
+#define _ASM_IA64_VMALLOC_H
+
+#endif /* _ASM_IA64_VMALLOC_H */
diff --git a/arch/m68k/include/asm/vmalloc.h b/arch/m68k/include/asm/vmalloc.h
new file mode 100644
index 0000000..bc1dca6
--- /dev/null
+++ b/arch/m68k/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_M68K_VMALLOC_H
+#define _ASM_M68K_VMALLOC_H
+
+#endif /* _ASM_M68K_VMALLOC_H */
diff --git a/arch/microblaze/include/asm/vmalloc.h b/arch/microblaze/include/asm/vmalloc.h
new file mode 100644
index 0000000..04013a4
--- /dev/null
+++ b/arch/microblaze/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_MICROBLAZE_VMALLOC_H
+#define _ASM_MICROBLAZE_VMALLOC_H
+
+#endif /* _ASM_MICROBLAZE_VMALLOC_H */
diff --git a/arch/mips/include/asm/vmalloc.h b/arch/mips/include/asm/vmalloc.h
new file mode 100644
index 0000000..25dc09b
--- /dev/null
+++ b/arch/mips/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_MIPS_VMALLOC_H
+#define _ASM_MIPS_VMALLOC_H
+
+#endif /* _ASM_MIPS_VMALLOC_H */
diff --git a/arch/nds32/include/asm/vmalloc.h b/arch/nds32/include/asm/vmalloc.h
new file mode 100644
index 0000000..caeed38
--- /dev/null
+++ b/arch/nds32/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_NDS32_VMALLOC_H
+#define _ASM_NDS32_VMALLOC_H
+
+#endif /* _ASM_NDS32_VMALLOC_H */
diff --git a/arch/nios2/include/asm/vmalloc.h b/arch/nios2/include/asm/vmalloc.h
new file mode 100644
index 0000000..ec7a926
--- /dev/null
+++ b/arch/nios2/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_NIOS2_VMALLOC_H
+#define _ASM_NIOS2_VMALLOC_H
+
+#endif /* _ASM_NIOS2_VMALLOC_H */
diff --git a/arch/openrisc/include/asm/vmalloc.h b/arch/openrisc/include/asm/vmalloc.h
new file mode 100644
index 0000000..75435ec
--- /dev/null
+++ b/arch/openrisc/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_OPENRISC_VMALLOC_H
+#define _ASM_OPENRISC_VMALLOC_H
+
+#endif /* _ASM_OPENRISC_VMALLOC_H */
diff --git a/arch/parisc/include/asm/vmalloc.h b/arch/parisc/include/asm/vmalloc.h
new file mode 100644
index 0000000..1088ae4
--- /dev/null
+++ b/arch/parisc/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_PARISC_VMALLOC_H
+#define _ASM_PARISC_VMALLOC_H
+
+#endif /* _ASM_PARISC_VMALLOC_H */
diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
new file mode 100644
index 0000000..b992dfa
--- /dev/null
+++ b/arch/powerpc/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_POWERPC_VMALLOC_H
+#define _ASM_POWERPC_VMALLOC_H
+
+#endif /* _ASM_POWERPC_VMALLOC_H */
diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
new file mode 100644
index 0000000..ff9abc0
--- /dev/null
+++ b/arch/riscv/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_RISCV_VMALLOC_H
+#define _ASM_RISCV_VMALLOC_H
+
+#endif /* _ASM_RISCV_VMALLOC_H */
diff --git a/arch/s390/include/asm/vmalloc.h b/arch/s390/include/asm/vmalloc.h
new file mode 100644
index 0000000..3ba3a6b
--- /dev/null
+++ b/arch/s390/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_S390_VMALLOC_H
+#define _ASM_S390_VMALLOC_H
+
+#endif /* _ASM_S390_VMALLOC_H */
diff --git a/arch/sh/include/asm/vmalloc.h b/arch/sh/include/asm/vmalloc.h
new file mode 100644
index 0000000..716b774
--- /dev/null
+++ b/arch/sh/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_SH_VMALLOC_H
+#define _ASM_SH_VMALLOC_H
+
+#endif /* _ASM_SH_VMALLOC_H */
diff --git a/arch/sparc/include/asm/vmalloc.h b/arch/sparc/include/asm/vmalloc.h
new file mode 100644
index 0000000..04b8ab9
--- /dev/null
+++ b/arch/sparc/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_SPARC_VMALLOC_H
+#define _ASM_SPARC_VMALLOC_H
+
+#endif /* _ASM_SPARC_VMALLOC_H */
diff --git a/arch/um/include/asm/vmalloc.h b/arch/um/include/asm/vmalloc.h
new file mode 100644
index 0000000..9a7b9ed
--- /dev/null
+++ b/arch/um/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_UM_VMALLOC_H
+#define _ASM_UM_VMALLOC_H
+
+#endif /* _ASM_UM_VMALLOC_H */
diff --git a/arch/unicore32/include/asm/vmalloc.h b/arch/unicore32/include/asm/vmalloc.h
new file mode 100644
index 0000000..0544358
--- /dev/null
+++ b/arch/unicore32/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_UNICORE32_VMALLOC_H
+#define _ASM_UNICORE32_VMALLOC_H
+
+#endif /* _ASM_UNICORE32_VMALLOC_H */
diff --git a/arch/x86/include/asm/vmalloc.h b/arch/x86/include/asm/vmalloc.h
new file mode 100644
index 0000000..ba6295f
--- /dev/null
+++ b/arch/x86/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_X86_VMALLOC_H
+#define _ASM_X86_VMALLOC_H
+
+#endif /* _ASM_X86_VMALLOC_H */
diff --git a/arch/xtensa/include/asm/vmalloc.h b/arch/xtensa/include/asm/vmalloc.h
new file mode 100644
index 0000000..0eb94b7
--- /dev/null
+++ b/arch/xtensa/include/asm/vmalloc.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_XTENSA_VMALLOC_H
+#define _ASM_XTENSA_VMALLOC_H
+
+#endif /* _ASM_XTENSA_VMALLOC_H */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index a4b2411..ec38132 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -10,6 +10,8 @@
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
 
+#include <asm/vmalloc.h>
+
 struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
 struct notifier_block;		/* in notifier.h */
 
