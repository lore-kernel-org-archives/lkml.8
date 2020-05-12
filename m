Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2986FC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021B520731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bwgSPVs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgELVwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728362AbgELVv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:51:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689EBC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:51:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so25710325wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0knvu8zyqVx4y2NkIr8lOmrEgshGQH0lpKJi3cjk2SI=;
        b=bwgSPVs5laGpM0d83i3csmznJ1/yWKtFq1xT96YbPjSKVZY3DA/KjehTuB5plFcy6z
         EY3hNdTNGMRO+CSZGMVlJ5g4ACqDMocZYlhOnzK3a5BPn61uwB0dn0LYty6Bxov73Vlw
         1R/Z8XAkTT7HEiHdHVbawuL4MFXn4A6zZa7dk6icq3xN/ilfVGa0UFWWOYODfL+OjLvB
         Zf6N/dMiWhEvQnvKJW/nkzO1/nhdFy4KygJVbKSZpLK/We8me5P197koIyOBNKSVvcgB
         gnrQc1RKBtfdHlw+bmGtYur+Kgv1E0KbZxcW1d49ddhOy1nmAA+YoslbKMUEhIWyYt9a
         +meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0knvu8zyqVx4y2NkIr8lOmrEgshGQH0lpKJi3cjk2SI=;
        b=fFlqZ16T+U/xsnNdhsfg9Nk1Hn+qoXXP2ENb+ZHVF28FS666Wg37cS3eVHjd0yHpCP
         3aDcP/KbXHE7FT8l+4xdIFkmTBCzg9F4bpoQ2/RIOyTtJrOIXFSdOVM3tvNMucGlULiS
         6/TbMMyrf1XWTWL5+4OlCbg5p10+5RHmRFsHZfINvWxUcP3v5QV3kC3CGDjycr/zuU2q
         asZ9KSMY310aUDcVQnvjJbum3BruDR1dd2Z9aOa84c/KsUnOSXmUu6duxqZznWtJIAI7
         NInsbKlD7ZexpGf7cQq8sq2GMnBmw+rg5GJcwrVQ1b2vGjri2/zNCVcrTZtblr+52zZb
         SBgg==
X-Gm-Message-State: AGi0PuY6QL2kSX3hzrbxItn/ILWxzCIxHomO/Zs8LVJib0kdUiTEcbdy
        NHCvjaTNjwCiJ4zOL5yATTk=
X-Google-Smtp-Source: APiQypJ8uUi4vGNBLtT0TFTdWAmJqfDA59+C/Ue8RoCtXdE4ee4Rp809GhvNT7tn2LEUhTnMGBwK+A==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr7874381wmh.87.1589320318046;
        Tue, 12 May 2020 14:51:58 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id d9sm9154234wmd.10.2020.05.12.14.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:51:57 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] ARM: dts: meson: Switch existing boards with RGMII PHY to "rgmii-id"
Date:   Tue, 12 May 2020 23:51:48 +0200
Message-Id: <20200512215148.540322-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512215148.540322-1-martin.blumenstingl@googlemail.com>
References: <20200512215148.540322-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the PHY generate the RX and TX delay on the Odroid-C1 and MXIII
Plus.

Previously we did not know that these boards used an RX delay. We
assumed that setting the TX delay on the MAC side It turns out that
these boards also require an RX delay of 2ns (verified on Odroid-C1,
but the u-boot code uses the same setup on both boards). Ethernet only
worked because u-boot added this RX delay on the MAC side.

The 4ns TX delay was also wrong and the result of using an unsupported
RGMII TX clock divider setting. This has been fixed in the driver with
commit bd6f48546b9cb7 ("net: stmmac: dwmac-meson8b: Fix the RGMII TX
delay on Meson8b/8m2 SoCs").

Switch to phy-mode "rgmii-id" to let the PHY side handle all the delays,
(as recommended by the Ethernet maintainers anyways) to correctly
describe the need for a 2ns RX as well as 2ns TX delay on these boards.
This fixes the Ethernet performance on Odroid-C1 where there was a huge
amount of packet loss when transmitting data due to the incorrect TX
delay.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 3 +--
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index a2a47804fc4a..cb21ac9f517c 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -202,9 +202,8 @@ &ethmac {
 	pinctrl-0 = <&eth_rgmii_pins>;
 	pinctrl-names = "default";
 
-	phy-mode = "rgmii";
 	phy-handle = <&eth_phy>;
-	amlogic,tx-delay-ns = <4>;
+	phy-mode = "rgmii-id";
 
 	nvmem-cells = <&ethernet_mac_address>;
 	nvmem-cell-names = "mac-address";
diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index d54477b1001c..cc498191ddd1 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -69,9 +69,7 @@ &ethmac {
 	pinctrl-names = "default";
 
 	phy-handle = <&eth_phy0>;
-	phy-mode = "rgmii";
-
-	amlogic,tx-delay-ns = <4>;
+	phy-mode = "rgmii-id";
 
 	mdio {
 		compatible = "snps,dwmac-mdio";
-- 
2.26.2

