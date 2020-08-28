Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56168C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305AC2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gI9bAnr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgH1Prv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgH1Prm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:47:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A76C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:47:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so1341998wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOjcUQAzjdKMUBQz9pCR37JmdK7LsMO1KAx1BuqAcUE=;
        b=gI9bAnr5JSfBRzzwqqeFQeZ+TmOK38nNFBQuIZSuzWnTnYJXoBTgAVen2uftuz8FEv
         ZjC0A7+hOfbC2b7mLHY1Qu/RAunI+aiI4BGFFlIQxrAZPfADnPQPAY7Zy4HScXQd//on
         m5vQgTPdOMuJ37l/5TnqUF32EQXXkNXeg4q0odzYqtEPmPm8lyONoJ+rhVImCRFP2ID+
         j/rFOjVBYWIEo15+8iYb0UYiUyIS69HOfYFBPrJmlOrZCvetbcBEl6ZwSSBtExKR+K+6
         99QIEWse2ti/ufQnkbYYRyi777IkFAWLnv+wCcLQH1yYcxBgObBqiXaHT11opun0faBO
         LMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOjcUQAzjdKMUBQz9pCR37JmdK7LsMO1KAx1BuqAcUE=;
        b=N+Oh993jH0r2qR8WA1spHDqwOVlYjDtACnkzlcbh5wfaltswJdY8djZmbpuPc3aPJu
         hoanGMEKrnwD8izT7v8XMDhFKOkYj+pajOVZ0R21Bj2sGjQCgrwlZ5P1NITMiwxlZsCO
         WR68bWFAp8q6+/GxAIJ+j2l866cu17/c1lWp35Hj9HDeNPnRTktEr1TKP1HDLCn7czA3
         FdQLcDQxJwA0ksFputlqs1EdMZJykg7IXyjDeKQA8YiJOc792s63arkbfYg2OapR9LkA
         zKV0MPvEDR7gs1UELhkDWCZpSxfW0B5wq9W/tW9LYAfFWjG6op7OGbYT8IFQpRgzas7R
         pfag==
X-Gm-Message-State: AOAM530k8EB2k1LCRZ5N6Eyei3MaVlL7+uQyaAE8xGipdqGMEPnM623l
        xIZFd5TGq+xV9tk0lfsQ4htKAA==
X-Google-Smtp-Source: ABdhPJy5BerRgM4DpFWDQXDmijD30b0WFwUdB+Kqn2qC0AshshLhhAKK/GeM24eNPwjyGbElVhe2ew==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr2127732wml.169.1598629660269;
        Fri, 28 Aug 2020 08:47:40 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l1sm2921646wrb.12.2020.08.28.08.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:47:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, linux-clk@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: make shipped controller configurable
Date:   Fri, 28 Aug 2020 17:47:35 +0200
Message-Id: <20200828154735.435374-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary so bits so unnecessary amlogic clock controllers can be
compiled out. This allows to save a few kB when necessary.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index dabeb435d067..034da203e8e0 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+menu "Clock support for Amlogic platforms"
+	depends on ARCH_MESON || COMPILE_TEST
+
 config COMMON_CLK_MESON_REGMAP
 	tristate
 	select REGMAP
@@ -41,8 +44,9 @@ config COMMON_CLK_MESON_CPU_DYNDIV
 	select COMMON_CLK_MESON_REGMAP
 
 config COMMON_CLK_MESON8B
-	bool
-	depends on ARCH_MESON
+	bool "Meson8 SoC Clock controller support"
+	depends on ARM
+	default y
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
@@ -54,8 +58,9 @@ config COMMON_CLK_MESON8B
 	  want peripherals and CPU frequency scaling to work.
 
 config COMMON_CLK_GXBB
-	bool
-	depends on ARCH_MESON
+	bool "GXBB and GXL SoC clock controllers support"
+	depends on ARM64
+	default y
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_VID_PLL_DIV
@@ -69,8 +74,9 @@ config COMMON_CLK_GXBB
 	  Say Y if you want peripherals and CPU frequency scaling to work.
 
 config COMMON_CLK_AXG
-	bool
-	depends on ARCH_MESON
+	bool "AXG SoC clock controllers support"
+	depends on ARM64
+	default y
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_MPLL
@@ -84,7 +90,7 @@ config COMMON_CLK_AXG
 
 config COMMON_CLK_AXG_AUDIO
 	tristate "Meson AXG Audio Clock Controller Driver"
-	depends on ARCH_MESON
+	depends on ARM64
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_PHASE
 	select COMMON_CLK_MESON_SCLK_DIV
@@ -94,8 +100,9 @@ config COMMON_CLK_AXG_AUDIO
 	  aka axg, Say Y if you want audio subsystem to work.
 
 config COMMON_CLK_G12A
-	bool
-	depends on ARCH_MESON
+	bool "G12 and SM1 SoC clock controllers support"
+	depends on ARM64
+	default y
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_MPLL
@@ -107,3 +114,4 @@ config COMMON_CLK_G12A
 	help
 	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
 	  devices, aka g12a. Say Y if you want peripherals to work.
+endmenu
-- 
2.25.4

