Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC61C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B86020870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BecTvUbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGCRFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgGCRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:05:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409CC061794;
        Fri,  3 Jul 2020 10:05:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w6so35004020ejq.6;
        Fri, 03 Jul 2020 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oikHKxlZdSMl4kU8NDm7Y2RW1v6HkvM4hXnxFdh9Lk=;
        b=BecTvUbYAyD/OdkoEv/XY3Xkvv/x/yVVwVGu/DcRLYELOMTefkeRfTip0Nu63KYbIO
         c1dI6htpcRXamtPVD+Vf/jTc3KaQthAFof9ZBQE8tIZkHr8KZNRHFzWep9QUqUsxdMcT
         3Kmy1fGd42T1Np425tWQcF82+gnSS8ysSwfc5IIJ6avN8OIX/HsPM/SJzonQSxYrwUkA
         Pt1tf/FZ+zSbGdtnyNqE0kqodZlX0sjHsFIlp7jTqgGeJdqDw+RAPQfa1j3krPqxFxpV
         7kzCmtke2ztHVHMuJ4ItO1PRAYYqGuhoZo/fYunVJi4sPNPCvL0cfZk68rKmy0NcLuXe
         y3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7oikHKxlZdSMl4kU8NDm7Y2RW1v6HkvM4hXnxFdh9Lk=;
        b=QRIVNiYPUDYPiuQxtKv98SCauc6+asw1Iw1d6Ngi2tIUkIVWIwWSGfW327WNIw91Ur
         gGK3PQ4jprK0Rpso2owbScxGVORL37S6mJer+UYKQFoYlEVwr5YkfKQilyVakj3JR9GB
         GaqUikxb3dAP8AbKOGibKgBu9VHp7w1aQcH0qm96bU/jiGT/fb/GvDvBU+rbuTfJSbh0
         KpQTo1njvOIEKfyZeVAIE5jZgP2vSFCtTOhmnzAnaIJBM9DFIKh/snxeh9eiBM2YtQ6G
         2YVXynYxxdupNXp/dsYdLNNLDsxv1Bo82R7VuRo4GhF3IDeztUnOoZPXWDQzTBdi6QoG
         K/sQ==
X-Gm-Message-State: AOAM5305jpSWRAsh10YKrevcefyJaQ6AIVW1X6BzT8G5UT2F1gsvtx1u
        ArW6SaRbrqoFdti7B+zA9ICCmZY35ec=
X-Google-Smtp-Source: ABdhPJzEZQX7tLn/NL9ee9FUnN3bsw0t/tybH7hR5W+WK+sqIPoaM8mUqXMrgUNSQMvsuM1thBQQtQ==
X-Received: by 2002:a17:906:e215:: with SMTP id gf21mr27328777ejb.310.1593795920532;
        Fri, 03 Jul 2020 10:05:20 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id dg8sm14342272edb.56.2020.07.03.10.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:05:20 -0700 (PDT)
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
Subject: [PATCH v3 4/6] dt-bindings: reset: Add binding constants for Actions S500 RMU
Date:   Fri,  3 Jul 2020 20:05:10 +0300
Message-Id: <daf615160b3be9f38dcf7926cc82128c9c2d73e3.1593788312.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding constants for Actions Semi S500 SoC Reset
Management Unit (RMU).

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes in v3:
 - Added Philipp's Acked-by tag

Changes in v2:
 - None

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

