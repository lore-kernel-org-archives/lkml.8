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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF711C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E0820722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcxm9UqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCVRuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:50:18 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36510 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgCVRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 13:50:13 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so4956397pjb.1;
        Sun, 22 Mar 2020 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n2XYXavZMeYoAHc5mBv6tNDgFoTw76pNiSWNX3EEa9Q=;
        b=pcxm9UqZ/HAL0OwPYcs8XshKDVUzxHE5vqSAML7ZGwDWBL87tX9LzqHPxf0Vr9ROoP
         fAsu/S9YFGMA2SkRtG68jKO1/HLH76jlrqZws/qJM5AI1PnjFXYLGdd9QahqogxEHgAt
         i8Uzzb2ffn35pW1gFKRQNkoe9jIYY4t6d0d07+a7wNK8hoscfFFmnSVkbY9gv1fdJ1Y8
         vMO0skSFZ/HJnd+/S4PdIiPV/YSUSffvpNfYFXsuxgW6ocqKUEOaiR/k79Oi42VQyP2Y
         Q93DMXy7n3V+Kv3RrcTZaZViZDsRHRRaGx55jufJwy9vPIXMSMqQ2pkFDpCY/fRGytmV
         F0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2XYXavZMeYoAHc5mBv6tNDgFoTw76pNiSWNX3EEa9Q=;
        b=IuvIB8dkMoy3ivp0cLdfHl6nOZyWlrT4Oah9Yb4wn0Ym4Yn+4ePiotG/L9OhUOJUuG
         Pg/ew2jmptsKxZV0JIemLWDA2h7D6HrWuQ5vtvzZKEhwC8ecmSyuPfB8u24V4bWbLTx2
         8wD1mo0/W52rJw6kED4bMoO1/KcNBL2mY0MMv4Ht/a6ICHB+Agy0H+toHLkUq8h+GCPN
         mxceKJZuO0n6FLWP8tGJubuVM5NZNoasSbDwi/I/iPmlV87ut61F4izoKemT3dN9ZJQJ
         Df6bbEZ7VUZ0LtWL3Q0S/Zt4gbd8ZSntOBDAUKj9iKdEbmSLsc40ZeCIWAX6HQIRm3f+
         Cpvw==
X-Gm-Message-State: ANhLgQ3KAUIqX8cIlCPnTH6nZKhLGxaBGEkehcwnEzR99JjkRNAUOGcw
        q6Wg1x8JT9MBJYYlHXn6IzA=
X-Google-Smtp-Source: ADFU+vvZo/GquTPYaiXgc6x6RKv+XMsH+z54GAX/IH3g5frJzPtJbDNf3qiNbeVAxAk3xrIiVwV54Q==
X-Received: by 2002:a17:90a:8806:: with SMTP id s6mr21311160pjn.141.1584899412228;
        Sun, 22 Mar 2020 10:50:12 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id nk12sm1366666pjb.41.2020.03.22.10.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 10:50:11 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net,
        mchehab+samsung@kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, broonie@kernel.org, tglx@linutronix.de,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next v5 05/10] net: phy: aquantia: use phy_read_mmd_poll_timeout() to simplify the code
Date:   Mon, 23 Mar 2020 01:49:38 +0800
Message-Id: <20200322174943.26332-6-zhengdejin5@gmail.com>
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
simplify aqr107_wait_reset_complete() function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v4 -> v5:
	- no changed
v3 -> v4:
	- no changed
v2 -> v3:
	- adapt to it after modifying the parameter order of the
	  newly added function
v1 -> v2:
	- remove the handle of phy_read_mmd's return error.

 drivers/net/phy/aquantia_main.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index 31927b2c7d5a..db3e20938729 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -451,16 +451,11 @@ static int aqr107_set_tunable(struct phy_device *phydev,
  */
 static int aqr107_wait_reset_complete(struct phy_device *phydev)
 {
-	int val, retries = 100;
-
-	do {
-		val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
-		if (val < 0)
-			return val;
-		msleep(20);
-	} while (!val && --retries);
+	int val;
 
-	return val ? 0 : -ETIMEDOUT;
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					 VEND1_GLOBAL_FW_ID, val,
+					 val != 0, 20000, 2000000);
 }
 
 static void aqr107_chip_info(struct phy_device *phydev)
-- 
2.25.0

