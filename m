Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE7AC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186CB21569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAMWci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:32:38 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:43389 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgAMWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:32:09 -0500
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4612D100008;
        Mon, 13 Jan 2020 22:32:07 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        allan.nielsen@microchip.com, camelia.groza@nxp.com,
        Simon.Edelhaus@aquantia.com, Igor.Russkikh@aquantia.com,
        jakub.kicinski@netronome.com
Subject: [PATCH net-next v6 09/10] net: macsec: PN wrap callback
Date:   Mon, 13 Jan 2020 23:31:47 +0100
Message-Id: <20200113223148.746096-10-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113223148.746096-1-antoine.tenart@bootlin.com>
References: <20200113223148.746096-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to call macsec_pn_wrapped from hardware drivers to notify when a
PN rolls over. Some drivers might used an interrupt to implement this.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/macsec.c | 25 +++++++++++++++++++------
 include/net/macsec.h |  2 ++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index e515919e8687..45bfd99f17fa 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -424,6 +424,23 @@ static struct macsec_eth_header *macsec_ethhdr(struct sk_buff *skb)
 	return (struct macsec_eth_header *)skb_mac_header(skb);
 }
 
+static void __macsec_pn_wrapped(struct macsec_secy *secy,
+				struct macsec_tx_sa *tx_sa)
+{
+	pr_debug("PN wrapped, transitioning to !oper\n");
+	tx_sa->active = false;
+	if (secy->protect_frames)
+		secy->operational = false;
+}
+
+void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa)
+{
+	spin_lock_bh(&tx_sa->lock);
+	__macsec_pn_wrapped(secy, tx_sa);
+	spin_unlock_bh(&tx_sa->lock);
+}
+EXPORT_SYMBOL_GPL(macsec_pn_wrapped);
+
 static u32 tx_sa_update_pn(struct macsec_tx_sa *tx_sa, struct macsec_secy *secy)
 {
 	u32 pn;
@@ -432,12 +449,8 @@ static u32 tx_sa_update_pn(struct macsec_tx_sa *tx_sa, struct macsec_secy *secy)
 	pn = tx_sa->next_pn;
 
 	tx_sa->next_pn++;
-	if (tx_sa->next_pn == 0) {
-		pr_debug("PN wrapped, transitioning to !oper\n");
-		tx_sa->active = false;
-		if (secy->protect_frames)
-			secy->operational = false;
-	}
+	if (tx_sa->next_pn == 0)
+		__macsec_pn_wrapped(secy, tx_sa);
 	spin_unlock_bh(&tx_sa->lock);
 
 	return pn;
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 16e7e5061178..92e43db8b566 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -219,4 +219,6 @@ struct macsec_ops {
 	int (*mdo_del_txsa)(struct macsec_context *ctx);
 };
 
+void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
+
 #endif /* _NET_MACSEC_H_ */
-- 
2.24.1

