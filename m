Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC017C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6B620772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645953;
	bh=PFJ61hZlXewm98PbidinrVr4O2dRVdQs+bRrFd1QcbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bY7tkswwxHxpxaw9GP9DhghQcNuKLXncqyPtAYO6AHmsU0PEKsPuZSbGn2bd298nL
	 uWWYbthUEL7qenn4rG4ilaytTJp8N3QkDec9UO+2juxzcM5PS1ItBoFggcSMnUjm5B
	 y2AzYaVCR48/pjdrs8vPE+lzUixonYx7VfMoLZXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgCaJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731129AbgCaJM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:12:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266A4208FE;
        Tue, 31 Mar 2020 09:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645948;
        bh=PFJ61hZlXewm98PbidinrVr4O2dRVdQs+bRrFd1QcbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODjVxOFuiXpfkKNXJq/CbnYm7Egq3yJU2n83IEN/y2K4pW641kfN7gtmR97cyzVRz
         KlqZLPMmap5B1IVnA6ds+qJ/FdPx3dxS4tBeIauuSBiLR0DxPUO4LfKiDYE8kSMUDq
         X0OlZt5rcYalrEjiW/cVlKyY6Q+/40l25UbFd5j8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edwin Peer <edwin.peer@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 040/155] bnxt_en: fix memory leaks in bnxt_dcbnl_ieee_getets()
Date:   Tue, 31 Mar 2020 10:58:00 +0200
Message-Id: <20200331085422.897153000@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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


