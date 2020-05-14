Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CD2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E901820671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xfbLUg+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgENQ7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgENQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:59:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED229C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:59:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w19so18947448wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAX7gpmF0UnCkHoN2iXHQmoGmy8q2rcynSEgVQObiis=;
        b=xfbLUg+P7fleiOX59Muih2DpZDUYTCOghJaOg87Yp3eymeIdv/DJ8ELLCH8YbuwH7U
         ynADSqdccBZ0benYeg1FEBUKSFAVL8aUQzoG9LfSlI7maLNuuluxCpyw5nImsoamzaJS
         TyJeTc4Ufs7WJ7ipEVIzrslyy/braWeBnXK3BpHNscvBRwV7+hfE71KcbUxGVIfNV32N
         4DGi+Tp71HhfF6WYl/6PsQKTnDNV5w5uCf8jJgHgcDwDkvsn5ZzkB0dX44lRjUGpGRnq
         f1PuivBfnw2NOVjezMsUOXzrMTXhyI12g8lC7xJgFkBLVdeSc5zmNzGkbg/16CTGtwwr
         hViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAX7gpmF0UnCkHoN2iXHQmoGmy8q2rcynSEgVQObiis=;
        b=Z0YUhD+qKem2YIEt79fQ/QOEPCqIBekttwHC2G53WT38oPvoI+ZDk7zVrfCVK1Qffs
         pcCXcEmlHgd9ui6QEXmsnRvPhZ4oBBE1yZdDGNbfLtHA36o4MRG8QybazshM7GpyktAp
         Yu/qlosVnwYAB8Z0wA1hCbXphpJYiChrzAGloQS/MYpvL6ZdMsKhr3e8wwh+f6MEyKQ2
         zlsf+z06bV7uiKGMLtv8tH3rNdQ6644u0VrQJuPAY1dOnCDCV81tL11Q1OGhuAM6SO/T
         +pd6LL8/Lw1RVCDjELPJ9H5MrrtaXhhTHYHF0GV+rnY3gTTPKiv8D8pZf/S8dsdY4HbN
         6wGw==
X-Gm-Message-State: AGi0PuZPRjekMAySX7vTrZmePhqwKiFMey/DGTho1SF42YKPvqZAC9LE
        C13tVogF1cT64vTEwQHEIeE2GQ==
X-Google-Smtp-Source: APiQypJXwW4bMxdrz1XTj4O2wz2iHy1Vb7odBH9Sr2FK5n9yMLjLxX87IGclvxzZ4cfBIhv3AugxPA==
X-Received: by 2002:a1c:1b0d:: with SMTP id b13mr27066878wmb.171.1589475584582;
        Thu, 14 May 2020 09:59:44 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id b14sm29744078wmb.18.2020.05.14.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 09:59:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] net: phy: mdio-moxart: remove unneeded include
Date:   Thu, 14 May 2020 18:59:38 +0200
Message-Id: <20200514165938.21725-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

mdio-moxart doesn't use regulators in the driver code. We can remove
the regulator include.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/mdio-moxart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/mdio-moxart.c b/drivers/net/phy/mdio-moxart.c
index 2d16fc4173c1..b72c6d185175 100644
--- a/drivers/net/phy/mdio-moxart.c
+++ b/drivers/net/phy/mdio-moxart.c
@@ -12,7 +12,6 @@
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
-#include <linux/regulator/consumer.h>
 
 #define REG_PHY_CTRL            0
 #define REG_PHY_WRITE_DATA      4
-- 
2.25.0

