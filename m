Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C135207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe/bjDut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405757AbgFXRsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405696AbgFXRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:48:04 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA10C0613ED;
        Wed, 24 Jun 2020 10:48:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a8so927286edy.1;
        Wed, 24 Jun 2020 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xz8Ly05gyeb5KBCpOokF5fCnIvNh3e8To5d/tCGw6s=;
        b=Fe/bjDutnwOqo93w+Xjty82lq2fDYEmrAOKpCMovNUMLb+3FAiXqih2FNgfZ6vthki
         ytYRp7jxYrfwADDdUI5gTBRZ++n0JILPb/zBlQm42x4iZLWu0uaI3z96bAgR58DNIsV/
         3Kx6u3c342922rGTT49qVEz14r4hQNXqHE6QgIBckrhwfx+SWVLvLLeoanWEF6DVDcwt
         KGuVWxFGOyTmBZHKwah0d39EX8RHP+n2rcjYu1nHsvQGdSZCQ+EU4HAq6k3yvZxOHG0B
         wUHYP5LysSO4rSutWx7BplzlPRDSlPhl35lx9cf6jnwowNFVapXY9it5JiTwsT3yqWjc
         qvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xz8Ly05gyeb5KBCpOokF5fCnIvNh3e8To5d/tCGw6s=;
        b=Bg/+E2PtzQ9datJ0TnDWQojRumzlhJALQXImecT56fs3jRPpH81mWtYO5CrnvuIQEH
         gyaDXBOZ+ge6Wsv47LDQsX7Eoz4MCFF5O3AYs3Isaav2e7Wm34nxjsj20hvK7TTn56sK
         fSFRt/nwjIuCNC9JZqZbp3/xvpHFZPvV5Q+e+rhMEg6J/bv4kPw2a2qHlEr4KVECWe8q
         CRfDzGt4U0Nc5fatYJYG0fnvYtVLpjHVih4ej4k2529Bua+Qe9TvvwyQGNH2V6nPdt31
         eHP+sSHnK5Na3/K4n4xJS1+ilpNhsZMhYBIP6kw6DYNbY2/l8rQPStOPF4Qb0WCM6v91
         a3Qg==
X-Gm-Message-State: AOAM532Hc1XuWjUfXs2qII3go9RZhOjb+feTzeknQ1WzPclWKZLIoO7L
        ty6UbFTPtQu9+5+mBX5g5uo=
X-Google-Smtp-Source: ABdhPJy4nlS4R3fh8GjfZyWRxLUjKET745KFBVTLw5Odhwtl34mGdwqJOCwC7dldEzPaGZ9uwkVJPg==
X-Received: by 2002:a50:b964:: with SMTP id m91mr29300403ede.37.1593020882972;
        Wed, 24 Jun 2020 10:48:02 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id s14sm8044146edq.36.2020.06.24.10.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:48:02 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 2/6] dt-bindings: clock: Add APB, DMAC, GPIO bindings for Actions S500 SoC
Date:   Wed, 24 Jun 2020 20:47:53 +0300
Message-Id: <1998440a1debe07f838899ccbb15c72518b6b94f.1592941257.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
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

