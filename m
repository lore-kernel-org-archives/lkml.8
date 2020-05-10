Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00661C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA42208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgEJMYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:24:37 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39161 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgEJMYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:24:36 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1D7D8C0005;
        Sun, 10 May 2020 12:24:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/2] MAINTAINERS: Remove Xiaolei Li and mark MTK NFC as orphaned
Date:   Sun, 10 May 2020 14:24:30 +0200
Message-Id: <20200510122430.19105-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510122430.19105-1-miquel.raynal@bootlin.com>
References: <20200510122430.19105-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaolei's address is bouncing, remove him from MAINTAINERS and mark
the driver he was maintaining, Mediatek's, as orphaned.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fdd6e96a689b..55ba0bec2ec8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10722,9 +10722,8 @@ F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
 F:	drivers/i2c/busses/i2c-mt7621.c
 
 MEDIATEK NAND CONTROLLER DRIVER
-M:	Xiaolei Li <xiaolei.li@mediatek.com>
 L:	linux-mtd@lists.infradead.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/mtd/mtk-nand.txt
 F:	drivers/mtd/nand/raw/mtk_*
 
-- 
2.20.1

