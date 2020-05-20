Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73D3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A175120758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DdsJMtoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgETLZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgETLZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:25:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5362C08C5C5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so2703784wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLB08H4ZIlTMzvj5hInDPm3tTNq7mk/XtYoMNSk6v2w=;
        b=DdsJMtoqD2XEe5pqI+7G1yIhCDJBpTVeqCCKfVUu9GfPyImPik8Xq5o3U5HJwOACo8
         VWicYw4xbBqY4JRDT15bYRlQtEa9idFjml9PKxfc1KOPVYBrehTeDtfV7xR4uWrq0RwR
         1iOZS4oIUEVFcgABFOUhiz64uD3cYjHVLDkIsBT9FyWb2CFLTlcm1JIskeVmIExaQI96
         LvEfFDjUugzJCn5oqI6+tXVc3sm2FQ+nrAFJAlGSaV9hNP1XedyZqGy+5ij+S9sC5o31
         8xOcTFLGbqcqq4S+14hx7O/aecbVf8cluflwtMquahckiUUAXdMjFYXVhVWaAfC+SRi4
         m5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLB08H4ZIlTMzvj5hInDPm3tTNq7mk/XtYoMNSk6v2w=;
        b=FdLFT9a9yBhqh3ybDNinVy29oD8IXS4onrYzpWI2FLeZnDPK4wBRZTHG4ph88mE2WK
         4FkEt19n0H5rXVHxI1LUgrxqyqYolEIFrpK8aQqkZWGtL0CXU6hrcSXC77Obg8jHuMlx
         xCWMOuhVxiqFNwp3o1HUp8WBeygOsRf4SeubuyZoUH3R24eR9Xc9I5BtRiM0bG17t5j3
         87iq93Hlxlquhkx1AX4gXJIKfmaq8GNDj7ZWeAmrRCBwUPPOR4tjzuzPMj6HeJfLXzhE
         8oQgYcHNHeRJhWcUgWf11T1Pqle9K1u+Fe+nTTufEotVk3vvE7mLCJVRYdUYh+jBjSvz
         4HRw==
X-Gm-Message-State: AOAM531L6Tw5bFdNryRI0h+lJwjky2mUnwA4WlcNV1w9M6ZUM9j4g0bv
        aIFNseDPkpwRl8qb3kqGnezejw==
X-Google-Smtp-Source: ABdhPJwwJBc3w2VmTMgfqTJSthEm43N5ws6r6wVEpUxxUeDaTlLFPSxSxxtCGl4iIm9ZRdTzPJlx+g==
X-Received: by 2002:a05:6000:1c5:: with SMTP id t5mr4071173wrx.229.1589973943577;
        Wed, 20 May 2020 04:25:43 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id v22sm2729265wml.21.2020.05.20.04.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:25:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v4 08/11] ARM64: dts: mediatek: add the ethernet node to mt8516.dtsi
Date:   Wed, 20 May 2020 13:25:20 +0200
Message-Id: <20200520112523.30995-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200520112523.30995-1-brgl@bgdev.pl>
References: <20200520112523.30995-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the Ethernet MAC node to mt8516.dtsi. This defines parameters common
to all the boards based on this SoC.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index 8cedaf74ae86..89af661e7f63 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -406,6 +406,18 @@ mmc2: mmc@11170000 {
 			status = "disabled";
 		};
 
+		ethernet: ethernet@11180000 {
+			compatible = "mediatek,mt8516-eth";
+			reg = <0 0x11180000 0 0x1000>;
+			mediatek,pericfg = <&pericfg>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_RG_ETH>,
+				 <&topckgen CLK_TOP_66M_ETH>,
+				 <&topckgen CLK_TOP_133M_ETH>;
+			clock-names = "core", "reg", "trans";
+			status = "disabled";
+		};
+
 		rng: rng@1020c000 {
 			compatible = "mediatek,mt8516-rng",
 				     "mediatek,mt7623-rng";
-- 
2.25.0

