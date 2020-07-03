Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FE92070C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGCI1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:27:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCI1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5443EAD11;
        Fri,  3 Jul 2020 08:27:42 +0000 (UTC)
Date:   Fri, 3 Jul 2020 10:27:41 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Krzysztof Halasa <khalasa@piap.pl>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/2] soc: ixp4xx: Really select helper drivers automatically
Message-ID: <20200703102741.6b0b03a2@endymion>
In-Reply-To: <20200703102617.0b9f933e@endymion>
References: <20200703102617.0b9f933e@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig claims that the ixp4xx-qmgr and ixp4xx-npe helper drivers
are selected automatically as needed. However this is not what the
Kconfig entries are doing. Convert depends to select to match the
help texts.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Krzysztof Halasa <khalasa@piap.pl>
---
 drivers/crypto/Kconfig              |    4 +++-
 drivers/net/ethernet/xscale/Kconfig |    7 ++++---
 drivers/net/wan/Kconfig             |    4 +++-
 3 files changed, 10 insertions(+), 5 deletions(-)

--- linux-5.7.orig/drivers/net/ethernet/xscale/Kconfig	2020-06-01 01:49:15.000000000 +0200
+++ linux-5.7/drivers/net/ethernet/xscale/Kconfig	2020-06-23 13:05:23.071767146 +0200
@@ -6,8 +6,7 @@
 config NET_VENDOR_XSCALE
 	bool "Intel XScale IXP devices"
 	default y
-	depends on NET_VENDOR_INTEL && (ARM && ARCH_IXP4XX && \
-		   IXP4XX_NPE && IXP4XX_QMGR)
+	depends on NET_VENDOR_INTEL && (ARM && ARCH_IXP4XX)
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -20,9 +19,11 @@ if NET_VENDOR_XSCALE
 
 config IXP4XX_ETH
 	tristate "Intel IXP4xx Ethernet support"
-	depends on ARM && ARCH_IXP4XX && IXP4XX_NPE && IXP4XX_QMGR
+	depends on ARM && ARCH_IXP4XX
 	select PHYLIB
 	select NET_PTP_CLASSIFY
+	select IXP4XX_NPE
+	select IXP4XX_QMGR
 	---help---
 	  Say Y here if you want to use built-in Ethernet ports
 	  on IXP4xx processor.
--- linux-5.7.orig/drivers/net/wan/Kconfig	2020-06-01 01:49:15.000000000 +0200
+++ linux-5.7/drivers/net/wan/Kconfig	2020-06-23 13:05:23.072767157 +0200
@@ -315,8 +315,10 @@ config DSCC4_PCI_RST
 
 config IXP4XX_HSS
 	tristate "Intel IXP4xx HSS (synchronous serial port) support"
-	depends on HDLC && IXP4XX_NPE && IXP4XX_QMGR
+	depends on HDLC
 	depends on ARCH_IXP4XX
+	select IXP4XX_NPE
+	select IXP4XX_QMGR
 	help
 	  Say Y here if you want to use built-in HSS ports
 	  on IXP4xx processor.
--- linux-5.7.orig/drivers/crypto/Kconfig	2020-06-01 01:49:15.000000000 +0200
+++ linux-5.7/drivers/crypto/Kconfig	2020-06-25 00:04:11.570461001 +0200
@@ -308,11 +308,13 @@ config CRYPTO_DEV_TALITOS2
 
 config CRYPTO_DEV_IXP4XX
 	tristate "Driver for IXP4xx crypto hardware acceleration"
-	depends on ARCH_IXP4XX && IXP4XX_QMGR && IXP4XX_NPE
+	depends on ARCH_IXP4XX
 	select CRYPTO_LIB_DES
 	select CRYPTO_AEAD
 	select CRYPTO_AUTHENC
 	select CRYPTO_SKCIPHER
+	select IXP4XX_NPE
+	select IXP4XX_QMGR
 	help
 	  Driver for the IXP4xx NPE crypto engine.
 

-- 
Jean Delvare
SUSE L3 Support
