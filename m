Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728EA20B80
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653160;
	bh=tdynT2JV7a0+gxRc6IFSgh5pZhbM6pNqj5JJ3tzCOCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f2Tav6m6kIh8U4YKWdfJ1hXNZpIAP9j8jVxPMTXhPYjR1GdiaOCbZE+SAAap9lmZf
	 Ricyz14Mrp6TA4tlUy3h7gtv2XqMk89g01TUYpqy6qvKonleP2tJyYgAZme87tr9t5
	 DSmKDSbBFH87l3jxVm/ktj7OahlX1L4LkFPkkbww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgGBBZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbgGBBZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:25:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B9120874;
        Thu,  2 Jul 2020 01:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653147;
        bh=tdynT2JV7a0+gxRc6IFSgh5pZhbM6pNqj5JJ3tzCOCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnsWHoGsgFWO0TBTM07Mp/aBytLz/KonrE105BQQVKhwMnOU1fDlL1WLXWEgNCeqw
         /jwzhmTzVbaDAfFtAQgN3tiDrVMM+j+mXCt7iWD68gKuiVMe4JtaVCoZdRfPzJ9aXW
         EqbeoEAejREj1Qw2DZMpsGRuaoAran1PpD3RaKDE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 18/40] net: ethernet: mvneta: Add 2500BaseX support for SoCs without comphy
Date:   Wed,  1 Jul 2020 21:23:39 -0400
Message-Id: <20200702012402.2701121-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012402.2701121-1-sashal@kernel.org>
References: <20200702012402.2701121-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit 1a642ca7f38992b086101fe204a1ae3c90ed8016 ]

The older SoCs like Armada XP support a 2500BaseX mode in the datasheets
referred to as DR-SGMII (Double rated SGMII) or HS-SGMII (High Speed
SGMII). This is an upclocked 1000BaseX mode, thus
PHY_INTERFACE_MODE_2500BASEX is the appropriate mode define for it.
adding support for it merely means writing the correct magic value into
the MVNETA_SERDES_CFG register.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index b0599b205b36e..9799253948281 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -108,6 +108,7 @@
 #define MVNETA_SERDES_CFG			 0x24A0
 #define      MVNETA_SGMII_SERDES_PROTO		 0x0cc7
 #define      MVNETA_QSGMII_SERDES_PROTO		 0x0667
+#define      MVNETA_HSGMII_SERDES_PROTO		 0x1107
 #define MVNETA_TYPE_PRIO                         0x24bc
 #define      MVNETA_FORCE_UNI                    BIT(21)
 #define MVNETA_TXQ_CMD_1                         0x24e4
@@ -3199,6 +3200,11 @@ static int mvneta_config_interface(struct mvneta_port *pp,
 			mvreg_write(pp, MVNETA_SERDES_CFG,
 				    MVNETA_SGMII_SERDES_PROTO);
 			break;
+
+		case PHY_INTERFACE_MODE_2500BASEX:
+			mvreg_write(pp, MVNETA_SERDES_CFG,
+				    MVNETA_HSGMII_SERDES_PROTO);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.25.1

