Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED29204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690335;
	bh=4B9M30yOczoJmUUUKtSnieioAmo0+n5FXfVoWuaIk7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QBzJTiN0OKc63w5VPOpvKt/sxeNIMeggVNtgaXOKvNa7meEcl0MTv8lUB27uRz7eU
	 OJjvtspnRpJ8sWrZEnRSF3dIgEyTLXevBqOH1VKU4T5gsuTeOl/7Zfvj9Jc81gsGtG
	 cEAPTWtcpADNJm7t1yvJn870PcQLC9XPWOCUX1yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403818AbgHQSwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387855AbgHQPwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:52:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1152072E;
        Mon, 17 Aug 2020 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679551;
        bh=4B9M30yOczoJmUUUKtSnieioAmo0+n5FXfVoWuaIk7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qR97DEasD6S/6QFHuQwMxI3NHc1rcz0oSD6Se3iOpRYwxUmOfWZbdWreHEPis4X6O
         nxSzK9wUZfJgFnKx9FdZ7M/K3Q+3cr5eJQY/CBUXwKADGTcFpSbdXqezSr0wLOK88y
         NAm2yAwwp1Z1WwsL2fe+uSf5IGJ0sc9AI6yAZw+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 251/393] PCI: cadence: Fix updating Vendor ID and Subsystem Vendor ID register
Date:   Mon, 17 Aug 2020 17:15:01 +0200
Message-Id: <20200817143831.796275839@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit e3bca37d15dca118f2ef1f0a068bb6e07846ea20 ]

Commit 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe
controller") in order to update Vendor ID, directly wrote to
PCI_VENDOR_ID register. However PCI_VENDOR_ID in root port configuration
space is read-only register and writing to it will have no effect.
Use local management register to configure Vendor ID and Subsystem Vendor
ID.

Link: https://lore.kernel.org/r/20200722110317.4744-10-kishon@ti.com
Fixes: 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 11eb81da0233f..aa18fb724d2ed 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -69,6 +69,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
 	u32 value, ctrl;
+	u32 id;
 
 	/*
 	 * Set the root complex BAR configuration register:
@@ -88,8 +89,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
 
 	/* Set root port configuration space */
-	if (rc->vendor_id != 0xffff)
-		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
+	if (rc->vendor_id != 0xffff) {
+		id = CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
+			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
+	}
+
 	if (rc->device_id != 0xffff)
 		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
 
-- 
2.25.1



