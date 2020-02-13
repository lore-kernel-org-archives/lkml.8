Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A3C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8846520675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608185;
	bh=bTaM9z7UZIreCdFbopgJgFvaS0Ot1vVV2fi3Qq0RXyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PeW/UbArBuILTGZmq4T94wSREfsDFgTz5ncY9ZyXvFF+UyZ79FWwmIyI0LBvUUklQ
	 ihO+i0oXLpD/tmhQk5E1HuJ62X/m9dulFp6zgT0o6ucjb/xpwnQBpHczLUktQDrd8h
	 B51kxf38zdUkWubUn2wuBxmsbNi/SQEQU7l4jLp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbgBMPab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:30:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbgBMP1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:20 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D3C24681;
        Thu, 13 Feb 2020 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607639;
        bh=bTaM9z7UZIreCdFbopgJgFvaS0Ot1vVV2fi3Qq0RXyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIuIRVq4GN1YNsJQr54pZ0snxBd+eNrGEPQ/mNPEEPtgmiu9mEZzJoMGaLDl3O/z+
         pjfVVrwUgLCsW2Y0Y7u9uleQGKGPa+zABoVwUysvInM81eOeymEbspFQrTzPcuo27N
         I4wDxlhFBucW7WC57Ztf6NAZVUZL5SfNSA0O0xeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Ziswiler <marcel@ziswiler.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.4 17/96] PCI: tegra: Fix afi_pex2_ctrl reg offset for Tegra30
Date:   Thu, 13 Feb 2020 07:20:24 -0800
Message-Id: <20200213151846.153218983@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel@ziswiler.com>

commit 21a92676e1fe292acb077b13106b08c22ed36b14 upstream.

Fix AFI_PEX2_CTRL reg offset for Tegra30 by moving it from the Tegra20
SoC struct where it erroneously got added. This fixes the AFI_PEX2_CTRL
reg offset being uninitialised subsequently failing to bring up the
third PCIe port.

Fixes: adb2653b3d2e ("PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC struct")
Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/pci-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2499,7 +2499,6 @@ static const struct tegra_pcie_soc tegra
 	.num_ports = 2,
 	.ports = tegra20_pcie_ports,
 	.msi_base_shift = 0,
-	.afi_pex2_ctrl = 0x128,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
 	.pads_refclk_cfg0 = 0xfa5cfa5c,
@@ -2528,6 +2527,7 @@ static const struct tegra_pcie_soc tegra
 	.num_ports = 3,
 	.ports = tegra30_pcie_ports,
 	.msi_base_shift = 8,
+	.afi_pex2_ctrl = 0x128,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0xfa5cfa5c,


