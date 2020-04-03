Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC82C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E62208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APq8zqvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgDCUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:22:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51072 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgDCUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:22:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id t128so8471547wma.0;
        Fri, 03 Apr 2020 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WS2drkVzUywPkUAraDwxibChKAzL4Ioj5dgxbparViM=;
        b=APq8zqvnzru0QNSUVmz1Bamnt9WwBG0Ba+0o9zlwP5hmr9KKGSVgL1qxQwwWq+YrqV
         JxrqA4jdfSxyIygLsRySycAtz3JbJk1RM76CM7zDmzYh4vHK9Y1FYY9M5JP+8o+9sEHQ
         puINkczY1Sp5tXnYikpww0JpzJOOK9/MG1n3papRoGb83am1XzDV1N+u5VC8ChZYQfhO
         Mdy0V15OW14tmkNe7LY7XnpuqRRlhPshIWzkWRm0C28JyNuSmovLDzkuQgESWJcCkciE
         z1XSEpha/t2YzEhZW52xQc7G+if7YZOUbyJR/SPriub5kHQIuJC7JtdU1vBHxeGGJoH2
         7msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WS2drkVzUywPkUAraDwxibChKAzL4Ioj5dgxbparViM=;
        b=F6hpXLbDLQfpadaEFLnyavFPXSNy/4qU+XMgN3gMwBpfvrtayWsADYzXRyxxvoG8c2
         BuhuAtFk4z0U/59ilyejcBDv9HCPmYca91+rHZzRwTO/y7XxwpIyPB0wEA0i4wSxIJF6
         zZLz2y6EFt7sL+VWOT7GlqF4VbjBXWWqtGr4/uqm/RRKWHtCboUUX/bRtKXcOeuQdA+B
         mQNc7FFLilW51zQks67+3/X9PArvqhavcL4XMtM7TkFkzN8680SdlpZRPYtTVNpbm9DT
         fg0XjokZSbPEXObEcrL+ftJiUrRk9trHQsrKW2bPWU0eSCUwY/TN7+KDLTUQgUMWZDLW
         4waw==
X-Gm-Message-State: AGi0PuYhC9ypq1A06iaqxrihDOP7Jdsk/taraDEsLZLokPZoZEoYA+L8
        2HftOF2BCU9urVULbwbueeY9gCu+
X-Google-Smtp-Source: APiQypK7NTafTkpGY2knIzDtkbi/m/65q+yopgUPWyBDnGa4LDCAPZpjpPNjHOgsFE+8seD7lY5AhQ==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr10095222wmy.140.1585945347470;
        Fri, 03 Apr 2020 13:22:27 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id v186sm12715529wme.24.2020.04.03.13.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:22:26 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] arm64: tegra: Add native timer support on Tegra194
Date:   Fri,  3 Apr 2020 22:22:08 +0200
Message-Id: <20200403202209.299823-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403202209.299823-1-thierry.reding@gmail.com>
References: <20200403202209.299823-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add the
device tree node on Tegra194.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 019f66f03a97..a0a5b44ff9bb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -213,6 +213,23 @@ emc: external-memory-controller@2c60000 {
 			};
 		};
 
+		timer@3010000 {
+			compatible = "nvidia,tegra194-timer",
+				     "nvidia,tegra186-timer";
+			reg = <0x03010000 0x000e0000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		uarta: serial@3100000 {
 			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x40>;
-- 
2.24.1

