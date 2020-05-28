Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0A8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623F22063A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388769AbgE1MLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:11:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:45760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389724AbgE1MLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:11:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 606DAAD4B;
        Thu, 28 May 2020 12:11:28 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: mvpp2: Enable autoneg bypass for 1000BaseX/2500BaseX ports
Date:   Thu, 28 May 2020 14:11:21 +0200
Message-Id: <20200528121121.125189-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d14e078f23cc ("net: marvell: mvpp2: only reprogram what is necessary
 on mac_config") disabled auto negotiation bypass completely, which breaks
platforms enabling bypass via firmware (not the best option, but it worked).
Since 1000BaseX/2500BaseX ports neither negotiate speed nor duplex mode
we could enable auto negotiation bypass to get back information about link
state.

Fixes: d14e078f23cc ("net: marvell: mvpp2: only reprogram what is necessary on mac_config")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2b5dad2ec650..ddcd781052e1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5043,6 +5043,7 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 			MVPP2_GMAC_CONFIG_GMII_SPEED |
 			MVPP2_GMAC_CONFIG_FULL_DUPLEX);
 		an |= MVPP2_GMAC_IN_BAND_AUTONEG |
+		      MVPP2_GMAC_IN_BAND_AUTONEG_BYPASS |
 		      MVPP2_GMAC_CONFIG_GMII_SPEED |
 		      MVPP2_GMAC_CONFIG_FULL_DUPLEX;
 
-- 
2.16.4

