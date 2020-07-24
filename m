Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC75C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B58120714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595602478;
	bh=vCIiSSrNBiKU9rWnlwPIL7tlQSFCsk4ZNaipJKAKff0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WyOHpjzrUARDNKsc8s1KbuI6KMZIhV7WNuWAy9jaU+l+k8d8USUWM8clFrAeMHNqE
	 wxVZS+OOJVSjxUTGUHYiTxKIxknOKcfRm+nFptpzl3D6cXgYML0liTXkeiDvtGBEfU
	 LxdR61LAMyoPgbIANxetCgyJTMrzujCzX6TlhxkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGXOyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXOyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:54:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25DC820737;
        Fri, 24 Jul 2020 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595602476;
        bh=vCIiSSrNBiKU9rWnlwPIL7tlQSFCsk4ZNaipJKAKff0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vt4xehHeWRatMiO+D4YTV2ENXSEuVbLsCcKQPsCWWowDNurbeC831CmTRXMu2px/5
         L+F21oRJahyBjYz2ZJ68EDlGMVBozCKGU/nXiPYBVBdlVJaL6/nV4wulbSc82PBJaA
         W8G0pJOPMQwCMp8Ks7vQIrlqilFym0ISRfQs56lk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to architecture only
Date:   Fri, 24 Jul 2020 16:54:01 +0200
Message-Id: <20200724145401.2566-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724145401.2566-1-krzk@kernel.org>
References: <20200724145401.2566-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the MTD_NAND_JZ4780 driver makes sense only for specific
hardware - the Ingenic SoC architecture.  Set it's dependency to
MACH_INGENIC so it will not appear on unrelated architectures (easier
job for downstream/distro kernel engineers).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. New patch
---
 drivers/mtd/nand/raw/ingenic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
index 96c5ae8b1bbc..2e3936543ba6 100644
--- a/drivers/mtd/nand/raw/ingenic/Kconfig
+++ b/drivers/mtd/nand/raw/ingenic/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MTD_NAND_JZ4780
 	tristate "JZ4780 NAND controller"
-	depends on MIPS || COMPILE_TEST
+	depends on MACH_INGENIC || COMPILE_TEST
 	depends on JZ4780_NEMC
 	help
 	  Enables support for NAND Flash connected to the NEMC on JZ4780 SoC
-- 
2.17.1

