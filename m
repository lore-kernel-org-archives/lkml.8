Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F012C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344EE20758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDm86G6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGMAZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 20:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgGMAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 20:25:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35BC08C5DB;
        Sun, 12 Jul 2020 17:25:20 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g13so8765228qtv.8;
        Sun, 12 Jul 2020 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GerhqmMCr4E+FR59/J/sugyUeiejF25UmyRdQteT5UU=;
        b=iDm86G6T60pEKI0u/kkBAA3985zBVXj2Rg7gRWRUY64lrJVyYt3kd/TR+65ZnBNGbl
         HBBLmfXNrHHNL79PyZkggdFGSm7SKDiyZFoQARNcA/WUZE0XWaOG3U1GQ6JFSfFOkY5m
         9w6kqZPkGZOvM8YLk8Ok3SKQRpmrqeV6tm8VGcNhqO8wfgEiaP7oK/btAGDg2dO7L95Y
         RavquZpoGHdRnw4PMwZ9tpvEtzxPczFSgfsguLpEaFdTpN3vk4Sdrk+n6c6lMco0vYmJ
         Lk+bnIlw2r66UCNgeWVPb3W2JRMTtv0bPMTp9iOZDGI62MCA62+0RTPtkWzRXtW77unW
         ToHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GerhqmMCr4E+FR59/J/sugyUeiejF25UmyRdQteT5UU=;
        b=Kf6Xy9L50/y2qhUmkOEqUvSlpdbGU8Wy0nzXYX3uUVERAxr1BvLEsI8BYN6Y1KSP//
         3EHn/YqbXnn+6OvwUHZksH1wy6rd4cb2ZuqldtAue2RO7jMZvhdHaeRFfWur1LoOrvEI
         u5TzXtQ2k07D+UkyJPEOT1/zUTAge0P+Jl3XLn1x2Z3kXx1ziy7rGLkD9qq7sicaIVlS
         5BsSEsndDE7nzaNe3VRuTdOT4T7EfKJbvTOFaV8v3EBdQXryHWnouptl1+aG+ZiFWqjF
         LhiSs9QDgahXu7v+BOErPOm5Bep4Qisb8X7FFJKse5sfXDyYXYmxIdQ4XYtEDDphWw/T
         vLmg==
X-Gm-Message-State: AOAM533WVETOtdcnskJzpbURnQEhFdxEkXk9TsUFVHJM54qvdmoYrWHT
        i0TPDDFYg1W7PxzaHek5Voc=
X-Google-Smtp-Source: ABdhPJwwIzORD25u00+A6/CTPdO32Pwk7/mPSgL1UWDFbjr96rFO1cGxq3r/gaedZHQALWH5VfSc/Q==
X-Received: by 2002:ac8:fec:: with SMTP id f41mr76161414qtk.212.1594599919764;
        Sun, 12 Jul 2020 17:25:19 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id u5sm17044309qke.32.2020.07.12.17.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 17:25:19 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 3/5] dt-bindings: imx6qdl-clock: add QuadPlus enet clocks
Date:   Sun, 12 Jul 2020 20:25:10 -0400
Message-Id: <20200713002512.28742-4-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713002512.28742-1-TheSven73@gmail.com>
References: <20200713002512.28742-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the QuadPlus, hardware designers have improved the enet clocking.
Add these QuadPlus-specific clocks to the dt-bindings.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

Tree: v5.8-rc4

To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org

 Documentation/devicetree/bindings/clock/imx6q-clock.yaml | 2 ++
 include/dt-bindings/clock/imx6qdl-clock.h                | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
index 92a8e545e212..ecd28403eeff 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
@@ -34,6 +34,7 @@ properties:
       - description: ckih1 clock input
       - description: anaclk1 clock input
       - description: anaclk2 clock input
+      - description: anaclk3 clock input
 
   clock-names:
     items:
@@ -42,6 +43,7 @@ properties:
       - const: ckih1
       - const: anaclk1
       - const: anaclk2
+      - const: anaclk3
 
   fsl,pmic-stby-poweroff:
     $ref: /schemas/types.yaml#/definitions/flag
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index e20c43cc36f6..afc6b7b1e3e6 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -273,6 +273,9 @@
 #define IMX6QDL_CLK_MMDC_P0_IPG			263
 #define IMX6QDL_CLK_DCIC1			264
 #define IMX6QDL_CLK_DCIC2			265
-#define IMX6QDL_CLK_END				266
+#define IMX6QDL_CLK_ENET_PAD			266
+#define IMX6QDL_CLK_ENET_PTP			267
+#define IMX6QDL_CLK_ANACLK3			268
+#define IMX6QDL_CLK_END				269
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
2.17.1

