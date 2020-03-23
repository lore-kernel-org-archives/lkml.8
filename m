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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABCBC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEAA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4OeduM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCWPH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:07:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46582 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgCWPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:07:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id r3so6008420pls.13;
        Mon, 23 Mar 2020 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aa6t6On9SFFaqUu6JfdwGcBHkFRJmU7LGTC9/kij2yU=;
        b=j4OeduM1npfKZ66EzlFeA2FKn4gSg+Klzf5Ykh0nJ37W3tuHmt4dGgjwU+r2fdUVBh
         WDNf9zL0XLqhB6vrPb7Pd9z5DSJxKYATXoiUW/DH7S98dRnzLO03BmqmM46WyA42VW8e
         kPO+3pE3hsogvJJ3CQa744J+yBS9w89ZLTeGK6T1lHyKxD3SCvTeOvyX1tG/M9tj64KP
         AFxa6f9nZKK5i3GLedFqtrkACxPLzgl6QEufAyYZfHqU8314nnwHfhIrH9xK2tAR6TOs
         5vQ84b7w7VtrJvdjFtX+b1/vYKL0bEJy6z8kY0XBjmItjrQUH0IifKF0eqgucHUPbZn6
         RNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aa6t6On9SFFaqUu6JfdwGcBHkFRJmU7LGTC9/kij2yU=;
        b=KyR8XGROI7lxrAWkXKJF/aCMkM+wM5K7U/6wPudae/+wWc/U8JVa27Q/6Kyh6Tf2kR
         TVGKghAorLnnkJ71rSb5EzspyC75AFQ3GkNyHyVaycOouK19zorRSHJU0qZeyAHozA8U
         S8vovDb9UOr++25+sCCWfuPJZfPWHzVGKwtiYi671G1nYWM3FYUaARqzNgqNALliBua6
         sQhNCtEolYD5irb3yZZLf4Kw3xXr0BNDVvJBmsEoB8LOBbqd0jgsgTKRYKqm5FICUTM1
         mdcC6GFC+jMUX7OQvhz8TU1pqss/aoOtCs2PtEWskijvM5ndGQw2myUs0aleU8TfRhNF
         EUZQ==
X-Gm-Message-State: ANhLgQ3CUq0+WB52nzvgZQSUY4fG2LDL/ZPqoCDV3gYWD0qcHP0kdHPW
        l7Wix2RRXrBiw/daPOqcBJY=
X-Google-Smtp-Source: ADFU+vtN2ERQpbC09KXihGgin8XmePpn0g8nL0BFTsTtWALL34FFr1+PIv9mRN6UJzIHfhyEGjhIbw==
X-Received: by 2002:a17:90b:11c4:: with SMTP id gv4mr12148505pjb.148.1584976044918;
        Mon, 23 Mar 2020 08:07:24 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id x75sm13914648pfc.161.2020.03.23.08.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 08:07:24 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, corbet@lwn.net,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, mchehab+samsung@kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next v7 10/10] net: phy: tja11xx: use phy_read_poll_timeout() to simplify the code
Date:   Mon, 23 Mar 2020 23:06:00 +0800
Message-Id: <20200323150600.21382-11-zhengdejin5@gmail.com>
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
simplify tja11xx_check() function.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v6 -> v7:
	- adapt to a newly added parameter sleep_before_read.
v5 -> v6:
	- no changed.
v4 -> v5:
	- no changed.
v3 -> v4:
	- add this patch by Andrew's suggestion. Thanks Andrew!

 drivers/net/phy/nxp-tja11xx.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index b705d0bd798b..47caae770ffc 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -72,20 +72,10 @@ static struct tja11xx_phy_stats tja11xx_hw_stats[] = {
 
 static int tja11xx_check(struct phy_device *phydev, u8 reg, u16 mask, u16 set)
 {
-	int i, ret;
-
-	for (i = 0; i < 200; i++) {
-		ret = phy_read(phydev, reg);
-		if (ret < 0)
-			return ret;
-
-		if ((ret & mask) == set)
-			return 0;
-
-		usleep_range(100, 150);
-	}
+	int val;
 
-	return -ETIMEDOUT;
+	return phy_read_poll_timeout(phydev, reg, val, (val & mask) == set,
+				     150, 30000, false);
 }
 
 static int phy_modify_check(struct phy_device *phydev, u8 reg,
-- 
2.25.0

