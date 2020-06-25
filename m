Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CC820706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405977AbgFYPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:45:01 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48403 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405910AbgFYPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:44:54 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A4DB840006;
        Thu, 25 Jun 2020 15:44:51 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: [PATCH net-next 0/8] net: phy: mscc: multiple improvements
Date:   Thu, 25 Jun 2020 17:42:03 +0200
Message-Id: <20200625154211.606591-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains various improvements to the MSCC PHY driver, fixing
sparse and smatch warnings, using functions provided by the PHY core,
and improving the driver consistency and maintenance.

I don't think any of those improvements and fixes is worth backporting
to stable trees.

Thanks!
Antoine

Antoine Tenart (8):
  net: phy: mscc: macsec: fix sparse warnings
  net: phy: mscc: fix a possible double unlock
  net: phy: mscc: ptp: fix a smatch error
  net: phy: mscc: ptp: fix a typo in a comment
  net: phy: mscc: do not access the MDIO bus lock directly
  net: phy: mscc: restore the base page in vsc8514/8584_config_init
  net: phy: mscc: remove useless page configuration in the config init
  net: phy: mscc: improve vsc8514/8584_config_init consistency

 drivers/net/phy/mscc/mscc_macsec.c | 12 ++++---
 drivers/net/phy/mscc/mscc_main.c   | 54 +++++++++++++++++-------------
 drivers/net/phy/mscc/mscc_ptp.c    | 15 +++++----
 3 files changed, 45 insertions(+), 36 deletions(-)

-- 
2.26.2

