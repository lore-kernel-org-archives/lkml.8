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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B80C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F12520838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttoW4FJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbgAXQaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:30:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36118 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388341AbgAXQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so2723829wru.3;
        Fri, 24 Jan 2020 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hYFbabH/1+eJ5tgZu8gLApj2AMrLFA7PILlgYylYfww=;
        b=ttoW4FJX0uyIo4LvuzYHHh6Q2hKvvZTOmQ1R9vyPsn8wHAhh4UrcWnvxbYR6M8Lw5O
         VnfCpwIO34bxDsK2hKHXo/dc+uANQ3V76q0PsA0QV6N9/wTbxci2fcBVupoItf1DH9xb
         08R1vxFYvluoAXgpJjLElER8668aFhH+gda3dQe+uUOvjvIMWNzEqPHbWxNBl/5G/9uT
         6CdZahcOpZG2SlVgZqUGrXL16FPRdM6wNgimndjOqiwO9OxmPoC0TMvbWSwAdJJrGZnG
         rm1RxYAtmNzQNVKQKAVxuFdGYQ7m+4JyGQpo9UhZRqhPjkFVMQhAq0DU3S6fq4cjPgzy
         Nz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hYFbabH/1+eJ5tgZu8gLApj2AMrLFA7PILlgYylYfww=;
        b=s4aVJ/1RiiR9spMu8ELteomu0xE8hpY+x3kSxMl1MgNMd0m2S3C7jmuco5xrUbzjOZ
         GSPhrgAMsHxlCxhBooaogcugmtmmgsbGG1YvJlw1rsbS5B0l9cM5Rpp820hogde/4esi
         lQjpmTrcKfId+Vwy5VK2gN/cdrHaOH4ltewfuI22zea2TXTaBt9Dj06TSIt3BrgyU/HB
         yg7VDwExKXGcQyiO50xz4lowqm0W2fJ6RWkPtbxUcd13Ex8gBMQtAsoJ8AUWZaQrAkhM
         8GUMWAN7mZ2qUT5sXNsyXbw1Uv2vtLYmlpdPacsBIWeJtyGTUBkMYA8gcAHzs+1wUcQ7
         sjgw==
X-Gm-Message-State: APjAAAW4QUp8E4bxSEa19VWr7RMLreLGQnaQbGyrMBs7eSPxEvPzyuKy
        LKp6ZBEB1CuYbCyuxi6u4Ic=
X-Google-Smtp-Source: APXvYqykWcME/KmUDZrrd7CGyy/O95zP9Xfvvz6gjuR9vTr6EyI82sKy8dHM95zTWTcR0vjltX6/ng==
X-Received: by 2002:adf:f288:: with SMTP id k8mr5516067wro.301.1579883414238;
        Fri, 24 Jan 2020 08:30:14 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:13 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 03/10] ARM: dts: rockchip: add nandc node for rk3066a/rk3188
Date:   Fri, 24 Jan 2020 17:29:54 +0100
Message-Id: <20200124163001.28910-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Zhong <zyw@rock-chips.com>

Add nandc node for rk3066a/rk3188.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 97307a405..221c30314 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -273,6 +273,15 @@
 		status = "disabled";
 	};
 
+	nandc: nand-controller@10500000 {
+		compatible = "rockchip,rk3066-nand-controller";
+		reg = <0x10500000 0x4000>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC0>;
+		clock-names = "hclk_nandc";
+		status = "disabled";
+	};
+
 	pmu: pmu@20004000 {
 		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
 		reg = <0x20004000 0x100>;
-- 
2.11.0

