Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A1823B45
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHOVoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:44:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:55000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgHOVnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:43:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3634FB04F;
        Sat, 15 Aug 2020 10:07:11 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 6/6] x86/paravirt: avoid needless paravirt step clearing page table entries
Date:   Sat, 15 Aug 2020 12:06:41 +0200
Message-Id: <20200815100641.26362-7-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200815100641.26362-1-jgross@suse.com>
References: <20200815100641.26362-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_clear() et al are based on tw0 paravirt steps today: one step to
create a page table entry with all zeroes, and one step to write this
entry value.

Drop the first step as it is completely useless.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f0464b88ea1e..d25cc6830e89 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -448,7 +448,7 @@ static inline pudval_t pud_val(pud_t pud)
 
 static inline void pud_clear(pud_t *pudp)
 {
-	set_pud(pudp, __pud(0));
+	set_pud(pudp, native_make_pud(0));
 }
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
@@ -485,15 +485,15 @@ static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 } while (0)
 
 #define pgd_clear(pgdp) do {						\
-	if (pgtable_l5_enabled())						\
-		set_pgd(pgdp, __pgd(0));				\
+	if (pgtable_l5_enabled())					\
+		set_pgd(pgdp, native_make_pgd(0));			\
 } while (0)
 
 #endif  /* CONFIG_PGTABLE_LEVELS == 5 */
 
 static inline void p4d_clear(p4d_t *p4dp)
 {
-	set_p4d(p4dp, __p4d(0));
+	set_p4d(p4dp, native_make_p4d(0));
 }
 
 static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -504,12 +504,12 @@ static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep)
 {
-	set_pte(ptep, __pte(0));
+	set_pte(ptep, native_make_pte(0));
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
 {
-	set_pmd(pmdp, __pmd(0));
+	set_pmd(pmdp, native_make_pmd(0));
 }
 
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
-- 
2.26.2

