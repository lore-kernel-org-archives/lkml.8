Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67A0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BF220724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCLW2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:28:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38618 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgCLW2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:28:42 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4258E1A11CF;
        Thu, 12 Mar 2020 23:28:41 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0304B1A11CB;
        Thu, 12 Mar 2020 23:28:41 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 762B440BCF;
        Thu, 12 Mar 2020 15:28:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 5/6] soc: fsl: qe: fix sparse warnings for ucc_fast.c
Date:   Thu, 12 Mar 2020 17:28:26 -0500
Message-Id: <20200312222827.17409-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20200312222827.17409-1-leoyang.li@nxp.com>
References: <20200312222827.17409-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

drivers/soc/fsl/qe/ucc_fast.c:218:22: warning: incorrect type in assignment (different base types)
drivers/soc/fsl/qe/ucc_fast.c:218:22:    expected unsigned int [noderef] [usertype] <asn:2> *p_ucce
drivers/soc/fsl/qe/ucc_fast.c:218:22:    got restricted __be32 [noderef] <asn:2> *
drivers/soc/fsl/qe/ucc_fast.c:219:22: warning: incorrect type in assignment (different base types)
drivers/soc/fsl/qe/ucc_fast.c:219:22:    expected unsigned int [noderef] [usertype] <asn:2> *p_uccm
drivers/soc/fsl/qe/ucc_fast.c:219:22:    got restricted __be32 [noderef] <asn:2> *

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 include/soc/fsl/qe/ucc_fast.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/soc/fsl/qe/ucc_fast.h b/include/soc/fsl/qe/ucc_fast.h
index ba0e838f962a..dc4e79468094 100644
--- a/include/soc/fsl/qe/ucc_fast.h
+++ b/include/soc/fsl/qe/ucc_fast.h
@@ -178,10 +178,10 @@ struct ucc_fast_info {
 struct ucc_fast_private {
 	struct ucc_fast_info *uf_info;
 	struct ucc_fast __iomem *uf_regs; /* a pointer to the UCC regs. */
-	u32 __iomem *p_ucce;	/* a pointer to the event register in memory. */
-	u32 __iomem *p_uccm;	/* a pointer to the mask register in memory. */
+	__be32 __iomem *p_ucce;	/* a pointer to the event register in memory. */
+	__be32 __iomem *p_uccm;	/* a pointer to the mask register in memory. */
 #ifdef CONFIG_UGETH_TX_ON_DEMAND
-	u16 __iomem *p_utodr;	/* pointer to the transmit on demand register */
+	__be16 __iomem *p_utodr;/* pointer to the transmit on demand register */
 #endif
 	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
 	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
-- 
2.17.1

