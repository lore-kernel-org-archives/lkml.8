Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33184C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EB52073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="L46dDlkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBLFrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:47:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45164 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgBLFre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:47:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so645759pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 21:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0eDFn39gIg7xtZfHp4ELa6UyXk2yfoJL9wFZ1T547PE=;
        b=L46dDlkOez2ml8dh2NS+K4qq7GTlG/io/AMAU9SRBGPaz4blna+0SbhhfSOT8CxueM
         GKZ5MCVfZZ6DX82aTrUsAMnj/FU5JzlRV4IiQjIA4KhwgqWDk4SzORV9x4CxyzRqrRHb
         1CHvDymIOD+q8aqsKCluSH5SAPqL9he+ZO5o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0eDFn39gIg7xtZfHp4ELa6UyXk2yfoJL9wFZ1T547PE=;
        b=cOhcR+ijuEXugGegHdhQjAy3flQfUhzsXGzJoLekrxkOYlt0tGnzWTYKf/9jL9eZaK
         6D+OFcs48NVAgJ/iQTz7YTVQSTUqOfRFTRUacRWv32XlmkwW6ufQ5OZe3wvU33MNfa79
         PvqwrXANZrSs8pEvAyWNvJlvvARQOdCSKFm8WeDUszO9jpY8Hic7ZjLybDX3niHHJMv9
         Bfvtchf/dyqVa+N61fK9G2LC6GswOdHA/ZHqf0WWXQ9en7AxQiEIs4cCBut5/uxiGBMj
         lo9BFoHgdM6l+biMikuVpAdKL6J/RHvN+z8gOF5EByIJHTXf7r8KcqUQpGsN/TYBSUAm
         tZIg==
X-Gm-Message-State: APjAAAV3HUY+qRrDYELTjTs8eCS9zo5Dwj8cg9XSLJ2uzePbdMnN/PjC
        NAduP2eLdZwWrKhFwxUIO6fh7nPaicc=
X-Google-Smtp-Source: APXvYqz1Geq46JTS1k8k9cQzXBKQ43uOUT4qhGGPD7QkzUf9EB0qW8h3Jb/pGJ4+qFGDFiZWJtusww==
X-Received: by 2002:a62:2cd8:: with SMTP id s207mr6815093pfs.247.1581486453988;
        Tue, 11 Feb 2020 21:47:33 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-65dc-9b98-63a7-c7a4.static.ipv6.internode.on.net. [2001:44b8:1113:6700:65dc:9b98:63a7:c7a4])
        by smtp.gmail.com with ESMTPSA id d64sm6160498pga.17.2020.02.11.21.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 21:47:33 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v6 1/4] kasan: define and use MAX_PTRS_PER_* for early shadow tables
Date:   Wed, 12 Feb 2020 16:47:21 +1100
Message-Id: <20200212054724.7708-2-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212054724.7708-1-dja@axtens.net>
References: <20200212054724.7708-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc has a variable number of PTRS_PER_*, set at runtime based
on the MMU that the kernel is booted under.

This means the PTRS_PER_* are no longer constants, and therefore
breaks the build.

Define default MAX_PTRS_PER_*s in the same style as MAX_PTRS_PER_P4D.
As KASAN is the only user at the moment, just define them in the kasan
header, and have them default to PTRS_PER_* unless overridden in arch
code.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Suggested-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/kasan.h | 18 +++++++++++++++---
 mm/kasan/init.c       |  6 +++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5cde9e7c2664..b3a4500633f5 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -14,10 +14,22 @@ struct task_struct;
 #include <asm/kasan.h>
 #include <asm/pgtable.h>
 
+#ifndef MAX_PTRS_PER_PTE
+#define MAX_PTRS_PER_PTE PTRS_PER_PTE
+#endif
+
+#ifndef MAX_PTRS_PER_PMD
+#define MAX_PTRS_PER_PMD PTRS_PER_PMD
+#endif
+
+#ifndef MAX_PTRS_PER_PUD
+#define MAX_PTRS_PER_PUD PTRS_PER_PUD
+#endif
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
-extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
-extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
-extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
+extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE];
+extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
+extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 
 int kasan_populate_early_shadow(const void *shadow_start,
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ce45c491ebcd..8b54a96d3b3e 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -46,7 +46,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
-pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
+pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
 static inline bool kasan_pud_table(p4d_t p4d)
 {
 	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
@@ -58,7 +58,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
+pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
 static inline bool kasan_pmd_table(pud_t pud)
 {
 	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
@@ -69,7 +69,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 	return false;
 }
 #endif
-pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
+pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE] __page_aligned_bss;
 
 static inline bool kasan_pte_table(pmd_t pmd)
 {
-- 
2.20.1

