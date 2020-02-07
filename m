Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A40C352A5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC30A22522
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T1EdeMqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGJw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:52:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37529 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBGJw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:52:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1020851pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWIoySfTs+lYj43oDvfKH9OpO9DF7iULZlt5qviH+8A=;
        b=T1EdeMqp3OpvEIUD067ScWuXZuCd8XlSmFGVywk4DzSH6/6H1nFXZIcRTi7eLwBvBk
         +W4octi2UT5DzDuW0YXlQrlPVbYltKEU+MX7Kl0nHQ7mHuSPXBhpcUaQ2TBronsX2Rra
         nYy0Dda1dW/8g2usNTlGA7JWjllKI2rns6jyujZOo38AQjBqi71tOKbFf/rDK1NxHnbj
         Db3VKgqAZUyghgUBgFuyQJtz0YZq06RzaG0QcLnnhEHDiIHOVV3W8oL22yi9VW12OqKm
         Q0vF/YJoIwGoiVSEovgXg5LqYmry65q9uFzczdmollrYCXsblZditHu/81IHhW5/eoPJ
         OAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWIoySfTs+lYj43oDvfKH9OpO9DF7iULZlt5qviH+8A=;
        b=Q/Eza4t1UyuE3Ny8FhMMLjkbSnUjI9x03m62i+C7ggP8xknlxkeBoLbS3W/Ihy1K6f
         EwQvdCHq63MlFspt5695PzZn4zGx368dzdfCm68xo+uyQ3kj5J+c1XZF5TZz4xTzdkcH
         NdiN72G6tbdmRN0eCkgJ3RMxim/9qQ439Xdl8P0BT7dzliNh5oyIhxDELVujJl+H5Vqn
         lgvpa6AkOFosSrU0vslj37g2VLik/ucyI1tXcljixtnGKBCjVZfLv8f/XGKmIc9Od9kc
         SP2k9XxpVgozARz1yKuXU4JuYKo17V8QlB0FBVEFvvWCK9HwtzNt+z0CDbm79cTbV7d5
         JlrQ==
X-Gm-Message-State: APjAAAWNFr1MajdbjG4V69fky3fblXdXjuVU2juw3c+X8xSdGkmqmjvU
        aboHDN39Jwb7Jv6e8qyMwnimig==
X-Google-Smtp-Source: APXvYqzpAt+eHl3Ef66fH5hx5gSetjsz7ko9rZ4uUWujTcWwyfFAsCFXvynl7xHbd2T9dI1V9vm4EQ==
X-Received: by 2002:a65:4242:: with SMTP id d2mr8690309pgq.166.1581069176273;
        Fri, 07 Feb 2020 01:52:56 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s23sm2060934pjq.17.2020.02.07.01.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:52:55 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/2] riscv: adjust the indent
Date:   Fri,  7 Feb 2020 17:52:45 +0800
Message-Id: <20200207095245.21955-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207095245.21955-1-zong.li@sifive.com>
References: <20200207095245.21955-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the indent to match Linux coding style.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/kasan_init.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index f8eaf7e73a23..ec0ca90dd900 100644
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
@@ -86,7 +89,8 @@ void __init kasan_init(void)
 	unsigned long i;
 
 	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
-			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
+				    (void *)kasan_mem_to_shadow((void *)
+								VMALLOC_END));
 
 	for_each_memblock(memory, reg) {
 		void *start = (void *)__va(reg->base);
@@ -95,14 +99,14 @@ void __init kasan_init(void)
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

