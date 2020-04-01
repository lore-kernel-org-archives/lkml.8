Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D95FC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6387F214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758226;
	bh=PFJ61hZlXewm98PbidinrVr4O2dRVdQs+bRrFd1QcbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XyJry2xIJ9N5mpnA2ZZeG48zSWsziCC4u4PLBJ8qyIFaLoT6jTjSmbLR8WbfeuA+u
	 YqRwKDXMyN2srWWA0JohltA896PzEc8ciIHy666HJzrQN8/XfhW1udEZTN7fmAraso
	 LKHS9KTaiGxNP/+TpJh3+a95u7VvFeIMQ+WCi1Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbgDAQXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733291AbgDAQXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:23:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D49215A4;
        Wed,  1 Apr 2020 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758219;
        bh=PFJ61hZlXewm98PbidinrVr4O2dRVdQs+bRrFd1QcbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmPNLuLoMoWbTxfhou54UMKRWF6pdKJUGOEu+lbKKzJvfpVNRY9XEIOxshXXmYt38
         gaiN2MV4xSrYJiuWXQOd3YTkIsvvmECxOr5ny4GMyK/av0hZ00//5U2Lv+Q9kRnY08
         EVdZeVr85TbnEqqryVgPn1gBfdCNjB3yq7lMHhHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edwin Peer <edwin.peer@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 021/116] bnxt_en: fix memory leaks in bnxt_dcbnl_ieee_getets()
Date:   Wed,  1 Apr 2020 18:16:37 +0200
Message-Id: <20200401161544.905874112@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edwin Peer <edwin.peer@broadcom.com>

[ Upstream commit 62d4073e86e62e316bea2c53e77db10418fd5dd7 ]

The allocated ieee_ets structure goes out of scope without being freed,
leaking memory. Appropriate result codes should be returned so that
callers do not rely on invalid data passed by reference.

Also cache the ETS config retrieved from the device so that it doesn't
need to be freed. The balance of the code was clearly written with the
intent of having the results of querying the hardware cached in the
device structure. The commensurate store was evidently missed though.

Fixes: 7df4ae9fe855 ("bnxt_en: Implement DCBNL to support host-based DCBX.")
Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -479,24 +479,26 @@ static int bnxt_dcbnl_ieee_getets(struct
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct ieee_ets *my_ets = bp->ieee_ets;
+	int rc;
 
 	ets->ets_cap = bp->max_tc;
 
 	if (!my_ets) {
-		int rc;
-
 		if (bp->dcbx_cap & DCB_CAP_DCBX_HOST)
 			return 0;
 
 		my_ets = kzalloc(sizeof(*my_ets), GFP_KERNEL);
 		if (!my_ets)
-			return 0;
+			return -ENOMEM;
 		rc = bnxt_hwrm_queue_cos2bw_qcfg(bp, my_ets);
 		if (rc)
-			return 0;
+			goto error;
 		rc = bnxt_hwrm_queue_pri2cos_qcfg(bp, my_ets);
 		if (rc)
-			return 0;
+			goto error;
+
+		/* cache result */
+		bp->ieee_ets = my_ets;
 	}
 
 	ets->cbs = my_ets->cbs;
@@ -505,6 +507,9 @@ static int bnxt_dcbnl_ieee_getets(struct
 	memcpy(ets->tc_tsa, my_ets->tc_tsa, sizeof(ets->tc_tsa));
 	memcpy(ets->prio_tc, my_ets->prio_tc, sizeof(ets->prio_tc));
 	return 0;
+error:
+	kfree(my_ets);
+	return rc;
 }
 
 static int bnxt_dcbnl_ieee_setets(struct net_device *dev, struct ieee_ets *ets)


