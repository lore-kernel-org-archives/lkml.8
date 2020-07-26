Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE0AC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DE32070B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595779015;
	bh=H4kDu9O4JpiDRCFqLsrb8AJs54D5IBHU0KS5w1O+DS8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eXGCA8hXmw/FYDFet+cZGhuhowD8m+u1QYvoTmUgzxZt71eK/N5Osg87zdFgk4oP2
	 PlBPJoA8NBftB2plABrEsK0f/rrxgfbB3X7i+W3p7fKA+HMv8XPyDXt/v+sqfqKb5F
	 MJVBSVk/Gpm9ZMIjhlhpEtOlQqYrBqRuyFXiSVFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGZP4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgGZP4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:56:53 -0400
Received: from localhost.localdomain (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C06642065F;
        Sun, 26 Jul 2020 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595779013;
        bh=H4kDu9O4JpiDRCFqLsrb8AJs54D5IBHU0KS5w1O+DS8=;
        h=From:To:Cc:Subject:Date:From;
        b=YLTSNILKx2m2rSOZajG1XS1S5RJGVh7pk4YXNnea6U2sVFT+tLZpY+40On2Q9Jr2R
         TiR9NCH4U8TK0IzWH8KdFWSg+rBcuZNSnN7LOL8c6IMnsFvzia4PJppe5k4I4EaHVe
         ZhbyR+E0y/PiTH5FoVTL8xAvi0fKRCBXZKQS1+io=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/2] MAINTAINERS: Remove JZ4780 DMA driver entry
Date:   Sun, 26 Jul 2020 17:55:58 +0200
Message-Id: <20200726155559.4650-1-krzk@kernel.org>
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
index cba0ed77775b..362863cae239 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8541,11 +8541,6 @@ F:	include/uapi/rdma/
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

