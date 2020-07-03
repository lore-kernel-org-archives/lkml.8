Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F406C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79397207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cA7HaW9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgGCIHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgGCIHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:07:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EBC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:07:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so33087082wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8L2ymad7uoE5dUtck9cxUKwpycxjoxw6UPplO4++sw=;
        b=cA7HaW9ozERboAuFN1YKyL0eJ9qTEfjabd73QLZYCr8JYx4MDRAY4sr1CrwKxd7e+0
         +2qaUWTyjHD2UNG5edk+loEfOfALbhN42YcMZ/HzDyzRfYTcE3DWKeECrUeImTL7sw92
         peWipbKkC0KxjjZhFz9PrenW0V/O8wWfGbqQAbdzpq3Qhh1rssa2psDvVD55QUHEgwNR
         S8c2J0nmpdi7VQ9sA2PLt8EWyzDUaevnN/BQXHjDxCA3GiJ38FzcoHPP7SYKwtvBy21M
         14LF6HL1WcbbI0QlLreutc0zQ6IazLYgG0CmG8GuCLt5n+UiUF06HupOpCYd+oGaLN7H
         RAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8L2ymad7uoE5dUtck9cxUKwpycxjoxw6UPplO4++sw=;
        b=DnhR+pcxP81v5SANZVXqONVRpI7PRB6Nv/Unv7J2lcHL8RX7rb3fKoNbPvmaBP7rUH
         /Q5fxHfI0QWv6vs67kcf9JYlDlrGmFsCcupBkkh2m37PghUXslRme9VkapVViXDE91Dv
         5JA8n1IzYvKt6ArjRKEZQNEAfZVwKGR1xLVdjhJuP7X/DRkOrYttMy7JOSW8qXj1dcvP
         +E8g8WmrkH0fhyUJSScoryKY/DYB9vTStCJ3jbStq8+uxJoi+GD4jaSfSvAF21e+6UHC
         Kw2nixKC1sVzxQn8sBU3ahQLF7nz8oZ/fJ/PCY27tKufgru7RokhYAubPZCrirl3EZmW
         AxFg==
X-Gm-Message-State: AOAM531H3iezPhdTeLZsTTpUqXHYFiZ7S72Kqm7YvTo5yHH7A3Rt1OTU
        +c6dXyUg+PV1mh1Wi1OtNJez7w==
X-Google-Smtp-Source: ABdhPJxFqjpvl3b0UJve6c0iOJ4MjwZ0scn2Vk9ofpstuBtdKJs4JuNzymRK6MsAmFbBysjHmny/RQ==
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr34051103wme.55.1593763660377;
        Fri, 03 Jul 2020 01:07:40 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:6959:e617:6562:cabf])
        by smtp.gmail.com with ESMTPSA id 1sm12682403wmf.0.2020.07.03.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:07:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     jianxin.pan@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v9 2/6] drm/meson: add Amlogic Video FBC registers
Date:   Fri,  3 Jul 2020 10:07:24 +0200
Message-Id: <20200703080728.25207-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200703080728.25207-1-narmstrong@baylibre.com>
References: <20200703080728.25207-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the registers of the VPU VD1 Amlogic FBC decoder module, and routing
register.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 8ea00546cd4e..08631fdfe4b9 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -144,10 +144,15 @@
 #define		VIU_SW_RESET_OSD1               BIT(0)
 #define VIU_MISC_CTRL0 0x1a06
 #define		VIU_CTRL0_VD1_AFBC_MASK         0x170000
+#define		VIU_CTRL0_AFBC_TO_VD1		BIT(20)
 #define VIU_MISC_CTRL1 0x1a07
 #define		MALI_AFBC_MISC			GENMASK(15, 8)
 #define D2D3_INTF_LENGTH 0x1a08
 #define D2D3_INTF_CTRL0 0x1a09
+#define VD1_AFBCD0_MISC_CTRL 0x1a0a
+#define		VD1_AXI_SEL_AFBC		(1 << 12)
+#define		AFBC_VD1_SEL			(1 << 10)
+#define VD2_AFBCD1_MISC_CTRL 0x1a0b
 #define VIU_OSD1_CTRL_STAT 0x1a10
 #define		VIU_OSD1_OSD_BLK_ENABLE         BIT(0)
 #define		VIU_OSD1_OSD_MEM_MODE_LINEAR	BIT(2)
@@ -365,6 +370,23 @@
 #define VIU_OSD1_OETF_LUT_ADDR_PORT 0x1add
 #define VIU_OSD1_OETF_LUT_DATA_PORT 0x1ade
 #define AFBC_ENABLE 0x1ae0
+#define AFBC_MODE 0x1ae1
+#define AFBC_SIZE_IN 0x1ae2
+#define AFBC_DEC_DEF_COLOR 0x1ae3
+#define AFBC_CONV_CTRL 0x1ae4
+#define AFBC_LBUF_DEPTH 0x1ae5
+#define AFBC_HEAD_BADDR 0x1ae6
+#define AFBC_BODY_BADDR 0x1ae7
+#define AFBC_SIZE_OUT 0x1ae8
+#define AFBC_OUT_YSCOPE 0x1ae9
+#define AFBC_STAT 0x1aea
+#define AFBC_VD_CFMT_CTRL 0x1aeb
+#define AFBC_VD_CFMT_W 0x1aec
+#define AFBC_MIF_HOR_SCOPE 0x1aed
+#define AFBC_MIF_VER_SCOPE 0x1aee
+#define AFBC_PIXEL_HOR_SCOPE 0x1aef
+#define AFBC_PIXEL_VER_SCOPE 0x1af0
+#define AFBC_VD_CFMT_H 0x1af1
 
 /* vpp */
 #define VPP_DUMMY_DATA 0x1d00
-- 
2.22.0

