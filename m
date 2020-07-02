Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63124C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBF320781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="l8Hhhj8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGBCyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGBCyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:54:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49187C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:54:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so1383702pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jEAbvp0NcKYXLPlKcCam8GQvvafUBgcVOJIj099LJII=;
        b=l8Hhhj8syHtUNp+VamGkuO605PBoNs6uw34vpgDBxugaKXT2I1bsRT706gUgLeQb93
         UcvGY5rWgmysWYXpcfJjpd+Qx7bW15hiJuKELfz6TgFbM3YM7SvlWHzFwk/bZKsj/mWj
         SWSx61IQHNmJ2LbwV6MWAFY0GnBISyORFGlkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jEAbvp0NcKYXLPlKcCam8GQvvafUBgcVOJIj099LJII=;
        b=pGGGZRNlLRLTLY6W9w9Jt7IHTmmO+wKOE1ACXua9YOYZl+XAlmWGszMh93aBBwl9w6
         RnbgeZ43Lo1YORA+vd2ZnrTePE9F7RgFwDL96pr6vmwS4FFTuPeQcizCe0A0brTt2aTY
         yuoPr8Z3CCeqsjMocigJXOLd6o2oodJGFzyW58lGhgzD3iWawdFlRsHsU4dJc/bhYpnW
         k/HAXLSXfkIEaQH4cQz4EkHlHOME0fCS8oMLEcTNxWFPq9C4ivYFCWiYBR7lmtvuhBj9
         1BNNqXL4D+NoNUD0AasrquwlxILlgG1EttQZyC3CzVzLZHF1ElkRSaipYdN6LZGcdPY5
         bnaw==
X-Gm-Message-State: AOAM533rrMX8U4Zh3hRERgYsN7vds1CQjwia/IAhXipylZq89XQCTkjb
        0ELSCI6qp95/KlxOqDnKUDBoyOutj+w=
X-Google-Smtp-Source: ABdhPJzHgVpfPFDfS8EwmQPaJdUfflOkSYb9QRnPNc4+/66KDIKNgnGl0dQ7GbTywsipCv35/i6xsA==
X-Received: by 2002:a17:90a:bb84:: with SMTP id v4mr20987849pjr.162.1593658480672;
        Wed, 01 Jul 2020 19:54:40 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-3c80-6152-10ca-83bc.static.ipv6.internode.on.net. [2001:44b8:1113:6700:3c80:6152:10ca:83bc])
        by smtp.gmail.com with ESMTPSA id 140sm7127309pfz.154.2020.07.01.19.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 19:54:40 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 1/4] kasan: define and use MAX_PTRS_PER_* for early shadow tables
Date:   Thu,  2 Jul 2020 12:54:29 +1000
Message-Id: <20200702025432.16912-2-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702025432.16912-1-dja@axtens.net>
References: <20200702025432.16912-1-dja@axtens.net>
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
index 82522e996c76..b6f94952333b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -14,10 +14,22 @@ struct task_struct;
 #include <linux/pgtable.h>
 #include <asm/kasan.h>
 
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
index fe6be0be1f76..42bca3d27db8 100644
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
2.25.1

