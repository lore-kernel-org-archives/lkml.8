Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FFBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7902920768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItiEF2Rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgFYXex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFYXei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA81FC08C5DC;
        Thu, 25 Jun 2020 16:34:37 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a1so7582697ejg.12;
        Thu, 25 Jun 2020 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zuENK659rKG+a5Ma0hucJQTrbZkZ4ohQwxPoDYc8kWU=;
        b=ItiEF2Rg0/b2D5yRBWM2F2qjCjk7qcvp1qgb7+GNATxfYk2gMrFlIbeGmqjd94//Tq
         XAl1tot+kbcRHyBee72ySllucM9RlGwvi7XVxDlnWdfi3+m5fvLjDrf6t8lO/b3uAIj+
         0dVKQCoPSlWyHusDObaGxk57DvYIQymn60iSNIyjh6T2TcQvn+Tl+jUVLrQgwy2tsdBb
         CM0W2jtC+mmNVCKe9pr8F7vGn5WxPfled/yo9eA+oFKzaNKQcfuACTH1oYeeP84Gph3L
         g0u4hOBaYlURsBO05N2Q8pvVj3nFasqmCELcJxjQvA31+COmxfhG7NZxrR25wlVUWGpj
         5zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuENK659rKG+a5Ma0hucJQTrbZkZ4ohQwxPoDYc8kWU=;
        b=Aek34AaQVdKJ2ghRfRr8XRhC/3HqrSVSVauUz1GmXKA9Om/w9ilKKBioY4Kj/noGK4
         cAX0SqNqjLbNImHqCDDPGfmLBlVAeeSKuzH0kyMVLC8oEsYdKqGxJHlZ9uxhs1iqsFFq
         I+8wqwYeFxoEKrTW298veEDQ1bTQy5pfLLIdDgzEvk3e0R5sBHKRuPl/BXittFnHhBXE
         5+CJikz0oRCKKAYdsB7qhIEBZaR9x5JoPDdPDZtnBcUaoVzJtRbC0g1Tle8nGmDabyG4
         Mj4VXJOMfJyk1MpWnV7QaV7xy2SNhQZrhToAEdhhpeNa1a9SkibLRbD0BTiVj/FEYUS8
         Y5mg==
X-Gm-Message-State: AOAM5325l6NSh3Cy75BRsmLaEAtIoN6r3wO348UYxZ6H34CHibfjruFQ
        8zTme4GLW9pOu0vMWGspG00=
X-Google-Smtp-Source: ABdhPJxrSbfKOi8QkMG1n+35xPESQM1sYQkVh9IPWK7OVO1FpoMgGmV9kSOmyYYbz7Cip/0hmQb6eg==
X-Received: by 2002:a17:906:2304:: with SMTP id l4mr200024eja.104.1593128076604;
        Thu, 25 Jun 2020 16:34:36 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:36 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 10/10] arm: dts: owl-s500-roseapplepi: Enable I2C0
Date:   Fri, 26 Jun 2020 02:34:22 +0300
Message-Id: <564bbfeac8c1ed6f103bf1d9be0550856778244f.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definitions for the I2C controllers used in RoseapplePi SBC.
For the moment enable only I2C0, which is used by PMIC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index 0a916b6c83a8..f5d515ba9bdd 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -37,7 +37,50 @@ sd_vcc: sd-vcc {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_default>;
+};
+
+&i2c1 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_default>;
+};
+
+&i2c2 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_default>;
+};
+
 &pinctrl {
+	i2c0_default: i2c0_default {
+		pinmux {
+			groups = "i2c0_mfp";
+			function = "i2c0";
+		};
+		pinconf {
+			pins = "i2c0_sclk", "i2c0_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c1_default: i2c1_default {
+		pinconf {
+			pins = "i2c1_sclk", "i2c1_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c2_default: i2c2_default {
+		pinconf {
+			pins = "i2c2_sclk", "i2c2_sdata";
+			bias-pull-up;
+		};
+	};
+
 	mmc0_default: mmc0_default {
 		pinmux {
 			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
-- 
2.27.0

