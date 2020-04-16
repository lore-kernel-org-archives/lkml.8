Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD4FC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1715E21D79
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587043636;
	bh=vSXvfk+ZBHDHOnvNignHEMR/sPicw9FxaumxDke6jfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rCUED4lEck5ZhT3KVNN4H2+Z2VDxpuNWEltVA7Dsy4Xfpp+Y9AgWF8LvAODVHFr2V
	 iUlN/zTimbaIrZsQr7W3VmPPsxb0WW0pwqA5abvQcxn9o7wB/H/K8USS6QHBIMBDZC
	 X4iMNCOFn3nmbQDVZYK6ml05EjPnMyHi8UYscRdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895428AbgDPN1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895058AbgDPN0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:26:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5833721D93;
        Thu, 16 Apr 2020 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043583;
        bh=vSXvfk+ZBHDHOnvNignHEMR/sPicw9FxaumxDke6jfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcu6aw9hc6BN+R3G6bruTPPt4BRwhoqanwtT5wXr651Bf2flkpugHlCHkDjmSS8jx
         RyGNnq6t9wBIHHJdWgBph8908Ld+0ZpRDw/MMUdV/kD8WWkBgdGGj+SB3fg/LXUXhq
         3jRjRJ2+RJGKOJrFz1CHSImUnn6TSnCAt8kScg2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 017/146] x86: Dont let pgprot_modify() change the page encryption bit
Date:   Thu, 16 Apr 2020 15:22:38 +0200
Message-Id: <20200416131244.884838189@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

[ Upstream commit 6db73f17c5f155dbcfd5e48e621c706270b84df0 ]

When SEV or SME is enabled and active, vm_get_page_prot() typically
returns with the encryption bit set. This means that users of
pgprot_modify(, vm_get_page_prot()) (mprotect_fixup(), do_mmap()) end up
with a value of vma->vm_pg_prot that is not consistent with the intended
protection of the PTEs.

This is also important for fault handlers that rely on the VMA
vm_page_prot to set the page protection. Fix this by not allowing
pgprot_modify() to change the encryption bit, similar to how it's done
for PAT bits.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20200304114527.3636-2-thomas_os@shipmail.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/pgtable.h       | 7 +++++--
 arch/x86/include/asm/pgtable_types.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 690c0307afed0..2e1ed12c65f82 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -608,12 +608,15 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return __pmd(val);
 }
 
-/* mprotect needs to preserve PAT bits when updating vm_page_prot */
+/*
+ * mprotect needs to preserve PAT and encryption bits when updating
+ * vm_page_prot
+ */
 #define pgprot_modify pgprot_modify
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 {
 	pgprotval_t preservebits = pgprot_val(oldprot) & _PAGE_CHG_MASK;
-	pgprotval_t addbits = pgprot_val(newprot);
+	pgprotval_t addbits = pgprot_val(newprot) & ~_PAGE_CHG_MASK;
 	return __pgprot(preservebits | addbits);
 }
 
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 106b7d0e2dae5..71ea49e7db747 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -124,7 +124,7 @@
  */
 #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
 /*
-- 
2.20.1



