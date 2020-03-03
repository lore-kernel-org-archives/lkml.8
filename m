Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3703C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21D920842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgCCI43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:56:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbgCCI43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:56:29 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8FD36214148A0B4E2E5F;
        Tue,  3 Mar 2020 16:56:26 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 16:56:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <christophe.leroy@c-s.fr>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] powerpc/pmac/smp: drop unnecessary volatile qualifier
Date:   Tue, 3 Mar 2020 16:56:04 +0800
Message-ID: <20200303085604.24952-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191225114943.17216-1-yuehaibing@huawei.com>
References: <20191225114943.17216-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

core99_l2_cache/core99_l3_cache no need to mark as volatile,
just remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove 'volatile' qualifier
---
 arch/powerpc/platforms/powermac/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index f95fbde..69ad567 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -661,8 +661,8 @@ static void smp_core99_gpio_tb_freeze(int freeze)
 #endif /* !CONFIG_PPC64 */
 
 /* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
-volatile static long int core99_l2_cache;
-volatile static long int core99_l3_cache;
+static long core99_l2_cache;
+static long core99_l3_cache;
 
 static void core99_init_caches(int cpu)
 {
-- 
2.7.4


