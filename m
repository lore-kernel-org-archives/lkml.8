Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B2FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292AE20661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338550;
	bh=pHb1R8s6RmlJR4xQ1P+qJ8eh6RNXlQUf8Ym9UcRfsjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8biXiLt2YP9VJl3h+j1uBlbiO+0wAR9lsEzWPbsowZ2LABIr7fyWRG6slwcZCxDj
	 msOBp7434MMqbqUAaIyq4GUHwQGe6VYEI9ucj+MLv0b1ykEyipTAtrbR2O0tUxvUJU
	 LRIvyxvWKYQK3I0z0KjX88J04zzAdbh7X3zxshng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgBJMm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbgBJMjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:21 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA1832051A;
        Mon, 10 Feb 2020 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338360;
        bh=pHb1R8s6RmlJR4xQ1P+qJ8eh6RNXlQUf8Ym9UcRfsjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fG3E9Y+/9U3J0aqdXcTKnhidXfofC+SpvrO47arsjnlOz3/v8H6r4EpUkY325ZP59
         3NyN3j5ypTELU2ZLGj3vwK/00aydVHvJQeEb8Dst5NSwuszVqHAW2olSbgpToAgGiT
         11g0bbmpHQfZW3gy/fOe1x0pRF3BSOYpUF48Ptdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.5 021/367] net: phy: at803x: disable vddio regulator
Date:   Mon, 10 Feb 2020 04:28:54 -0800
Message-Id: <20200210122425.829178136@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

[ Upstream commit 2318ca8aef3877da2b16b92edce47a497370a86e ]

The probe() might enable a VDDIO regulator, which needs to be disabled
again before calling regulator_put(). Add a remove() function.

Fixes: 2f664823a470 ("net: phy: at803x: add device tree binding")
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/at803x.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -489,6 +489,14 @@ static int at803x_probe(struct phy_devic
 	return at803x_parse_dt(phydev);
 }
 
+static void at803x_remove(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+
+	if (priv->vddio)
+		regulator_disable(priv->vddio);
+}
+
 static int at803x_clk_out_config(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
@@ -711,6 +719,7 @@ static struct phy_driver at803x_driver[]
 	.name			= "Qualcomm Atheros AR8035",
 	.phy_id_mask		= AT803X_PHY_ID_MASK,
 	.probe			= at803x_probe,
+	.remove			= at803x_remove,
 	.config_init		= at803x_config_init,
 	.set_wol		= at803x_set_wol,
 	.get_wol		= at803x_get_wol,
@@ -726,6 +735,7 @@ static struct phy_driver at803x_driver[]
 	.name			= "Qualcomm Atheros AR8030",
 	.phy_id_mask		= AT803X_PHY_ID_MASK,
 	.probe			= at803x_probe,
+	.remove			= at803x_remove,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
 	.set_wol		= at803x_set_wol,
@@ -741,6 +751,7 @@ static struct phy_driver at803x_driver[]
 	.name			= "Qualcomm Atheros AR8031/AR8033",
 	.phy_id_mask		= AT803X_PHY_ID_MASK,
 	.probe			= at803x_probe,
+	.remove			= at803x_remove,
 	.config_init		= at803x_config_init,
 	.set_wol		= at803x_set_wol,
 	.get_wol		= at803x_get_wol,


