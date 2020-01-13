Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FDDC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1FB21569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DzjEKWVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAMI35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:57 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54356 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbgAMI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:56 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A08D440692;
        Mon, 13 Jan 2020 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578904196; bh=Ben06d7t9W2BvCud3kGg7X4OfXW/BtwnEBLz0+lX38c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DzjEKWVEjc5TkB7btFpWwzZuBnS1ivO72dE+YqSFRLVvBHEtr0Fl38WhJ3JG7CI6K
         q5+YN7cXCZ4lWYGQG+xLUr5ADris9bTV3hRxhfH1mGdukcbAq8T523SK5Two/gjtrv
         PAQ3sSKWWCisXTpjDGA6suVvlUOLi8poCa+ylk8jQS3962dyXQfVHMTAvsTzD4pt4O
         00LNYmEzUv1HunaNGUFK44Jx6A20MnMIyb/khCkIpFudg0cic/9Z8K6HLSxryJRL+p
         oFxHupN++nOfEs3wjN4i5K6L1n3b9zlmz9+OvaWxnYFiXfz3Mimz5Wc27GEEQKIeQT
         dvVatQdPNxD7A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 63D40A0077;
        Mon, 13 Jan 2020 08:29:54 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: stmmac: pci: Enable TBS on GMAC5 IPK PCI entry
Date:   Mon, 13 Jan 2020 09:29:39 +0100
Message-Id: <2ab70398e404244933f9feac1be0795aff871730.1578903874.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1578903874.git.Jose.Abreu@synopsys.com>
References: <cover.1578903874.git.Jose.Abreu@synopsys.com>
In-Reply-To: <cover.1578903874.git.Jose.Abreu@synopsys.com>
References: <cover.1578903874.git.Jose.Abreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable TBS support on GMAC5 PCI entry for all Queues except Queue 0.

Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 40f171d310d7..623521052152 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -401,6 +401,8 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 		plat->tx_queues_cfg[i].use_prio = false;
 		plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
 		plat->tx_queues_cfg[i].weight = 25;
+		if (i > 0)
+			plat->tx_queues_cfg[i].tbs_en = 1;
 	}
 
 	plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
-- 
2.7.4

