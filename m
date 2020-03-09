Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C901FC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35A121D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV9q2Ofr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCIO4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:56:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53121 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgCIO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:56:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id p9so10284839wmc.2;
        Mon, 09 Mar 2020 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3tKnuzyIhGtfcJxu/aubezG0WoRFs1qYucKlMVKdm1I=;
        b=BV9q2OfrSHlzHX6qCKrzGEQjKeDlxcAZVtRQkbfEmTByXGADaW+BbXpcM9GwWnJPRZ
         FXpdMwHptuDMIOhNOdORQtS4sDDjZKQyTkiN3F5u+JOjdYUa5lVaz7kLcw302ngYZ5zI
         rvnQdAtda3PzTUDx9ii01Ery83EkAr7cY6EHXZ1DL8aJ7e6kaJsraNwXHJRvpb0+yo3s
         8+gIzLYmWpwWfJiBxB/jEsJUcgdG9bPrNZ5AKTjus0eWitMIIhlGR+MqS38PI9ryhyIf
         q5YgJfB2+jIpkMWTp7+RIOUIOkyeZ96c+oprOHib2Izhm6vFd+m3AsvW6uaJgLvFLOct
         ccEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3tKnuzyIhGtfcJxu/aubezG0WoRFs1qYucKlMVKdm1I=;
        b=Q0nCqQ5jee1va7JM+VaMnCayuUdYF1A5AjnCJGv8A8y2NeGfb0adKehqq8ij7zdo6M
         QtMeY+nTkcCNcNri1cmS2b+xTrvUHg9VZisAzWsPv91bgLo1pGwt9ZjIQ+56FHhuXyVy
         i1w1EwpFNaORMhvp7MZpHEM8yqU6jxjOW5X76EK0hzia/JLnlAjB54PqLG82Zif+9Pcz
         ZjkvfkBl6zIzgWFu2337wX3PVLvtnEfq5U+OSmaIaZ3rxxJKi7+0b4MaSZrNX7ux99OY
         qCIyT1upmmosWuqdKmhXsAJ9rR/amC3TPznt0sM4qDq8JuN5fqCdbEfOaqM0OnHWUsqz
         KEBw==
X-Gm-Message-State: ANhLgQ3rE/Qtfv5CB62ey8hHHJRqDawgnvwgd9ewj8bRJdUn+HpHdq3q
        udg2p4vpeMxLL0SP6VU8yyk=
X-Google-Smtp-Source: ADFU+vsFZMPaHE9ul1ObY4Ha8+G1xB0jzN1J4j1KiH8cFwP7SMnBpGH03Mp9dx2jkC/jakykSS6TzQ==
X-Received: by 2002:a1c:4642:: with SMTP id t63mr7100411wma.164.1583765806553;
        Mon, 09 Mar 2020 07:56:46 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id w22sm26905374wmk.34.2020.03.09.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:45 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH 5/6] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
Date:   Mon,  9 Mar 2020 16:56:23 +0200
Message-Id: <20200309145624.10026-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309145624.10026-1-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

LS1028A has a functional connection to the eDMA module. Even if the
spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the slots
in the DMAMUX for connecting the eDMA channels to the 3 DSPI
controllers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 515e0a1b934f..18155273a46e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -298,6 +298,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 62>, <&edma0 0 60>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
 			little-endian;
 			status = "disabled";
@@ -311,6 +313,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 58>, <&edma0 0 56>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
 			little-endian;
 			status = "disabled";
@@ -324,6 +328,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 54>, <&edma0 0 2>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <3>;
 			little-endian;
 			status = "disabled";
-- 
2.17.1

