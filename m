Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C12C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769342075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY19Ro6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgDXEtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:49:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29698 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbgDXEtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587703748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=64G9GahoE1R2oI2BMnZEz8XNw5xsvmzLezAX8Z3VN+g=;
        b=XY19Ro6EAz6Gl23j01hrA3gNNk6o5ALGA7FdXjejU7OkV4Ft/uxe+3yIPMGSYt1zJJXTXV
        bxW535tR6VwjlNOUlHqXMwYMYksz0ZQqkIexGjUxVk9rOvEIId1R4Tpw0OMdEMonS6yRm8
        IIkfa6x0Y24h+7IIHjsX4hRswhJag3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-3TwUM8z4Pue688Km7TtidA-1; Fri, 24 Apr 2020 00:49:03 -0400
X-MC-Unique: 3TwUM8z4Pue688Km7TtidA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7BA6835B4A;
        Fri, 24 Apr 2020 04:49:01 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97D3F5C1C8;
        Fri, 24 Apr 2020 04:48:59 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, shan.gavin@gmail.com
Subject: [PATCH] arm64/mm: Use phys_to_page() to access pgtable memory
Date:   Fri, 24 Apr 2020 14:48:54 +1000
Message-Id: <20200424044854.15760-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros {pgd, pud, pmd}_page() retrieves the page struct of the
corresponding page frame, which is reserved as page table. There
is already a macro (phys_to_page), defined in memory.h, to convert
the physical address to the page struct. So it's reasonable to
use that in pgtable.h.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
index 538c85e62f86..8c20e2bd6287 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -508,7 +508,7 @@ static inline void pte_unmap(pte_t *pte) { }
 #define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(=
pmd, addr))
 #define pte_clear_fixmap()		clear_fixmap(FIX_PTE)
=20
-#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(__pmd_to_phys(pmd)))
+#define pmd_page(pmd)			phys_to_page(__pmd_to_phys(pmd))
=20
 /* use ONLY for statically allocated translation tables */
 #define pte_offset_kimg(dir,addr)	((pte_t *)__phys_to_kimg(pte_offset_ph=
ys((dir), (addr))))
@@ -566,7 +566,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 #define pmd_set_fixmap_offset(pud, addr)	pmd_set_fixmap(pmd_offset_phys(=
pud, addr))
 #define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
=20
-#define pud_page(pud)		pfn_to_page(__phys_to_pfn(__pud_to_phys(pud)))
+#define pud_page(pud)			phys_to_page(__pud_to_phys(pud))
=20
 /* use ONLY for statically allocated translation tables */
 #define pmd_offset_kimg(dir,addr)	((pmd_t *)__phys_to_kimg(pmd_offset_ph=
ys((dir), (addr))))
@@ -624,7 +624,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pud_set_fixmap_offset(pgd, addr)	pud_set_fixmap(pud_offset_phys(=
pgd, addr))
 #define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
=20
-#define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
+#define pgd_page(pgd)			phys_to_page(__pgd_to_phys(pgd))
=20
 /* use ONLY for statically allocated translation tables */
 #define pud_offset_kimg(dir,addr)	((pud_t *)__phys_to_kimg(pud_offset_ph=
ys((dir), (addr))))
--=20
2.23.0

