Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F10C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009B32076A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AG+9uC/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCXHbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:31:08 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40541 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgCXHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:31:01 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so1045949pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klBEcTaZTM89My6NFvl8X/nEuMTFhvIx/ugZCt3MXO4=;
        b=AG+9uC/8nRSOJB+P5ypaf3gqmhSCEHjRpdinGoG0ihkvqs00uicArdKU/RauncEVNS
         /jr4FM3waJ7m3kgA0/YlE9Y/s2AXXDgjbcVvws87Q+asnKzmm0lO8BVXx4qHBuS+Zdac
         utC7Is/6yjR+1eC5kX1thCIKZAwGmuq+3OJT6bOgObDpguY3PMR3hGE+qaVesFwDMmx6
         3g/jgTiZ2VJSx0ct7YhuzgCBmxpGWsUXxl+v5d4+UMOczw0qWBkSS6RxXqATJlLs63bp
         TnETxvwb0viDn668uejcqivlG5/kLXFfhOtcIHeJvDtfYmKios0w0AS4V3YtK6DnRdye
         zAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klBEcTaZTM89My6NFvl8X/nEuMTFhvIx/ugZCt3MXO4=;
        b=jhQ794TeEUkpqkZbLo+PNMWJLox6G/2eJPtOOPfRgUozqjKSF8BwIH+eB9m9Mt5SAA
         LothuVm3Hpv+0cfGvQlwYpI02YJEBHU7jVND9RIPOiRtz7Ahew+z0R49oNjfAlQeI21E
         K9fUxUPHTSBTNg7fhxNAr4uTC3zPLOxOnpw4KWhTUtl0CrxPKGl/sC5ejwTrPTiCdaJL
         p7XzNIzyzviIEqU6K167oIzcNg4gmZpE89nqgInoRUBZbNUH1Fr792wn62jUIygskJDc
         GCePnrtNtj6r+d2/hGtF5DA/Xx53APlBDiJ0cyaDp+O91NqwLCgdqmmDPuYwfYSMgVpz
         kAEQ==
X-Gm-Message-State: ANhLgQ0H7sph6a/xN9Q+cm1Jph0egQRrpsiXJdjR5DrG2xbbzXMo3KnO
        XLre0T5/uDHmXPp8W1QeUbvwEw==
X-Google-Smtp-Source: ADFU+vurevye9kGuwfX5gxdkntd88xuvY3Fgsvd35C31e8AXMXuwYNW3TYUL5f30GFG46lLBGeJy6Q==
X-Received: by 2002:a17:90a:628a:: with SMTP id d10mr3826207pjj.25.1585035060570;
        Tue, 24 Mar 2020 00:31:00 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:31:00 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 2/8] riscv/kaslr: introduce functions to clear page table
Date:   Tue, 24 Mar 2020 15:30:47 +0800
Message-Id: <286a940ef8fbc4480c63679271eea440d167a258.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1584352425.git.zong.li@sifive.com>
References: <cover.1584352425.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In KASLR, we need to re-create page table after getting a random
destination. Introduce clear function to clear old content. Also, the
page table entries allow writing value when it's empty, so we have to
clear the early page table.

This patch is a preparation to support KASLR.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/init.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ace5d74fd939..51e263c04fa2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -315,6 +315,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 #define get_pgd_next_virt(__pa)	get_pmd_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
+#define clear_pgd_next_mapping(__nextp)	clear_pmd(__nextp)
 #define fixmap_pgd_next		fixmap_pmd
 #else
 #define pgd_next_t		pte_t
@@ -322,6 +323,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 #define get_pgd_next_virt(__pa)	get_pte_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
+#define clear_pgd_next_mapping(__nextp)	clear_pte(__nextp)
 #define fixmap_pgd_next		fixmap_pte
 #endif
 
@@ -361,6 +363,58 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 	return PMD_SIZE;
 }
 
+#ifdef CONFIG_RANDOMIZE_BASE
+static void __init clear_pte(pte_t *ptep)
+{
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		if (!pte_none(ptep[i]))
+			ptep[i] = __pte(0);
+}
+
+static void __init clear_pmd(pmd_t *pmdp)
+{
+	unsigned int i;
+	pte_t *ptep;
+	phys_addr_t pte_phys;
+	uintptr_t kaslr_offset = get_kaslr_offset();
+
+	for (i = 0; i < PTRS_PER_PMD; i++)
+		if (!pmd_none(pmdp[i])) {
+			if (pmd_leaf(pmdp[i])) {
+				pmd_clear(&pmdp[i]);
+			} else {
+				pte_phys = PFN_PHYS(_pmd_pfn(pmdp[i]));
+				ptep = get_pte_virt(pte_phys + kaslr_offset);
+				clear_pte(ptep);
+				pmd_clear(&pmdp[i]);
+			}
+		}
+}
+
+static void __init clear_pgd(pgd_t *pgdp)
+{
+	unsigned int i;
+	pgd_next_t *nextp;
+	phys_addr_t next_phys;
+	uintptr_t kaslr_offset = get_kaslr_offset();
+
+	for (i = 0; i < PTRS_PER_PGD; i++)
+		if (pgd_val(pgdp[i]) != 0) {
+			if (pgd_leaf(pgd_val(pgdp[i]))) {
+				set_pgd(&pgdp[i], __pgd(0));
+			} else {
+				next_phys = PFN_PHYS(_pgd_pfn(pgdp[i]));
+				nextp = get_pgd_next_virt(next_phys +
+							  kaslr_offset);
+				clear_pgd_next_mapping(nextp);
+				set_pgd(&pgdp[i], __pgd(0));
+			}
+		}
+}
+#endif
+
 /*
  * setup_vm() is called from head.S with MMU-off.
  *
-- 
2.25.1

