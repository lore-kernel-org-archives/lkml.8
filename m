Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3BBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0541920644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onc16++v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404810AbgDNDdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404793AbgDNDdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:33:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19CC0A3BDC;
        Mon, 13 Apr 2020 20:33:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so4174145pls.4;
        Mon, 13 Apr 2020 20:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fwAH/9wNW27Bix3RiJQ6nNoorCZe5Ipf6jNZRotmVU=;
        b=onc16++vP3GjZTBCXH5NG6TwG8u44PkhoIhCquUX/LXliOCgJGgyUPHLsLUyy9iZoN
         ix35zSm3OcU38vdmtkR8cXOBAbVbJLl3gaqzH8W/Y2DSvyL24tBuSlmQmfQSv1TixnYM
         B2ohhI8ULhmGvfh5hsCrvsXtDWYEUaPJU7e9V4Fo+9952Gla6Bsxc58XKcSWL0JDkUjb
         55UAlsSiYZhGn2/u1k1WSJQHdAP8P6P6KwAfAQL3cNtdT4q4AhU7SO6GLAnSCnLu0vbv
         6hO+QLJEF6tjay07Gw7SIKAfSVnSbha1H74Z+kFA5rlWMjKmVvlbCQWmRhEtUwIoiq2Y
         KeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fwAH/9wNW27Bix3RiJQ6nNoorCZe5Ipf6jNZRotmVU=;
        b=ej2vnlldCOTKRy9NxEVES7FbQNTxl4CHWqWl2MxVCQktys81xj30Kb4uQw7XlAaKxP
         wPKa5b+gKEi7P7TNAJLW9MqVzKTFll7HFqLWX1CEMcBpm90r4/4jzh8xiJAJfuMUEq4s
         EsggcjlUo/qWwijx2I1BzPEOaZnFKIZ6tWJp/UpJbrRfnyVG79Tq3rhec+drcOqbpfWc
         ojZqOSc6zBJIgveYnTqx1dGohcGRRoHxExPXA+ipSUdUu0G36lnAzfssxRrc0F4sT10O
         1Gb371AUohnA3Cdx/qShjennPc1wSGf7WFPRsq+ymZKf8hHpXgQTvCNAQFh3aJ0zCNfG
         5Tng==
X-Gm-Message-State: AGi0Pube/GRhNA5IeoOaR/SNlFr8Yi5bBDRIsLqOVTfJXIDZXUNFHbJU
        GnE8HUqYTJcllWFn3IkqIqwX7ZzTfZc=
X-Google-Smtp-Source: APiQypK17AJdeWPRLxKxA+VceQs7EOYShFUQBmG2VIfayfVHsnoLnP4yGe2sKvHQkTpXC++KG27ePQ==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr22326022pjp.75.1586835225667;
        Mon, 13 Apr 2020 20:33:45 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 140sm5612440pge.49.2020.04.13.20.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 20:33:45 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 3/4] clk: sprd: add dt-bindings include for mipi_csi_xx clocks
Date:   Tue, 14 Apr 2020 11:33:24 +0800
Message-Id: <20200414033325.26536-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414033325.26536-1-zhang.lyra@gmail.com>
References: <20200414033325.26536-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/sprd,sc9863a-clk.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/sprd,sc9863a-clk.h b/include/dt-bindings/clock/sprd,sc9863a-clk.h
index 901ba59676c2..4e030421641f 100644
--- a/include/dt-bindings/clock/sprd,sc9863a-clk.h
+++ b/include/dt-bindings/clock/sprd,sc9863a-clk.h
@@ -308,6 +308,11 @@
 #define CLK_MCPHY_CFG_EB	14
 #define CLK_MM_GATE_NUM		(CLK_MCPHY_CFG_EB + 1)
 
+#define CLK_MIPI_CSI		0
+#define CLK_MIPI_CSI_S		1
+#define CLK_MIPI_CSI_M		2
+#define CLK_MM_CLK_NUM		(CLK_MIPI_CSI_M + 1)
+
 #define CLK_SIM0_EB		0
 #define CLK_IIS0_EB		1
 #define CLK_IIS1_EB		2
-- 
2.20.1

