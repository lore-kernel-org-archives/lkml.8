Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D1FC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C8922BEB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752845;
	bh=KWQ4e3p+UIInG0QsWaTKjw4uJUmUUZQzFdKT60LPMKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAJQeLzjRx+6kME71nNsNK8zEtNgVSRsB0wpDhDOioyUQdLEKDb31U1Xr6zZLC5db
	 zLSsu1JuTXgLqfoqiAJBTQ3+AR8BV6pvfmkJ0wwpM/3Xku/D7HD27rws4KFuSEYy2n
	 aC/WKKBMPR4ekEuDfjZPa5zTyV+5Eu/RGRv+7XuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgGNSyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730715AbgGNSyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40D6822BEB;
        Tue, 14 Jul 2020 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752841;
        bh=KWQ4e3p+UIInG0QsWaTKjw4uJUmUUZQzFdKT60LPMKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCEc3+nZP0o/yuVxyVfrIziPnO28Q85Rj3JD+Ayr8Czi3p7BdmELwYi91h9D4aJrV
         /0CHOgix18O52iTCijy5Qb3sQ8FD7mB44gbXM9OUTc3F6Ez/fDQXEypJW/mx0/8vzp
         p+hQcQkB1bpxHYg/UJ5+GTsvz/56XEL7QIL3C7a0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 021/166] net: ethernet: mvneta: Add 2500BaseX support for SoCs without comphy
Date:   Tue, 14 Jul 2020 20:43:06 +0200
Message-Id: <20200714184116.903912669@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 401eeeca89660..af578a5813bd2 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -110,6 +110,7 @@
 #define MVNETA_SERDES_CFG			 0x24A0
 #define      MVNETA_SGMII_SERDES_PROTO		 0x0cc7
 #define      MVNETA_QSGMII_SERDES_PROTO		 0x0667
+#define      MVNETA_HSGMII_SERDES_PROTO		 0x1107
 #define MVNETA_TYPE_PRIO                         0x24bc
 #define      MVNETA_FORCE_UNI                    BIT(21)
 #define MVNETA_TXQ_CMD_1                         0x24e4
@@ -3558,6 +3559,11 @@ static int mvneta_config_interface(struct mvneta_port *pp,
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



