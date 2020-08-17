Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378B5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C963204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689713;
	bh=XGnEgmFBVdyc/oUXakYFZiKhW4THFttuZ2JyUOkUtJw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BkHfOqtfGHidUUkOogusJdGxxVHE476PtW6b5km4uBySxFanbqLbqpE3YQr+OR1sV
	 66lOCYt40tVFghCZ9GFRPUWCdCnkxhhJdok6h/np2keY9YVhcsCX6SMnP32KEHDcWe
	 h24a+Tisit8mG24oVNOBEQ+F/64pWmxPZ3I2tZUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391445AbgHQSlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389597AbgHQSlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:41:40 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73123204EC;
        Mon, 17 Aug 2020 18:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597689700;
        bh=XGnEgmFBVdyc/oUXakYFZiKhW4THFttuZ2JyUOkUtJw=;
        h=From:To:Cc:Subject:Date:From;
        b=jHawPRZQrrd5xxfRQtHweKENED5UFeclNEs/TU/nUtthQQZGnCL0R1AJ+Sk46mDyQ
         icRCngDuUc/ZyulO0k04YaBQYT5wRmJvOyTh0Yqj/ernE9YH+1S6cpkWclCHRgMYQA
         3d20KnUo5XBAY2DvCeRAvg2R4oADhEYrn4Kfvg4k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/2] MAINTAINERS: Remove JZ4780 DMA driver entry
Date:   Mon, 17 Aug 2020 20:41:30 +0200
Message-Id: <20200817184131.907-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entry for MIPS Ingenic JZ4780 DMA driver is not up to date anymore.
Zubair Lutfullah Kakakhel's email bounces and no maintenance is
provided.

Suggested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0a742ce8f2c..9ab3a7fd6451 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8580,11 +8580,6 @@ F:	include/uapi/rdma/
 F:	samples/bpf/ibumad_kern.c
 F:	samples/bpf/ibumad_user.c
 
-INGENIC JZ4780 DMA Driver
-M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
-S:	Maintained
-F:	drivers/dma/dma-jz4780.c
-
 INGENIC JZ4780 NAND DRIVER
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mtd@lists.infradead.org
-- 
2.17.1

