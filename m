Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD585C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB979207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482578;
	bh=HFAswY58QVMy+ZlOL6ETdXJNak7GLAW3Bl0hMPqHTPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hweZ26AwWgzLUWLZ2SYU4bjR0fHfacillc/41HHN6/JEHb2e1EMRChxnMhxXRLMzD
	 G64xQjbgwn9LoXjEnr7QNTNxw69w8WKe9OJHVFMWjbccdqqNFdWRRBvYqq6kVp97l8
	 JbNiP4yFdbd+MLVEKIYiKG7nO7LUR94mhtzFQpi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgENS4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgENS4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:56:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D96F20809;
        Thu, 14 May 2020 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482563;
        bh=HFAswY58QVMy+ZlOL6ETdXJNak7GLAW3Bl0hMPqHTPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sralPgH1Jz28iISEvuSCU+3Mgvg6j+1j8zWpERARBzPSu8m8cWkP7pXFuuA/9CT5V
         KYN5ITblw8X/NAaUX2qWH0A26h/HP5QgGlhQIe0KmqIfJLN0Fo3xw5hRJEpC3/0HA/
         QtXIaUEplkp1imSFtgZIj1DTQI8BKE/p23NPiOkI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 10/27] bnxt_en: Fix VLAN acceleration handling in bnxt_fix_features().
Date:   Thu, 14 May 2020 14:55:33 -0400
Message-Id: <20200514185550.21462-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185550.21462-1-sashal@kernel.org>
References: <20200514185550.21462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit c72cb303aa6c2ae7e4184f0081c6d11bf03fb96b ]

The current logic in bnxt_fix_features() will inadvertently turn on both
CTAG and STAG VLAN offload if the user tries to disable both.  Fix it
by checking that the user is trying to enable CTAG or STAG before
enabling both.  The logic is supposed to enable or disable both CTAG and
STAG together.

Fixes: 5a9f6b238e59 ("bnxt_en: Enable and disable RX CTAG and RX STAG VLAN acceleration together.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 736e550163e10..bbf382439a8b9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5997,6 +5997,7 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 					   netdev_features_t features)
 {
 	struct bnxt *bp = netdev_priv(dev);
+	netdev_features_t vlan_features;
 
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp))
 		features &= ~NETIF_F_NTUPLE;
@@ -6004,12 +6005,14 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	/* Both CTAG and STAG VLAN accelaration on the RX side have to be
 	 * turned on or off together.
 	 */
-	if ((features & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX)) !=
-	    (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX)) {
+	vlan_features = features & (NETIF_F_HW_VLAN_CTAG_RX |
+				    NETIF_F_HW_VLAN_STAG_RX);
+	if (vlan_features != (NETIF_F_HW_VLAN_CTAG_RX |
+			      NETIF_F_HW_VLAN_STAG_RX)) {
 		if (dev->features & NETIF_F_HW_VLAN_CTAG_RX)
 			features &= ~(NETIF_F_HW_VLAN_CTAG_RX |
 				      NETIF_F_HW_VLAN_STAG_RX);
-		else
+		else if (vlan_features)
 			features |= NETIF_F_HW_VLAN_CTAG_RX |
 				    NETIF_F_HW_VLAN_STAG_RX;
 	}
-- 
2.20.1

