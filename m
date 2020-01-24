Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01A9C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7155C2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qODzbZGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbgAXQao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:30:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45339 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbgAXQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so2680699wrj.12;
        Fri, 24 Jan 2020 08:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CG21ojEDjECTj7XUBPSg8AMrBX1gphh8BPherlSg2c=;
        b=qODzbZGmaHGWOL3dDb3Xify6xkGEbOZyCAuqjPjEIaPY8V6dE42lSq2czZnDgXBpUG
         7auQNJ2tdS+OMddJObOB02bB0h12ZrwpqtFLHg1hlmO2MtcbeSXfw6hwogMvGmXXG0Rq
         hAyyxGmJmWE3AdA/1RdJ7y+J22+B04xgc5Gq0GZa2jgbbH+SMWXEH8LErXNVr3JPEJfu
         Fr/zJqBqy+XGPgKnRqvDGP+OamI41kH+w0KAvqYV+Yb4tjmH6yv2237dABwohRIrA48C
         oomdcNS3Y6flFc9EoLqbLn2zbxr8IstdVfrNwZlNKbGp4mSW/HmCBdJcsYMBgdpsg+5s
         i9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CG21ojEDjECTj7XUBPSg8AMrBX1gphh8BPherlSg2c=;
        b=SbR2M5Bpi6SCtqRBRHHF/kXLy5awuYNPsCkJi6gYBotkwZH2Z3vQK0JLY1XH2NCC7H
         dBxJxF3VEkbiA8DZHcG6ZVDvji7PgTB/M+IE87ERNPStn7ImF1G3u+9wmhhJctSSDIEg
         HS3u7j69gX1sulr4WRPaaPFD7Fi6BelgtQhcTqQBNci3fUCanGaYgqhSyfmFLb5d18iq
         3kCqPCUU6isGQ0qifD7LOlAc8XdiuJVWrB4pVH5b+bH4xXtRzRYCgJxetf0TIEkuvwlI
         zM+eyZTJVpEi/Pyf4719UMpwUSwJ1Bf4F/sXZzCYdeY/oqxwvMkG+0Jul8yCUAUpgvp7
         0H7w==
X-Gm-Message-State: APjAAAXYNHobIYbdadvOeG9Y8IltRUvilCFpbEI0/4Y6X+TfWSMAjXWb
        TUcxw/4Sp0MB28FzQ8lPIoA=
X-Google-Smtp-Source: APXvYqyb6Y4gGv12/4HSD8PzStB662RmnSDlEdKQLoXAtCs6xALQmyQQxt8zVDbHFXtpDTTV1Yl7TA==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr5110889wru.411.1579883415317;
        Fri, 24 Jan 2020 08:30:15 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:14 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 04/10] ARM: dts: rockchip: add nandc node for rk322x
Date:   Fri, 24 Jan 2020 17:29:55 +0100
Message-Id: <20200124163001.28910-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenping Zhang <wenping.zhang@rock-chips.com>

Add nandc node for rk322x.

Signed-off-by: Wenping Zhang <wenping.zhang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 340ed6ccb..2f5122206 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -707,6 +707,15 @@
 		status = "disabled";
 	};
 
+	nandc: nand-controller@30030000 {
+		compatible = "rockchip,rk3228-nand-controller";
+		reg = <0x30030000 0x4000>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+		clock-names = "hclk_nandc", "clk_nandc";
+		status = "disabled";
+	};
+
 	usb_otg: usb@30040000 {
 		compatible = "rockchip,rk3228-usb", "rockchip,rk3066-usb",
 			     "snps,dwc2";
-- 
2.11.0

