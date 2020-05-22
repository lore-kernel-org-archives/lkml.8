Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D57BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1CE206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Sn/1CrJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgEVMHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgEVMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:07:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3317AC08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:07:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w64so9557818wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLB08H4ZIlTMzvj5hInDPm3tTNq7mk/XtYoMNSk6v2w=;
        b=Sn/1CrJlRf1gaXAt7BzExoLU8RuOHChRbTQLpaUrzwFYqGsov68ZYpiUu778e1h74U
         EG8H1AkAkI/Dvmx5QKB9iXaqQh4CeJTf3KZiOAOTno9BIiFgfkjQQ3V4IRkEH4GAPrLA
         maiOekJ94V3I7H6hUXcjbEOxaDc55leACFe7VuKpdTyg7O80elge/QfPQjJeWku+bhMk
         /BOFybbSX0X7y3Qvi81k2fAIAzdXkIexmNVingkHUbHWITInUkDyAjfPXgMuJPMXVerx
         QZT3djIizjK6MVClkQM2eCBMIBdSWPweS9uJyC7sYma38spotFpi6WHBHlfhEvvRmcPV
         FXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLB08H4ZIlTMzvj5hInDPm3tTNq7mk/XtYoMNSk6v2w=;
        b=dh/PE9993NCmJdC6G9/2IKq0blf229vloJjsqPgmwrxbOd63zU+C71jGbthIHnKUvT
         YDm5894ZH9/Qn1JoiGKFOg0vgA5EVKfDmQmL1oK3ZHrp8DbnP9Dl8omf9fo6NQU3xrhs
         fejVj7/Jd95xUluuGwVEjCOF/NhFGmxjp6t5+/UHWNp1Uzp4wrp0/zwNVbn1g+CYJHcs
         aLq/begyQXAaSzLksuITVhaqbUcOtx+0CV1sTk3AC+MyNMdjazZjWXzBiUzNpxuqkD3X
         xanHL3E0SDpnCkbS2fojbaFN303sy8jbKklO8Ukd3kBqozlf2RNMltGJNzrpOk36NPyY
         /J0w==
X-Gm-Message-State: AOAM532tOHf3egCBE8ojKli8KYo4h1YlM+uofuFZ8QmteBnAvBL+tuLa
        4aMOkP8kJHQOJRToF5W7Azq6Uw==
X-Google-Smtp-Source: ABdhPJy2DwWygp0CZukF1c5MDhWbG3suEHoLEk61djOMVZnj0q+0DRdXHTp94SuAfm6DtS52JEtM4Q==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr13962835wma.106.1590149252025;
        Fri, 22 May 2020 05:07:32 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id f128sm9946233wme.1.2020.05.22.05.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:07:31 -0700 (PDT)
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
Subject: [PATCH v5 08/11] ARM64: dts: mediatek: add the ethernet node to mt8516.dtsi
Date:   Fri, 22 May 2020 14:06:57 +0200
Message-Id: <20200522120700.838-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522120700.838-1-brgl@bgdev.pl>
References: <20200522120700.838-1-brgl@bgdev.pl>
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

