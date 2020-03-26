Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394FDC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A8B20746
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lfgJ5e8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCZDYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41386 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbgCZDYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id q188so5094447qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/Ha04HVP09wLsA+m7AwzAUIvaSN0h5yH2XDwYGttZt8=;
        b=lfgJ5e8wODMhjhd3EqUkzc8ismHRO3h4YiAdLWHtNOqpuNN2pXlaN6A/evefZ2/iTV
         Kyj8wsBHg0YvX66KQaJT8GGeng65oo9d3T6LwHZfgmYGO2BJy57G46z1vHEaPjAz8jwx
         81F9gHaLcgrdWqDqdbR7JldCvHkLP6CpD2wzYilGpLfJtaQauW2jvICZbdYTnBdkvX+M
         Zs71QuTRZ/4qPztZ32Xbqj22+2jniG3bd3TVvPwSqs5V1RJGLKeA5Vv9dlCqKK60/r4j
         vVJzOtCtZse3+MXqBG02pIWsEmsoaQfGcyPRsHpD/9vgRsXFRCefH/i+3SRUe4G9HjZW
         tISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/Ha04HVP09wLsA+m7AwzAUIvaSN0h5yH2XDwYGttZt8=;
        b=YytdY7FBvT23JSlWEKC06GTkplxdgpINhoR1Mpwlo7B4BsepBif6584IyxBbJSrcr0
         eQjfUnhfyKpUzrCYwNnCfPEcDG+LD9MlF1dMNQbTkATAK90f2TvwAW9VjqE8rBaSwC7e
         qNmhSi8ufcz2GLAbvjx1FDDMKCSsnQjnNtZzrNI/r3FJHNrsy8a57zI1NU8ntLABU3jR
         jYyG9vPPvEUMzUkznIwbZCsCG1NY+utZnJNJ622my6zKQrRWjM88/KmxiQyu5n7ZV2Gu
         b3fz0gfe7Ece1oyc/gMIEhpUeG6cgWNc7UGn82VV6PEdoiPSXcgUh3vK6d/0pkqB/zsU
         EUwA==
X-Gm-Message-State: ANhLgQ2eRTcAtVs/buqGUsxQKlVjd59613MJhuS3Zk4ZNcoRNqT72MCM
        u4X5P3+rdjTiUfKc9aOeROSWAQ==
X-Google-Smtp-Source: ADFU+vu3Rc5UkCrQ+4t6bZVLJVgpd6G5rs76GwLMmw2vzo4tLQGaATsAula88JtT+4Hnl9hceDwEPg==
X-Received: by 2002:a37:9e56:: with SMTP id h83mr6432213qke.389.1585193069114;
        Wed, 25 Mar 2020 20:24:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:28 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 04/18] arm64: trans_pgd: pass allocator trans_pgd_create_copy
Date:   Wed, 25 Mar 2020 23:24:06 -0400
Message-Id: <20200326032420.27220-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make trans_pgd_create_copy and its subroutines to use allocator that is
passed as an argument

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  4 +--
 arch/arm64/kernel/hibernate.c      |  7 ++++-
 arch/arm64/mm/trans_pgd.c          | 44 ++++++++++++++++++------------
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index ad5194ad178d..97a7ea73b289 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -26,8 +26,8 @@ struct trans_pgd_info {
 	void *trans_alloc_arg;
 };
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
-			  unsigned long end);
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
+			  unsigned long start, unsigned long end);
 
 int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		       void *page, unsigned long dst_addr, pgprot_t pgprot);
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 607bb1fbc349..95e00536aa67 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -322,13 +322,18 @@ int swsusp_arch_resume(void)
 	phys_addr_t phys_hibernate_exit;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
+	struct trans_pgd_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+	};
 
 	/*
 	 * Restoring the memory image will overwrite the ttbr1 page tables.
 	 * Create a second copy of just the linear map, and use this when
 	 * restoring.
 	 */
-	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, PAGE_END);
+	rc = trans_pgd_create_copy(&trans_info, &tmp_pg_dir, PAGE_OFFSET,
+				   PAGE_END);
 	if (rc)
 		return rc;
 
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 275a79935d7e..c16ae4e2b496 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -57,14 +57,14 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 	}
 }
 
-static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
-		    unsigned long end)
+static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
+		    pmd_t *src_pmdp, unsigned long start, unsigned long end)
 {
 	pte_t *src_ptep;
 	pte_t *dst_ptep;
 	unsigned long addr = start;
 
-	dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
+	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
 	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
@@ -78,8 +78,8 @@ static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
 	return 0;
 }
 
-static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
-		    unsigned long end)
+static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
+		    pud_t *src_pudp, unsigned long start, unsigned long end)
 {
 	pmd_t *src_pmdp;
 	pmd_t *dst_pmdp;
@@ -87,7 +87,7 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 	unsigned long addr = start;
 
 	if (pud_none(READ_ONCE(*dst_pudp))) {
-		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
+		dst_pmdp = trans_alloc(info);
 		if (!dst_pmdp)
 			return -ENOMEM;
 		pud_populate(&init_mm, dst_pudp, dst_pmdp);
@@ -102,7 +102,7 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 		if (pmd_none(pmd))
 			continue;
 		if (pmd_table(pmd)) {
-			if (copy_pte(dst_pmdp, src_pmdp, addr, next))
+			if (copy_pte(info, dst_pmdp, src_pmdp, addr, next))
 				return -ENOMEM;
 		} else {
 			set_pmd(dst_pmdp,
@@ -113,7 +113,8 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 	return 0;
 }
 
-static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
+static int copy_pud(struct trans_pgd_info *info, pgd_t *dst_pgdp,
+		    pgd_t *src_pgdp, unsigned long start,
 		    unsigned long end)
 {
 	pud_t *dst_pudp;
@@ -122,7 +123,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 	unsigned long addr = start;
 
 	if (pgd_none(READ_ONCE(*dst_pgdp))) {
-		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
+		dst_pudp = trans_alloc(info);
 		if (!dst_pudp)
 			return -ENOMEM;
 		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
@@ -137,7 +138,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 		if (pud_none(pud))
 			continue;
 		if (pud_table(pud)) {
-			if (copy_pmd(dst_pudp, src_pudp, addr, next))
+			if (copy_pmd(info, dst_pudp, src_pudp, addr, next))
 				return -ENOMEM;
 		} else {
 			set_pud(dst_pudp,
@@ -148,8 +149,8 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 	return 0;
 }
 
-static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
-			    unsigned long end)
+static int copy_page_tables(struct trans_pgd_info *info, pgd_t *dst_pgdp,
+			    unsigned long start, unsigned long end)
 {
 	unsigned long next;
 	unsigned long addr = start;
@@ -160,25 +161,34 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(READ_ONCE(*src_pgdp)))
 			continue;
-		if (copy_pud(dst_pgdp, src_pgdp, addr, next))
+		if (copy_pud(info, dst_pgdp, src_pgdp, addr, next))
 			return -ENOMEM;
 	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
 
 	return 0;
 }
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
-			  unsigned long end)
+/*
+ * Create trans_pgd and copy linear map.
+ * info:	contains allocator and its argument
+ * dst_pgdp:	new page table that is created, and to which map is copied.
+ * start:	Start of the interval (inclusive).
+ * end:		End of the interval (exclusive).
+ *
+ * Returns 0 on success, and -ENOMEM on failure.
+ */
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **dst_pgdp,
+			  unsigned long start, unsigned long end)
 {
 	int rc;
-	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	pgd_t *trans_pgd = trans_alloc(info);
 
 	if (!trans_pgd) {
 		pr_err("Failed to allocate memory for temporary page tables.\n");
 		return -ENOMEM;
 	}
 
-	rc = copy_page_tables(trans_pgd, start, end);
+	rc = copy_page_tables(info, trans_pgd, start, end);
 	if (!rc)
 		*dst_pgdp = trans_pgd;
 
-- 
2.17.1

