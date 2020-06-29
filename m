Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F61C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00154206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VvL4yO6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbgF2TO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731789AbgF2TOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DFC0F26CC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so13599018wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hz0iVZuquqaAZG91zpdXr2Uyq4D9Tl6Yab1oO2oLyu4=;
        b=VvL4yO6jCcGsEdtzYiLzKqRQKd+CJHaFyeqJWf7CcFeUmtn3q8wK56Ka3u84RH2/TB
         NB1CiAymp//XtqnFz5/H+ApJeRCUh/SqYJkad+wuFzUrSypwMyamn05nNgh9bLzgio/4
         QBu82NPhZZT4p9ki5bX41KR4ZogP7bglHyn0k1CHfqSTORfkjFmMOuW3F+ZcTgaapo1B
         kH2qepefaYlMyQ/1lvRS5epPqtlijcTGvri5VRyh7kANgzWCz96TsJFHbd1OpXN75CnZ
         b9jNoyvkUTRs0Vyin0UkoI4pBwLsrwpFCWDaCSYqIKh9GuRWgBS4RIRv05e4D75Eph+2
         us+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hz0iVZuquqaAZG91zpdXr2Uyq4D9Tl6Yab1oO2oLyu4=;
        b=Ou9Ycae3gy+0KZZwc2wxWYAJq7WO2UkznRUy2+PMIPDrEUjZuaL80DMhtuwiM+bCmz
         iEKnkkzkcTu6Mon6FVT6M2U8ye4MkUfGLCh5P88XzyVxNtO6so/hep23VgCGtR2RGvLX
         bwJtioG/iuKGiYyrrjYjjGJf35rbad5Ma4IjEr+VZhqRRvAnvYzbJusLkERaQipPQciZ
         HeQDLHeQCKolQhGuEG/BbZQW7ILf0aTiEu90/j355cWY+mSN6+1pP3Sx4MpS0bKgrzL/
         51pyX53zlARo1/wQcUDnjuEdgv850MhuUoVosNQbpFc9YuVl5k3FnsXDpAlDaVX1ZWtF
         x73g==
X-Gm-Message-State: AOAM533sal4ucR7bKWC2Rpxqj/oWPrsVb1m78DOWG4UhSbhScpan2qrt
        5DFs1X/QHJNrrojO6O2IDf3Caw==
X-Google-Smtp-Source: ABdhPJwR+XCjvBHh7hN27yb4wbyQ2NgRHNnJda5bGoNm1j9W8pobPb9+mBDwQzfYrDFvbqSH7NAqWg==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr17632537wma.180.1593432252690;
        Mon, 29 Jun 2020 05:04:12 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id d81sm25274347wmc.0.2020.06.29.05.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:04:12 -0700 (PDT)
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
Subject: [PATCH v2 01/10] net: ethernet: ixgbe: check the return value of ixgbe_mii_bus_init()
Date:   Mon, 29 Jun 2020 14:03:37 +0200
Message-Id: <20200629120346.4382-2-brgl@bgdev.pl>
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

This function may fail. Check its return value and propagate the error
code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 97a423ecf808..8752b5eea091 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11175,10 +11175,14 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			IXGBE_LINK_SPEED_10GB_FULL | IXGBE_LINK_SPEED_1GB_FULL,
 			true);
 
-	ixgbe_mii_bus_init(hw);
+	err = ixgbe_mii_bus_init(hw);
+	if (err)
+		goto err_netdev;
 
 	return 0;
 
+err_netdev:
+	unregister_netdev(netdev);
 err_register:
 	ixgbe_release_hw_control(adapter);
 	ixgbe_clear_interrupt_scheme(adapter);
-- 
2.26.1

