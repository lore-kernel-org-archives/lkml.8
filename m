Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B46C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06F920663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bhKeRr58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgF2UqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgF2TN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751D9C00E3D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so13820551wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcgV1UNGKm4K4QD82m2Udcr1uoHRVa+LAuPxtdS553M=;
        b=bhKeRr58llmIS9VKgVFyB6mAC7XOTgR+vC4RJRrwyWIr5sh0Pep1GPWHLAgwGzpwAc
         MGPqTye+7rp41hJ0FSDOVSH+p83Zt/3ZFe7cwcMshyi04ZZeZpr/muoHkBS6d3gEFsqC
         gL9tprIlM/mTLQfg0PC3ySsy+WIP8DkfosTU4J5ojN9iLGjwYxKS/OZIJyN/rXYZmrgt
         b/PirIRVemOkzEXXswFvaL53RJkfuhhqpelHeBzIZhnZXZ+/gqm1xcXkTKom438Uu5E3
         dMbEgvGvBvjLo2LDuXkeV0gRZt75ZzMGwBn8D2w+jiehl1HPOVrLev1YO1EDLxfeZxlK
         6RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcgV1UNGKm4K4QD82m2Udcr1uoHRVa+LAuPxtdS553M=;
        b=ItOpSyTh5eFrI1l0MY4fV7m4JLge83kV5z9OREKDuJqJ8C2Yf9pmEzG98BUgrER2vC
         oI86xeh5I3tAan8p+RyMP6YSCKt1c5tFDSid8JOL1y4vfn1mx1Aag5XuU+eECoIgnP1A
         VEhoZLTbKLa7Roq38nT1OxqmR0TWZ19CtssXhIVnkr4DhT8GEbly+103YLJHImMxZA/4
         Ts+0LFJ8QfMpHP+F42BBl9r0EZRZLmOfXjqGfiiqCAerBJS5xBqXlvTynsG2BzZArtlq
         hPhjLlHY8FqYPjyxgywzm2tb1hFLdGSXMz/Qm3Ta+TQSERxn0W/6Vw1iayXnlwn2vKT2
         ErQw==
X-Gm-Message-State: AOAM530VuaPFcV8L0vHYdabRHY/gjZizwkhneTJCEhK15wcmq5vTvmGw
        yeQwtMKNcWmLr6pPyhvnHqQ+LQ==
X-Google-Smtp-Source: ABdhPJwlADkzSAVFbK3JmZ+v+w78Y8jXO+OaWZ19/qk/J/aygV+blBomdVtOyQPcaDByMnxBjS6U2A==
X-Received: by 2002:adf:c185:: with SMTP id x5mr18180867wre.403.1593432260279;
        Mon, 29 Jun 2020 05:04:20 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id d81sm25274347wmc.0.2020.06.29.05.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:04:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 06/10] phy: mdio: add kerneldoc for __devm_mdiobus_register()
Date:   Mon, 29 Jun 2020 14:03:42 +0200
Message-Id: <20200629120346.4382-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629120346.4382-1-brgl@bgdev.pl>
References: <20200629120346.4382-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This function is not documented. Add a short kerneldoc description.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/mdio_devres.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/mdio_devres.c b/drivers/net/phy/mdio_devres.c
index f0b4b6cfe5e3..3ee887733d4a 100644
--- a/drivers/net/phy/mdio_devres.c
+++ b/drivers/net/phy/mdio_devres.c
@@ -2,6 +2,13 @@
 
 #include <linux/phy.h>
 
+/**
+ * __devm_mdiobus_register - Resource-managed variant of mdiobus_register()
+ * @bus:	MII bus structure to register
+ * @owner:	Owning module
+ *
+ * Returns 0 on success, negative error number on failure.
+ */
 int __devm_mdiobus_register(struct mii_bus *bus, struct module *owner)
 {
 	int ret;
-- 
2.26.1

