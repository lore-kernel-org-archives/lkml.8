Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626062086A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037514;
	bh=dcISaO5ZIf/Q0SbY++gUBhKTdgN9apg2neVbPtJy5wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mlbmtYlg4ovOVHtcUuOkcIyWCl3pnRvaWpOCsiPvBAR9LEFOSQOi8j+YIvT6d7N5b
	 ErgavIdmq4i+PUnE0ChFaa6M+ZUfhPGw9vUrueuKVxQ0wzosRf1VDeyMAjeSKHjPy5
	 n3lY54Pi+jJN5+kYSjNGLOKMoabneakmNgmL4JC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgFASvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbgFASEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:04:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C555206E2;
        Mon,  1 Jun 2020 18:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034676;
        bh=dcISaO5ZIf/Q0SbY++gUBhKTdgN9apg2neVbPtJy5wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wBTNxFucRKHb80Bcoy2wHzzyiJlROJLaYjw/IHSR7HIvvIqdKKY32QPRunlx1Pwn/
         maSuyIsNv6DatkC0CoeYN/UEQ1PIE6sdHGOMon3PkXnAbJmxKrK+2JgU2IQOLtYR64
         00KgFWi1TkNs07N+Wof6uau8WKKIjMk+QeD0w1fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 32/95] net: freescale: select CONFIG_FIXED_PHY where needed
Date:   Mon,  1 Jun 2020 19:53:32 +0200
Message-Id: <20200601174025.867837444@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 99352c79af3e5f2e4724abf37fa5a2a3299b1c81 ]

I ran into a randconfig build failure with CONFIG_FIXED_PHY=m
and CONFIG_GIANFAR=y:

x86_64-linux-ld: drivers/net/ethernet/freescale/gianfar.o:(.rodata+0x418): undefined reference to `fixed_phy_change_carrier'

It seems the same thing can happen with dpaa and ucc_geth, so change
all three to do an explicit 'select FIXED_PHY'.

The fixed-phy driver actually has an alternative stub function that
theoretically allows building network drivers when fixed-phy is
disabled, but I don't see how that would help here, as the drivers
presumably would not work then.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/Kconfig      | 2 ++
 drivers/net/ethernet/freescale/dpaa/Kconfig | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index a580a3dcbe59..e9f4326a0afa 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -76,6 +76,7 @@ config UCC_GETH
 	depends on QUICC_ENGINE
 	select FSL_PQ_MDIO
 	select PHYLIB
+	select FIXED_PHY
 	---help---
 	  This driver supports the Gigabit Ethernet mode of the QUICC Engine,
 	  which is available on some Freescale SOCs.
@@ -89,6 +90,7 @@ config GIANFAR
 	depends on HAS_DMA
 	select FSL_PQ_MDIO
 	select PHYLIB
+	select FIXED_PHY
 	select CRC32
 	---help---
 	  This driver supports the Gigabit TSEC on the MPC83xx, MPC85xx,
diff --git a/drivers/net/ethernet/freescale/dpaa/Kconfig b/drivers/net/ethernet/freescale/dpaa/Kconfig
index a654736237a9..8fec41e57178 100644
--- a/drivers/net/ethernet/freescale/dpaa/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
@@ -2,6 +2,7 @@ menuconfig FSL_DPAA_ETH
 	tristate "DPAA Ethernet"
 	depends on FSL_DPAA && FSL_FMAN
 	select PHYLIB
+	select FIXED_PHY
 	select FSL_FMAN_MAC
 	---help---
 	  Data Path Acceleration Architecture Ethernet driver,
-- 
2.25.1



