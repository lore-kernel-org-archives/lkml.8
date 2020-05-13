Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255DCCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90FF20753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363598;
	bh=3xG9TPjkLb2LpCYLww4vtZNrSlVKi1DeIqN36zfxsWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DscVrLzEDTbZnbkMthCGCdYgX8BpqyeLUXFbjvMJZIraFGTMqcHSCg5Aotx2WpJys
	 9w6xbgrcmCwQJuznK1DTOurSAHIasaB6IuDSefpwRIFAywu6sFY/HxN2t2X1PxwFMu
	 9AMwFEzVqbKt5Kukwzs1U5b886R58qM7BOpDN/mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgEMJxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733311AbgEMJxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:53:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236A423127;
        Wed, 13 May 2020 09:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363589;
        bh=3xG9TPjkLb2LpCYLww4vtZNrSlVKi1DeIqN36zfxsWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2upPZgJZFpeGRQMA8wWB6Gdh9kaf+F6NTx0Yn9WK1XC7SL+b7fBJJm2CW/wASjSfT
         PO9q5p57668O+8G85HSiy9bLT6BWjIuQ+VsyeeYHY45+gkCsrj7VtSYH8/n6tgJ8Ml
         4LZNMkzHU5M5326GcEOjA0FFl9aXabi19GZ/Ug2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 045/118] bnxt_en: Fix VLAN acceleration handling in bnxt_fix_features().
Date:   Wed, 13 May 2020 11:44:24 +0200
Message-Id: <20200513094421.215548764@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9794,6 +9794,7 @@ static netdev_features_t bnxt_fix_featur
 					   netdev_features_t features)
 {
 	struct bnxt *bp = netdev_priv(dev);
+	netdev_features_t vlan_features;
 
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp))
 		features &= ~NETIF_F_NTUPLE;
@@ -9810,12 +9811,14 @@ static netdev_features_t bnxt_fix_featur
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


