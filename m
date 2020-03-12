Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27A6C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB9720724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCLW27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:28:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38598 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgCLW2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:28:42 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 071591A11CE;
        Thu, 12 Mar 2020 23:28:41 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BDF3F1A11BA;
        Thu, 12 Mar 2020 23:28:40 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2BBC640AB2;
        Thu, 12 Mar 2020 15:28:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 4/6] soc: fsl: qe: fix sparse warnings for qe_ic.c
Date:   Thu, 12 Mar 2020 17:28:25 -0500
Message-Id: <20200312222827.17409-5-leoyang.li@nxp.com>
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

drivers/soc/fsl/qe/qe_ic.c:253:32: warning: incorrect type in argument 1 (different base types)
drivers/soc/fsl/qe/qe_ic.c:253:32:    expected restricted __be32 [noderef] [usertype] <asn:2> *base
drivers/soc/fsl/qe/qe_ic.c:253:32:    got unsigned int [noderef] [usertype] <asn:2> *regs
drivers/soc/fsl/qe/qe_ic.c:254:26: warning: incorrect type in argument 1 (different base types)
drivers/soc/fsl/qe/qe_ic.c:254:26:    expected restricted __be32 [noderef] [usertype] <asn:2> *base
drivers/soc/fsl/qe/qe_ic.c:254:26:    got unsigned int [noderef] [usertype] <asn:2> *regs
drivers/soc/fsl/qe/qe_ic.c:269:32: warning: incorrect type in argument 1 (different base types)
drivers/soc/fsl/qe/qe_ic.c:269:32:    expected restricted __be32 [noderef] [usertype] <asn:2> *base
drivers/soc/fsl/qe/qe_ic.c:269:32:    got unsigned int [noderef] [usertype] <asn:2> *regs
drivers/soc/fsl/qe/qe_ic.c:270:26: warning: incorrect type in argument 1 (different base types)
drivers/soc/fsl/qe/qe_ic.c:270:26:    expected restricted __be32 [noderef] [usertype] <asn:2> *base
drivers/soc/fsl/qe/qe_ic.c:270:26:    got unsigned int [noderef] [usertype] <asn:2> *regs
drivers/soc/fsl/qe/qe_ic.c:341:31: warning: incorrect type in argument 1 (different base types)
drivers/soc/fsl/qe/qe_ic.c:341:31:    expected restricted __be32 [noderef] [usertype] <asn:2> *base
drivers/soc/fsl/qe/qe_ic.c:341:31:    got unsigned int [noderef] [usertype] <asn:2> *regs
drivers/soc/fsl/qe/qe_ic.c:357:31: warning: incorrect type in argument 1 (different base types)
drivers/soc/fsl/qe/qe_ic.c:357:31:    expected restricted __be32 [noderef] [usertype] <asn:2> *base
drivers/soc/fsl/qe/qe_ic.c:357:31:    got unsigned int [noderef] [usertype] <asn:2> *regs
drivers/soc/fsl/qe/qe_ic.c:450:26: warning: incorrect type in argument 1 (different base types)
drivers/soc/fsl/qe/qe_ic.c:450:26:    expected restricted __be32 [noderef] [usertype] <asn:2> *base
drivers/soc/fsl/qe/qe_ic.c:450:26:    got unsigned int [noderef] [usertype] <asn:2> *regs

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/qe/qe_ic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 0dd5bdb04a14..0390af999900 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -44,7 +44,7 @@
 
 struct qe_ic {
 	/* Control registers offset */
-	u32 __iomem *regs;
+	__be32 __iomem *regs;
 
 	/* The remapper for this QEIC */
 	struct irq_domain *irqhost;
-- 
2.17.1

