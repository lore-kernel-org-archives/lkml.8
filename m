Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1634AC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADF620716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCLWKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:10:42 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46959 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCLWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:10:40 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AD7701BF206;
        Thu, 12 Mar 2020 22:10:38 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: phy: split the mscc driver
Date:   Thu, 12 Mar 2020 23:10:30 +0100
Message-Id: <20200312221033.777437-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a proposal to split the MSCC PHY driver, as its code base grew a
lot lately (it's already 3800+ lines). It also supports features
requiring a lot of code (MACsec), which would gain in being split from
the driver core, for readability and maintenance. This is also done as
other features should be coming later, which will also need lots of code
addition.

This series shouldn't change the way the driver works.

I checked, and there were no patch pending on this driver. This change
was done on top of all the modifications done on this driver in net-next.

Thanks,
Antoine

Since v1:
  - Moved more definitions into the mscc_macsec.h header.

Antoine Tenart (3):
  net: phy: move the mscc driver to its own directory
  net: phy: mscc: split the driver into separate files
  net: phy: mscc: fix header defines and descriptions

 drivers/net/phy/Makefile                     |    2 +-
 drivers/net/phy/mscc/Makefile                |   10 +
 drivers/net/phy/mscc/mscc.h                  |  392 +++++
 drivers/net/phy/{ => mscc}/mscc_fc_buffer.h  |    8 +-
 drivers/net/phy/{ => mscc}/mscc_mac.h        |    8 +-
 drivers/net/phy/mscc/mscc_macsec.c           | 1051 +++++++++++++
 drivers/net/phy/{ => mscc}/mscc_macsec.h     |   66 +-
 drivers/net/phy/{mscc.c => mscc/mscc_main.c} | 1469 +-----------------
 8 files changed, 1532 insertions(+), 1474 deletions(-)
 create mode 100644 drivers/net/phy/mscc/Makefile
 create mode 100644 drivers/net/phy/mscc/mscc.h
 rename drivers/net/phy/{ => mscc}/mscc_fc_buffer.h (95%)
 rename drivers/net/phy/{ => mscc}/mscc_mac.h (98%)
 create mode 100644 drivers/net/phy/mscc/mscc_macsec.c
 rename drivers/net/phy/{ => mscc}/mscc_macsec.h (90%)
 rename drivers/net/phy/{mscc.c => mscc/mscc_main.c} (60%)

-- 
2.24.1

