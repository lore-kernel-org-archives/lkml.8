Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64955C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B41D20848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736938;
	bh=1fnI6aUTDTUR6gujDAhqQrt0aJB0YLNvLt5D3fwF7xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tl1FWHacsPy1QttTFR3goYiWCnxpaFjbQAimn2+x3uWKLJD5paQwGSMfRQXO6xHXA
	 3Tm3w5kHiNooXxbQiGo03piBaTF9fB7lNpsyPOx1+y9dFPtM0DohsOZfv43ZqY4GSC
	 4iYbnLx/wh0YNCZrq8bUcHsXfO3IggHdOM6xjxfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAKKCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgAKKCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:02:16 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A8320842;
        Sat, 11 Jan 2020 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736935;
        bh=1fnI6aUTDTUR6gujDAhqQrt0aJB0YLNvLt5D3fwF7xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=15RJp5JFqhqamehM8WAg0y7cNsOiwUg6IrTyYRRbZrFqMD1G3374lY9T/cHooTWHS
         WhWv8von4/R9G3BSq8y2hkAbdS3gqTUCE2hlx7MwGVWScO9ZvcTlBjXC6GTccCDvj1
         O7OfGgDBiCjkLI5ygHayqysTA5auEIAx96RyMMUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 33/91] arm64: Revert support for execute-only user mappings
Date:   Sat, 11 Jan 2020 10:49:26 +0100
Message-Id: <20200111094857.366585437@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

commit 24cecc37746393432d994c0dbc251fb9ac7c5d72 upstream.

The ARMv8 64-bit architecture supports execute-only user permissions by
clearing the PTE_USER and PTE_UXN bits, practically making it a mostly
privileged mapping but from which user running at EL0 can still execute.

The downside, however, is that the kernel at EL1 inadvertently reading
such mapping would not trip over the PAN (privileged access never)
protection.

Revert the relevant bits from commit cab15ce604e5 ("arm64: Introduce
execute-only page access permissions") so that PROT_EXEC implies
PROT_READ (and therefore PTE_USER) until the architecture gains proper
support for execute-only user mappings.

Fixes: cab15ce604e5 ("arm64: Introduce execute-only page access permissions")
Cc: <stable@vger.kernel.org> # 4.9.x-
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/include/asm/pgtable-prot.h |    5 ++---
 arch/arm64/include/asm/pgtable.h      |   10 +++-------
 arch/arm64/mm/fault.c                 |    2 +-
 mm/mmap.c                             |    6 ------
 4 files changed, 6 insertions(+), 17 deletions(-)

--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -77,13 +77,12 @@
 #define PAGE_COPY_EXEC		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
 #define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
 #define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
-#define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_NG | PTE_PXN)
 
 #define __P000  PAGE_NONE
 #define __P001  PAGE_READONLY
 #define __P010  PAGE_COPY
 #define __P011  PAGE_COPY
-#define __P100  PAGE_EXECONLY
+#define __P100  PAGE_READONLY_EXEC
 #define __P101  PAGE_READONLY_EXEC
 #define __P110  PAGE_COPY_EXEC
 #define __P111  PAGE_COPY_EXEC
@@ -92,7 +91,7 @@
 #define __S001  PAGE_READONLY
 #define __S010  PAGE_SHARED
 #define __S011  PAGE_SHARED
-#define __S100  PAGE_EXECONLY
+#define __S100  PAGE_READONLY_EXEC
 #define __S101  PAGE_READONLY_EXEC
 #define __S110  PAGE_SHARED_EXEC
 #define __S111  PAGE_SHARED_EXEC
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -83,12 +83,8 @@ extern unsigned long empty_zero_page[PAG
 #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
 
 #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
-/*
- * Execute-only user mappings do not have the PTE_USER bit set. All valid
- * kernel mappings have the PTE_UXN bit set.
- */
 #define pte_valid_not_user(pte) \
-	((pte_val(pte) & (PTE_VALID | PTE_USER | PTE_UXN)) == (PTE_VALID | PTE_UXN))
+	((pte_val(pte) & (PTE_VALID | PTE_USER)) == PTE_VALID)
 #define pte_valid_young(pte) \
 	((pte_val(pte) & (PTE_VALID | PTE_AF)) == (PTE_VALID | PTE_AF))
 #define pte_valid_user(pte) \
@@ -104,8 +100,8 @@ extern unsigned long empty_zero_page[PAG
 
 /*
  * p??_access_permitted() is true for valid user mappings (subject to the
- * write permission check) other than user execute-only which do not have the
- * PTE_USER bit set. PROT_NONE mappings do not have the PTE_VALID bit set.
+ * write permission check). PROT_NONE mappings do not have the PTE_VALID bit
+ * set.
  */
 #define pte_access_permitted(pte, write) \
 	(pte_valid_user(pte) && (!(write) || pte_write(pte)))
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -319,7 +319,7 @@ static int __kprobes do_page_fault(unsig
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	int fault, sig, code;
-	unsigned long vm_flags = VM_READ | VM_WRITE;
+	unsigned long vm_flags = VM_READ | VM_WRITE | VM_EXEC;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	if (notify_page_fault(regs, esr))
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -87,12 +87,6 @@ static void unmap_region(struct mm_struc
  * MAP_PRIVATE	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
  *		w: (no) no	w: (no) no	w: (copy) copy	w: (no) no
  *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
- *
- * On arm64, PROT_EXEC has the following behaviour for both MAP_SHARED and
- * MAP_PRIVATE:
- *								r: (no) no
- *								w: (no) no
- *								x: (yes) yes
  */
 pgprot_t protection_map[16] = {
 	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,


