Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001BDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58A220675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HEmrcvM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgENIAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbgENIAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:00:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93690C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m12so24245023wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLB08H4ZIlTMzvj5hInDPm3tTNq7mk/XtYoMNSk6v2w=;
        b=HEmrcvM1MOsX04VShtRQfw8wX95eDldjdaz2ns3Yi89VAbdiUxlVX87C6nzdephlup
         xHJMCz6e0Z5r01RY+lzPy4wHor8E2bIsMkvwpFAKFaBcg96Yv1a32HR47oaX+TXsTmxa
         tZ7BQztG8IQr3XPcRIMaWryF7+6ihgGVZH91ZuakknnofVFjDvamLmrgqsjevIBTIecd
         D//XX+ZSlcunyYyK8Qs563ju1w+pRSmKcL46Gx+DIpsLzRGBl4u61KIqVfRWAeiKOdzK
         G1WrNxSeiQ3W4YBBAZ1ChwL/wg09tzntcjmSjs7CEdvDYc5GX+643Ls0LEsYi8J2650b
         emRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLB08H4ZIlTMzvj5hInDPm3tTNq7mk/XtYoMNSk6v2w=;
        b=ZKRQm1qq1C90tc6ixo4FMv9IlLn7hD6Xn99PIS5YVyB4Iz4Pv0wREb9+V3XTQ5uK8g
         fZYPDSm5f9op2Ned10bQy2Easxy4kLDvjvj1WoddwzyYiPk7tyApRclxhZ41QAr2SnEx
         c0SbcCvsGdPFoiENjlpCGs/orKQlXr2p3UVwrodRgeQk0DqZVLQTVCR1tJUcGe9pNzci
         asoC/mUqzb7ZOP3B1BIf5duGkHSVsSkxNJYcCMqcZlir78vkSoSFQImwI+XbEYA/Y9p+
         z482xpzO/aKvWMYITZLRyriaC40EULi3/Jb3z940XpWuJ6xylirLxCLKRZFb/voT1juE
         vzOw==
X-Gm-Message-State: AOAM533E0J2AHu3AZ61SEti2ZCFYiqvrA725edVniULbddeiBGdDXW24
        GCoNvWwhYKSN9MIv2pCYHy+Xlw==
X-Google-Smtp-Source: ABdhPJyVjd4+wt6kvtuaiL+tPilOBT+IL6rIp/TSm7VviUo+tkETpkHnlzpF7kAbFINWELiacsGnAA==
X-Received: by 2002:a1c:3206:: with SMTP id y6mr10610900wmy.12.1589443223305;
        Thu, 14 May 2020 01:00:23 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 81sm23337446wme.16.2020.05.14.01.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:00:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v3 12/15] ARM64: dts: mediatek: add the ethernet node to mt8516.dtsi
Date:   Thu, 14 May 2020 09:59:39 +0200
Message-Id: <20200514075942.10136-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200514075942.10136-1-brgl@bgdev.pl>
References: <20200514075942.10136-1-brgl@bgdev.pl>
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

