Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F3C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3568206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjXKCqIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCVRuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:50:20 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51101 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgCVRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 13:50:17 -0400
Received: by mail-pj1-f66.google.com with SMTP id v13so5016748pjb.0;
        Sun, 22 Mar 2020 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KK3Ro2FLwCDE/TwXjj4wqViR4KSXhk4w82GFr36fy4=;
        b=KjXKCqIPvUSlSTFndLJj/ygE3t+yMKnldDlXqXrdjnGEyAnIY6v1PposD3DYeRRpDa
         fhwijHMJaE1Lt16cooebo9YTytFz4iVy2MzW8/WUeWVQCi0ghawsdSAY8KfGqxRdUwNH
         RRSTfOWyJYvOaHvygxoibRWzvNx8XQlLoRA8+iU4vWK6hiXMVrZyJOQWpnHpNnrVPVO/
         WjvyMLzA0IIcfHchdPCZG7tdQbkoFEJs9v7K40UXBes8ZSJ1WZGpGGqUPGYh/Qdfo7rL
         IchSHNxEW4RsqbrDK/B31bf1peAkPcEQzbYMhHvzRfjteTzi1nf6jkJBpm2+nx94DhZh
         q4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KK3Ro2FLwCDE/TwXjj4wqViR4KSXhk4w82GFr36fy4=;
        b=ECUgVizKcAMOuKOoaLx3po4acwd/JnGlatzcDUComK8FWjJQPsjVTuOp8TdGwcJFdj
         0+K0bddv5GlUfd0qaVguQN8dpcsDUi9t4ZTPYOdN0Syu5n3TWsPUQWoyqu0bs9orv+8N
         jU7+2gbXakVBqTWyATgVbDfk4MFE7V/QiXuZoVU75OUHPuEr2LKXMW8tphJ0slZ7zTjL
         9Q39ba30VeV5t+juN9FaLkZGVxvOrpMbZXzLcKZKG8A8VzBa8UaQQ3dp3wcSCFiSCNG3
         +JJrnj0C86UlDJMefVGoefwil8AnGjcoog58ryAsrULaW/F6OsQWF0E3i+bgaQCALZlO
         MNYQ==
X-Gm-Message-State: ANhLgQ0+mA7bz51Dkl3JRErxlEBewnulBGXM3CCejrFVlEjvMu9Ecwha
        AZWpqzrVi27dCTLbWyGlt64=
X-Google-Smtp-Source: ADFU+vvLvQ6L6WOE/gLrmdD7xpPudkUuhEU+ZgWI+NjRNU3GlGfsMiqAD/p/Z/JEvsadjV8ztlM1uw==
X-Received: by 2002:a17:902:82c5:: with SMTP id u5mr1947470plz.254.1584899416291;
        Sun, 22 Mar 2020 10:50:16 -0700 (PDT)
Received: from localhost ([216.24.188.11])
        by smtp.gmail.com with ESMTPSA id t3sm4609244pfl.26.2020.03.22.10.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 10:50:15 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net,
        mchehab+samsung@kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, broonie@kernel.org, tglx@linutronix.de,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next v5 06/10] net: phy: marvell10g: use phy_read_mmd_poll_timeout() to simplify the code
Date:   Mon, 23 Mar 2020 01:49:39 +0800
Message-Id: <20200322174943.26332-7-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200322174943.26332-1-zhengdejin5@gmail.com>
References: <20200322174943.26332-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use phy_read_mmd_poll_timeout() to replace the poll codes for
simplify mv3310_reset() function.

it should be add msleep(5) before call phy_read_mmd_poll_timeout()
to keep the code more similar, but it will report that warning, so
modify it to msleep(20).

./scripts/checkpatch.pl
v5-0006-net-phy-marvell10g-use-phy_read_mmd_poll_timeout-.patch
WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst
#41: FILE: drivers/net/phy/marvell10g.c:251:
+	msleep(5);

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v4 -> v5:
	- add msleep() to before call phy_read_mmd_poll_timeout()
	  to keep the code more similar.
v3 -> v4:
	- add this patch by Andrew's suggestion. Thanks Andrew!

 drivers/net/phy/marvell10g.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 7e05b92504f0..c0fb8391c75b 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -241,22 +241,18 @@ static int mv3310_power_up(struct phy_device *phydev)
 
 static int mv3310_reset(struct phy_device *phydev, u32 unit)
 {
-	int retries, val, err;
+	int val, err;
 
 	err = phy_modify_mmd(phydev, MDIO_MMD_PCS, unit + MDIO_CTRL1,
 			     MDIO_CTRL1_RESET, MDIO_CTRL1_RESET);
 	if (err < 0)
 		return err;
 
-	retries = 20;
-	do {
-		msleep(5);
-		val = phy_read_mmd(phydev, MDIO_MMD_PCS, unit + MDIO_CTRL1);
-		if (val < 0)
-			return val;
-	} while (val & MDIO_CTRL1_RESET && --retries);
-
-	return val & MDIO_CTRL1_RESET ? -ETIMEDOUT : 0;
+	msleep(20);
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PCS,
+					 unit + MDIO_CTRL1, val,
+					 !(val & MDIO_CTRL1_RESET),
+					 5000, 80000);
 }
 
 static int mv3310_get_edpd(struct phy_device *phydev, u16 *edpd)
-- 
2.25.0

