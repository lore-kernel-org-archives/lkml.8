Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5987C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D04820704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9DAU6TT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390213AbgAXQaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:30:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37685 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388920AbgAXQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so2724354wru.4;
        Fri, 24 Jan 2020 08:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m4uH+eGyV8vifXYAWHIYcpVOQ6Xb6SMallkR/M4Jzo4=;
        b=N9DAU6TTlHbKO4obm1WBB/8OVkXS9wDNxNScvOY9VzaXFRFu/d/gM8Wp4t8CmSJH6R
         kHQHSuTVqyVx6j2LUZWROmvEjPlv2DOwKeavv4wLM8XBO6nykxGMc3v8BKERBTVCoN0v
         J1TI/MM5xTGDHkGbpZ4mHIqv+Mb/yFqty+XiIUpARwIH2EowSELTyC2EsD4ifvA511ho
         o56I+WptcLEhBOpW1zTOoANtU2wjq+Rb84nkbarxGHN6sniP2hWtV+V4N0iKHxdY35MC
         ZWmtfkj27qFJuLxezcANfWgeyFmKVekOAumEjq3oje6dMAbxfbm+Fk2rRYn9aLRYWws9
         dA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m4uH+eGyV8vifXYAWHIYcpVOQ6Xb6SMallkR/M4Jzo4=;
        b=DQ9OHi9nz4bvvMoL6Eh1h8GmKoPu5TRN4Hc8MC3jka8p+OKUkONBR6PxX73HkwSnO5
         f5ljdlwOlp7r7GpzeQRnTh8EQttr8f9m1hQBVns1NRXaWlLnl1le293Nn5P1QstkRbfA
         eYO9NZnUt2p5G14bshwhrZRvc7Y9vX8UITZTOIb22EcH7gXBQtH43dlPH1YMxIUKZSoJ
         9Tjm83LYyh8kOHRL7X4ynnN8uD7ZltYfbDipkVLw6s/ySAeYzarJ5YDrhgHddf/RkWeX
         mdOZVG4oWE3zQHXgIUCiWnms9+BW9OCpU9m9+1VGitM++SWC14IApTgVbnZrSBHbwtg1
         RLDg==
X-Gm-Message-State: APjAAAVzVjEFymxDje28n15ChF8yK54ZBlQbV++WagYsllebFtBfpXMf
        +ElxIWosugIgEojQRjMjO68=
X-Google-Smtp-Source: APXvYqxD/FBeeFd3slUqJ5Vb/20lkgUjc3N2O4Q64GE49ZY7NRKOlNPUIY+qChA1pkM9tk0K61fYoQ==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr5156235wru.173.1579883420073;
        Fri, 24 Jan 2020 08:30:20 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:19 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 08/10] arm64: dts: rockchip: add nandc node for rk3308
Date:   Fri, 24 Jan 2020 17:29:59 +0100
Message-Id: <20200124163001.28910-9-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dingqiang Lin <jon.lin@rock-chips.com>

Add nandc node for rk3308.

Signed-off-by: Dingqiang Lin <jon.lin@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 8bdc66c62..a6c98edfb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -627,6 +627,15 @@
 		status = "disabled";
 	};
 
+	nandc: nand-controller@ff4b0000 {
+		compatible = "rockchip,rk3308-nand-controller";
+		reg = <0x0 0xff4b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+		clock-names = "hclk_nandc", "clk_nandc";
+		status = "disabled";
+	};
+
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
-- 
2.11.0

