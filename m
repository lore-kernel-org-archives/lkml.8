Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94E6C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69312072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB5hBti5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgGUB75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGUB74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:59:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523EC061794;
        Mon, 20 Jul 2020 18:59:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so19643024wrs.0;
        Mon, 20 Jul 2020 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Re6La/qV3n1ukkxNTX/ju/OZLeqen/7aiCy5YNlMaBo=;
        b=pB5hBti5DRoBjJS0TkkYddmaRA6YmLjbKVqgTjUx/cBp91jDcw7cN9/TagT1y9htZF
         GVMeF5bbvlYerM1+LYKkstpzgn4gJq2EEveijDRFQ96zOyUh1PauLe9Oo2yIOxG3/dQB
         UJNJ12yeYzV4dUIZTXYR47hR4xn6VNoHsRK5caBa+HrFxZwtyBOcz9voMxZ/beH0fb2f
         TBDxkX7Dc1owqPdjtZfaowXJFZRP+SK5Uu9dTJ/HeMW4mSv5PffWY4HSQS9fnBaOyTw7
         P9O5d2Ns7oGIqwoUQhEzqFG3Oj97Jmw+heq6u0rZHZhQ9zpHnqpi49MceoWTP+mfjTOD
         PvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Re6La/qV3n1ukkxNTX/ju/OZLeqen/7aiCy5YNlMaBo=;
        b=XDook0cKrq5OIeeO2BpMMjaqvPCSDdCLn8wa99tFGjbcdJs2M1lD8h2dKyLJFtZ7/l
         5k+cU6KKHghd31XHtZfrlIQXmVrRU2+lbncP1vpByF0APm+FodDIlhyIr4Ff7D27wX3b
         fKSqfEmDQMdMjOBkdOeyu7kSPuE69OwNLgS8n1V6wp61GuumaxiRsVvEIMaJViVKULc/
         FC9X/98+kFhZMLZSyUPlM50t+B5F3bsh79tVQ7BbIILOQGlpV5zKWlE3m+tqqtKN3TZ/
         gCrzT+JYkMNYvHBH92R2IzR61BW24eqR0j82XaRM489yAwHtgv5w3lGRo1GrNpCDSSQo
         dspA==
X-Gm-Message-State: AOAM532xtUt0wywsLGdhMbSJnJ0dSEJGSM+D4DhHfojvgUZr+pH1n3Ap
        h2AbfIE2NeoLKrqUL+jM5RU=
X-Google-Smtp-Source: ABdhPJwdcC9jByWPNIZBOEA9DB5O7rqqiVArp+ZASBJj+ETWteWd4vVfPTsYntco232mpddtdCTd4g==
X-Received: by 2002:a5d:550e:: with SMTP id b14mr16832282wrv.392.1595296794662;
        Mon, 20 Jul 2020 18:59:54 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e8sm34479069wrp.26.2020.07.20.18.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 18:59:54 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2] arm64: dts: meson: fix mmc0 tuning error on Khadas VIM3
Date:   Tue, 21 Jul 2020 01:59:50 +0000
Message-Id: <20200721015950.11816-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other G12B devices using the W400 dtsi, I see reports of mmc0
tuning errors on VIM3 after a few hours uptime:

[12483.917391] mmc0: tuning execution failed: -5
[30535.551221] mmc0: tuning execution failed: -5
[35359.953671] mmc0: tuning execution failed: -5
[35561.875332] mmc0: tuning execution failed: -5
[61733.348709] mmc0: tuning execution failed: -5

I do not see the same on VIM3L, so remove sd-uhs-sdr50 from the common dtsi
to silence the error, then (re)add it to the VIM3L dts.

Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
Fixes: 700ab8d83927 ("arm64: dts: khadas-vim3: add support for the SM1 based VIM3L")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi     | 1 -
 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 27408c10a811..ddfd52b88002 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -293,7 +293,6 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index dbbf29a0dbf6..026b21708b07 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -88,6 +88,10 @@
 	status = "okay";
 };
 
+&sd_emmc_a {
+	sd-uhs-sdr50;
+};
+
 &usb {
 	phys = <&usb2_phy0>, <&usb2_phy1>;
 	phy-names = "usb2-phy0", "usb2-phy1";
-- 
2.17.1

