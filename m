Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28337C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F5A20727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rp37gfzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbgEWN1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387857AbgEWN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:27:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E91CC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:27:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so13024809wru.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+yFWYJIlSICmhm10tVUfzLOMvlRQ6VDJMbx/0w2dnM=;
        b=rp37gfzAHCsfIapPIDnPi7bhKo6b+4zS1qkIx4xs7tAznZqzIdivacCFjDJKCqT6hG
         1OX9zD5yiWYH4CqkM6qHcEAAGbm1wVPBTh2lWvqqDpdi98elF69xmUr8VREH3Bf2OLjK
         6yV3qoI0RCu8I5DOcq5Nb+MnauOEWgc1E1hQGs3NdKmTOl4Y/Jlz9OVZARBw8pvX/22+
         7Cm1u4L8WZQo7PMHtZpGsGWh9TvXKsGW7Dc9Rh/GcaTJTp5l/mRjnaFxrE6C8hONjgIc
         dTVbBVazQyYYBzO8OZNy/C8jOnDmZrw3gBLCOA1jSBsnsqlLmZjZ8bkqn8UaNgYNkcVk
         r0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+yFWYJIlSICmhm10tVUfzLOMvlRQ6VDJMbx/0w2dnM=;
        b=BbeRTJpvP3Qy5j1T+LKhtegRI0vNuqCLkDGeXj8tR4SXXATTQW9JtdyIw7UwSUb0G5
         WVl4NIMr80NxLey3sx37dmrtnB088f1/Go5q2VoAjNbKKETePrD1pC0oMf7qsTvNXQCs
         5neXmxOZwHGmQgEz3DcOZ37VMTRQfN34q8Unn259X3ZWkpR6cnDtlqgL34zUNOBkRVNq
         eLjGXLLEA71X9PMRFuFUOFOReZnJXpBXq7yBZOQFGz5YF5Zwa8Xsjxz7KHua3FOIKA6D
         LrPmvPVy+uuTS3fxIH+41+Y+7ntWN6sofFhnkpxxI1MzWrdfRii+6p7LwdQoBrt/ziCK
         SWtg==
X-Gm-Message-State: AOAM5338GuvOTjiNEIBhRFEEZNUMkVZXUBxWj80SRZOKMgkj9oZG5O98
        /WFPgD/IPUYvQC3LFr9KuFt8Xw==
X-Google-Smtp-Source: ABdhPJxCZ/C5LkU5FvQk1ZK/F68K0jYwlV3rlUq0UEXtfIpESu0BTugHOfJzFdukxZNlBknHIuZEVQ==
X-Received: by 2002:adf:eccf:: with SMTP id s15mr7285736wro.70.1590240442325;
        Sat, 23 May 2020 06:27:22 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id g69sm8098703wmg.15.2020.05.23.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 06:27:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/5] net: move devres helpers into a separate source file
Date:   Sat, 23 May 2020 15:27:08 +0200
Message-Id: <20200523132711.30617-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200523132711.30617-1-brgl@bgdev.pl>
References: <20200523132711.30617-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's currently only a single devres helper in net/ - devm variant
of alloc_etherdev. Let's move it to net/devres.c with the intention of
assing a second one: devm_register_netdev(). This new routine will need
to know the address of the release function of devm_alloc_etherdev() so
that it can verify (using devres_find()) that the struct net_device
that's being passed to it is also resource managed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/Makefile       |  2 +-
 net/devres.c       | 36 ++++++++++++++++++++++++++++++++++++
 net/ethernet/eth.c | 28 ----------------------------
 3 files changed, 37 insertions(+), 29 deletions(-)
 create mode 100644 net/devres.c

diff --git a/net/Makefile b/net/Makefile
index 07ea48160874..5744bf1997fd 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -6,7 +6,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-obj-$(CONFIG_NET)		:= socket.o core/
+obj-$(CONFIG_NET)		:= devres.o socket.o core/
 
 tmp-$(CONFIG_COMPAT) 		:= compat.o
 obj-$(CONFIG_NET)		+= $(tmp-y)
diff --git a/net/devres.c b/net/devres.c
new file mode 100644
index 000000000000..c1465d9f9019
--- /dev/null
+++ b/net/devres.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file contains all networking devres helpers.
+ */
+
+#include <linux/device.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+
+static void devm_free_netdev(struct device *dev, void *res)
+{
+	free_netdev(*(struct net_device **)res);
+}
+
+struct net_device *devm_alloc_etherdev_mqs(struct device *dev, int sizeof_priv,
+					   unsigned int txqs, unsigned int rxqs)
+{
+	struct net_device **dr;
+	struct net_device *netdev;
+
+	dr = devres_alloc(devm_free_netdev, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	netdev = alloc_etherdev_mqs(sizeof_priv, txqs, rxqs);
+	if (!netdev) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	*dr = netdev;
+	devres_add(dev, dr);
+
+	return netdev;
+}
+EXPORT_SYMBOL(devm_alloc_etherdev_mqs);
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index c8b903302ff2..dac65180c4ef 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -400,34 +400,6 @@ struct net_device *alloc_etherdev_mqs(int sizeof_priv, unsigned int txqs,
 }
 EXPORT_SYMBOL(alloc_etherdev_mqs);
 
-static void devm_free_netdev(struct device *dev, void *res)
-{
-	free_netdev(*(struct net_device **)res);
-}
-
-struct net_device *devm_alloc_etherdev_mqs(struct device *dev, int sizeof_priv,
-					   unsigned int txqs, unsigned int rxqs)
-{
-	struct net_device **dr;
-	struct net_device *netdev;
-
-	dr = devres_alloc(devm_free_netdev, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return NULL;
-
-	netdev = alloc_etherdev_mqs(sizeof_priv, txqs, rxqs);
-	if (!netdev) {
-		devres_free(dr);
-		return NULL;
-	}
-
-	*dr = netdev;
-	devres_add(dev, dr);
-
-	return netdev;
-}
-EXPORT_SYMBOL(devm_alloc_etherdev_mqs);
-
 ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len)
 {
 	return scnprintf(buf, PAGE_SIZE, "%*phC\n", len, addr);
-- 
2.25.0

