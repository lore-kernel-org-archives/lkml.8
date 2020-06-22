Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCE1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1824620716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="2GosbQAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFVJle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgFVJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894CEC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so14196789wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLmPOYVdaqe+y9UvFG8JqfkTSyC/6Nk+DJj6OjGJzDQ=;
        b=2GosbQAaXiA/JCZI+g11JdzSxLyfN527ZSvaJacFgJHvRnRrhvLEPiWmyJFet6DLEb
         hARZd6Itp8Ly0hWe26lMW947wIjwj7XUtHNewIkPpHDfvslkT6iaZRGzwVc1+AdkfN9E
         77J7zDnRp2cYGiifSFx4PYoShheiwsluJXswRLqt8WCuWUWb6Embtw6Z9mU9W3xNZj5+
         FkCtTAjDmKfNu78ysMk7zie06INp6h4obBSJsjUfKcugxIeYOlBAJsbCB32uIVigpa55
         H1TopXYcKvoxi2/iyqbeMnFO353y8FNqh6Aqq/dcIb9ZhBcMg37bYYwmNiEdTQ26X7wA
         iCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLmPOYVdaqe+y9UvFG8JqfkTSyC/6Nk+DJj6OjGJzDQ=;
        b=CcDqcR/tHzg8ixhzgbBwao3Kqk7dPeZEnbsKmCZP4TaTWkq/9S1maH/rphILSVzGNL
         YLLxX4EIvSsmdgSUiCOXQzsJisW6vhZyrS+UJByeIuV2HIDepmBmWZsxKvlHPQnvBbqR
         a0o2h5H8Q45bn4ObAXC4YpVqnSHCe3BIsEURL0Kmvg4lyZ7814R6i4ppCxcUs8vSJypS
         74koWw5gktNBVHNmxILYxB1FccFsjA1VNsi9fJ1vKVFEaGziA8xuPcOKt+55U+TIfYtC
         7aCk8yESC8I3TWXHlRpOWSRfpH27CnCWvOulVj45IfSktj5MyFWMdCsm2/REL3uLESAf
         MjSQ==
X-Gm-Message-State: AOAM531iP7v0VAv7GkunNMgMMMWnkXZtms7pzFka/FcogaCt2RU+qfkR
        UivB9U0GIwwPc8UX88gRhRS4ag==
X-Google-Smtp-Source: ABdhPJzDaXbcIaH5nH0mryMVoe9yjbkPdBB2oGScnXDu1GQppXU4cUVJs6lCaQVoAVfhbUhW/QgYFw==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr18359072wmc.159.1592818887262;
        Mon, 22 Jun 2020 02:41:27 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/15] net: phy: arrange headers in phy_device.c alphabetically
Date:   Mon, 22 Jun 2020 11:37:32 +0200
Message-Id: <20200622093744.13685-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200622093744.13685-1-brgl@bgdev.pl>
References: <20200622093744.13685-1-brgl@bgdev.pl>
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
---
 drivers/net/phy/phy_device.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 04946de74fa0..1b4df12c70ad 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -9,28 +9,28 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
+#include <linux/bitmap.h>
 #include <linux/delay.h>
-#include <linux/netdevice.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/skbuff.h>
+#include <linux/ethtool.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mdio.h>
+#include <linux/mii.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/mii.h>
-#include <linux/ethtool.h>
-#include <linux/bitmap.h>
+#include <linux/netdevice.h>
 #include <linux/phy.h>
 #include <linux/phy_led_triggers.h>
 #include <linux/sfp.h>
-#include <linux/mdio.h>
-#include <linux/io.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/unistd.h>
 
 MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
-- 
2.26.1

