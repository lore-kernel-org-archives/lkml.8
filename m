Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C846246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgB1P5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:57:13 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47701 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgB1P5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:57:11 -0500
X-Originating-IP: 90.89.41.158
Received: from localhost (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7CCB560003;
        Fri, 28 Feb 2020 15:57:08 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss@0leil.net
Subject: [PATCH net-next v2 0/3] net: phy: mscc: add support for RGMII MAC mode
Date:   Fri, 28 Feb 2020 16:56:59 +0100
Message-Id: <20200228155702.2062570-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for the RGMII MAC mode for the VSC8584 PHY
family.

The first patch adds support for configuring the PHY MAC mode based on
phydev->interface.

The second and third patches add new dt bindings for the MSCC driver, to
configure the RGMII Tx and Rx skews from the device tree.

Thanks!
Antoine

Since v1:
  - The RGMII skew delays are now set based on the PHY interface mode
    being used (RGMII vs ID vs RXID vs TXID).
  - When RGMII is used, the skew delays are set to their default value,
    meaning we do not rely anymore on the bootloader's configuration.
  - Improved the commit messages.
  - s/phy_interface_mode_is_rgmii/phy_interface_is_rgmii/


Antoine Tenart (3):
  net: phy: mscc: add support for RGMII MAC mode
  dt-bindings: net: phy: mscc: document rgmii skew properties
  net: phy: mscc: RGMII skew delay configuration

 .../bindings/net/mscc-phy-vsc8531.txt         |  8 ++
 drivers/net/phy/mscc.c                        | 83 ++++++++++++++++---
 include/dt-bindings/net/mscc-phy-vsc8531.h    | 10 +++
 3 files changed, 89 insertions(+), 12 deletions(-)

-- 
2.24.1

