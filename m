Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22ABC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 02:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC5720637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 02:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgCKCn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 22:43:26 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:41932 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727685AbgCKCn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 22:43:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 15FA652AA;
        Wed, 11 Mar 2020 02:43:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kick15_57e25c75e760e
X-Filterd-Recvd-Size: 3524
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 02:43:23 +0000 (UTC)
Message-ID: <062df3c71913d94339aec60020db7594ba97b0a5.camel@perches.com>
Subject: [PATCH] sfc: ethtool: Refactor to remove fallthrough comments in
 case blocks
From:   Joe Perches <joe@perches.com>
To:     Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Martin Habets <mhabets@solarflare.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 19:41:41 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting fallthrough comments to fallthrough; creates warnings
in this code when compiled with gcc.

This code is overly complicated and reads rather better with a
little refactoring and no fallthrough uses at all.

Remove the fallthrough comments and simplify the written source
code while reducing the object code size.

Consolidate duplicated switch/case blocks for IPV4 and IPV6.

defconfig x86-64 with sfc:

$ size drivers/net/ethernet/sfc/ethtool.o*
   text	   data	    bss	    dec	    hex	filename
  10055	     12	      0	  10067	   2753	drivers/net/ethernet/sfc/ethtool.o.new
  10135	     12	      0	  10147	   27a3	drivers/net/ethernet/sfc/ethtool.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/sfc/ethtool.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 993b57..9a637cd 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -582,6 +582,7 @@ efx_ethtool_get_rxnfc(struct net_device *net_dev,
 
 	case ETHTOOL_GRXFH: {
 		struct efx_rss_context *ctx = &efx->rss_context;
+		__u64 data;
 
 		mutex_lock(&efx->rss_lock);
 		if (info->flow_type & FLOW_RSS && info->rss_context) {
@@ -591,35 +592,38 @@ efx_ethtool_get_rxnfc(struct net_device *net_dev,
 				goto out_unlock;
 			}
 		}
-		info->data = 0;
+
+		data = 0;
 		if (!efx_rss_active(ctx)) /* No RSS */
-			goto out_unlock;
+			goto out_setdata_unlock;
+
 		switch (info->flow_type & ~FLOW_RSS) {
 		case UDP_V4_FLOW:
-			if (ctx->rx_hash_udp_4tuple)
-				/* fall through */
-		case TCP_V4_FLOW:
-				info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			/* fall through */
-		case SCTP_V4_FLOW:
-		case AH_ESP_V4_FLOW:
-		case IPV4_FLOW:
-			info->data |= RXH_IP_SRC | RXH_IP_DST;
-			break;
 		case UDP_V6_FLOW:
 			if (ctx->rx_hash_udp_4tuple)
-				/* fall through */
+				data = (RXH_L4_B_0_1 | RXH_L4_B_2_3 |
+					RXH_IP_SRC | RXH_IP_DST);
+			else
+				data = RXH_IP_SRC | RXH_IP_DST;
+			break;
+		case TCP_V4_FLOW:
 		case TCP_V6_FLOW:
-				info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			/* fall through */
+			data = (RXH_L4_B_0_1 | RXH_L4_B_2_3 |
+				RXH_IP_SRC | RXH_IP_DST);
+			break;
+		case SCTP_V4_FLOW:
 		case SCTP_V6_FLOW:
+		case AH_ESP_V4_FLOW:
 		case AH_ESP_V6_FLOW:
+		case IPV4_FLOW:
 		case IPV6_FLOW:
-			info->data |= RXH_IP_SRC | RXH_IP_DST;
+			data = RXH_IP_SRC | RXH_IP_DST;
 			break;
 		default:
 			break;
 		}
+out_setdata_unlock:
+		info->data = data;
 out_unlock:
 		mutex_unlock(&efx->rss_lock);
 		return rc;


