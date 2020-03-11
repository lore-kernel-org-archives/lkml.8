Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C95DC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DACE24649
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgCKFHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:07:51 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:44666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728349AbgCKFHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:07:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5379A1802E2C7;
        Wed, 11 Mar 2020 05:07:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: magic61_25e9dec9d9c62
X-Filterd-Recvd-Size: 2826
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:40 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 027/491] AMD XGBE DRIVER: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:41 -0700
Message-Id: <05794ab3463ec40162689e651e3b6c2245e27984.1583896349.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index b71f9b0..a51abf 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1612,7 +1612,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
 	/* PTP v2, UDP, any kind of event packet */
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		/* Fall through - to PTP v1, UDP, any kind of event packet */
+		fallthrough;	/* to PTP v1, UDP, any kind of event packet */
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
@@ -1623,7 +1623,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
 	/* PTP v2, UDP, Sync packet */
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		/* Fall through - to PTP v1, UDP, Sync packet */
+		fallthrough;	/* to PTP v1, UDP, Sync packet */
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
@@ -1634,7 +1634,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
 	/* PTP v2, UDP, Delay_req packet */
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		/* Fall through - to PTP v1, UDP, Delay_req packet */
+		fallthrough;	/* to PTP v1, UDP, Delay_req packet */
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
-- 
2.24.0

