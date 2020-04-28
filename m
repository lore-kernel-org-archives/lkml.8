Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB2C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67E12053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgD1HxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgD1HxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:53:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238AC03C1AA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:53:19 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jTL3I-000287-0X; Tue, 28 Apr 2020 09:53:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jTL3F-0000uN-SB; Tue, 28 Apr 2020 09:53:09 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Kubecek <mkubecek@suse.cz>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, mkl@pengutronix.de,
        Marek Vasut <marex@denx.de>,
        Christian Herber <christian.herber@nxp.com>
Subject: [PATCH net-next v3 0/2] provide support for PHY master/slave configuration
Date:   Tue, 28 Apr 2020 09:53:06 +0200
Message-Id: <20200428075308.2938-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.26.2
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
- provide separate field for config and state.
- make state rejected on set
- add validation

changes v2:
- change names. Use MASTER_PREFERRED instead of MULTIPORT
- configure master/slave only on request. Default configuration can be
  provided by PHY or eeprom
- status and configuration to the user space.

Oleksij Rempel (2):
  ethtool: provide UAPI for PHY master/slave configuration.
  net: phy: tja11xx: add support for master-slave configuration

 Documentation/networking/ethtool-netlink.rst |  3 +
 drivers/net/phy/nxp-tja11xx.c                | 58 ++++++++++++-
 drivers/net/phy/phy.c                        |  7 +-
 drivers/net/phy/phy_device.c                 | 89 ++++++++++++++++++++
 include/linux/phy.h                          |  3 +
 include/uapi/linux/ethtool.h                 | 29 ++++++-
 include/uapi/linux/ethtool_netlink.h         |  2 +
 include/uapi/linux/mii.h                     |  2 +
 net/ethtool/linkmodes.c                      | 15 +++-
 9 files changed, 204 insertions(+), 4 deletions(-)

-- 
2.26.2

