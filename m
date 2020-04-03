Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E06FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D3B20757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbgDCGsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:48:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387962AbgDCGsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:48:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7EFA5B00FAE0776F69B5;
        Fri,  3 Apr 2020 14:48:28 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 14:48:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <gregkh@linuxfoundation.org>,
        <christophe.leroy@c-s.fr>, <allison@lohutok.net>,
        <armijn@tjaldur.nl>, <tglx@linutronix.de>,
        <aneesh.kumar@linux.ibm.com>, <yuehaibing@huawei.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] powerpc/mm: ptdump: Add missing include <asm/hvcall.h>
Date:   Fri, 3 Apr 2020 14:47:56 +0800
Message-ID: <20200403064756.36128-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200402135828.37308-1-yuehaibing@huawei.com>
References: <20200402135828.37308-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while PPC_PSERIES is not set, gcc build fails:

arch/powerpc/mm/ptdump/hashpagetable.c: In function ‘pseries_find’:
arch/powerpc/mm/ptdump/hashpagetable.c:262:18: error: ‘H_SUCCESS’ undeclared (first use in this function); did you mean ‘FL_ACCESS’?
   if (lpar_rc != H_SUCCESS)
                  ^~~~~~~~~
                  FL_ACCESS

If PPC_PSERIES is not set, <asm/plpar_wrappers.h> does not
include <asm/hvcall.h>, which leads to this failure.

Add missing include file <asm/hvcall.h> in hashpagetable.c to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 65e701b2d2a8 ("powerpc/ptdump: drop non vital #ifdefs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: Add hvcall.h instead of vio.h, also rework patch log
---
 arch/powerpc/mm/ptdump/hashpagetable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index b6ed9578382f..3e7e6206688c 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -20,6 +20,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/hvcall.h>
 #include <linux/memblock.h>
 #include <asm/firmware.h>
 
-- 
2.17.1


