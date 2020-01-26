Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ADCC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F36D2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/whYoNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbgAZOJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 09:09:41 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34608 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbgAZOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 09:09:39 -0500
Received: by mail-yb1-f196.google.com with SMTP id w17so3652548ybm.1;
        Sun, 26 Jan 2020 06:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0waTrM+p0MNxst8w9Z5JQMayoehG4IUq+pQpCkmEaO8=;
        b=Y/whYoNP5vb88jRBSS1HcGmlCT6z7yURB0WKKZu9ViIR1Ye/BPkoagOfjw6OfNzaL3
         KhDtMjA0we0C62kLbl1CANuDAOtxC0LVFs2YF3I7W37x6F9kH8nID3XO6uy3MyBKepyS
         cuXXX4qPn9UXTvCW5NoalPXUv+8DMHnDaH8Gg8/WyEnaLJJYbVf7yfqZEiJXsR1J+Np5
         d0Vht7U4UMe5Sku2R58lebhMMFygcxKzke537fW7C3GrfWnhgxGpk1tARgl9vty8d/gn
         SGbEwJ8jx1lodEuq07i//FH9+0vdgpLG6s/Cc3CNs2TQr7nIS5edeOo8FIVf0QZz6o6D
         Pqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0waTrM+p0MNxst8w9Z5JQMayoehG4IUq+pQpCkmEaO8=;
        b=NbugRJ9o5YODt2ZAxIPCYd7u5uypkg+C6ZdChtFVdGF6/WrbdfocSu8u+3y1D+ssXW
         1CIgn/IiKRK2DczRsxVu3A1t9BgnxIZ1lq2hgZHz/QR/QaJ8jd9iMKJZ290uTLkdGVqj
         KtgmwY8HHPhilwvrLln4zzSzYyjPMPBOqSYJCMAXlBD93vbzXHWREtjeocmwsVH2WGoe
         cqn0W0goTnUnB4gt4Dj0Zh2TFmAygcOGMuWMpqR9paZBjWeRaCYO5l0MPmC9HK2+kShP
         ZGeyUYQsm3tLNTVWpVHoeH5KzhdA7r6pnNAQ2ghP1544MuSY4nLmJV/NWaWDPQ7WX2ng
         YcQg==
X-Gm-Message-State: APjAAAVvV/7pgouBayDxoFgItxkR1EmQxprzLZlJGlzgn04NksHS5JPV
        IGCx2bE0j5Vv1eG4gn13CDKzOmHB90A=
X-Google-Smtp-Source: APXvYqzlMdUSQYdwJJeaz15msbfWK+Z3P5aEgzbxzTYJ+IDLEk+5tn/w/276UKI8pyR+W6+/cki/aQ==
X-Received: by 2002:a25:d1c9:: with SMTP id i192mr9426559ybg.493.1580047778366;
        Sun, 26 Jan 2020 06:09:38 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id a12sm5237214ywa.95.2020.01.26.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 06:09:37 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] arm64: dts: enable fspi in imx8mm dts
Date:   Sun, 26 Jan 2020 08:09:12 -0600
Message-Id: <20200126140913.2139260-5-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200126140913.2139260-1-aford173@gmail.com>
References: <20200126140913.2139260-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull in upstream patch from NXP repo to:
enable fspi in imx8mm DT file

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Han Xu <han.xu@nxp.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 1e5e11592f7b..679769fe6cab 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -558,7 +558,21 @@ aips3: bus@30800000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x30800000 0x30800000 0x400000>;
+			ranges = <0x30800000 0x30800000 0x400000>,
+				 <0x8000000 0x8000000 0x10000000>;
+
+			flexspi: spi@30bb0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_QSPI_ROOT>,
+					 <&clk IMX8MM_CLK_QSPI_ROOT>;
+				clock-names = "fspi", "fspi_en";
+				status = "disabled";
+			};
 
 			ecspi1: spi@30820000 {
 				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
-- 
2.24.0

