Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879CC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BDC20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586954303;
	bh=bVX46KhkbkCHDIA/scQ1dBlN5PmtSFZfWNNUIRuWydQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KukleF3dFD0UjzEQy/pygOLBPUMH08mL9FZt1AjKXc/nA0sO4rXpzhDhwPxCcbri0
	 os949r/XGwvTm6K77j+k9IItUx0ctalpSTa1Y4QaXiEUQbwE5yYAbSpl4+2mlsWexX
	 iiKflNUH2CH8jw1SrQkb/t2s96IpzLdrNhXPTCgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369923AbgDOMiS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897561AbgDOLoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:44:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DFE72137B;
        Wed, 15 Apr 2020 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951042;
        bh=bVX46KhkbkCHDIA/scQ1dBlN5PmtSFZfWNNUIRuWydQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/2NSaTlzsrvJl4x7uRVzU26yE5OB6YyUPBUNjU5CW0Lnw2zEFt67RdAkV4+YQOy2
         gWh4V9U45fBowBzI25LcuCWEt2h1VLwVhnABg7gXSzYw1HrAR8skcpL78WPJFogBFl
         xGAEX6v32mf+Zm6s+LFAmeIZc1ajR/5OEWfkmPII=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 078/106] net: stmmac: xgmac: Fix VLAN register handling
Date:   Wed, 15 Apr 2020 07:41:58 -0400
Message-Id: <20200415114226.13103-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 21f64e72e7073199a6f8d7d8efe52cd814d7d665 ]

Commit 907a076881f1, forgot that we need to clear old values of
XGMAC_VLAN_TAG register when we switch from VLAN perfect matching to
HASH matching.

Fix it.

Fixes: 907a076881f1 ("net: stmmac: xgmac: fix incorrect XGMAC_VLAN_TAG register writting")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index e9bf54a579df6..f0b9c43f6e31e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -576,8 +576,13 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 			value |= XGMAC_VLAN_EDVLP;
 			value |= XGMAC_VLAN_ESVL;
 			value |= XGMAC_VLAN_DOVLTC;
+		} else {
+			value &= ~XGMAC_VLAN_EDVLP;
+			value &= ~XGMAC_VLAN_ESVL;
+			value &= ~XGMAC_VLAN_DOVLTC;
 		}
 
+		value &= ~XGMAC_VLAN_VID;
 		writel(value, ioaddr + XGMAC_VLAN_TAG);
 	} else if (perfect_match) {
 		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
@@ -588,13 +593,19 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		value = readl(ioaddr + XGMAC_VLAN_TAG);
 
+		value &= ~XGMAC_VLAN_VTHM;
 		value |= XGMAC_VLAN_ETV;
 		if (is_double) {
 			value |= XGMAC_VLAN_EDVLP;
 			value |= XGMAC_VLAN_ESVL;
 			value |= XGMAC_VLAN_DOVLTC;
+		} else {
+			value &= ~XGMAC_VLAN_EDVLP;
+			value &= ~XGMAC_VLAN_ESVL;
+			value &= ~XGMAC_VLAN_DOVLTC;
 		}
 
+		value &= ~XGMAC_VLAN_VID;
 		writel(value | perfect_match, ioaddr + XGMAC_VLAN_TAG);
 	} else {
 		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
-- 
2.20.1

