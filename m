Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA9C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE925206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD1Gc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:32:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgD1Gc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:32:59 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63867BDA9149D8277BD9;
        Tue, 28 Apr 2020 14:32:57 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:32:47 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <jesper.nilsson@axis.com>, <lars.persson@axis.com>,
        <linux@armlinux.org.uk>, <tglx@linutronix.de>,
        <linux-arm-kernel@axis.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] arm: remove unneeded semicolon in board-artpec6.c
Date:   Tue, 28 Apr 2020 14:32:13 +0800
Message-ID: <20200428063213.16038-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

arch/arm/mach-artpec/board-artpec6.c:42:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/arm/mach-artpec/board-artpec6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
index d3cf3e8603e8..c27e7bbcd7bc 100644
--- a/arch/arm/mach-artpec/board-artpec6.c
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -39,7 +39,7 @@ static void __init artpec6_init_machine(void)
 		 */
 		regmap_write(regmap, ARTPEC6_DMACFG_REGNUM,
 			     ARTPEC6_DMACFG_UARTS_BURST);
-	};
+	}
 }
 
 static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
-- 
2.21.1

