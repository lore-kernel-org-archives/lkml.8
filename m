Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD3224681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221086;
	bh=znnOsdGetlEllZIX25wHMUIdX9foOB5SC+8CsdfWSUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TkCQCzoamCcZ6gBx+1MRfoQ/z4EAZnXtyE+bBRj493blnyFC0D9IxN0Q8g2JkLjxP
	 kW3IEBZTT0iu6vu+hbNMN7w7blJWEPMv2TKseQOV96rxQ2MOagJfkLdezZV6mAAUVt
	 /ZfvI6O4cayAVUOz5kgVC15e6MWr+5ZTUlxiaJu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgA1OSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbgA1OR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:17:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100062071E;
        Tue, 28 Jan 2020 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221079;
        bh=znnOsdGetlEllZIX25wHMUIdX9foOB5SC+8CsdfWSUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSx2t2WHgYSguPKR2vmee6BZf7dB+sAzuoLpOAJ0Q7wfQrmDlHukfhNs21reLTDEe
         cx/rs8JshmSlHCAu+hP/1Zdly4R9Pzs936R2WZDVkrOpw/6GyNNeCJ02vPgu3Zvh88
         Ag8vYolHsgnsj57TKulNGjOgMt/1gyGjeYJ39tds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 081/271] net: dsa: qca8k: Enable delay for RGMII_ID mode
Date:   Tue, 28 Jan 2020 15:03:50 +0100
Message-Id: <20200128135858.584187520@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit a968b5e9d5879f9535d6099505f9e14abcafb623 ]

RGMII_ID specifies that we should have internal delay, so resurrect the
delay addition routine but under the RGMII_ID mode.

Fixes: 40269aa9f40a ("net: dsa: qca8k: disable delay for RGMII mode")
Tested-by: Michal Vokáč <michal.vokac@ysoft.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/qca8k.c | 12 ++++++++++++
 drivers/net/dsa/qca8k.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index ebfbaf8597f40..3bbe85aae49bb 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -460,6 +460,18 @@ qca8k_set_pad_ctrl(struct qca8k_priv *priv, int port, int mode)
 		qca8k_write(priv, QCA8K_REG_PORT5_PAD_CTRL,
 			    QCA8K_PORT_PAD_RGMII_RX_DELAY_EN);
 		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		/* RGMII_ID needs internal delay. This is enabled through
+		 * PORT5_PAD_CTRL for all ports, rather than individual port
+		 * registers
+		 */
+		qca8k_write(priv, reg,
+			    QCA8K_PORT_PAD_RGMII_EN |
+			    QCA8K_PORT_PAD_RGMII_TX_DELAY(QCA8K_MAX_DELAY) |
+			    QCA8K_PORT_PAD_RGMII_RX_DELAY(QCA8K_MAX_DELAY));
+		qca8k_write(priv, QCA8K_REG_PORT5_PAD_CTRL,
+			    QCA8K_PORT_PAD_RGMII_RX_DELAY_EN);
+		break;
 	case PHY_INTERFACE_MODE_SGMII:
 		qca8k_write(priv, reg, QCA8K_PORT_PAD_SGMII_EN);
 		break;
diff --git a/drivers/net/dsa/qca8k.h b/drivers/net/dsa/qca8k.h
index 9c22bc3210cdf..db95168ca111d 100644
--- a/drivers/net/dsa/qca8k.h
+++ b/drivers/net/dsa/qca8k.h
@@ -40,6 +40,7 @@
 						((0x8 + (x & 0x3)) << 22)
 #define   QCA8K_PORT_PAD_RGMII_RX_DELAY(x)		\
 						((0x10 + (x & 0x3)) << 20)
+#define   QCA8K_MAX_DELAY				3
 #define   QCA8K_PORT_PAD_RGMII_RX_DELAY_EN		BIT(24)
 #define   QCA8K_PORT_PAD_SGMII_EN			BIT(7)
 #define QCA8K_REG_MODULE_EN				0x030
-- 
2.20.1



