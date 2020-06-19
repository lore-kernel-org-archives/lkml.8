Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B176C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3299E217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578654;
	bh=yKkzUylOknIwecsv8r1l0CYmrdBOv5/1gOFSrHKSh6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXenSWN0W2p/fgiWSMbKog1fr6F5gFGW3q6Ys1FyLxvI7NmDjCmsJUibQguGyCBSj
	 KGTZ1tMAJHpOE63iE6hPspf5vq/ypOmQWi0NsYQi8wPZBLIGoQde3++9VjR7yKSvay
	 NBBTlcGuhVUcygfYccD4VYYLZOdlP2Syq8Ah3a8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbgFSO5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389814AbgFSO5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:57:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB44217D8;
        Fri, 19 Jun 2020 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578627;
        bh=yKkzUylOknIwecsv8r1l0CYmrdBOv5/1gOFSrHKSh6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SID9elaY/sT1R3TMBFrFgtt7IVyWZAwuY/znCyMI/xgEkiZ/DxgEp8sLL/PMPehTU
         tKDmUi+X37S5XPCI7m9WnETzJlNMmTx5EQUz4QCVO2Mg4/n70GrCQW5/EIyaepkImx
         ZgdQqcGKr/04q063O/6P91E1TJxFJNcwI8Qlahxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/267] crypto: ccp -- dont "select" CONFIG_DMADEVICES
Date:   Fri, 19 Jun 2020 16:31:20 +0200
Message-Id: <20200619141653.427883679@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit eebac678556d6927f09a992872f4464cf3aecc76 ]

DMADEVICES is the top-level option for the slave DMA
subsystem, and should not be selected by device drivers,
as this can cause circular dependencies such as:

drivers/net/ethernet/freescale/Kconfig:6:error: recursive dependency detected!
drivers/net/ethernet/freescale/Kconfig:6:	symbol NET_VENDOR_FREESCALE depends on PPC_BESTCOMM
drivers/dma/bestcomm/Kconfig:6:	symbol PPC_BESTCOMM depends on DMADEVICES
drivers/dma/Kconfig:6:	symbol DMADEVICES is selected by CRYPTO_DEV_SP_CCP
drivers/crypto/ccp/Kconfig:10:	symbol CRYPTO_DEV_SP_CCP depends on CRYPTO
crypto/Kconfig:16:	symbol CRYPTO is selected by LIBCRC32C
lib/Kconfig:222:	symbol LIBCRC32C is selected by LIQUIDIO
drivers/net/ethernet/cavium/Kconfig:65:	symbol LIQUIDIO depends on PTP_1588_CLOCK
drivers/ptp/Kconfig:8:	symbol PTP_1588_CLOCK is implied by FEC
drivers/net/ethernet/freescale/Kconfig:23:	symbol FEC depends on NET_VENDOR_FREESCALE

The LIQUIDIO driver causing this problem is addressed in a
separate patch, but this change is needed to prevent it from
happening again.

Using "depends on DMADEVICES" is what we do for all other
implementations of slave DMA controllers as well.

Fixes: b3c2fee5d66b ("crypto: ccp - Ensure all dependencies are specified")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/Kconfig b/drivers/crypto/ccp/Kconfig
index b9dfae47aefd..7f5fc705503d 100644
--- a/drivers/crypto/ccp/Kconfig
+++ b/drivers/crypto/ccp/Kconfig
@@ -9,10 +9,9 @@ config CRYPTO_DEV_CCP_DD
 config CRYPTO_DEV_SP_CCP
 	bool "Cryptographic Coprocessor device"
 	default y
-	depends on CRYPTO_DEV_CCP_DD
+	depends on CRYPTO_DEV_CCP_DD && DMADEVICES
 	select HW_RANDOM
 	select DMA_ENGINE
-	select DMADEVICES
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	help
-- 
2.25.1



