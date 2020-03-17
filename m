Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D666C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20A220658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hu9yeveS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCQEyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:54:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37070 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgCQEyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:54:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id a141so20416048wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Z/pLHqEymmI8qdYZpx02WBRLipjnKwZXZVqV8m8MSSY=;
        b=Hu9yeveSk7lvKAgkYqMZGbJjupqBFlO1hDJJn/f26IzkoN9kOnt+c1715OgLvVXhX6
         SIXcVljSb2WE4ejla8A/dMxdUYQiO1PDZlEEa1fiKMEqWZho5cMEJYzTCs2sbjlRn+bg
         0AQ/kJixJH546JWh2HbJ63TNz4z5jQgMIAvwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z/pLHqEymmI8qdYZpx02WBRLipjnKwZXZVqV8m8MSSY=;
        b=uHEm9+YKzMddGLEe/5oNXQSXXFz4i3H9QtT7jnGiW+myfH5877KU5HvC68Xs9/RPUh
         BFzlTPt8729gi0DDRkuwYg3zIu4ESiYn6DEmirF5/n3qvxSTJsctJ096vgPxuhBhw0G4
         XALMuTvzf7463h0DCDUwJTNHfyturYjFJ1rWfzgWnaNyIcm+W3Pbf4izBN7rOJtrK3RJ
         KK5j5z+h+0HnCA9qRJC4m8HPnlEZiH6huxBVbZml8KxzBMPsCEFQb3UqgJ/9kU2i1peZ
         9ate/vUd9p0W6sKjSQ28j/ZzrSu/JFAUMw+kjur7JCc2gJnQTkczSVA824FxzhKl76Wl
         OlnQ==
X-Gm-Message-State: ANhLgQ3NT84DZBmZ/QCsJgYZlbMgzi2Yz6Gkc8NwA/azqkbXEUXKuSVD
        Kw54pkxwLxunkxnU9ROdJWp1Ug==
X-Google-Smtp-Source: ADFU+vtloprSXesJvtRnEjLPOoV7EqcOa08m/oOOJVTgeOAFV+HVZ4G4S3W0WCB1yQtt7cfGvfhQRA==
X-Received: by 2002:a1c:7207:: with SMTP id n7mr2819390wmc.138.1584420888626;
        Mon, 16 Mar 2020 21:54:48 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i67sm2874498wri.50.2020.03.16.21.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 21:54:47 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] net: phy: mdio-mux-bcm-iproc: check clk_prepare_enable() return value
Date:   Tue, 17 Mar 2020 10:24:35 +0530
Message-Id: <20200317045435.29975-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check clk_prepare_enable() return value.

Fixes: 2c7230446bc9 ("net: phy: Add pm support to Broadcom iProc mdio mux driver")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 88d409e48c1f..aad6809ebe39 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -288,8 +288,13 @@ static int mdio_mux_iproc_suspend(struct device *dev)
 static int mdio_mux_iproc_resume(struct device *dev)
 {
 	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
+	int rc;
 
-	clk_prepare_enable(md->core_clk);
+	rc = clk_prepare_enable(md->core_clk);
+	if (rc) {
+		dev_err(md->dev, "failed to enable core clk\n");
+		return rc;
+	}
 	mdio_mux_iproc_config(md);
 
 	return 0;
-- 
2.17.1

