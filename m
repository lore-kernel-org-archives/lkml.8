Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B839C433F2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A392070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgGZLj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:39:56 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:32827
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgGZLjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:39:52 -0400
X-IronPort-AV: E=Sophos;i="5.75,398,1589234400"; 
   d="scan'208";a="355309544"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 26 Jul 2020 13:39:47 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Solarflare linux maintainers <linux-net-drivers@solarflare.com>
Cc:     kernel-janitors@vger.kernel.org,
        Edward Cree <ecree@solarflare.com>,
        Martin Habets <mhabets@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] sfc: drop unnecessary list_empty
Date:   Sun, 26 Jul 2020 12:58:27 +0200
Message-Id: <1595761112-11003-3-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1595761112-11003-1-git-send-email-Julia.Lawall@inria.fr>
References: <1595761112-11003-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_safe is able to handle an empty list.
The only effect of avoiding the loop is not initializing the
index variable.
Drop list_empty tests in cases where these variables are not
used.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@
expression x,e;
iterator name list_for_each_safe;
statement S;
identifier i,j;
@@

-if (!(list_empty(x))) {
   list_for_each_safe(i,j,x) S
- }
 ... when != i
     when != j
(
  i = e;
|
? j = e;
)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/net/ethernet/sfc/ptp.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 393b7cb..bea4725 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -1154,17 +1154,15 @@ static void efx_ptp_drop_time_expired_events(struct efx_nic *efx)
 
 	/* Drop time-expired events */
 	spin_lock_bh(&ptp->evt_lock);
-	if (!list_empty(&ptp->evt_list)) {
-		list_for_each_safe(cursor, next, &ptp->evt_list) {
-			struct efx_ptp_event_rx *evt;
-
-			evt = list_entry(cursor, struct efx_ptp_event_rx,
-					 link);
-			if (time_after(jiffies, evt->expiry)) {
-				list_move(&evt->link, &ptp->evt_free_list);
-				netif_warn(efx, hw, efx->net_dev,
-					   "PTP rx event dropped\n");
-			}
+	list_for_each_safe(cursor, next, &ptp->evt_list) {
+		struct efx_ptp_event_rx *evt;
+
+		evt = list_entry(cursor, struct efx_ptp_event_rx,
+				 link);
+		if (time_after(jiffies, evt->expiry)) {
+			list_move(&evt->link, &ptp->evt_free_list);
+			netif_warn(efx, hw, efx->net_dev,
+				   "PTP rx event dropped\n");
 		}
 	}
 	spin_unlock_bh(&ptp->evt_lock);

