Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D82FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A3420663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKHWLJRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCWPHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:07:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41819 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgCWPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:07:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so6016719plr.8;
        Mon, 23 Mar 2020 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1chrW1p6r783D8IVsf1Wd8VGJ5DUqrzj1FnJUn6rv18=;
        b=OKHWLJRJ3iWJXECf4enlLUs9TazfI+iienfWxXOsqDTd7Usgzub7vIfnbq0DNZpxnA
         2Ng8go/HxaFTqMTZJJNMDIOOOhm/GtWQh4DfxGaTGcLdqjtkhEzCz75Bs6qwqk+95s9W
         lLJ6lkMJWKio9STOaQ7RlD10sOT8dUXGfkTN+jCv0ShxPYWNWnLgouyBiF/r7IV762BU
         btq/4zsk0/4Q41UamTKu686pdwVZuI25s3gC88YYG7YP1TjA2+X0eh9cVhJZFo6sqGU8
         Da3UE7FLtw6F1j4Zb+vnahprtC/OHWGjfYt7BkKgq9dx3aJmx2RlVoSkIOmFAPAmBTbN
         Ly2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1chrW1p6r783D8IVsf1Wd8VGJ5DUqrzj1FnJUn6rv18=;
        b=NjhDpzqYHflu0eHf1l8Akn5Ab1oBoZSirKkqzbgWQ7u4YYJaDaTEI/GWRz+H5Rny97
         ek/97zr/GwiRKLElx+50heOoRjYhh47a3EPqw4+Rd9BBJKvwPOni20FiGIkp7O5Nv46d
         AuwYkYktwXKIlL04+8Lyfi9QHEhd+WKf041B/UkyuVZ4XP9T3oLxLGJqauf6n8TaIUQw
         kguh1TpNlDs2UVML+JPADx4sCgMaVT0xI+Xh0+vPA/Ad4xdRcTbEwcREsh69lkBd429p
         H1XavUJwAPPW83XwvFmlz/mVlVoyBCPt2dcjj60DJf0oL+yM8QpmLjVBDpIfgonKgUNu
         escQ==
X-Gm-Message-State: ANhLgQ0iQOlefGd9BQHKnlT5s3RMCgDLo9UGpb1WQOONt+9RWoTJos+T
        qS8nTvEL8/777STQoqW8NIg=
X-Google-Smtp-Source: ADFU+vszx04TiPqNUvmapICvLgTBDHHeK2xFhvmYKm6Gu/RotSPQ4EXWAvNd6k4iKs7h/qng8lfgJQ==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr22130142plm.306.1584976040020;
        Mon, 23 Mar 2020 08:07:20 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id n100sm12050147pjc.38.2020.03.23.08.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 08:07:19 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, corbet@lwn.net,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, mchehab+samsung@kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next v7 09/10] net: phy: smsc: use phy_read_poll_timeout() to simplify the code
Date:   Mon, 23 Mar 2020 23:05:59 +0800
Message-Id: <20200323150600.21382-10-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323150600.21382-1-zhengdejin5@gmail.com>
References: <20200323150600.21382-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use phy_read_poll_timeout() to replace the poll codes for
simplify lan87xx_read_status() function.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v6 -> v7:
	- adapt to a newly added parameter sleep_before_read.
v5 -> v6:
	- no changed.
v4 -> v5:
	- add msleep before phy_read_poll_timeout() to keep the
	  code more similar
v3 -> v4:
	- add this patch by Andrew's suggestion. Thanks Andrew!

 drivers/net/phy/smsc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index b73298250793..93da7d3d0954 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -112,8 +112,6 @@ static int lan87xx_read_status(struct phy_device *phydev)
 	int err = genphy_read_status(phydev);
 
 	if (!phydev->link && priv->energy_enable) {
-		int i;
-
 		/* Disable EDPD to wake up PHY */
 		int rc = phy_read(phydev, MII_LAN83C185_CTRL_STATUS);
 		if (rc < 0)
@@ -125,15 +123,11 @@ static int lan87xx_read_status(struct phy_device *phydev)
 			return rc;
 
 		/* Wait max 640 ms to detect energy */
-		for (i = 0; i < 64; i++) {
-			/* Sleep to allow link test pulses to be sent */
-			msleep(10);
-			rc = phy_read(phydev, MII_LAN83C185_CTRL_STATUS);
-			if (rc < 0)
-				return rc;
-			if (rc & MII_LAN83C185_ENERGYON)
-				break;
-		}
+		phy_read_poll_timeout(phydev, MII_LAN83C185_CTRL_STATUS, rc,
+				      rc & MII_LAN83C185_ENERGYON, 10000,
+				      640000, true);
+		if (rc < 0)
+			return rc;
 
 		/* Re-enable EDPD */
 		rc = phy_read(phydev, MII_LAN83C185_CTRL_STATUS);
-- 
2.25.0

