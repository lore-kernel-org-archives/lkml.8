Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41439C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12DF2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599581914;
	bh=yVzu16jkR+ZSizyDraX6CgN0pG7oqdVsMdzwGZ9bSn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OSPcXiHVu1KkT2L147LWOzcTXYgKYxmJgbEdGFmDgkEsGOGl6ylIIvJee2EJnAxeH
	 NTPlp6uMQ7MpbvTTVWXCQL4jI3PY3/zHVna7pzSXLGJSWTRw9pNRxNB9qUhZdRJOYk
	 WiWLGp6hS09Mvxa6PFEeuGNPxsER/caQlMbNTPtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbgIHQSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731308AbgIHQIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:08:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33C623F5A;
        Tue,  8 Sep 2020 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580091;
        bh=yVzu16jkR+ZSizyDraX6CgN0pG7oqdVsMdzwGZ9bSn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GP+uUCeMj2WlYBLZIZasSF8/mrnrarFPM5FMiI93qIhOYa1skOIimp70yn8Gi+3Yg
         SJk4ir0k3PEkjoNa+2NTPPFeDJ3JnYd+QG10JSxdng3H+HEgFAn5tsO8b8QzSzV3m8
         6yw5ZjaG5Xcbf/BWlT7H7cv3fDNeJJYs2L6+lqAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 28/88] net: arc_emac: Fix memleak in arc_mdio_probe
Date:   Tue,  8 Sep 2020 17:25:29 +0200
Message-Id: <20200908152222.486034130@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit e2d79cd8875fa8c3cc7defa98a8cc99a1ed0c62f ]

When devm_gpiod_get_optional() fails, bus should be
freed just like when of_mdiobus_register() fails.

Fixes: 1bddd96cba03d ("net: arc_emac: support the phy reset for emac driver")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/arc/emac_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/arc/emac_mdio.c b/drivers/net/ethernet/arc/emac_mdio.c
index 0187dbf3b87df..54cdafdd067db 100644
--- a/drivers/net/ethernet/arc/emac_mdio.c
+++ b/drivers/net/ethernet/arc/emac_mdio.c
@@ -153,6 +153,7 @@ int arc_mdio_probe(struct arc_emac_priv *priv)
 	if (IS_ERR(data->reset_gpio)) {
 		error = PTR_ERR(data->reset_gpio);
 		dev_err(priv->dev, "Failed to request gpio: %d\n", error);
+		mdiobus_free(bus);
 		return error;
 	}
 
-- 
2.25.1



