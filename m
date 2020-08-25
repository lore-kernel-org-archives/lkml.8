Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B0C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350AB2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgHYE5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:25 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:45648 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728043AbgHYE5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 57804837F24D;
        Tue, 25 Aug 2020 04:57:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rings03_320fcc527059
X-Filterd-Recvd-Size: 1890
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:13 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/29] fs_enet: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:14 -0700
Message-Id: <418850ae2026b293ea6ba3b8b19b8a7f8dfcaf3d.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index bf846b42bc74..78e008b81374 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -562,10 +562,13 @@ fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			BD_ENET_TX_TC);
 		CBDS_SC(bdp, BD_ENET_TX_READY);
 
-		if ((CBDR_SC(bdp) & BD_ENET_TX_WRAP) == 0)
-			bdp++, curidx++;
-		else
-			bdp = fep->tx_bd_base, curidx = 0;
+		if ((CBDR_SC(bdp) & BD_ENET_TX_WRAP) == 0) {
+			bdp++;
+			curidx++;
+		} else {
+			bdp = fep->tx_bd_base;
+			curidx = 0;
+		}
 
 		len = skb_frag_size(frag);
 		CBDW_BUFADDR(bdp, skb_frag_dma_map(fep->dev, frag, 0, len,
-- 
2.26.0

