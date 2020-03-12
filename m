Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BFDC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4F720575
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgCLGee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:34:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46875 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387784AbgCLGed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:34:33 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jCHQF-0006xL-Lz; Thu, 12 Mar 2020 07:34:23 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jCHQE-00069u-8z; Thu, 12 Mar 2020 07:34:22 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Marek Vasut <marex@denx.de>, David Jander <david@protonic.nl>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/4] add TJA1102 support
Date:   Thu, 12 Mar 2020 07:34:15 +0100
Message-Id: <20200312063419.23615-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v3:
- export part of of_mdiobus_register_phy() and reuse it in tja11xx
  driver
- coding style fixes

changes v2:
- use .match_phy_device
- add irq support
- add add delayed registration for PHY1

Oleksij Rempel (4):
  dt-bindings: net: phy: Add support for NXP TJA11xx
  net: phy: tja11xx: add initial TJA1102 support
  net: mdio: of: export part of of_mdiobus_register_phy()
  net: phy: tja11xx: add delayed registration of TJA1102 PHY1

 .../devicetree/bindings/net/nxp,tja11xx.yaml  |  61 ++++++
 drivers/net/phy/nxp-tja11xx.c                 | 201 +++++++++++++++++-
 drivers/of/of_mdio.c                          |  74 ++++---
 include/linux/of_mdio.h                       |  11 +-
 4 files changed, 309 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,tja11xx.yaml

-- 
2.25.1

