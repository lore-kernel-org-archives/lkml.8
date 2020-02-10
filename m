Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6883C35250
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC5820661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AiEyxIK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBJF5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 00:57:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37482 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJF5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:57:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so3313621pgl.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 21:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sfkmb35IpZPof1bD/rOU/zeEqg9sSc9VPK5w6BC0wlc=;
        b=AiEyxIK0eV9Djm2Eo7bsijie1cc+LBMz3Uh8E+ihWsg3qgnhO/7750+B90xPY9XD5h
         oiF9ZPOw3jMTl7TKaLwrgStvnzBOQaFvWnOWi+sLj83t6LkDeQMlT++eupUb3KSBIYtE
         DZpNW+eZh2r2Ap15ekORaQVyxetQpYiLjxD14b7KjieNsMLPPaonNVsr+tYrhXq47rxl
         qGDto+/DlKBvvDd8oTRM4lFwaIQQymjRvyf/B8jPmrjWrXtjuMj/768eRevs3dXuBtai
         yW+2qbLRjJFiBVoph/sLYWCgor48Mms1NOoWTtNgtxSJPQyB22Dtveg1FyKIBlZhEoir
         0gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sfkmb35IpZPof1bD/rOU/zeEqg9sSc9VPK5w6BC0wlc=;
        b=rGPScYpINoE/ORmuBHs6SB4Umjo2LJw8Fq1c740PmjoMFfijKDZrP/DQT6F0VrrzM+
         vNe4JR5DDCTqbvDSCQcgRtOX+fuS2ubv4rvNOy51ZARxy6yyfiMKl9DODnEHMyp0PbuN
         vaTv2uVkWD2927+3T42c4RLELPHCfwhYM/6xXufi5EF7HrfdY7DxrjyU668SEjhYmOo6
         2fWDPr9hdSl3c1poewbHonvQKsuH6Ejm0QxSazvVnYrNo/heuR1gz2YpH2JkMYTpcbPg
         mJFxqNtIQSKw70YRV/ZmRRpeAODpdGQ9G35e+kI5VXWWDZq5E7RaY3RMcpTfEEcUajrr
         u1vg==
X-Gm-Message-State: APjAAAU/1CGb1yUkAEUAdNdBFE1dbhUzZCQsoZ0tHb+eCL9IyHPiQ7u4
        Zk/vTfaqzwi3/OIPs0eSWm2N6Ib9ndM=
X-Google-Smtp-Source: APXvYqz3+aETwERtIyI+w4fTaxuNqIUthoZSuJH5Ho8GkNKVyNo+nwGfFEeLVB0BgaBmG5f4FqDcYQ==
X-Received: by 2002:a63:6607:: with SMTP id a7mr13074659pgc.310.1581314226978;
        Sun, 09 Feb 2020 21:57:06 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s206sm11140234pfs.100.2020.02.09.21.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 21:57:06 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, joe@perches.com, nickhu@andestech.com
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 2/2] riscv: adjust the indent
Date:   Mon, 10 Feb 2020 13:56:54 +0800
Message-Id: <20200210055654.96725-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210055654.96725-1-zong.li@sifive.com>
References: <20200210055654.96725-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the indent to match Linux coding style.

Changes in v2:
- Remove an unnecessary void* type casting. Suggested by Joe Perches.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/kasan_init.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index f8eaf7e73a23..abeb590e81f2 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -19,18 +19,20 @@ asmlinkage void __init kasan_early_init(void)
 	for (i = 0; i < PTRS_PER_PTE; ++i)
 		set_pte(kasan_early_shadow_pte + i,
 			mk_pte(virt_to_page(kasan_early_shadow_page),
-			PAGE_KERNEL));
+			       PAGE_KERNEL));
 
 	for (i = 0; i < PTRS_PER_PMD; ++i)
 		set_pmd(kasan_early_shadow_pmd + i,
-		 pfn_pmd(PFN_DOWN(__pa((uintptr_t)kasan_early_shadow_pte)),
-			__pgprot(_PAGE_TABLE)));
+			pfn_pmd(PFN_DOWN
+				(__pa((uintptr_t) kasan_early_shadow_pte)),
+				__pgprot(_PAGE_TABLE)));
 
 	for (i = KASAN_SHADOW_START; i < KASAN_SHADOW_END;
 	     i += PGDIR_SIZE, ++pgd)
 		set_pgd(pgd,
-		 pfn_pgd(PFN_DOWN(__pa(((uintptr_t)kasan_early_shadow_pmd))),
-			__pgprot(_PAGE_TABLE)));
+			pfn_pgd(PFN_DOWN
+				(__pa(((uintptr_t) kasan_early_shadow_pmd))),
+				__pgprot(_PAGE_TABLE)));
 
 	/* init for swapper_pg_dir */
 	pgd = pgd_offset_k(KASAN_SHADOW_START);
@@ -38,8 +40,9 @@ asmlinkage void __init kasan_early_init(void)
 	for (i = KASAN_SHADOW_START; i < KASAN_SHADOW_END;
 	     i += PGDIR_SIZE, ++pgd)
 		set_pgd(pgd,
-		 pfn_pgd(PFN_DOWN(__pa(((uintptr_t)kasan_early_shadow_pmd))),
-			__pgprot(_PAGE_TABLE)));
+			pfn_pgd(PFN_DOWN
+				(__pa(((uintptr_t) kasan_early_shadow_pmd))),
+				__pgprot(_PAGE_TABLE)));
 
 	flush_tlb_all();
 }
@@ -86,7 +89,7 @@ void __init kasan_init(void)
 	unsigned long i;
 
 	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
-			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
+				    kasan_mem_to_shadow((void *)VMALLOC_END));
 
 	for_each_memblock(memory, reg) {
 		void *start = (void *)__va(reg->base);
@@ -95,14 +98,14 @@ void __init kasan_init(void)
 		if (start >= end)
 			break;
 
-		populate(kasan_mem_to_shadow(start),
-			 kasan_mem_to_shadow(end));
+		populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
 	};
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
 		set_pte(&kasan_early_shadow_pte[i],
 			mk_pte(virt_to_page(kasan_early_shadow_page),
-			__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_ACCESSED)));
+			       __pgprot(_PAGE_PRESENT | _PAGE_READ |
+					_PAGE_ACCESSED)));
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 	init_task.kasan_depth = 0;
-- 
2.25.0

