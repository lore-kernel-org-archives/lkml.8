Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D8BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6BD021527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd+jjA0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgFQQsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0207C061755;
        Wed, 17 Jun 2020 09:48:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l27so3159184ejc.1;
        Wed, 17 Jun 2020 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6IFxg4j69ZkwCCMUppVQGAEtuDflNuWjwBqcXu4yWc=;
        b=Hd+jjA0qiCgPyGwq/YKCmOsq95TdCgNwNFdjCuMzvPQTq/LyAna+naHoNlOATqTcP0
         LldVbflE35vwb66LKkudHfCX1ExzUEjmHLXKqMWgRIR56dwKfT4e0DELMkt0uTwM1cH7
         Vck0R3qkeOx/esfrzVwRc9bPq0NbBWQGYQ1U1DYdWww62ZKWKlfdCrmti6hbuigUfxlZ
         0fsdrYQfXv8F8ZYI1bP9KsMSuick6wwCBtwNC5fjSgizvx7HtncmwYJkqPFqAm1oJNYS
         vS9MYfkiOuEdQgMjNXiSjrPVePovMCQRNhig4FaKr9fpXHIXrRedwLvZwO9AhkBDtKjf
         mD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6IFxg4j69ZkwCCMUppVQGAEtuDflNuWjwBqcXu4yWc=;
        b=SFlfpRcdx/0eXILdw99J17l98T91CV/7ZAdejwp9P+LdOvPWrmtcAVt/fGp9CRSWqz
         DcWJDMAL8zl5Z3ByG0BdQbbraBgvMRPPaQFvrVUpnEoX7mL2dgulw94ntVSSOL3Jfs3J
         uFn0BkmnfRCXi3Q4/V+0svR+Bcbea7MAtTo6HfPxEmwEnDxthwCgyTZAWo+nCzpf+rr/
         SqtoeivfUf1x6858Ho5ruxsYCUU84C0SY+nIhZlNnNrQEY1fF1xrkYjpiUwfIdUT/Gdv
         IX7y/+726YRbLyL6KMtZ61sVLRNtSyj4sluVZDBvJPdTceTgw1nDHTwUnk+t7jAYsMCT
         KIFA==
X-Gm-Message-State: AOAM532FtL+ZwfAxbe1L93AEIiHvFlOOUQbIsNsS7F6UTNoPqyKWCtPq
        Oqi0T91/fk2PBD89Un3jOc0=
X-Google-Smtp-Source: ABdhPJwdWbseXtvFP2fS4kLllfvqMBsrS/h//UWaCxJEWMISfQiPA6Y12StFp/40WvC6xV7yjZOueQ==
X-Received: by 2002:a17:906:f913:: with SMTP id lc19mr79340ejb.286.1592412505425;
        Wed, 17 Jun 2020 09:48:25 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:25 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-actions@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 08/11] dt-bindings: reset: Add binding constants for Actions S500 RMU
Date:   Wed, 17 Jun 2020 19:48:08 +0300
Message-Id: <064369c282f06f1e114eb4d7a832e65376680a59.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding constants for Actions Semi S500 SoC Reset
Management Unit (RMU).

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 .../dt-bindings/reset/actions,s500-reset.h    | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 include/dt-bindings/reset/actions,s500-reset.h

diff --git a/include/dt-bindings/reset/actions,s500-reset.h b/include/dt-bindings/reset/actions,s500-reset.h
new file mode 100644
index 000000000000..f5d94176d10b
--- /dev/null
+++ b/include/dt-bindings/reset/actions,s500-reset.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Device Tree binding constants for Actions Semi S500 Reset Management Unit
+ *
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_ACTIONS_S500_RESET_H
+#define __DT_BINDINGS_ACTIONS_S500_RESET_H
+
+#define RESET_DMAC				0
+#define RESET_NORIF				1
+#define RESET_DDR				2
+#define RESET_NANDC				3
+#define RESET_SD0				4
+#define RESET_SD1				5
+#define RESET_PCM1				6
+#define RESET_DE				7
+#define RESET_LCD				8
+#define RESET_SD2				9
+#define RESET_DSI				10
+#define RESET_CSI				11
+#define RESET_BISP				12
+#define RESET_KEY				13
+#define RESET_GPIO				14
+#define RESET_AUDIO				15
+#define RESET_PCM0				16
+#define RESET_VDE				17
+#define RESET_VCE				18
+#define RESET_GPU3D				19
+#define RESET_NIC301				20
+#define RESET_LENS				21
+#define RESET_PERIPHRESET			22
+#define RESET_USB2_0				23
+#define RESET_TVOUT				24
+#define RESET_HDMI				25
+#define RESET_HDCP2TX				26
+#define RESET_UART6				27
+#define RESET_UART0				28
+#define RESET_UART1				29
+#define RESET_UART2				30
+#define RESET_SPI0				31
+#define RESET_SPI1				32
+#define RESET_SPI2				33
+#define RESET_SPI3				34
+#define RESET_I2C0				35
+#define RESET_I2C1				36
+#define RESET_USB3				37
+#define RESET_UART3				38
+#define RESET_UART4				39
+#define RESET_UART5				40
+#define RESET_I2C2				41
+#define RESET_I2C3				42
+#define RESET_ETHERNET				43
+#define RESET_CHIPID				44
+#define RESET_USB2_1				45
+#define RESET_WD0RESET				46
+#define RESET_WD1RESET				47
+#define RESET_WD2RESET				48
+#define RESET_WD3RESET				49
+#define RESET_DBG0RESET				50
+#define RESET_DBG1RESET				51
+#define RESET_DBG2RESET				52
+#define RESET_DBG3RESET				53
+
+#endif /* __DT_BINDINGS_ACTIONS_S500_RESET_H */
-- 
2.27.0

