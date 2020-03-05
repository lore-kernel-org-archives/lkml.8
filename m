Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5A720732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="D+OoHwLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgCEOdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:33:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42022 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCEOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:33:02 -0500
Received: by mail-qk1-f196.google.com with SMTP id e11so5429747qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=t12PP+Y6fPg04CGydQKRRud0jZNc7mh3eq+JnGGoFlw=;
        b=D+OoHwLv5FkiKYYj+d73ffAMgsCKhAJcd1W6XTW4We88gcuddps6vzAiuWSwtm12ec
         WIMfjMcZXNx0qEy6cpVC4VH0l5cTK+qQOA88gcaoHbzKkXczF2NN1zj4AxY+HmoyCmPA
         VeftV9WHoPHEUW+/TmYdBS6Pp7Z2vew0495PtiJGCvliuiomniLTeO+BOu7ShXSgeH+a
         IyX7US3HmI7+fYcvYS+WtzU0a1Jjo2Uvpp+GmwW3+aZ3SQ6nmXxDOxYP2njvzY/AP4Lo
         9wIb4YzvdMPQ6+MzBBpue2ktT7CHiXfN96vA1AlXiniIbePKT1hT0rCAJbe/hJQkYNfd
         imIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t12PP+Y6fPg04CGydQKRRud0jZNc7mh3eq+JnGGoFlw=;
        b=CEOV6eI0yfHdaxfmwe9o3Qotn7UJJfn/CBHCJsn1xzidd5zT4b/b/BkiV7HoLw+Uug
         8aisTBhlYj2FiXyHycVPZcuJzxGETsDwRMmQs5m1f3BmdVC/gRjgJJjvRAW+Nz5JXcJr
         Bp7jV6NGO0mdIjAc1huTutxVf2jlCm1bZXzMTtJHrYVd81DuA13c1SsIwTaSBtLm+YoM
         Capugl5LrWGYgljsIOSk4Evsd8P4ePaebj0+qRoL6E8uU0kf1QZwgaW7A/TBzdE52cCx
         CzdSNie/4Lza40GbCMuB3AmsaSPD5jpmguzNZ5dLqZ3qV2QKvvn1mChWt3kvQ+3QHNM5
         TEFQ==
X-Gm-Message-State: ANhLgQ35BNVOGp0ISrBCDz8ukOzIwEvaJYGSuqYf74UZy7HBvmBZuFGa
        ty7EV7LLo/kfwNmDFS1aqZ1MRA==
X-Google-Smtp-Source: ADFU+vsE3hyiBkiu5Q9p6/HXzxk0WFlohUygbSOHcmSvau43NwWVfS2PwRAeTD8NEkmqJRJ6pC7zBg==
X-Received: by 2002:a05:620a:2209:: with SMTP id m9mr4055395qkh.71.1583418779726;
        Thu, 05 Mar 2020 06:32:59 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f7sm16969486qtc.29.2020.03.05.06.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 06:32:59 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au, akpm@linux-foundation.org
Cc:     rashmicy@gmail.com, christophe.leroy@c-s.fr, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] powerpc/64s/pgtable: fix an undefined behaviour
Date:   Thu,  5 Mar 2020 09:32:39 -0500
Message-Id: <1583418759-16105-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a power9 server with hash MMU could trigger an undefined
behaviour because pud_offset(p4d, 0) will do,

0 >> (PAGE_SHIFT:16 + PTE_INDEX_SIZE:8 + H_PMD_INDEX_SIZE:10)

Fix it by converting pud_offset() and friends to static inline
functions.

 UBSAN: shift-out-of-bounds in arch/powerpc/mm/ptdump/ptdump.c:282:15
 shift exponent 34 is too large for 32-bit type 'int'
 CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc4-next-20200303+ #13
 Call Trace:
 dump_stack+0xf4/0x164 (unreliable)
 ubsan_epilogue+0x18/0x78
 __ubsan_handle_shift_out_of_bounds+0x160/0x21c
 walk_pagetables+0x2cc/0x700
 walk_pud at arch/powerpc/mm/ptdump/ptdump.c:282
 (inlined by) walk_pagetables at arch/powerpc/mm/ptdump/ptdump.c:311
 ptdump_check_wx+0x8c/0xf0
 mark_rodata_ro+0x48/0x80
 kernel_init+0x74/0x194
 ret_from_kernel_thread+0x5c/0x74

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index fa60e8594b9f..4967bc9e25e2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1016,12 +1016,20 @@ static inline bool p4d_access_permitted(p4d_t p4d, bool write)
 
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
-#define pud_offset(p4dp, addr)	\
-	(((pud_t *) p4d_page_vaddr(*(p4dp))) + pud_index(addr))
-#define pmd_offset(pudp,addr) \
-	(((pmd_t *) pud_page_vaddr(*(pudp))) + pmd_index(addr))
-#define pte_offset_kernel(dir,addr) \
-	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
+static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
+{
+	return (pud_t *)p4d_page_vaddr(*p4d) + pud_index(address);
+}
+
+static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
+{
+	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
+}
+
+static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
+{
+	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
+}
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 
-- 
1.8.3.1

