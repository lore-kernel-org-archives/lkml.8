Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43091C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14AB206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MniSCi+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgIJKAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:00:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56737 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730827AbgIJKAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599731991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJ2MzQUZbNt3BABNnDrUz6b5ssQqFdxGWDpbq0Y1ahM=;
        b=MniSCi+tL9sK1cB6ajC2txrAukF0ecey0NaB3TUYlA7KjSdTAOMqp8SU8J2p2JfJ7yc7dL
        9dzBaFhatR23soBp3zYZ85Acq+0viVKveGy5C6rczCTCEfzxu6SfM7JdeNMOyOp7Aqskwn
        P7pjqQ2mSDP3WZJ7LbALeU2F+hjd58g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-MaaegvcdP66vSfXIHqi1aw-1; Thu, 10 Sep 2020 05:59:48 -0400
X-MC-Unique: MaaegvcdP66vSfXIHqi1aw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEDAF80EF8D;
        Thu, 10 Sep 2020 09:59:46 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-123.bne.redhat.com [10.64.54.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE2758357C;
        Thu, 10 Sep 2020 09:59:44 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 3/3] arm64/mm: Unitify CONT_PMD_SHIFT
Date:   Thu, 10 Sep 2020 19:59:36 +1000
Message-Id: <20200910095936.20307-3-gshan@redhat.com>
In-Reply-To: <20200910095936.20307-1-gshan@redhat.com>
References: <20200910095936.20307-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how CONT_PTE_SHIFT is determined, this introduces a new
kernel option (CONFIG_CONT_PMD_SHIFT) to determine CONT_PMD_SHIFT.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/Kconfig                     |  6 ++++++
 arch/arm64/include/asm/pgtable-hwdef.h | 10 ++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7ec30dd56300..d58e17fe9473 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -217,6 +217,12 @@ config ARM64_CONT_PTE_SHIFT
 	default 7 if ARM64_16K_PAGES
 	default 4
 
+config ARM64_CONT_PMD_SHIFT
+	int
+	default 5 if ARM64_64K_PAGES
+	default 5 if ARM64_16K_PAGES
+	default 4
+
 config ARCH_MMAP_RND_BITS_MIN
        default 14 if ARM64_64K_PAGES
        default 16 if ARM64_16K_PAGES
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 6c9c67f62551..94b3f2ac2e9d 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -82,17 +82,11 @@
  * Contiguous page definitions.
  */
 #define CONT_PTE_SHIFT		(CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
-#ifdef CONFIG_ARM64_64K_PAGES
-#define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
-#elif defined(CONFIG_ARM64_16K_PAGES)
-#define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
-#else
-#define CONT_PMD_SHIFT		(4 + PMD_SHIFT)
-#endif
-
 #define CONT_PTES		(1 << (CONT_PTE_SHIFT - PAGE_SHIFT))
 #define CONT_PTE_SIZE		(CONT_PTES * PAGE_SIZE)
 #define CONT_PTE_MASK		(~(CONT_PTE_SIZE - 1))
+
+#define CONT_PMD_SHIFT		(CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)
 #define CONT_PMDS		(1 << (CONT_PMD_SHIFT - PMD_SHIFT))
 #define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
 #define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
-- 
2.23.0

