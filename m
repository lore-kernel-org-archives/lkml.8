Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D5C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963632076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNEe8AGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgGRFkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 01:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgGRFkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:40:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19801C0619D2;
        Fri, 17 Jul 2020 22:40:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so20411935wmo.1;
        Fri, 17 Jul 2020 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pHFn3qli/TjcBYDvPYIZphMr/9QXXE2rgKtRBMGR0ZI=;
        b=ZNEe8AGalV3orNvMIKrPzBzMHPZqcNzooMpw9EXGTVPWf/dHyyk7xaLEQngOcZya/D
         pThmZNBRstvLjKQ6tm4kOiP/1sIOh229jlklB8JcibilNTBrjJc9e3KYMA1+6BFLzWpa
         gLkz1wib73q5Mc75eqngEnfubM/dTp4/7zHe4dwdtRaFLzQFGe+UxqqWfVZqqXZRts+7
         oWvf7g4Cq4q5ssPwTbKzqfDULdOREybSIRkN54yO6yUcoDK9n5uEePTDgPNkeEfML/U0
         Hp2cLap8SdlW1XwjSjiIQySVC/qRDXnlgkMPcgzzozT6Mf0N0hGyLETi+1EwLUb2Cz8O
         NOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pHFn3qli/TjcBYDvPYIZphMr/9QXXE2rgKtRBMGR0ZI=;
        b=VG/nDghgGTcHZVdaPn3v152K+7vQZIq28oTYPW91K8b4LBIdGYXP6mLqpkITl7WZ3x
         G2LaoY6seZiQGRd3FoHPn2jsHiPXzu0HumdnfC/VZg3CQyrrCEyhHoHTdNE31Rz7vBnt
         KeZnxwNRcKRTVWEwvEFlN8ir5E5H2coXzS0EQ44zFcv9eEbdnTkC55aWiPacKMiGMsXL
         +Unx8fjvhcHGy/1NGMPDCTSut6S6OlxpPHKL6yvywmsvABrqRlngzj+SFDcIKWx9dG2t
         sSG7zLU9bcHzcA90CJP8H0K68t4zv3ih61n/Vof9uUmFGcGbP6VqxhRk9WBmDSEd4mHt
         IeMg==
X-Gm-Message-State: AOAM531sMZRKBjciApM0OrNrcuqOvE/VW41S9WTTSNQUyGbadcXIBxZ5
        4d6Wg2SdSoPA68wGes5hCKY=
X-Google-Smtp-Source: ABdhPJz14TbNNNBW+nTTvXOaLTqyKPD9qyFpCxpQurtQUWxPrmzmSQhDYHvM1885ty1C+zFmLOaYTw==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr12739965wmi.85.1595050844672;
        Fri, 17 Jul 2020 22:40:44 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 59sm19361711wrj.37.2020.07.17.22.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 22:40:44 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: fix mmc0 tuning error on Khadas VIM3
Date:   Sat, 18 Jul 2020 05:40:40 +0000
Message-Id: <20200718054040.3996-1-christianshewitt@gmail.com>
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

Signed-off-by: Chrisitan Hewitt <christianshewitt@gmail.com>
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

