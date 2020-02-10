Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC13C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DDD2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338884;
	bh=XJ1roiFTYWm+63LJKnpN8lPcUwrfJbwEpPXZtnWvoKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yzNG6uxiK+chq9r6FhmHIUP874VDCoLT/q5I8+BRRgNg2hvxAfmV7gtVGqfYltUut
	 uKE7fYCQR+QT01ScLRXXBgHjSEL6SXmYZF/dtjLqyWWODipsQm0feV2vLHkNOrscw6
	 ycxjnMJbDTNI+Yx0gfiQnSgSHW8qA3vGw16fsCw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgBJMrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbgBJMoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:44:06 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0455E20838;
        Mon, 10 Feb 2020 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338646;
        bh=XJ1roiFTYWm+63LJKnpN8lPcUwrfJbwEpPXZtnWvoKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFX69bi/9vY3yVaW7EkVLcGXvWhb6HBA1SeVR9owpAB0qQSxDQ2tvtOg7zpwIhCVZ
         LezIaxxSs2uiVNVCrvRFuGefA8KpVXdCMBXsTghRF66znmkpmBulaOSj0M5JAoTF9p
         5Jcgn9H0EeqKkFWu/q2M9sIm8R07kogVO1MFPg6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Voon Weifeng <weifeng.voon@intel.com>,
        "Tan, Tee Min" <tee.min.tan@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 334/367] net: stmmac: update pci platform data to use phy_interface
Date:   Mon, 10 Feb 2020 04:34:07 -0800
Message-Id: <20200210122453.616957766@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Voon Weifeng <weifeng.voon@intel.com>

[ Upstream commit 909c1dde67c433f1e4122f2619cbd8ac370fcf0a ]

The recent patch to support passive mode converter did not take care the
phy interface configuration in PCI platform data. Hence, converting all
the PCI platform data from plat->interface to plat->phy_interface as the
default mode is meant for PHY.

Fixes: 0060c8783330 ("net: stmmac: implement support for passive mode converters via dt")
Signed-off-by: Voon Weifeng <weifeng.voon@intel.com>
Tested-by: Tan, Tee Min <tee.min.tan@intel.com>
Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -96,7 +96,7 @@ static int stmmac_default_data(struct pc
 
 	plat->bus_id = 1;
 	plat->phy_addr = 0;
-	plat->interface = PHY_INTERFACE_MODE_GMII;
+	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
@@ -220,7 +220,8 @@ static int ehl_sgmii_data(struct pci_dev
 {
 	plat->bus_id = 1;
 	plat->phy_addr = 0;
-	plat->interface = PHY_INTERFACE_MODE_SGMII;
+	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
+
 	return ehl_common_data(pdev, plat);
 }
 
@@ -233,7 +234,8 @@ static int ehl_rgmii_data(struct pci_dev
 {
 	plat->bus_id = 1;
 	plat->phy_addr = 0;
-	plat->interface = PHY_INTERFACE_MODE_RGMII;
+	plat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+
 	return ehl_common_data(pdev, plat);
 }
 
@@ -261,7 +263,7 @@ static int tgl_sgmii_data(struct pci_dev
 {
 	plat->bus_id = 1;
 	plat->phy_addr = 0;
-	plat->interface = PHY_INTERFACE_MODE_SGMII;
+	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	return tgl_common_data(pdev, plat);
 }
 
@@ -361,7 +363,7 @@ static int quark_default_data(struct pci
 
 	plat->bus_id = pci_dev_id(pdev);
 	plat->phy_addr = ret;
-	plat->interface = PHY_INTERFACE_MODE_RMII;
+	plat->phy_interface = PHY_INTERFACE_MODE_RMII;
 
 	plat->dma_cfg->pbl = 16;
 	plat->dma_cfg->pblx8 = true;
@@ -418,7 +420,7 @@ static int snps_gmac5_default_data(struc
 
 	plat->bus_id = 1;
 	plat->phy_addr = -1;
-	plat->interface = PHY_INTERFACE_MODE_GMII;
+	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;


