Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7057C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A263E20702
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jsHKvQlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgFZPxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbgFZPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:53:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184F5C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so9967357wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmM0w9++YOvRbigI3M/z92SWeCSR1I4ysKIp85NsNQ8=;
        b=jsHKvQlFJchlk+nAS6EYxJsTrPWMAcRj0EHZs85DK/6iCVgykw7yR98sHXSnketSzR
         FI7rNq81sjrlfzX8fx+6ZDnDEqFSrhsrY//kpRlw6yGXVPdrY6Lvw01bBxNX9vnG20HB
         cEkyF3fKhzRDaJpYyZ31CMyB0XPvJ+jT3XMEGCZdta9X63MU6dQRRbgNWo6NJVX0DEAW
         QYChEWjf7nJYsj2UO9Wjk09rPNR4EMTCAG1uTz+9YZJyPHlL1Q/swWGAOYDA5uN1vHN1
         S+91cXzE3pab4b+F0UR/+62QxPZJWQ1QEeMwLtkEhv3RxXLYa9RwQBhRM2RaQEHXT2eQ
         AdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmM0w9++YOvRbigI3M/z92SWeCSR1I4ysKIp85NsNQ8=;
        b=AILNHbpa7vBoF5pfhY+tC9ZyMxM87PZgyMr9JpxRArs9AXo2l4hGvVPLtccSry02C9
         enal5wkBoog27HX97ZFPs2C9tTWusufkvY0wCTAOYHo5Fd4vPw14dv1X4A7no03dpR7m
         FZJiQm0mmC52UlDeOsOEmIu559uz5Dt/iO8uNL259Yu6qCQrAoKOBfMJCDE8gOdf7LWD
         +TfkUjUAw0Sk1wLFTMns6ghLujpQAo51tiC80yKUqB3M32dGUS1MaYJnHeVF+NEyfJmF
         Sc6PI0H20k5+FwUi/mGCuNq9Iq3Q1CNnjjMC9D6oCuWXZ5+Jwi7E2SKe2RyVQxSVten2
         p/pQ==
X-Gm-Message-State: AOAM532LQF0bOQg5SvtnfvHIXwCjxcu8KQhjSjYOu+G0gK25ol8RT0fy
        q9/i5QQW2XdoaHB0zdQHAZLkBA==
X-Google-Smtp-Source: ABdhPJxpfFa9oiq45cqxPoAt/649YHTlK3jOGv8zobpD2qHFN9TrEmp90ncl1Z9EYnXHMGeh8Q34rQ==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr4597647wrx.416.1593186824858;
        Fri, 26 Jun 2020 08:53:44 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h142sm8242791wme.3.2020.06.26.08.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:53:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/6] net: phy: arrange headers in mdio_bus.c alphabetically
Date:   Fri, 26 Jun 2020 17:53:20 +0200
Message-Id: <20200626155325.7021-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200626155325.7021-1-brgl@bgdev.pl>
References: <20200626155325.7021-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Keeping the headers in alphabetical order is better for readability and
allows to easily see if given header is already included.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6ceee82b2839..296cf9771483 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -8,32 +8,32 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/of_device.h>
-#include <linux/of_mdio.h>
 #include <linux/of_gpio.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
 #include <linux/reset.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/mii.h>
-#include <linux/ethtool.h>
-#include <linux/phy.h>
-#include <linux/io.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/unistd.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mdio.h>
-- 
2.26.1

