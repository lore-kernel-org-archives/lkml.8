Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6831DC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE0C2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAJQU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:20:27 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55969 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgAJQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:20:25 -0500
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B5C141BF212;
        Fri, 10 Jan 2020 16:20:22 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        allan.nielsen@microchip.com, camelia.groza@nxp.com,
        Simon.Edelhaus@aquantia.com, Igor.Russkikh@aquantia.com,
        jakub.kicinski@netronome.com
Subject: [PATCH net-next v5 03/15] net: macsec: introduce MACsec ops
Date:   Fri, 10 Jan 2020 17:19:58 +0100
Message-Id: <20200110162010.338611-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110162010.338611-1-antoine.tenart@bootlin.com>
References: <20200110162010.338611-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces MACsec ops for drivers to support offloading
MACsec operations.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 include/net/macsec.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index 8882379d68ac..4d0afb79259e 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -196,4 +196,28 @@ struct macsec_context {
 	u8 prepare:1;
 };
 
+/**
+ * struct macsec_ops - MACsec offloading operations
+ */
+struct macsec_ops {
+	/* Device wide */
+	int (*mdo_dev_open)(struct macsec_context *ctx);
+	int (*mdo_dev_stop)(struct macsec_context *ctx);
+	/* SecY */
+	int (*mdo_add_secy)(struct macsec_context *ctx);
+	int (*mdo_upd_secy)(struct macsec_context *ctx);
+	int (*mdo_del_secy)(struct macsec_context *ctx);
+	/* Security channels */
+	int (*mdo_add_rxsc)(struct macsec_context *ctx);
+	int (*mdo_upd_rxsc)(struct macsec_context *ctx);
+	int (*mdo_del_rxsc)(struct macsec_context *ctx);
+	/* Security associations */
+	int (*mdo_add_rxsa)(struct macsec_context *ctx);
+	int (*mdo_upd_rxsa)(struct macsec_context *ctx);
+	int (*mdo_del_rxsa)(struct macsec_context *ctx);
+	int (*mdo_add_txsa)(struct macsec_context *ctx);
+	int (*mdo_upd_txsa)(struct macsec_context *ctx);
+	int (*mdo_del_txsa)(struct macsec_context *ctx);
+};
+
 #endif /* _NET_MACSEC_H_ */
-- 
2.24.1

