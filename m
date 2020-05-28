Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13807C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD85207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgE1Lyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbgE1Lyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:54:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD1C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:54:31 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jeH77-0003bN-PB; Thu, 28 May 2020 13:54:21 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jeH71-00030g-Ky; Thu, 28 May 2020 13:54:15 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        "John W. Linville" <linville@tuxdriver.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, mkl@pengutronix.de,
        Marek Vasut <marex@denx.de>,
        Christian Herber <christian.herber@nxp.com>,
        Amit Cohen <amitc@mellanox.com>,
        Petr Machata <petrm@mellanox.com>
Subject: [PATCH v2 0/3] Add support for SQI and master-slave
Date:   Thu, 28 May 2020 13:54:11 +0200
Message-Id: <20200528115414.11516-1-o.rempel@pengutronix.de>
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

This patch set is extending ethtool to make it more usable on automotive
PHYs like NXP TJA11XX.

They make use of new KAPI (currently in net-next, will go probably to the
kernel 5.8-rc1):
- PHY master-slave role configuration and status informaton. Mostly needed
  for 100Base-T1 PHYs due the lack of autonegatiation support.
- Signal Quality Index to investigate cable related issues.

changes v2:
- add master-slave information to the "ethtool --help" and man page
- move KAPI update changes to the separate patch. 

Oleksij Rempel (3):
  update UAPI header copies
  netlink: add master/slave configuration support
  netlink: add LINKSTATE SQI support

 ethtool.8.in                 |  19 ++
 ethtool.c                    |   1 +
 netlink/desc-ethtool.c       |   4 +
 netlink/settings.c           |  66 +++++++
 uapi/linux/ethtool.h         |  25 ++-
 uapi/linux/ethtool_netlink.h | 326 +++++++++++++++++++++++++++++++++++
 uapi/linux/genetlink.h       |   2 +
 uapi/linux/if_link.h         |   7 +-
 uapi/linux/net_tstamp.h      |   6 +
 uapi/linux/netlink.h         | 103 +++++++++++
 uapi/linux/rtnetlink.h       |   6 +
 11 files changed, 561 insertions(+), 4 deletions(-)

-- 
2.26.2

