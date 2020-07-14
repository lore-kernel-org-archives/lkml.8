Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82094C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FEF22BEF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752905;
	bh=JEMYg5gbmSFLxknIdptGKQdGbkRZKg4d8AowczU99ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/v4ygIzO84mHSh07uEXFkdaA5SRwoB5+qhNHDCmJXjj49eAOxvKIxohtd4RdhmBP
	 sMeySd+QK5loWN/zkKpk8a7ir05ll5xDqO0oZeUSI/LstMEmAWDxdFOELJ91hEsaXF
	 Wx3u0p2pLo3HGWo2+o41p14ShujvX9QOsm7Y5pvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgGNSzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730814AbgGNSy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0102922B47;
        Tue, 14 Jul 2020 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752898;
        bh=JEMYg5gbmSFLxknIdptGKQdGbkRZKg4d8AowczU99ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxR8FRmB0gOmv1HSLbC4YIYeswYe6Q3+wyt9nHxJekhy0KVFWxDt6uox1OTJQVmhL
         wgpDMzzgU5U/EC4jm90IxkJYKg95eRQGIMRoFDHKj+TaM86FUVT0n3zfKQ67NB1VLr
         cSikFnh+AuEZue/QrhgxgRWBBmEwXmWaL8rvD630=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dany Madden <drt@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 025/166] ibmvnic: continue to init in CRQ reset returns H_CLOSED
Date:   Tue, 14 Jul 2020 20:43:10 +0200
Message-Id: <20200714184117.089562706@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dany Madden <drt@linux.ibm.com>

[ Upstream commit 8b40eb73509f5704a0e8cd25de0163876299f1a7 ]

Continue the reset path when partner adapter is not ready or H_CLOSED is
returned from reset crq. This patch allows the CRQ init to proceed to
establish a valid CRQ for traffic to flow after reset.

Signed-off-by: Dany Madden <drt@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 2baf7b3ff4cbf..0fd7eae25fe9d 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1971,13 +1971,18 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 			release_sub_crqs(adapter, 1);
 		} else {
 			rc = ibmvnic_reset_crq(adapter);
-			if (!rc)
+			if (rc == H_CLOSED || rc == H_SUCCESS) {
 				rc = vio_enable_interrupts(adapter->vdev);
+				if (rc)
+					netdev_err(adapter->netdev,
+						   "Reset failed to enable interrupts. rc=%d\n",
+						   rc);
+			}
 		}
 
 		if (rc) {
 			netdev_err(adapter->netdev,
-				   "Couldn't initialize crq. rc=%d\n", rc);
+				   "Reset couldn't initialize crq. rc=%d\n", rc);
 			goto out;
 		}
 
-- 
2.25.1



