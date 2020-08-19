Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70725C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E96207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHSL0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:26:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbgHSL0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:26:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EC6CDD266D8F8E751BB3;
        Wed, 19 Aug 2020 19:26:30 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 19:26:30 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <linux@armlinux.org.uk>, <rppt@kernel.org>,
        <akpm@linux-foundation.org>, <geert@linux-m68k.org>,
        <ardb@kernel.org>, <clin@suse.com>, <maz@kernel.org>,
        <anshuman.khandual@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ARM: mm: remove duplicate include
Date:   Wed, 19 Aug 2020 19:24:20 +0800
Message-ID: <20200819112420.3605-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove asm/sections.h and asm/fixmap.h that are included more than once.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 arch/arm/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index c36f977b2ccb..21182eb534b0 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -20,7 +20,6 @@
 #include <asm/sections.h>
 #include <asm/cachetype.h>
 #include <asm/fixmap.h>
-#include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
 #include <asm/tlb.h>
@@ -34,7 +33,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/pci.h>
-#include <asm/fixmap.h>
 
 #include "fault.h"
 #include "mm.h"
-- 
2.17.1

