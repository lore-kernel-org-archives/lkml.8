Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1999CC4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10BC20736
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvG62241"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCVRuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:50:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgCVRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 13:50:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so6302444pfj.1;
        Sun, 22 Mar 2020 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBvGQ6CFlZdm2OTUEKWLVwd/Xsa7ZOZEZTJVRI1K72Y=;
        b=GvG62241AOXEJQBnj6q1TEZOUxDOmY5qh6seX9QeLUFt9INkY9BeOMCatf4EyE7ZoE
         7stlom2oQmTFRttUSpAAu9uecfBsgSI56Gd+qV289T+DFXVTJuIGGh+XUEf/Iapce0WT
         OuIV963fpOdyh/2dWra4XCrsSA5hnHU3jp334SAJqgf7o25fgGg3Ms3sosEC00owMZTU
         iEf/0p6ab7GKmRky1XW3nGbL7jAQ5toOE2/yvaNrGavNYdgqyGNhuaSLFMPV5ZgAf3zl
         BufOpVt5Ea9GEccMbcpyQLn+FiWqsNEYoelJyJzAO/I5pB8XqacqK0yqqCoHL+tlAy0Y
         /SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBvGQ6CFlZdm2OTUEKWLVwd/Xsa7ZOZEZTJVRI1K72Y=;
        b=k9+3P0UJrr6TgrHlaxSFC2YPWl4naVucjF1qNuqbOy0tmaU3RHqHNVJsiHq3o5ZdOY
         s0uE3UgytwotbmtAPMNO9P220rTpuKnZEJFg2nzr0LJaWDoWxGcfnOrD0gYv/ncs+zeN
         4VC/ObBb3vxybD/rXQ8zJybtaIUP9n+yQ/JRszB0jfDIYtP7zwIXXPuDUxhQmFjxcZSn
         jNJOU99BDiSeaFYK7cdnkCUGqyNARNfYoi/sS6H65uBYe6rfSVqKpYEAoXbOyeYPOqL+
         SB3u+fi1kZwcm7loo2gz2rB4HR4UKBACAKAB5MuglHS56MjHuiPzkTp8PjgmSm9c6WWg
         T3Vg==
X-Gm-Message-State: ANhLgQ3wzlHJNRXm0shL6oM0ZqAoUFSna9EFWg1PT+cmXfYtBpAh+OL7
        ZrbvPSXo6J5xmIcmdw7UtQI=
X-Google-Smtp-Source: ADFU+vt5Ba3Rj/x3BkRTwh6GJ+FWm9MuTFgQfEuj9WBwfUZWFPZRwjfRI4Byu97Bb5srUvxLL9KwOA==
X-Received: by 2002:a63:48e:: with SMTP id 136mr18018044pge.169.1584899420516;
        Sun, 22 Mar 2020 10:50:20 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id z20sm9996362pge.62.2020.03.22.10.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 10:50:20 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net,
        mchehab+samsung@kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, broonie@kernel.org, tglx@linutronix.de,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next v5 07/10] net: phy: introduce phy_read_poll_timeout macro
Date:   Mon, 23 Mar 2020 01:49:40 +0800
Message-Id: <20200322174943.26332-8-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200322174943.26332-1-zhengdejin5@gmail.com>
References: <20200322174943.26332-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is sometimes necessary to poll a phy register by phy_read()
function until its value satisfies some condition. introduce
phy_read_poll_timeout() macros that do this.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v4 -> v5:
	- no changed.
v3 -> v4:
	- deal with precedence issues for parameter cond.
v2 -> v3:
	- modify the parameter order of newly added functions.
	  phy_read_poll_timeout(val, cond, sleep_us, timeout_us, \
				phydev, regnum)
				||
				\/
	  phy_read_poll_timeout(phydev, regnum, val, cond, sleep_us, \
				timeout_us)
v1 -> v2:
	- pass a phydev and a regnum to replace args... parameter in
	  the phy_read_poll_timeout(), and also handle the
	  phy_read() function's return error.
 
 include/linux/phy.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 42a5ec9288d5..f2e0aea13a2f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -714,6 +714,19 @@ static inline int phy_read(struct phy_device *phydev, u32 regnum)
 	return mdiobus_read(phydev->mdio.bus, phydev->mdio.addr, regnum);
 }
 
+#define phy_read_poll_timeout(phydev, regnum, val, cond, sleep_us, timeout_us) \
+({ \
+	int ret = 0; \
+	ret = read_poll_timeout(phy_read, val, (cond) || val < 0, sleep_us, \
+				timeout_us, phydev, regnum); \
+	if (val <  0) \
+		ret = val; \
+	if (ret) \
+		phydev_err(phydev, "%s failed: %d\n", __func__, ret); \
+	ret; \
+})
+
+
 /**
  * __phy_read - convenience function for reading a given PHY register
  * @phydev: the phy_device struct
-- 
2.25.0

