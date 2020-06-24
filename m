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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921FBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6770320738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePkCpn77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405726AbgFXRsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405706AbgFXRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:48:07 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7EC061573;
        Wed, 24 Jun 2020 10:48:06 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so3305800eja.7;
        Wed, 24 Jun 2020 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6IFxg4j69ZkwCCMUppVQGAEtuDflNuWjwBqcXu4yWc=;
        b=ePkCpn77PKfesRhMTlf+TEFR/0RLn6oztaJSM5Aw8jjE0tsKa/PEULoSEJma9rEZdi
         rLU2/izSLPXPXSZxAkWpiEQeAvRjZ64rRHRb8/NMWQM5J8B2DBLIbrKChyDFjWY1Vwbu
         ySIRci0gg4FHQ6xxhsDmOHf0mAV8Qdon30eUOsn37ezKP2UE3dE8wI8MLShbscJaEDTu
         al6xhonChn59GZXkw/MqMA5pERDXl533p25nskpP4gn2A3hJqHsH0z0dw8WK9elGGdX3
         gkeQd2A2p4GWpBj3AkPTJBWAM+4afmkl0VXcXvNUiJXDUPNzt0AzK/o4FUnFpj1j/9zZ
         CqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6IFxg4j69ZkwCCMUppVQGAEtuDflNuWjwBqcXu4yWc=;
        b=XSBCYXhYdgTmiRx8zl+kwyrhnhJBDzo6zeGSBd7/Nx3dRjQdzDuxxpLc076P1rD9RH
         aS8loGG2gPAwlYZWOUcAfBvtcuRi8yPVLrlzn7FEU8UfCKw3z7zAjzbR5kQ+cloQUTQz
         34ElgaWVaxCKDu3MtPxv5yn+ye5YOnVwTs1XiHU+4Ao+i9886ONx27Jzg/irS76I97ae
         HHw+EllHKZxBujXGZryjJ646f0/QN+6164JD1nhVDnyJChGNDiYNF5x3qbQx7ZsB6RSZ
         nryYpDYiTrw9ZFApUmIeOKOytQ/WK36KfEiqIzQqQxBb7dVr5d3+WFqGHfK3hKUi0mH2
         shOA==
X-Gm-Message-State: AOAM530g7Sqy1VPoYvTRDA3uOWyWFL5FObVMssepF/Dm4upxtfG77p5J
        QV6bfasGqg1QK8QrS7ynJ5hi189NLcg=
X-Google-Smtp-Source: ABdhPJx78RtrWLOH9FK9jPUKJPAMVgpVk+sJi7HbsncxkrSTx2ojYXjGWOmxRUVgCi148o07yR8kIg==
X-Received: by 2002:a17:906:6441:: with SMTP id l1mr25061061ejn.169.1593020885380;
        Wed, 24 Jun 2020 10:48:05 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id s14sm8044146edq.36.2020.06.24.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:48:05 -0700 (PDT)
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
Subject: [PATCH v2 4/6] dt-bindings: reset: Add binding constants for Actions S500 RMU
Date:   Wed, 24 Jun 2020 20:47:55 +0300
Message-Id: <924885629e2797e332ae8ff9c077937d44379722.1592941257.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
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

