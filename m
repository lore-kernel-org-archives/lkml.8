Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D75C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7492072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgHYE50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:26 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:38492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728821AbgHYE5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6A42D182CED2A;
        Tue, 25 Aug 2020 04:57:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soap42_300b81b27059
X-Filterd-Recvd-Size: 4465
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:11 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 16/29] 8390: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:13 -0700
Message-Id: <720727617483779e9831f513bf9b671f59d26d57.1598331149.git.joe@perches.com>
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
 drivers/net/ethernet/8390/axnet_cs.c | 19 ++++++++++++-------
 drivers/net/ethernet/8390/lib8390.c  | 14 +++++++++-----
 drivers/net/ethernet/8390/pcnet_cs.c |  6 ++++--
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/8390/axnet_cs.c b/drivers/net/ethernet/8390/axnet_cs.c
index a00b36f91d9f..d041b6dda012 100644
--- a/drivers/net/ethernet/8390/axnet_cs.c
+++ b/drivers/net/ethernet/8390/axnet_cs.c
@@ -657,8 +657,10 @@ static void block_input(struct net_device *dev, int count,
     outb_p(E8390_RREAD+E8390_START, nic_base + AXNET_CMD);
 
     insw(nic_base + AXNET_DATAPORT,buf,count>>1);
-    if (count & 0x01)
-	buf[count-1] = inb(nic_base + AXNET_DATAPORT), xfer_count++;
+    if (count & 0x01) {
+	buf[count-1] = inb(nic_base + AXNET_DATAPORT);
+	xfer_count++;
+    }
 
 }
 
@@ -1270,10 +1272,12 @@ static void ei_tx_intr(struct net_device *dev)
 			ei_local->txing = 1;
 			NS8390_trigger_send(dev, ei_local->tx2, ei_local->tx_start_page + 6);
 			netif_trans_update(dev);
-			ei_local->tx2 = -1,
+			ei_local->tx2 = -1;
 			ei_local->lasttx = 2;
-		}
-		else ei_local->lasttx = 20, ei_local->txing = 0;	
+		} else {
+			ei_local->lasttx = 20;
+			ei_local->txing = 0;
+		}	
 	}
 	else if (ei_local->tx2 < 0) 
 	{
@@ -1289,9 +1293,10 @@ static void ei_tx_intr(struct net_device *dev)
 			netif_trans_update(dev);
 			ei_local->tx1 = -1;
 			ei_local->lasttx = 1;
+		} else {
+			ei_local->lasttx = 10;
+			ei_local->txing = 0;
 		}
-		else
-			ei_local->lasttx = 10, ei_local->txing = 0;
 	}
 //	else
 //		netdev_warn(dev, "unexpected TX-done interrupt, lasttx=%d\n",
diff --git a/drivers/net/ethernet/8390/lib8390.c b/drivers/net/ethernet/8390/lib8390.c
index babc92e2692e..1f48d7f6365c 100644
--- a/drivers/net/ethernet/8390/lib8390.c
+++ b/drivers/net/ethernet/8390/lib8390.c
@@ -597,10 +597,12 @@ static void ei_tx_intr(struct net_device *dev)
 			ei_local->txing = 1;
 			NS8390_trigger_send(dev, ei_local->tx2, ei_local->tx_start_page + 6);
 			netif_trans_update(dev);
-			ei_local->tx2 = -1,
+			ei_local->tx2 = -1;
 			ei_local->lasttx = 2;
-		} else
-			ei_local->lasttx = 20, ei_local->txing = 0;
+		} else {
+			ei_local->lasttx = 20;
+			ei_local->txing = 0;
+		}
 	} else if (ei_local->tx2 < 0) {
 		if (ei_local->lasttx != 2  &&  ei_local->lasttx != -2)
 			pr_err("%s: bogus last_tx_buffer %d, tx2=%d\n",
@@ -612,8 +614,10 @@ static void ei_tx_intr(struct net_device *dev)
 			netif_trans_update(dev);
 			ei_local->tx1 = -1;
 			ei_local->lasttx = 1;
-		} else
-			ei_local->lasttx = 10, ei_local->txing = 0;
+		} else {
+			ei_local->lasttx = 10;
+			ei_local->txing = 0;
+		}
 	} /* else
 		netdev_warn(dev, "unexpected TX-done interrupt, lasttx=%d\n",
 			    ei_local->lasttx);
diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 164c3ed550bf..9d3b1e0e425c 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -1178,8 +1178,10 @@ static void dma_block_input(struct net_device *dev, int count,
     outb_p(E8390_RREAD+E8390_START, nic_base + PCNET_CMD);
 
     insw(nic_base + PCNET_DATAPORT,buf,count>>1);
-    if (count & 0x01)
-	buf[count-1] = inb(nic_base + PCNET_DATAPORT), xfer_count++;
+    if (count & 0x01) {
+	buf[count-1] = inb(nic_base + PCNET_DATAPORT);
+	xfer_count++;
+    }
 
     /* This was for the ALPHA version only, but enough people have been
        encountering problems that it is still here. */
-- 
2.26.0

