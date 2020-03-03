Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D02C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0A24681
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203615;
	bh=9OVU4EcFsqQ+iHpyAQWUwLGV9HqFZaUnOOiiQ9LL61s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q0gz66+cXLo9bTO9y3aJqlfvpwKZcB7iWRZ8UtAbP+GPdJ8u8EwDZeJV2DB/OogHV
	 fEiObXUrR666SLg+Z64Fnfp96RdIdSYhsSVTwAKRumySMyfY1dunenT5WoUHr+J8ER
	 TsMBzSvKQdqK3Hxw08IQ6ZryHv5CZzut7BpcQH8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgCCCqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbgCCCqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:46:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123952468E;
        Tue,  3 Mar 2020 02:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203606;
        bh=9OVU4EcFsqQ+iHpyAQWUwLGV9HqFZaUnOOiiQ9LL61s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TH7XQA8GVK4z4ZgCSurDYHP6OPIYTAPvCKY/aIOJHZHJMty8q/1Zv6VK2MAwg0ANB
         MLFKxcNVbRPr6Kx7SZzvS7YMNb6Xp7kEFynWdxomyJrHeoAe0gXszqxmutWftMJcow
         u/Z7oUOMiClmUZs+HE5DMHbDEuwZz9i7Am7U/Wjw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nikita Danilov <ndanilov@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Dmitry Bogdanov <dbogdanov@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 25/66] net: atlantic: better loopback mode handling
Date:   Mon,  2 Mar 2020 21:45:34 -0500
Message-Id: <20200303024615.8889-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Danilov <ndanilov@marvell.com>

[ Upstream commit b42726fcf76e9367e524392e0ead7e672cc0791c ]

Add checks to not enable multiple loopback modes simultaneously,
It was also discovered that for dma loopback to function correctly
promisc mode should be enabled on device.

Fixes: ea4b4d7fc106 ("net: atlantic: loopback tests via private flags")
Signed-off-by: Nikita Danilov <ndanilov@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c |  5 +++++
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c   | 13 ++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index a1f99bef4a683..7b55633d2cb93 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -722,6 +722,11 @@ static int aq_ethtool_set_priv_flags(struct net_device *ndev, u32 flags)
 	if (flags & ~AQ_PRIV_FLAGS_MASK)
 		return -EOPNOTSUPP;
 
+	if (hweight32((flags | priv_flags) & AQ_HW_LOOPBACK_MASK) > 1) {
+		netdev_info(ndev, "Can't enable more than one loopback simultaneously\n");
+		return -EINVAL;
+	}
+
 	cfg->priv_flags = flags;
 
 	if ((priv_flags ^ flags) & BIT(AQ_HW_LOOPBACK_DMA_NET)) {
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 9acdb3fbb750d..d20d91cdece86 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -885,13 +885,16 @@ static int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
 {
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
 	unsigned int i = 0U;
+	u32 vlan_promisc;
+	u32 l2_promisc;
 
-	hw_atl_rpfl2promiscuous_mode_en_set(self,
-					    IS_FILTER_ENABLED(IFF_PROMISC));
+	l2_promisc = IS_FILTER_ENABLED(IFF_PROMISC) ||
+		     !!(cfg->priv_flags & BIT(AQ_HW_LOOPBACK_DMA_NET));
+	vlan_promisc = l2_promisc || cfg->is_vlan_force_promisc;
 
-	hw_atl_rpf_vlan_prom_mode_en_set(self,
-				     IS_FILTER_ENABLED(IFF_PROMISC) ||
-				     cfg->is_vlan_force_promisc);
+	hw_atl_rpfl2promiscuous_mode_en_set(self, l2_promisc);
+
+	hw_atl_rpf_vlan_prom_mode_en_set(self, vlan_promisc);
 
 	hw_atl_rpfl2multicast_flr_en_set(self,
 					 IS_FILTER_ENABLED(IFF_ALLMULTI) &&
-- 
2.20.1

