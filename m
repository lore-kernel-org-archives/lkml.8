Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF591C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20D520870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942931;
	bh=MVj9UZhM0DjTLdw9ouaGd2g02wNy/NokxdpMwsfgbjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UaQPFuWuuz/poUwf8/cAkdhnhPB/bUiCRS7318tE3qnL1v1jYVIYJmIfQRncLAPhG
	 OyQZ5TK9j7cy50x2k/s7t81pEIQVAH+4fRtnAmfp602VnebbcTrZkFVxuf477HHaYN
	 B0zuVYMC7fotkrunsS33fJ2sV4G/EBStPXdJr6wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgEHNCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgEHMvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:51:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E344E24969;
        Fri,  8 May 2020 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942272;
        bh=MVj9UZhM0DjTLdw9ouaGd2g02wNy/NokxdpMwsfgbjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEfC66F+62BTOi1LSOOxxDas6r25RxISPnW7KYTnitkqFxCzR2Fq1avSHcvESxVng
         SW9NRvnq2znAIGpntsdGZOdtNrpq058XR/b7NHC24JnvOLU7adcAEYXtLhBc9f2XAf
         5PaWRjMkNqkvauB42fT1Iw9wYAeoSLSt6lTSoSEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Beraud <julien.beraud@orolia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 12/32] net: stmmac: fix enabling socfpgas ptp_ref_clock
Date:   Fri,  8 May 2020 14:35:25 +0200
Message-Id: <20200508123036.422506887@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123034.886699170@linuxfoundation.org>
References: <20200508123034.886699170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Beraud <julien.beraud@orolia.com>

[ Upstream commit 15ce30609d1e88d42fb1cd948f453e6d5f188249 ]

There are 2 registers to write to enable a ptp ref clock coming from the
fpga.
One that enables the usage of the clock from the fpga for emac0 and emac1
as a ptp ref clock, and the other to allow signals from the fpga to reach
emac0 and emac1.
Currently, if the dwmac-socfpga has phymode set to PHY_INTERFACE_MODE_MII,
PHY_INTERFACE_MODE_GMII, or PHY_INTERFACE_MODE_SGMII, both registers will
be written and the ptp ref clock will be set as coming from the fpga.
Separate the 2 register writes to only enable signals from the fpga to
reach emac0 or emac1 when ptp ref clock is not coming from the fpga.

Signed-off-by: Julien Beraud <julien.beraud@orolia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 5b3b06a0a3bf5..33407df6bea69 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -274,16 +274,19 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 	    phymode == PHY_INTERFACE_MODE_MII ||
 	    phymode == PHY_INTERFACE_MODE_GMII ||
 	    phymode == PHY_INTERFACE_MODE_SGMII) {
-		ctrl |= SYSMGR_EMACGRP_CTRL_PTP_REF_CLK_MASK << (reg_shift / 2);
 		regmap_read(sys_mgr_base_addr, SYSMGR_FPGAGRP_MODULE_REG,
 			    &module);
 		module |= (SYSMGR_FPGAGRP_MODULE_EMAC << (reg_shift / 2));
 		regmap_write(sys_mgr_base_addr, SYSMGR_FPGAGRP_MODULE_REG,
 			     module);
-	} else {
-		ctrl &= ~(SYSMGR_EMACGRP_CTRL_PTP_REF_CLK_MASK << (reg_shift / 2));
 	}
 
+	if (dwmac->f2h_ptp_ref_clk)
+		ctrl |= SYSMGR_EMACGRP_CTRL_PTP_REF_CLK_MASK << (reg_shift / 2);
+	else
+		ctrl &= ~(SYSMGR_EMACGRP_CTRL_PTP_REF_CLK_MASK <<
+			  (reg_shift / 2));
+
 	regmap_write(sys_mgr_base_addr, reg_offset, ctrl);
 
 	/* Deassert reset for the phy configuration to be sampled by
-- 
2.20.1



