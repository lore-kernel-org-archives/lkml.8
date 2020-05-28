Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8F0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC8E207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Foxge38i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgE1GjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:39:08 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44979 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1GjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:39:07 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D49D522F00;
        Thu, 28 May 2020 08:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590647945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q1bu5QBhdAdbXUvXEiEnCUZrSNivo5f5gugf+SSbHRk=;
        b=Foxge38iXXwaD7tVwCvpNWREQi6gUrdK//72LrokP0OG/OTmwa7fA1GMPXUJ4JWjhE0r0D
        ytbnAeOYkOkxA9+Ir/j/BUdNHP24/T7hpkgVnvqvycj45LPbCrLXdZ2KYTx+Jrc3rLaDmE
        omO0JhzMPV2Uq7q0sdj6UngdaSwnqjg=
From:   Michael Walle <michael@walle.cc>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Michael Walle <michael@walle.cc>,
        Vladimir Oltean <olteanv@gmail.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH net-next v3 0/3] net: enetc: remove bootloader dependency
Date:   Thu, 28 May 2020 08:38:44 +0200
Message-Id: <20200528063847.27704-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches were picked from the following series:
https://lore.kernel.org/netdev/1567779344-30965-1-git-send-email-claudiu.manoil@nxp.com/
They have never been resent. I've picked them up, addressed Andrews
comments, fixed some more bugs and asked Claudiu if I can keep their SOB
tags; he agreed. I've tested this on our board which happens to have a
bootloader which doesn't do the enetc setup in all cases. Though, only
SGMII mode was tested.

changes since v2:
 - removed SOBs from "net: enetc: Initialize SerDes for SGMII and USXGMII
   protocols" because almost everything has changed.
 - get a phy_device for the internal PCS PHY so we can use the phy_
   functions instead of raw mdiobus writes
 - reuse macros already defined in fsl_mdio.h, move missing bits from
   felix to fsl_mdio.h, because they share the same PCS PHY building
   block
 - added 2500BaseX mode (based on felix init routine)
 - changed xgmii mode to usxgmii mode, because it is actually USXGMII and
   felix does the same.
 - fixed devad, which is 0x1f (MMD_VEND2)

changes since v1:
 - mdiobus id is '"imdio-%s", dev_name(dev)' because the plain dev_name()
   is used by the emdio.
 - use mdiobus_write() instead of imdio->write(imdio, ..), since this is
   already a full featured mdiobus
 - set phy_mask to ~0 to avoid scanning the bus
 - use phy_interface_mode_is_rgmii(phy_mode) to also include the RGMII
   modes with pad delays.
 - move enetc_imdio_init() to enetc_pf.c, there shouldn't be any other
   users, should it?
 - renamed serdes to SerDes
 - printing the error code of mdiobus_register() in the error path
 - call mdiobus_unregister() on _remove()
 - call devm_mdiobus_free() if mdiobus_register() fails, since an
   error is not fatal

Alex Marginean (1):
  net: enetc: Use DT protocol information to set up the ports

Michael Walle (2):
  net: dsa: felix: move USXGMII defines to common place
  net: enetc: Initialize SerDes for SGMII and USXGMII protocols

 drivers/net/dsa/ocelot/felix_vsc9959.c        |  21 --
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   3 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 191 +++++++++++++++---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   5 +
 include/linux/fsl/enetc_mdio.h                |  19 ++
 5 files changed, 194 insertions(+), 45 deletions(-)

-- 
2.20.1

