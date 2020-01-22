Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3399C33CBA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E6B2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TyTQ1Gmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgAVKFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:05:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33579 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgAVKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:04:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so4027929wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 02:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syU5/1zsk41J9XenYExkcSrSf1m75wNu2Uxs4S6RkBs=;
        b=TyTQ1Gmd71wvmjv/+74mGmrCiZ9C/3z1DIhBcwGsT4wOpNk3c9j3RmUkn/5S2OEmdX
         mn3gnUi3moCZvi0AQzLrek4FMn1ZXHqqeq61v1Ir7gV+o/bRfu/KNw62LBaFK6pZqjQE
         1cjNz6d+C0kUyauNMUcIjtX1oVOYvMTJlNy5RDNDQnspoHV3cc5dHU/r82VR/citD3rC
         eFDhRlYZxmMVWEealCj8PDi4LD+5ydSXAWcS07QbeTnnwjY01VW0P6G0DDYL+fyUAWXY
         i4OJW/Y6aBeg7EZ+uB1jed/lYXR1OH6a46ihmTvQmrq1l34r5USIN4sr9o9Ihv+4E3K9
         saEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syU5/1zsk41J9XenYExkcSrSf1m75wNu2Uxs4S6RkBs=;
        b=FWG1sfH1U59uItql59waSuHYIL9cu5xkErMKC/dh79VDjaAcIWGB6OKUiCxPERMiiW
         z7L+VNepetBfPmG05D5rzx66enZeTU0Plj1wjb6CV0qYduF1LbQLWs8KA/Wf9Li5jGuw
         ug7frqOi8yrNB/Tl+XVGeNyPncExUaA0E9tpmxEYvGlOTh0iXk+iIVS1f2X9MsuQ7uPe
         e0DuFwIltGF2/nlX/MegQ5rWWnagNwZkoKm3KaRHmeS2iVD8lTlWFDyUdePGmnHIZ7pr
         bs86azctduywnbCVd07cpi32yCb3jUI1h29VbxCmrpGFwUzQIZrFdfCMxVe0PqPY198/
         Z9zw==
X-Gm-Message-State: APjAAAXl1caqG+xZ1FL9V98TbAorAI5V7gw0ZLaXi2fZpobquHDZG4DL
        1YKm06HJt55PpQwNX9TmDNl6Q5cgmAY=
X-Google-Smtp-Source: APXvYqyIn4WjUP6H8iMUfBYz19dJwcFjkd+OuUywWtqSbuXPCcYhZDLdw3dWOmUzestdyp3FZqtlPA==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr2176455wma.95.1579687496806;
        Wed, 22 Jan 2020 02:04:56 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l3sm52237648wrt.29.2020.01.22.02.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:04:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, linux-clk@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: meson: gxbb: add the gxl internal dac gate
Date:   Wed, 22 Jan 2020 11:04:50 +0100
Message-Id: <20200122100451.2443153-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122100451.2443153-1-jbrunet@baylibre.com>
References: <20200122100451.2443153-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ACODEC clock gate to the gxl clk controller driver

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 3 +++
 drivers/clk/meson/gxbb.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 1f9c056e684c..47916c4f1700 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -2613,6 +2613,7 @@ static MESON_GATE(gxbb_assist_misc, HHI_GCLK_MPEG0, 23);
 static MESON_GATE(gxbb_emmc_a, HHI_GCLK_MPEG0, 24);
 static MESON_GATE(gxbb_emmc_b, HHI_GCLK_MPEG0, 25);
 static MESON_GATE(gxbb_emmc_c, HHI_GCLK_MPEG0, 26);
+static MESON_GATE(gxl_acodec, HHI_GCLK_MPEG0, 28);
 static MESON_GATE(gxbb_spi, HHI_GCLK_MPEG0, 30);
 
 static MESON_GATE(gxbb_i2s_spdif, HHI_GCLK_MPEG1, 2);
@@ -3100,6 +3101,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_HDMI_SEL]	    = &gxbb_hdmi_sel.hw,
 		[CLKID_HDMI_DIV]	    = &gxbb_hdmi_div.hw,
 		[CLKID_HDMI]		    = &gxbb_hdmi.hw,
+		[CLKID_ACODEC]		    = &gxl_acodec.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -3491,6 +3493,7 @@ static struct clk_regmap *const gxl_clk_regmaps[] = {
 	&gxl_hdmi_pll_od,
 	&gxl_hdmi_pll_od2,
 	&gxl_hdmi_pll_dco,
+	&gxl_acodec,
 };
 
 static const struct meson_eeclkc_data gxbb_clkc_data = {
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index b53584fe66cf..1ee8cb7e2f5a 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -188,7 +188,7 @@
 #define CLKID_HDMI_SEL		  203
 #define CLKID_HDMI_DIV		  204
 
-#define NR_CLKS			  206
+#define NR_CLKS			  207
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
-- 
2.24.1

