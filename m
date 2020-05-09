Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75803C54E7F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 22:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD1B21582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 22:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="nJw5TG1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgEIWh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 18:37:28 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:49329 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgEIWh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 18:37:27 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 063CF23E33;
        Sun, 10 May 2020 00:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1589063845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzHqYBvCwThHHkKVamjtONj8fPfk5y2Lf2183Wpe4Qc=;
        b=nJw5TG1bCOs5pvinAlfdW0/9uJ765K7vcsry0d32q+YbBYT/IHRx7kqnl3NmNEdc0GX/OA
        YDQpKWegjyJtwhnMza5BA4InQ4OVPQHQjFav/phEApl+IyP0vcHeSU+pNnuXt+UOO6MsG5
        JhRGllNHCtIiBG/0+Usdt4Jl8AsM5AI=
From:   Michael Walle <michael@walle.cc>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH net-next 2/4] net: phy: broadcom: add bcm_phy_modify_exp()
Date:   Sun, 10 May 2020 00:37:12 +0200
Message-Id: <20200509223714.30855-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509223714.30855-1-michael@walle.cc>
References: <20200509223714.30855-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the convenience function to do a read-modify-write. This has the
additional benefit of saving one write to the selection register.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/phy/bcm-phy-lib.c | 32 ++++++++++++++++++++++++++++++++
 drivers/net/phy/bcm-phy-lib.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index a390812714ed..41c728fbcfb2 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -67,6 +67,38 @@ int bcm_phy_read_exp(struct phy_device *phydev, u16 reg)
 }
 EXPORT_SYMBOL_GPL(bcm_phy_read_exp);
 
+int __bcm_phy_modify_exp(struct phy_device *phydev, u16 reg, u16 mask, u16 set)
+{
+	int new, ret;
+
+	ret = __phy_write(phydev, MII_BCM54XX_EXP_SEL, reg);
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_read(phydev, MII_BCM54XX_EXP_DATA);
+	if (ret < 0)
+		return ret;
+
+	new = (ret & ~mask) | set;
+	if (new == ret)
+		return 0;
+
+	return __phy_write(phydev, MII_BCM54XX_EXP_DATA, new);
+}
+EXPORT_SYMBOL_GPL(__bcm_phy_modify_exp);
+
+int bcm_phy_modify_exp(struct phy_device *phydev, u16 reg, u16 mask, u16 set)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __bcm_phy_modify_exp(phydev, reg, mask, set);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bcm_phy_modify_exp);
+
 int bcm54xx_auxctl_read(struct phy_device *phydev, u16 regnum)
 {
 	/* The register must be written to both the Shadow Register Select and
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index 0eb5333cda39..b35d880220b9 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -29,8 +29,10 @@
 
 int __bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
 int __bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
+int __bcm_phy_modify_exp(struct phy_device *phydev, u16 reg, u16 mask, u16 set);
 int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
 int bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
+int bcm_phy_modify_exp(struct phy_device *phydev, u16 reg, u16 mask, u16 set);
 
 static inline int bcm_phy_write_exp_sel(struct phy_device *phydev,
 					u16 reg, u16 val)
-- 
2.20.1

