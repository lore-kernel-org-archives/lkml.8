Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E03C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6877B20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595933112;
	bh=zefyhpGvTLn3ZTB/hhE8xNDFfEGO8gcnjogC92IGGmo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dzAFFVGqAENzqX7x/5mfGlfFv2uxbZXl6SBWQPObnXTJ9Ec7XyR66uNEHB+XBbItF
	 x2NUALaPpOz+c1Eiomadv4pphwKCJrwmh1Ejt1esSJiThoe2XuFS88/oSYRfTzwTBl
	 Q8UXSBOUhosvqM8w7vrn4pLf8wccGWzNFuNnhewY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgG1KpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgG1KpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:45:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CBF20775;
        Tue, 28 Jul 2020 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595933110;
        bh=zefyhpGvTLn3ZTB/hhE8xNDFfEGO8gcnjogC92IGGmo=;
        h=From:To:Cc:Subject:Date:From;
        b=ehGr5L2IoN2hIGtt08BR0qBSTQAlX0XQLoNjpouJEG/2s9PPQkLue8WT6c+hVBlsy
         FicpV9lYQhCEHcwxH3dhGhWocA+ZoMd9+3q4hMJHW4HX6VkNZbMtbPdkChY7+HJQr7
         2Jimfepgp6atHfDTxsKnbRKaBj/BDpZzULEvCfg4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 1/2] memory: jz4780-nemc: Do not build by default
Date:   Tue, 28 Jul 2020 12:45:02 +0200
Message-Id: <20200728104503.23655-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the JZ4780_NEMC driver makes sense only for specific hardware -
the Ingenic SoC architecture.  It is not an essential driver for the SoC
support so do not enable it by default.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Just drop the default, don't touch depends
2. Drop second patch for MTD_NAND_JZ4780

Changes since v2:
1. MIPS -> MACH_INGENIC, as suggested by Arnd
---
 drivers/memory/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index f64106fa63b7..8072204bc21a 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -164,7 +164,6 @@ config FSL_IFC
 
 config JZ4780_NEMC
 	bool "Ingenic JZ4780 SoC NEMC driver"
-	default y
 	depends on MIPS || COMPILE_TEST
 	depends on HAS_IOMEM && OF
 	help
-- 
2.17.1

