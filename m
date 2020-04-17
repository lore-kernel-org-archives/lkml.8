Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD891C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B94B2078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="T6ZcrWl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbgDQL6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:58:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5210 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730536AbgDQL6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:58:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 493ZP94TH5z9txqC;
        Fri, 17 Apr 2020 13:58:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=T6ZcrWl5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L8-nDmWdDGG7; Fri, 17 Apr 2020 13:58:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 493ZP93Nypz9txq9;
        Fri, 17 Apr 2020 13:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587124717; bh=b06zPAdyaI6WB+z5IDxc8Z72FybQU9Qa2n4l+Mw1owo=;
        h=From:Subject:To:Cc:Date:From;
        b=T6ZcrWl5+P4NUf5FR8ygy4zLUxwZvE70tXSVBnVN8rdjKFC/ZuDxQOU87yPoe5Vrh
         yARXC/HP6COUeq01z59E3n80tES0P1ky/O1JmuhJVzP6pL7o8PgNn24y/kV7RWAT0E
         yamtLqNNQoaC6Lvs4hrCGXLtI3uSRingWS6ucLp0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE2BE8B75E;
        Fri, 17 Apr 2020 13:58:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ywUdqUU_tmiC; Fri, 17 Apr 2020 13:58:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 35D018BB4C;
        Fri, 17 Apr 2020 13:58:38 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 0416F657A3; Fri, 17 Apr 2020 11:58:37 +0000 (UTC)
Message-Id: <6d1f8b6267eed56e7fcaffe68a40ba820a0f28d9.1587124655.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Kill the task on KUAP fault
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 17 Apr 2020 11:58:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task generates a KUAP fault, even from an acceptable
user access sequence, it is not a simple EFAULT.

Instead of emiting a warning, print a critical message and
kill the task with SIGSEGV.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h       |  7 +++++--
 arch/powerpc/include/asm/book3s/64/kup-radix.h | 14 +++++++++++---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h   |  8 ++++++--
 arch/powerpc/mm/fault.c                        |  6 +++++-
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 3c0ba22dc360..63422650cb86 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -181,12 +181,15 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	unsigned long begin = regs->kuap & 0xf0000000;
 	unsigned long end = regs->kuap << 28;
+	bool is_fault = address < begin || address >= end;
 
 	if (!is_write)
 		return false;
 
-	return WARN(address < begin || address >= end,
-		    "Bug: write fault blocked by segment registers !");
+	if (is_fault)
+		pr_crit("Bug: write fault blocked by segment registers !");
+
+	return is_fault;
 }
 
 #endif /* CONFIG_PPC_KUAP */
diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
index 3bcef989a35d..41a450d0aa06 100644
--- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -137,9 +137,17 @@ static inline void restore_user_access(unsigned long flags)
 static inline bool
 bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
-	return WARN(mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
-		    (regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_READ)),
-		    "Bug: %s fault blocked by AMR!", is_write ? "Write" : "Read");
+	bool is_fault;
+
+	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
+		return false;
+
+	is_fault = regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_READ);
+
+	if (is_fault)
+		pr_crit("Bug: %s fault blocked by AMR!", is_write ? "Write" : "Read");
+
+	return is_fault;
 }
 #else /* CONFIG_PPC_KUAP */
 static inline void kuap_restore_amr(struct pt_regs *regs)
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 85ed2390fb99..31419126c2bf 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -63,8 +63,12 @@ static inline void restore_user_access(unsigned long flags)
 static inline bool
 bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
-	return WARN(!((regs->kuap ^ MD_APG_KUAP) & 0xf0000000),
-		    "Bug: fault blocked by AP register !");
+	bool is_fault = !((regs->kuap ^ MD_APG_KUAP) & 0xf0000000);
+
+	if (is_fault)
+		pr_crit("Bug: fault blocked by AP register !\n");
+
+	return is_fault;
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 84af6c8eecf7..91b458aa666e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -233,8 +233,12 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
 
 	// Read/write fault in a valid region (the exception table search passed
 	// above), but blocked by KUAP is bad, it can never succeed.
-	if (bad_kuap_fault(regs, address, is_write))
+	if (bad_kuap_fault(regs, address, is_write)) {
+		pr_crit("kernel %s to userspace (%lx) blocked by KUAP\n",
+			is_write ? "write" : "read", address);
+		_exception(SIGSEGV, regs, SEGV_ACCERR, address);
 		return true;
+	}
 
 	// What's left? Kernel fault on user in well defined regions (extable
 	// matched), and allowed by KUAP in the faulting context.
-- 
2.25.0

