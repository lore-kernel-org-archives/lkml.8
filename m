Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A720C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF4E2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="t16Wut0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgFVJl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgFVJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so463033wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWTSazz+MH8fIE1pxN8/udTqpqfFld3u9PzBFouqA2o=;
        b=t16Wut0yPJpepbHcpqARVKDpzBMGDxgc7F1z6nRGLUey6JiRiIkb9NbOTM45ahU623
         AC7aMzDns4FT3n4nUTZGvVzerkg/ZvATWL2ugj0j1n43aWrHWCoJGMpHWAiSVhrlaDqe
         opttE6VqLvuNr7qLM6l6kbpsm7ZUKZUNO7MvE/EUsi7ztdZgkj7icEOUHoe0nL++ursA
         EkiCVMSE2m5SFwOcdT37fnP2nHjMC7+/7892TlqZrNOEkiyZP6OLCqA7u08kQYXOC1kP
         PVs4I3n+JcIFdm5UdFuB4ua1UvQ/mcbIuxlzt1q5Zybg3U4LsuPSY3nV25bLhmQ9qanr
         +rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWTSazz+MH8fIE1pxN8/udTqpqfFld3u9PzBFouqA2o=;
        b=PAJvLV8b79YJLe6tz14sc4giF13FAVde8SoRbSI6rTydJe6QOprPrrDsQ/HfB4iSnj
         O4s8J3ZNDgF8WInPmeIwBLueaGRs4oc0KOBG++R8HOx71HolHmbs96cvL8MR3ENtSTaz
         CPirIQob3Uha1VZcx4kO48pXN4WWC2+u9AMYIYhwCt8M1qz2kleCXhzKJ+bLV+bCPqG7
         a4n4uKyddMFMLWeOj/pw/0JXGdq3OV/5X7q4OLpR6rg3/OGmSgIyOvejwuoOkyohT8tM
         HEuB3DK4NxvX/+V2IdQFFUnO2M/jNaMDV7gELSN95O8lFwFdzcdAIcl9xX599emGG/vK
         k7/Q==
X-Gm-Message-State: AOAM531K8xllfSi3BHmYmS4mlzgSezrIFRTY2zaYtWIyxy4pp+JT6J8a
        sj0B500dfqRZKArC59RvvrDDUQ==
X-Google-Smtp-Source: ABdhPJy9sIiwuZldm3Z2QGhtksB0AjdTqLAwTXV+hFjc1BN1cQmzZ22mvJNgWLCUXRVjCMY3/bgKMw==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr17312428wme.34.1592818909166;
        Mon, 22 Jun 2020 02:41:49 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:48 -0700 (PDT)
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
Subject: [PATCH 15/15] ARM64: dts: mediatek: add a phy regulator to pumpkin-common.dtsi
Date:   Mon, 22 Jun 2020 11:37:44 +0200
Message-Id: <20200622093744.13685-16-brgl@bgdev.pl>
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

Add the appropriate supply to the PHY child-node on the MDIO bus.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 1a6998570db2..0f5fdc5d390b 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -206,6 +206,7 @@ mdio {
 
 		eth_phy: ethernet-phy@0 {
 			reg = <0>;
+			phy-supply = <&mt6392_vmch_reg>;
 		};
 	};
 };
-- 
2.26.1

