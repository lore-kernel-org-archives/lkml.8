Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476EDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287AC206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgCMJuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:50:14 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53105 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgCMJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:50:11 -0400
X-Originating-IP: 90.89.41.158
Received: from localhost (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 16C721C0004;
        Fri, 13 Mar 2020 09:50:08 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: phy: split the mscc driver
Date:   Fri, 13 Mar 2020 10:47:59 +0100
Message-Id: <20200313094802.82863-1-antoine.tenart@bootlin.com>
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

Since v2:
  - Defined inline functions as static inline.
  - Fixed a locking issue reported by Kbuild.

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

