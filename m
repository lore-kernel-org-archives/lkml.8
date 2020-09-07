Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D65C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA642075A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GXRL2jcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgIGJij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgIGJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:38:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7FC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 02:38:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so13515858wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lY1f6BPUzB++HrA2WRJHkdA8MgAHqDCMG4dVPqyy2dw=;
        b=GXRL2jcAHETtaAy+Yd8N2jg3wSJQNHn0HFB2TA7y/8aY0wUVjOXkzBJybLwaE7Mc2l
         FAuf+CuUtSXhL5Vw5QoZU5/kDJsy6yFx8p7Jfz8m1CQRqHLCP9V9UgB9GsQBP4T8yshE
         o14cpplTvFvxO7wc296KgfxPPbVuQ3lCmjTFKzyTRHAuyaQve1J+hnlUEDUj8GFOYX3W
         +W/Mb+667M/roOs5/xmC25VNY5/7XDqHPWhGLYdRYhB2GT/Kb0sPOK/AxC/F5/nuQVg0
         b0BNXAHTekSzhkqVKMR++HHawyTODucH8CZUphUSrPYAQTdhTqhh5otNZud+IwqZUzVM
         QOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lY1f6BPUzB++HrA2WRJHkdA8MgAHqDCMG4dVPqyy2dw=;
        b=BAg8icCEikFJXjS1YZcof52Vftiw0sL69bwUrnG6FuH2tt2KQKlv00XdoLgPu0iBJF
         dXoP4hnWbIfKitUv8F52N52KBeb0oIrnE5Z43GDoD5vo7YTJQm9pE4sN3viQN1yJGhTV
         dJURE3tnauarar5yQTkm1jbbuVOSpSjduwDj3c9s30VgSl5oLmtGB4QkyVl8mCZPKPZK
         M45332/BnThPIR6FH3q8dGchheyU8lZt3wWFCUQOZqf5+DlU/cnpzngTVsbBjjRFSYyI
         iGSBK3Du+7FICIEJxCmKktcBq59fcyVsFNE9y/zFRBgQzjPnClNs+VjBMltBxFocRzuq
         gV/Q==
X-Gm-Message-State: AOAM531H4ukOj/p/zNuwd7hAbFLHX9a/WH9H0jvklXjJuxVfpCvqW/On
        XRnl0K/SU2oNp03kZbJhI7WxMA==
X-Google-Smtp-Source: ABdhPJxpmUTuMWXELB/h2Tver8381dpQKTFZfsyv5TkXWK3JfwYLS+IvAXEN1+5gehJPeOMWmvHZQw==
X-Received: by 2002:a1c:7e16:: with SMTP id z22mr21381797wmc.117.1599471494913;
        Mon, 07 Sep 2020 02:38:14 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id n17sm25170687wrw.0.2020.09.07.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 02:38:14 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/4] dt-bindings: clk: axg-clkc: add Video Clocks
Date:   Mon,  7 Sep 2020 11:38:07 +0200
Message-Id: <20200907093810.6585-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907093810.6585-1-narmstrong@baylibre.com>
References: <20200907093810.6585-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock IDs for the video clocks.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/axg-clkc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
index fd1f938c38d1..281df3e0f131 100644
--- a/include/dt-bindings/clock/axg-clkc.h
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -72,5 +72,29 @@
 #define CLKID_PCIE_CML_EN1			80
 #define CLKID_MIPI_ENABLE			81
 #define CLKID_GEN_CLK				84
+#define CLKID_VPU_0_SEL				92
+#define CLKID_VPU_0				93
+#define CLKID_VPU_1_SEL				95
+#define CLKID_VPU_1				96
+#define CLKID_VPU				97
+#define CLKID_VAPB_0_SEL			99
+#define CLKID_VAPB_0				100
+#define CLKID_VAPB_1_SEL			102
+#define CLKID_VAPB_1				103
+#define CLKID_VAPB_SEL				104
+#define CLKID_VAPB				105
+#define CLKID_VCLK				106
+#define CLKID_VCLK2				107
+#define CLKID_VCLK_DIV1				122
+#define CLKID_VCLK_DIV2				123
+#define CLKID_VCLK_DIV4				124
+#define CLKID_VCLK_DIV6				125
+#define CLKID_VCLK_DIV12			126
+#define CLKID_VCLK2_DIV1			127
+#define CLKID_VCLK2_DIV2			128
+#define CLKID_VCLK2_DIV4			129
+#define CLKID_VCLK2_DIV6			130
+#define CLKID_VCLK2_DIV12			131
+#define CLKID_CTS_ENCL				133
 
 #endif /* __AXG_CLKC_H */
-- 
2.22.0

