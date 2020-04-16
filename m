Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A96C3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655AE20786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcXi45OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391537AbgDPSbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDPSbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:31:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE70C061A0C;
        Thu, 16 Apr 2020 11:31:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so5975353wrw.12;
        Thu, 16 Apr 2020 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Nyh5TNzdvU4zTksMNA3H/k/3n0TfFI0KKcct57bE6U=;
        b=CcXi45OFPvGGii0CicbOzHItjo336x/+aoM0fXl2270MtrHa7/RdnKu6xh074BgXL8
         xW1WGLNVAK3Uw8D6rqWF9XyMIcz6r5IjKjwWh/6IWLzoMQYjxcsF17q0zq238fLZis2e
         PuY7BRjF1r0BKIDLkjrIFjDxqk/yIsPPLgQ9On4a/63cuphMYpbaUDWfW8en/OIj9zyx
         EJAQC3IB5IrooaB7r6wqc2MJk5opbcxcD4ekUUIDoXCtSTnr9Kcagj0zXPs8N1zE3VrV
         QQn4hpVVo8KixTZ9Vd0LZkKiBtsk8h/K9V6IEw3ZktKFFlHjCw+N3D5DbD4e8g55yVjX
         pzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Nyh5TNzdvU4zTksMNA3H/k/3n0TfFI0KKcct57bE6U=;
        b=babDeSodj8c+ISSCugMLIi5keL4zuVJel67HrzSeovcGt9JuK42Olg31fWad7VJjQz
         7ovUIPZaTtweaFv8YJwpwTBM4EwGFdszpQdlf+oyW6eYcpu2qMPfx4bdcmP+LnAYVV2d
         2WcfzVQmXp0pJl5AH/7eHpD87sct4AykRGKm9L2fswSu0jD+Lu6IR08m/+Rksp2eH3Zk
         6KYgHyoukOF8Tb5+9d59iLbrWzbVKm01cXxUYFef/s5N/qGHh7anQWZbWihhs2cTshEB
         ByKCvTr58148LiqB9BA0J+4SJR4cNsT/+LgJiiNNqk/+WKEwO3GNLN+fH1Tj8e7EXYld
         2pxw==
X-Gm-Message-State: AGi0PubGphBVC08iEHdp+MZ6OqR1643Yo3Gx2u+CIj6GhE1TUXCdOPxf
        6LmxnX3+JJHYavxbCl4a/eE=
X-Google-Smtp-Source: APiQypJzkj+OxyfIBJYhLSIraECWen1zsYiNeLEHY0lY8SqIgnmWu0l8dwfVdsHu476GvPjWRqIFdw==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr34607368wrt.32.1587061861677;
        Thu, 16 Apr 2020 11:31:01 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a20sm6098495wra.26.2020.04.16.11.31.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 11:31:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add bus-width properties to mmc nodes for px30.dtsi
Date:   Thu, 16 Apr 2020 20:30:53 +0200
Message-Id: <20200416183053.6045-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bus-width' and pinctrl containing the bus-pins
should be in the same file, so add them to
all mmc nodes in 'px30.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 4820edc7f..b66a4ea9d 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -928,6 +928,7 @@
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <4>;
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
@@ -943,6 +944,7 @@
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <4>;
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
@@ -958,6 +960,7 @@
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <8>;
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
-- 
2.11.0

