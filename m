Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A62C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B9F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590514399;
	bh=90hS4ysSkB3At6pJSrj//l8AEpAJD3432HsLEWyyII8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sdxGp/Me5pWJq3Lb/javKoIRyMr0Ikd7V5+LkVOqGH9sZVnf068JEAex5MacwFh+1
	 R+2QhrEy8u5d5Uy9ZdFRFQM5BgsaLWnBh8x/0wM+OoDVkoRoFvfPxI7fq5hm1XB91r
	 d2QV/+RsVYabeMwoGiodNqMS5WGsWaw2M/01I8EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgEZRdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbgEZRdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:33:15 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A0E20873;
        Tue, 26 May 2020 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590514394;
        bh=90hS4ysSkB3At6pJSrj//l8AEpAJD3432HsLEWyyII8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvcazpi+Z0qahVu7CX3PYRAfva1WMO/6AnLaaEnMQ2h9DP7Z52oA1EreMfDuK66ZI
         NXqAqpFj80/H2swoSKh3OjaWs2bLTR+ysGXeaw8pFGOPlY2Wx/oDzawgjaGDuMZlYo
         UK4E1EDFOGzLkd3py99/natuZ0xTvr/ce9a5+mCk=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@kernel.org>, kernel-team@android.com
Subject: [PATCH 2/3] sparc32: mm: Disable SPLIT_PTLOCK_CPUS
Date:   Tue, 26 May 2020 18:33:01 +0100
Message-Id: <20200526173302.377-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526173302.377-1-will@kernel.org>
References: <20200526173302.377-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRMMU page-table allocator is not compatible with SPLIT_PTLOCK_CPUS
for two major reasons:

  1. Pages are allocated via memblock, and therefore the ptl is not
     cleared by prep_new_page(), which is expected by ptlock_init()

  2. Multiple PTE tables can exist in a single page, causing them to
     share the same ptl and deadlock when attempting to take the same
     lock twice (e.g. as part of copy_page_range()).

Ensure that SPLIT_PTLOCK_CPUS is not selected for SPARC32.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Will Deacon <will@kernel.org>
---
 mm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..97458119cce8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -192,6 +192,9 @@ config MEMORY_HOTREMOVE
 # Default to 4 for wider testing, though 8 might be more appropriate.
 # ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
 # PA-RISC 7xxx's spinlock_t would enlarge struct page from 32 to 44 bytes.
+# SPARC32 allocates multiple pte tables within a single page, and therefore
+# a per-page lock leads to problems when multiple tables need to be locked
+# at the same time (e.g. copy_page_range()).
 # DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC spinlock_t also enlarge struct page.
 #
 config SPLIT_PTLOCK_CPUS
@@ -199,6 +202,7 @@ config SPLIT_PTLOCK_CPUS
 	default "999999" if !MMU
 	default "999999" if ARM && !CPU_CACHE_VIPT
 	default "999999" if PARISC && !PA20
+	default "999999" if SPARC32
 	default "4"
 
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
-- 
2.27.0.rc0.183.gde8f92d652-goog

