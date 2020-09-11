Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C07C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B360221F1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="shWLfMfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgIKJtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKJtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:49:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064EAC061756;
        Fri, 11 Sep 2020 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Mc4tZfVXgFfpPmIymJY5y/QwWLIXEb/chQPOXnDzdm0=; b=shWLfMfqqNCuXVOEvQUuBptfHr
        WJSNAyGbFRdOH3yp7dABUJjHeHeNdzjshkcM8Q69wRhJhkWJUJ43WWxs2WVDf231HhEparIFBGEHu
        PIgUgmDSYWkYtgEcGV77YNEZo6yxjKoSd292YTa2sl8qyjicKUSXodJ3v6/U5MLAF2m8BRS4EUTSq
        wea5BKqs4efTTK2ZL4zecIaP5SX+W3yNgsqJ6Nj8PYhT+Y9XbH4tMTL0NiHZrpI/hZ+9yErAeie8W
        9xyKojrv6O7QWaKOFSepSRKtNgXB808vjdD4qIv3rIBsMOshNwU0Qtr30hZsV3lUpY+0qAFdDMEnA
        GyMQNhOQ==;
Received: from [2001:4bb8:184:af1:f3a9:a7a5:a666:7e03] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGfgX-00048H-GH; Fri, 11 Sep 2020 09:49:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tony.luck@intel.com, fenghua.yu@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: use libata instead of the legacy ide driver in defconfigs
Date:   Fri, 11 Sep 2020 11:49:36 +0200
Message-Id: <20200911094936.1175688-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the ia64 defconfigs to use the modern libata driver instead of
the soon to be removed legacy ide driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/configs/bigsur_defconfig    | 7 +++----
 arch/ia64/configs/generic_defconfig   | 9 ++++-----
 arch/ia64/configs/gensparse_defconfig | 9 ++++-----
 arch/ia64/configs/tiger_defconfig     | 9 ++++-----
 arch/ia64/configs/zx1_defconfig       | 7 +++----
 5 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
index 2ae6d9a32a8d81..cfed5ed8930114 100644
--- a/arch/ia64/configs/bigsur_defconfig
+++ b/arch/ia64/configs/bigsur_defconfig
@@ -26,10 +26,9 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=m
-CONFIG_IDE=m
-CONFIG_BLK_DEV_IDECD=m
-CONFIG_BLK_DEV_GENERIC=m
-CONFIG_BLK_DEV_PIIX=m
+CONFIG_ATA=m
+CONFIG_ATA_GENERIC=m
+CONFIG_ATA_PIIX=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_CONSTANTS=y
diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
index 19a0809cbacca1..ca0d596c800d80 100644
--- a/arch/ia64/configs/generic_defconfig
+++ b/arch/ia64/configs/generic_defconfig
@@ -44,11 +44,10 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SGI_XP=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_BLK_DEV_PIIX=y
+CONFIG_ATA=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_CMD64X=y
+CONFIG_ATA_PIIX=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=m
diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gensparse_defconfig
index 69322bf27aa39d..281eb9c544f9ce 100644
--- a/arch/ia64/configs/gensparse_defconfig
+++ b/arch/ia64/configs/gensparse_defconfig
@@ -35,12 +35,11 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
+CONFIG_ATA=y
 CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_BLK_DEV_PIIX=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_CMD64X=y
+CONFIG_ATA_PIIX=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
index bb510e9cc2f51d..b4f9819a1a45d6 100644
--- a/arch/ia64/configs/tiger_defconfig
+++ b/arch/ia64/configs/tiger_defconfig
@@ -40,11 +40,10 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_BLK_DEV_PIIX=y
+CONFIG_ATA=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_CMD64X=y
+CONFIG_ATA_PIIX=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index b43acc97854148..629cb9cdf723b3 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -25,10 +25,9 @@ CONFIG_IP_MULTICAST=y
 CONFIG_NETFILTER=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_CMD64X=y
+CONFIG_ATA=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_CMD64X=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
-- 
2.28.0

