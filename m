Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E3C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35352072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCTKl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:41:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54848 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbgCTKlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:41:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C581B2004B1;
        Fri, 20 Mar 2020 11:41:02 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A8CC82004A4;
        Fri, 20 Mar 2020 11:40:56 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E4B1C402FF;
        Fri, 20 Mar 2020 18:40:48 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Cochran <richardcochran@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: [PATCH 3/6] net: mscc: ocelot: fix timestamp info if ptp clock does not work
Date:   Fri, 20 Mar 2020 18:37:23 +0800
Message-Id: <20200320103726.32559-4-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320103726.32559-1-yangbo.lu@nxp.com>
References: <20200320103726.32559-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timestamp info should be only software timestamp capabilities
if ptp clock does not work.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index b342bbd..114d605 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1348,6 +1348,12 @@ int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 {
 	info->phc_index = ocelot->ptp_clock ?
 			  ptp_clock_index(ocelot->ptp_clock) : -1;
+	if (info->phc_index == -1) {
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
+					 SOF_TIMESTAMPING_RX_SOFTWARE |
+					 SOF_TIMESTAMPING_SOFTWARE;
+		return 0;
+	}
 	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
 				 SOF_TIMESTAMPING_RX_SOFTWARE |
 				 SOF_TIMESTAMPING_SOFTWARE |
-- 
2.7.4

