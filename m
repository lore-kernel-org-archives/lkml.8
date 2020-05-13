Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5985BC2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECCF20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363172;
	bh=Ka+uZXP3Qmj4SZKPSdSkxAFBLLh7Eg88+5ji6OJMt34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fBVXr1bo8a0Ih4KKQ3ygPtRrZJv9CBS5chha2nKPlmiU/HrHqc351ySF67ypMb5FF
	 cIbSahCo6ymslAEkLhoaei6OLoXDjl4XM77ZKik6A1tfFrV7X4KNBAuYgAi94dzOI4
	 zyeKZGuon0OdYUemHB1LtnJp2o8gec/2VBqXmlac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbgEMJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732569AbgEMJqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:46:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009D320740;
        Wed, 13 May 2020 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363166;
        bh=Ka+uZXP3Qmj4SZKPSdSkxAFBLLh7Eg88+5ji6OJMt34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBgDbLCG13btuux407rBr2UfYbB5dNE/4yIRP/LYVO34hixUHHla2scor4pz8gnVp
         GWEsex0LhCiU1iQyvL5wyhiOl7Y/WNFVy1RtbzbuCAhTAMYMxmCrhiaifiPrD1fg1F
         bohW0ce4EnvZF0SlSoYtwfr3ijZBlZ01SRPjmsDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 13/48] bnxt_en: Fix VLAN acceleration handling in bnxt_fix_features().
Date:   Wed, 13 May 2020 11:44:39 +0200
Message-Id: <20200513094354.851162960@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
References: <20200513094351.100352960@linuxfoundation.org>
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
@@ -7562,6 +7562,7 @@ static netdev_features_t bnxt_fix_featur
 					   netdev_features_t features)
 {
 	struct bnxt *bp = netdev_priv(dev);
+	netdev_features_t vlan_features;
 
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp))
 		features &= ~NETIF_F_NTUPLE;
@@ -7578,12 +7579,14 @@ static netdev_features_t bnxt_fix_featur
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


