Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD169C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5D420578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgBUIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:37:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731796AbgBUIhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:37:18 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C9E63AF9379C8FF77510;
        Fri, 21 Feb 2020 16:37:15 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Feb 2020
 16:37:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Roy.Pledge@nxp.com>, <leoyang.li@nxp.com>,
        <youri.querry_1@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soc: fsl: dpio: remove set but not used variable 'addr_cena'
Date:   Fri, 21 Feb 2020 16:36:37 +0800
Message-ID: <20200221083637.13392-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array
mode with ring mode enqueue") introduced this, but not
used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 740ee0d..350de56 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -658,7 +658,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 	const uint32_t *cl = (uint32_t *)d;
 	uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
 	int i, num_enqueued = 0;
-	uint64_t addr_cena;
 
 	spin_lock(&s->access_spinlock);
 	half_mask = (s->eqcr.pi_ci_mask>>1);
@@ -711,7 +710,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 
 	/* Flush all the cacheline without load/store in between */
 	eqcr_pi = s->eqcr.pi;
-	addr_cena = (size_t)s->addr_cena;
 	for (i = 0; i < num_enqueued; i++)
 		eqcr_pi++;
 	s->eqcr.pi = eqcr_pi & full_mask;
@@ -822,7 +820,6 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
 	const uint32_t *cl;
 	uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
 	int i, num_enqueued = 0;
-	uint64_t addr_cena;
 
 	half_mask = (s->eqcr.pi_ci_mask>>1);
 	full_mask = s->eqcr.pi_ci_mask;
@@ -866,7 +863,6 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
 
 	/* Flush all the cacheline without load/store in between */
 	eqcr_pi = s->eqcr.pi;
-	addr_cena = (uint64_t)s->addr_cena;
 	for (i = 0; i < num_enqueued; i++)
 		eqcr_pi++;
 	s->eqcr.pi = eqcr_pi & full_mask;
-- 
2.7.4


