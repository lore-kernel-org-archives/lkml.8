Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2612421548
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QbTK/jye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgFRKJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgFRKIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:08:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB0DC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:08:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so2443972pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9ZVEE5llXq13I1PufGR5qegeo37MSzNvw9PjU0Fjk8=;
        b=QbTK/jyeJEquEVJY7l+T6/kG04+mjbA9G/JwcvZDLZ8k+okay/dSxqJ/GZK0me6aPC
         T0/+LOR92quFHAlm1dVV68gOZr+8q/YvKBpK2wvxKO41bhYSGXU+4ZUQCTXjBFjTOyEq
         R3MmYnYx6U71ysADED3OWBNbxPvBQAmA2Zurs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9ZVEE5llXq13I1PufGR5qegeo37MSzNvw9PjU0Fjk8=;
        b=tLBoK23vFWDXLa3pu05ca/zpI5o2BKrKQZ+hHrtqsTbijhOw7xaiPGM0MZPmgpY1Kl
         j3erxjlDHLaG17CeIE819O/4vP15oeMiZ2cYdRsMv1yo2ZHLVBUgxRZyiIm6BExlFrso
         4NkCKp1nJe6/sYKJanr8A5aepSYZscI6ok0QiHSRlpwO4cL60jxVH9j86MStSvu+j1tt
         rvFIOYnAFz0996qtq1JgM85K/cnZkEWBfA1NgYw8VbeKT8fdVmN+UC9fPlXpOv7YwYiE
         XOTeHucsd7JKJ7LHbdC2BwIowdBkm2MgdZBnQznYZyB/1mtYZKLJvm7Mw7r+g/LOW2+9
         7xdw==
X-Gm-Message-State: AOAM5337IVX+gG/6pQGjjj4q0DxJ0Uv5i83gVb7AMoRRrtIyz8+f2kMR
        wE8TfIpqEnoCdlGnPuCtrchviw==
X-Google-Smtp-Source: ABdhPJwZhtlcgjGat0WBZE26aDW8H3kZ66NuB49AdKJ182thmlVQ7g0Vc4xPRCKoybJ9oMJ6otar7w==
X-Received: by 2002:a17:90a:f694:: with SMTP id cl20mr3587632pjb.141.1592474933565;
        Thu, 18 Jun 2020 03:08:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b0c7:f192:869b:df87])
        by smtp.gmail.com with ESMTPSA id o16sm2190793pgg.57.2020.06.18.03.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:08:52 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Tom Cubie <tom@radxa.com>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/4] ARM: dts: rockchip: radxa-dalang: Update sdmmc properties
Date:   Thu, 18 Jun 2020 15:38:29 +0530
Message-Id: <20200618100832.94202-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618100832.94202-1-jagan@amarulasolutions.com>
References: <20200618100832.94202-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radxa dalang carrier boards are used to mount vmarc SoM's
of rk3399pro and rk3288 to make complete SBC.

Among these combinations, card detection gpio, max-frequency
properties are used with rk3399pro SoM but not required for
rk3288 SoM based on the hardware schematics.

So, let's move these sdmmc specific properties on associate
vmarc dtsi to make common use of dalang carrier device tree file.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi  | 2 --
 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index df3712aedf8a..3e54f38f0ab6 100644
--- a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -52,10 +52,8 @@ &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	vqmmc-supply = <&vccio_sd>;
-	max-frequency = <150000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 0a516334f15f..6fd17e8a815f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -317,6 +317,11 @@ &sdhci {
 	status = "okay";
 };
 
+&sdmmc {
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+	max-frequency = <150000000>;
+};
+
 &tsadc {
 	status = "okay";
 	rockchip,hw-tshut-mode = <1>;
-- 
2.25.1

