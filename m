Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F8C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74ADC206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Prx0wc13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgIJKAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730825AbgIJJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599731989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3bdH6rS36JPz2IorF2RT/wH2c1nRGZH4EVS3NzKDhU=;
        b=Prx0wc13738YSZ0F4f7GHUIrGuYlH4cHlh4nnA1m7eY9NP82sBARuofb+UJQMVV+o3zFRs
        F3Y5y3XYxZ8NkLvKg4MvSGqLT3ZnsxGaO3ra8ZCe3nkggHFO9t62QjCWgDWpWDuL3Mw9aT
        NFagU8+Jd5LfncpjRnAfCzbxh7e52Wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-E1S3e20TOSq160CHHZNRsg-1; Thu, 10 Sep 2020 05:59:45 -0400
X-MC-Unique: E1S3e20TOSq160CHHZNRsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 800AD10BBEC6;
        Thu, 10 Sep 2020 09:59:44 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-123.bne.redhat.com [10.64.54.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87F8B7E173;
        Thu, 10 Sep 2020 09:59:42 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 2/3] arm64/mm: Unitify CONT_PTE_SHIFT
Date:   Thu, 10 Sep 2020 19:59:35 +1000
Message-Id: <20200910095936.20307-2-gshan@redhat.com>
In-Reply-To: <20200910095936.20307-1-gshan@redhat.com>
References: <20200910095936.20307-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONT_PTE_SHIFT actually depends on CONFIG_ARM64_CONT_SHIFT. It's
reasonable to reflect the dependency:

   * This renames CONFIG_ARM64_CONT_SHIFT to CONFIG_ARM64_CONT_PTE_SHIFT,
     so that we can introduce CONFIG_ARM64_CONT_PMD_SHIFT later.

   * CONT_{SHIFT, SIZE, MASK}, defined in page-def.h are removed as they
     are not used by anyone.

   * CONT_PTE_SHIFT is determined by CONFIG_ARM64_CONT_PTE_SHIFT.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/Kconfig                     | 2 +-
 arch/arm64/include/asm/page-def.h      | 5 -----
 arch/arm64/include/asm/pgtable-hwdef.h | 4 +---
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..7ec30dd56300 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -211,7 +211,7 @@ config ARM64_PAGE_SHIFT
 	default 14 if ARM64_16K_PAGES
 	default 12
 
-config ARM64_CONT_SHIFT
+config ARM64_CONT_PTE_SHIFT
 	int
 	default 5 if ARM64_64K_PAGES
 	default 7 if ARM64_16K_PAGES
diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
index f99d48ecbeef..2403f7b4cdbf 100644
--- a/arch/arm64/include/asm/page-def.h
+++ b/arch/arm64/include/asm/page-def.h
@@ -11,13 +11,8 @@
 #include <linux/const.h>
 
 /* PAGE_SHIFT determines the page size */
-/* CONT_SHIFT determines the number of pages which can be tracked together  */
 #define PAGE_SHIFT		CONFIG_ARM64_PAGE_SHIFT
-#define CONT_SHIFT		CONFIG_ARM64_CONT_SHIFT
 #define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
-#define CONT_SIZE		(_AC(1, UL) << (CONT_SHIFT + PAGE_SHIFT))
-#define CONT_MASK		(~(CONT_SIZE-1))
-
 #endif /* __ASM_PAGE_DEF_H */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 8a399e666837..6c9c67f62551 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -81,14 +81,12 @@
 /*
  * Contiguous page definitions.
  */
+#define CONT_PTE_SHIFT		(CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
 #ifdef CONFIG_ARM64_64K_PAGES
-#define CONT_PTE_SHIFT		(5 + PAGE_SHIFT)
 #define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
 #elif defined(CONFIG_ARM64_16K_PAGES)
-#define CONT_PTE_SHIFT		(7 + PAGE_SHIFT)
 #define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
 #else
-#define CONT_PTE_SHIFT		(4 + PAGE_SHIFT)
 #define CONT_PMD_SHIFT		(4 + PMD_SHIFT)
 #endif
 
-- 
2.23.0

