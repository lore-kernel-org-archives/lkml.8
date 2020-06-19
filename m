Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7EBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E3B21707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583724;
	bh=LdNzVHSOMoY3VrTfF8wSlN0qzmWL8FJ+lC8X3l9ZdLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dk+JXSaENe0A9kWf8wEyxbOw7IYNt0SIQ3lD0hQdgYpVjrefNwS0x7mYrD6xeVPpb
	 Lh2rPWx74uZpWuUlSpibP+Gbte8oPqYfXmNlerygEKScgvwXwRXuaCtBWBTDAhb0k0
	 QFBiX+txVKfHPpZsIZqPud/isNAko8zvT+LIqc+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbgFSQWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390637AbgFSPAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:00:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F07A21548;
        Fri, 19 Jun 2020 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578829;
        bh=LdNzVHSOMoY3VrTfF8wSlN0qzmWL8FJ+lC8X3l9ZdLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh49CqwPRJftUteiLuIrro6fDfXRjb5WFCSV8f17HiNVfH7jJjoBVperPhWPgxvax
         X2vF96JbxckGQg7+RhIVox7EhYe2LysSFWCyx3Mx/ljgxJpLOiF7ENNwIbMFFJmu2q
         yIdhegb3QyD2rFhQccLOVyhKL2bw3mE/OCrwrAL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 172/267] net: ethernet: fec: move GPR register offset and bit into DT
Date:   Fri, 19 Jun 2020 16:32:37 +0200
Message-Id: <20200619141657.046148582@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

[ Upstream commit 8a448bf832af537d26aa557d183a16943dce4510 ]

The commit da722186f654 (net: fec: set GPR bit on suspend by DT
configuration) set the GPR reigster offset and bit in driver for
wake on lan feature.

But it introduces two issues here:
- one SOC has two instances, they have different bit
- different SOCs may have different offset and bit

So to support wake-on-lan feature on other i.MX platforms, it should
configure the GPR reigster offset and bit from DT.

So the patch is to improve the commit da722186f654 (net: fec: set GPR
bit on suspend by DT configuration) to support multiple ethernet
instances on i.MX series.

v2:
 * switch back to store the quirks bitmask in driver_data
v3:
 * suggested by Sascha Hauer, use a struct fec_devinfo for
   abstracting differences between different hardware variants,
   it can give more freedom to describe the differences.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 48c58f93b124..6702bc2dd92f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -88,8 +88,6 @@ static void fec_enet_itr_coal_init(struct net_device *ndev);
 
 struct fec_devinfo {
 	u32 quirks;
-	u8 stop_gpr_reg;
-	u8 stop_gpr_bit;
 };
 
 static const struct fec_devinfo fec_imx25_info = {
@@ -112,8 +110,6 @@ static const struct fec_devinfo fec_imx6q_info = {
 		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR006358 |
 		  FEC_QUIRK_HAS_RACC,
-	.stop_gpr_reg = 0x34,
-	.stop_gpr_bit = 27,
 };
 
 static const struct fec_devinfo fec_mvf600_info = {
@@ -3401,19 +3397,23 @@ static int fec_enet_get_irq_cnt(struct platform_device *pdev)
 }
 
 static int fec_enet_init_stop_mode(struct fec_enet_private *fep,
-				   struct fec_devinfo *dev_info,
 				   struct device_node *np)
 {
 	struct device_node *gpr_np;
+	u32 out_val[3];
 	int ret = 0;
 
-	if (!dev_info)
-		return 0;
-
-	gpr_np = of_parse_phandle(np, "gpr", 0);
+	gpr_np = of_parse_phandle(np, "fsl,stop-mode", 0);
 	if (!gpr_np)
 		return 0;
 
+	ret = of_property_read_u32_array(np, "fsl,stop-mode", out_val,
+					 ARRAY_SIZE(out_val));
+	if (ret) {
+		dev_dbg(&fep->pdev->dev, "no stop mode property\n");
+		return ret;
+	}
+
 	fep->stop_gpr.gpr = syscon_node_to_regmap(gpr_np);
 	if (IS_ERR(fep->stop_gpr.gpr)) {
 		dev_err(&fep->pdev->dev, "could not find gpr regmap\n");
@@ -3422,8 +3422,8 @@ static int fec_enet_init_stop_mode(struct fec_enet_private *fep,
 		goto out;
 	}
 
-	fep->stop_gpr.reg = dev_info->stop_gpr_reg;
-	fep->stop_gpr.bit = dev_info->stop_gpr_bit;
+	fep->stop_gpr.reg = out_val[1];
+	fep->stop_gpr.bit = out_val[2];
 
 out:
 	of_node_put(gpr_np);
@@ -3501,7 +3501,7 @@ fec_probe(struct platform_device *pdev)
 	if (of_get_property(np, "fsl,magic-packet", NULL))
 		fep->wol_flag |= FEC_WOL_HAS_MAGIC_PACKET;
 
-	ret = fec_enet_init_stop_mode(fep, dev_info, np);
+	ret = fec_enet_init_stop_mode(fep, np);
 	if (ret)
 		goto failed_stop_mode;
 
-- 
2.25.1



