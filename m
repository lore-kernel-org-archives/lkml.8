Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB30246EB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203824;
	bh=xrSwneQSyxbFcrpnGduhSn7IJJUdsBkAyHBLcwBerkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GfTBgCl9lzJ/ZMjpUBzOWRqn26E4LU4wvELede9L+YdzozqE/DEOE99y6FxR3+7/+
	 +hHhgZRSIq2s/VNzb5GN+ozjY+OIIs14OoHhdzmcBN5WBhFZBqv51QuV4ZKC6EfvEx
	 G4j4A0imTvc81zrv2VsM73ambvAfCcHw27Drcbtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgCCCuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgCCCuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:50:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35D024697;
        Tue,  3 Mar 2020 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203812;
        bh=xrSwneQSyxbFcrpnGduhSn7IJJUdsBkAyHBLcwBerkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DgQf99OWgQfK/1CZpv80i8qUW97R8gKDtsM/RvR4hpCTtdZYwlHEsTM93Jn4xI0o
         eElUa4w2ai9pv5mH7M+BBunWYeNu11InzfIwAsqjIZzAOiv2+SJ/vcubuv51JW6peA
         np3P0qYQ9xqxn1C0LiIDxJ2KKV60K3ZtA0RK1wX4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 07/13] net: phy: restore mdio regs in the iproc mdio driver
Date:   Mon,  2 Mar 2020 21:49:56 -0500
Message-Id: <20200303025002.10600-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303025002.10600-1-sashal@kernel.org>
References: <20200303025002.10600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Parameswaran <arun.parameswaran@broadcom.com>

[ Upstream commit 6f08e98d62799e53c89dbf2c9a49d77e20ca648c ]

The mii management register in iproc mdio block
does not have a retention register so it is lost on suspend.
Save and restore value of register while resuming from suspend.

Fixes: bb1a619735b4 ("net: phy: Initialize mdio clock at probe function")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mdio-bcm-iproc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/phy/mdio-bcm-iproc.c b/drivers/net/phy/mdio-bcm-iproc.c
index 46fe1ae919a30..51ce3ea17fb37 100644
--- a/drivers/net/phy/mdio-bcm-iproc.c
+++ b/drivers/net/phy/mdio-bcm-iproc.c
@@ -188,6 +188,23 @@ static int iproc_mdio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+int iproc_mdio_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iproc_mdio_priv *priv = platform_get_drvdata(pdev);
+
+	/* restore the mii clock configuration */
+	iproc_mdio_config_clk(priv->base);
+
+	return 0;
+}
+
+static const struct dev_pm_ops iproc_mdio_pm_ops = {
+	.resume = iproc_mdio_resume
+};
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct of_device_id iproc_mdio_of_match[] = {
 	{ .compatible = "brcm,iproc-mdio", },
 	{ /* sentinel */ },
@@ -198,6 +215,9 @@ static struct platform_driver iproc_mdio_driver = {
 	.driver = {
 		.name = "iproc-mdio",
 		.of_match_table = iproc_mdio_of_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &iproc_mdio_pm_ops,
+#endif
 	},
 	.probe = iproc_mdio_probe,
 	.remove = iproc_mdio_remove,
-- 
2.20.1

