Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D63C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A08A21655
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD8m14hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFQQtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgFQQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:23 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E105C06174E;
        Wed, 17 Jun 2020 09:48:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x93so2495846ede.9;
        Wed, 17 Jun 2020 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xz8Ly05gyeb5KBCpOokF5fCnIvNh3e8To5d/tCGw6s=;
        b=CD8m14hnX7VcHXJMTVTmQVcGUeGMSX/ov8Q3OW7+n1RHPg/JvcAUOaeJa9NDKiphpk
         ox57Km3KikGeVu/93qmYFniSmpU9y5Knn8zqVdv3siuOirND6juMH5cNWH0MnC4m0cNw
         Gg2qMvgG2is4IrwdLr1zhlMgXJ+HTUPEWtU0P8fbQQ6L+/8r3qYmjO8L0WJ+S5YvX9bb
         L6aEEfdsWdMD8X7ygGBP8tdeimjhtKZi+vhQZppIB52MDKCFvFVa37eRpNcJvYEWo2Kq
         ggYDflt54E2Hv0mnSdfaG5DTf6dYUP6mc9ZgSO3eu7MM6tItMhYGzF4glnBU0SgEvqUH
         zStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xz8Ly05gyeb5KBCpOokF5fCnIvNh3e8To5d/tCGw6s=;
        b=jpwmVhkV0mwqTA1vf6touBA/4vz6pLlRyuEdFOIHz8PCzfNuKCpKw0Xh89nskJHegD
         DcNcU6cOPlrinL7htI9jvspXmjj/j34aYCGMeRaNVjH+XT8voz3xF3Lx9+4b105q6CCS
         X+Gq2QH9VFGNB6t4NqUX4zUzTx5qM0pW419h2pbeeWa1Oity6cr8o+n/Aixri997IImp
         gLqtmmjY2LH/mCmAVxwL55mzhSdQZ0uBLvi2kC1t+5RFLF3ndbeEq0WdmD+qhSPOpDS6
         dTIfXDVNeo+6Ldt+xK6SgrxV3hPvl1SNhrdi/p735ebjKfurFBlKbXLtdxAIs/o1TXpl
         ncLw==
X-Gm-Message-State: AOAM532F64Zr7F0JDFcSZnIMui7DssM7M62bXx1NRf4afgzUivLSiYLu
        X6bsbxW9F2Me9ILxK8hrSMwOI+zHRFw=
X-Google-Smtp-Source: ABdhPJw7R9J5akrcHX2/Jrnt76GIBJaqtZXz4ydlRGQJIySk9dkbir5UXWT8+JNL8Sp76H/boj9rnA==
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr57339edw.127.1592412501173;
        Wed, 17 Jun 2020 09:48:21 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:20 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] dt-bindings: clock: Add APB, DMAC, GPIO bindings for Actions S500 SoC
Date:   Wed, 17 Jun 2020 19:48:05 +0300
Message-Id: <00fe89cdca09f8d6cd510e558c754ec37ae303cb.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing APB, DMAC and GPIO clock bindings constants for
Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 include/dt-bindings/clock/actions,s500-cmu.h | 77 ++++++++++----------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/include/dt-bindings/clock/actions,s500-cmu.h b/include/dt-bindings/clock/actions,s500-cmu.h
index 030981cd2d56..a391d1651257 100644
--- a/include/dt-bindings/clock/actions,s500-cmu.h
+++ b/include/dt-bindings/clock/actions,s500-cmu.h
@@ -33,45 +33,48 @@
 #define CLK_BISP		15
 #define CLK_VCE			16
 #define CLK_VDE			17
+#define CLK_APB			18
+#define CLK_DMAC		19
 
 /* peripheral device clock */
-#define CLK_TIMER		18
-#define CLK_I2C0		19
-#define CLK_I2C1		20
-#define CLK_I2C2		21
-#define CLK_I2C3		22
-#define CLK_PWM0		23
-#define CLK_PWM1		24
-#define CLK_PWM2		25
-#define CLK_PWM3		26
-#define CLK_PWM4		27
-#define CLK_PWM5		28
-#define CLK_SD0			29
-#define CLK_SD1			30
-#define CLK_SD2			31
-#define CLK_SENSOR0		32
-#define CLK_SENSOR1		33
-#define CLK_SPI0		34
-#define CLK_SPI1		35
-#define CLK_SPI2		36
-#define CLK_SPI3		37
-#define CLK_UART0		38
-#define CLK_UART1		39
-#define CLK_UART2		40
-#define CLK_UART3		41
-#define CLK_UART4		42
-#define CLK_UART5		43
-#define CLK_UART6		44
-#define CLK_DE1			45
-#define CLK_DE2			46
-#define CLK_I2SRX		47
-#define CLK_I2STX		48
-#define CLK_HDMI_AUDIO		49
-#define CLK_HDMI		50
-#define CLK_SPDIF		51
-#define CLK_NAND		52
-#define CLK_ECC			53
-#define CLK_RMII_REF		54
+#define CLK_GPIO		20
+#define CLK_TIMER		21
+#define CLK_I2C0		22
+#define CLK_I2C1		23
+#define CLK_I2C2		24
+#define CLK_I2C3		25
+#define CLK_PWM0		26
+#define CLK_PWM1		27
+#define CLK_PWM2		28
+#define CLK_PWM3		29
+#define CLK_PWM4		30
+#define CLK_PWM5		31
+#define CLK_SD0			32
+#define CLK_SD1			33
+#define CLK_SD2			34
+#define CLK_SENSOR0		35
+#define CLK_SENSOR1		36
+#define CLK_SPI0		37
+#define CLK_SPI1		38
+#define CLK_SPI2		39
+#define CLK_SPI3		40
+#define CLK_UART0		41
+#define CLK_UART1		42
+#define CLK_UART2		43
+#define CLK_UART3		44
+#define CLK_UART4		45
+#define CLK_UART5		46
+#define CLK_UART6		47
+#define CLK_DE1			48
+#define CLK_DE2			49
+#define CLK_I2SRX		50
+#define CLK_I2STX		51
+#define CLK_HDMI_AUDIO		52
+#define CLK_HDMI		53
+#define CLK_SPDIF		54
+#define CLK_NAND		55
+#define CLK_ECC			56
+#define CLK_RMII_REF		57
 
 #define CLK_NR_CLKS	       (CLK_RMII_REF + 1)
 
-- 
2.27.0

