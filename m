Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9291C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF37520719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="S0x6XhgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgDGNOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:14:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34027 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgDGNN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:13:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48xSXf5cpsz9tyQ2;
        Tue,  7 Apr 2020 15:13:54 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=S0x6XhgM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sjUIJJjIfdFK; Tue,  7 Apr 2020 15:13:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48xSXf3n06z9ty2V;
        Tue,  7 Apr 2020 15:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586265234; bh=Rmwc0A7uZPaca2pYl3mLjUC2hKKmMsy4icLjoIOooDQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=S0x6XhgMtVavqZu1VQTkWSwh6sXHEZLagcs749y5B1bjRIlQAaLdcrWUGg/uAu6TQ
         MkMkh0sp91l1mXY0rS4mACm/P/cFQxU4WQSylk7MJWrgif7j4FS6jxSDQ5p1iN0poJ
         zPgA9qGnGDCqu6EfFfFDwZEM/Nev5qub1alrlbKM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF0FF8B79C;
        Tue,  7 Apr 2020 15:13:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tC9s6CCLf9Qo; Tue,  7 Apr 2020 15:13:55 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 811AF8B7B9;
        Tue,  7 Apr 2020 15:13:55 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 56B3A65746; Tue,  7 Apr 2020 13:13:55 +0000 (UTC)
Message-Id: <0e7f77332812cb875d5a9e5e54d78c92f0383792.1586265010.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1586265010.git.christophe.leroy@c-s.fr>
References: <cover.1586265010.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 3/4] powerpc/processor: Move cpu_relax() into
 asm/vdso/processor.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org
Date:   Tue,  7 Apr 2020 13:13:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_relax() need to be in asm/vdso/processor.h to be used by
the C VDSO generic library.

Move it there.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/processor.h      | 10 ++--------
 arch/powerpc/include/asm/vdso/processor.h | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/processor.h

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index eedcbfb9a6ff..89c9eab8e45c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -6,6 +6,8 @@
  * Copyright (C) 2001 PPC 64 Team, IBM Corp
  */
 
+#include <vdso/processor.h>
+
 #include <asm/reg.h>
 
 #ifdef CONFIG_VSX
@@ -63,14 +65,6 @@ extern int _chrp_type;
 
 #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
 
-/* Macros for adjusting thread priority (hardware multi-threading) */
-#define HMT_very_low()   asm volatile("or 31,31,31   # very low priority")
-#define HMT_low()	 asm volatile("or 1,1,1	     # low priority")
-#define HMT_medium_low() asm volatile("or 6,6,6      # medium low priority")
-#define HMT_medium()	 asm volatile("or 2,2,2	     # medium priority")
-#define HMT_medium_high() asm volatile("or 5,5,5      # medium high priority")
-#define HMT_high()	 asm volatile("or 3,3,3	     # high priority")
-
 #ifdef __KERNEL__
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..39b9beace9ca
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+/* Macros for adjusting thread priority (hardware multi-threading) */
+#define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
+#define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
+#define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
+#define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
+#define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
+#define HMT_high()		asm volatile("or 3, 3, 3	# high priority")
+
+#ifdef CONFIG_PPC64
+#define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+#else
+#define cpu_relax()	barrier()
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
-- 
2.25.0

