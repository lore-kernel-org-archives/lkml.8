Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F394206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595602473;
	bh=u+leMY/uyyK1fWRYghEZunX1y6Y8sNEwuMV+HF0X39U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sEdG6Dl+drSiXQiw5NNapseeCJ/te0Yy34UvSw7bJvauk0suRHSicuEqaP8k/2Lhi
	 6ScLBuoqC/O0eGEgcyNClpa4Pg6wIRW4edUvHwyH3SCYa1FHM2jUFdnRC7dFLY16C0
	 11R9QKsIPQZfWLx702lnWP1dtnhCUO6YXfSD7pHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGXOyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXOya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:54:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B332A206F0;
        Fri, 24 Jul 2020 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595602470;
        bh=u+leMY/uyyK1fWRYghEZunX1y6Y8sNEwuMV+HF0X39U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbWSdqe5Q8XzhFi2VQRwgz5Ty+mKEy4sG7IQKnfAHGw8VfplBi3UWAFDIzxUDOaMB
         hCxh4rP2UrtXV9QxJFa3heamEtMzAXoiLu9bO6sdZE2zYFRN5m9s8dxIfxmbN39n2X
         lBT0zI2y1riP7eQDVwprNVqoQFWMvDYzmUhjz9VQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/2] memory: jz4780-nemc: Limit dependency and compile testing to Ingenic architecture only
Date:   Fri, 24 Jul 2020 16:54:00 +0200
Message-Id: <20200724145401.2566-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724145401.2566-1-krzk@kernel.org>
References: <20200724145401.2566-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the JZ4780_NEMC driver makes sense only for specific hardware -
the Ingenic SoC architecture.  Set it's dependency to MACH_INGENIC so it
will not appear on unrelated architectures (easier job for
downstream/distro kernel engineers).

When compile testing, do not enable the driver on other architectures.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. MIPS -> MACH_INGENIC, as suggested by Arnd
---
 drivers/memory/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index a1493549fec3..cd4fc93b50df 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -152,8 +152,8 @@ config FSL_IFC
 
 config JZ4780_NEMC
 	bool "Ingenic JZ4780 SoC NEMC driver"
-	default y
-	depends on MIPS || COMPILE_TEST
+	default y if MACH_INGENIC
+	depends on MACH_INGENIC || COMPILE_TEST
 	depends on HAS_IOMEM && OF
 	help
 	  This driver is for the NAND/External Memory Controller (NEMC) in
-- 
2.17.1

