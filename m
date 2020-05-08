Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B64EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E312724955
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgEHOKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:10:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbgEHOKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:10:10 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EC0DB1A56182C8F5F6C2;
        Fri,  8 May 2020 22:10:00 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 22:09:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Roy.Pledge@nxp.com>, <leoyang.li@nxp.com>,
        <youri.querry_1@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soc: fsl: dpio: Remove unused inline function qbman_write_eqcr_am_rt_register
Date:   Fri, 8 May 2020 22:09:47 +0800
Message-ID: <20200508140947.28712-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree anymore since commit
3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array mode with ring mode enqueue")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 804b8ba9bf5c..e2e9fbb58a72 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -572,18 +572,6 @@ void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32 qdid,
 #define EQAR_VB(eqar)      ((eqar) & 0x80)
 #define EQAR_SUCCESS(eqar) ((eqar) & 0x100)
 
-static inline void qbman_write_eqcr_am_rt_register(struct qbman_swp *p,
-						   u8 idx)
-{
-	if (idx < 16)
-		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT + idx * 4,
-				     QMAN_RT_MODE);
-	else
-		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT2 +
-				     (idx - 16) * 4,
-				     QMAN_RT_MODE);
-}
-
 #define QB_RT_BIT ((u32)0x100)
 /**
  * qbman_swp_enqueue_direct() - Issue an enqueue command
-- 
2.17.1


