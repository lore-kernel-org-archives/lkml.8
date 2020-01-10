Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5722DC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EE72080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgAJLy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:54:26 -0500
Received: from foss.arm.com ([217.140.110.172]:43084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbgAJLyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:54:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB7B1063;
        Fri, 10 Jan 2020 03:54:24 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A13593F534;
        Fri, 10 Jan 2020 03:54:23 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] net: xilinx: temac: Relax Kconfig dependencies
Date:   Fri, 10 Jan 2020 11:54:02 +0000
Message-Id: <20200110115415.75683-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110115415.75683-1-andre.przywara@arm.com>
References: <20200110115415.75683-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to axienet, the temac driver is now architecture agnostic, and
can be at least compiled for several architectures.
Especially the fact that this is a soft IP for implementing in FPGAs
makes the current restriction rather pointless, as it could literally
appear on any architecture, as long as an FPGA is connected to the bus.

The driver hasn't been actually tried on any hardware, it is just a
drive-by patch when doing the same for axienet (a similar patch for
axienet is already merged).

This (temac and axienet) have been compile-tested for:
alpha hppa64 microblaze mips64 powerpc powerpc64 riscv64 s390 sparc64
(using kernel.org cross compilers).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/net/ethernet/xilinx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 6304ebd8b5c6..0810af8193cb 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -32,7 +32,6 @@ config XILINX_AXI_EMAC
 
 config XILINX_LL_TEMAC
 	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
-	depends on PPC || MICROBLAZE || X86 || COMPILE_TEST
 	select PHYLIB
 	---help---
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
-- 
2.17.1

