Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E38C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EBF2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 08:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgBEIzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 03:55:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:48635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgBEIzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 03:55:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 00:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="264149194"
Received: from unknown (HELO bong5-HP-Z440.png.intel.com) ([10.221.118.166])
  by fmsmga002.fm.intel.com with ESMTP; 05 Feb 2020 00:55:39 -0800
From:   Ong Boon Leong <boon.leong.ong@intel.com>
To:     netdev@vger.kernel.org
Cc:     Tan Tee Min <tee.min.tan@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v4 3/6] net: stmmac: xgmac: fix incorrect XGMAC_VLAN_TAG register writting
Date:   Wed,  5 Feb 2020 16:55:07 +0800
Message-Id: <20200205085510.32353-4-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205085510.32353-1-boon.leong.ong@intel.com>
References: <20200205085510.32353-1-boon.leong.ong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should always do a read of current value of XGMAC_VLAN_TAG instead of
directly overwriting the register value.

Fixes: 3cd1cfcba26e2 ("net: stmmac: Implement VLAN Hash Filtering in XGMAC")
Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 2af3ac5409b7..a0e67d178280 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -569,7 +569,9 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		writel(value, ioaddr + XGMAC_PACKET_FILTER);
 
-		value = XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV;
+		value = readl(ioaddr + XGMAC_VLAN_TAG);
+
+		value |= XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV;
 		if (is_double) {
 			value |= XGMAC_VLAN_EDVLP;
 			value |= XGMAC_VLAN_ESVL;
@@ -584,7 +586,9 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		writel(value, ioaddr + XGMAC_PACKET_FILTER);
 
-		value = XGMAC_VLAN_ETV;
+		value = readl(ioaddr + XGMAC_VLAN_TAG);
+
+		value |= XGMAC_VLAN_ETV;
 		if (is_double) {
 			value |= XGMAC_VLAN_EDVLP;
 			value |= XGMAC_VLAN_ESVL;
-- 
2.17.1

