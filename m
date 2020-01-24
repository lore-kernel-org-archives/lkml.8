Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772452070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfhUD5JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgAXIoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:44:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38309 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAXIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:44:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so961417wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 00:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tinV4d7dayDQdXjsrVgYkWqqsGnfasFnSwWIE4CmiKU=;
        b=mfhUD5JAemI+ypy5lGJeIq/9k0X9UjbcMCE2F+ZQwxSFd91PeNM/5/7jiiVxv8EoP5
         LKLjCyd/jPfCksTv/u/7Q7bsVcy+hNmfL/xs4bw94nHJcFaUELRuR/4nsL/zAlYWRzc4
         iTUNza8XpUrjLhXme37z7sYfwYnvhGdSuEH8vu7aXlUmLELzi2Q2IKZIaoMOlzE5D6S/
         mZV2saZ1IzC5d/1a5Tv4Wym6ypdopY1TL/Nox/+tRw24ZdkX3IvbdSgLhElIeOBw6UbW
         Ltet24NGNPluCKDJOVFKDJEfWguYLC3iKZZYjshBaETvJt+BenwMYIjfivgBw+6BdyF8
         zaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tinV4d7dayDQdXjsrVgYkWqqsGnfasFnSwWIE4CmiKU=;
        b=Opc7eddoahaKXgUeuA21BRdzXNA1RPSOV7t36DdLg0UOI9FSyFpN7l+lBekgXNp2/m
         062/n/00tr2jXpzX/Z8NpC0edsIBcxQ8BL9FaseHwSQdRHpLeQPJFIrCP2Nbh02uf9Oa
         DpF3fmxx6QGQR2n4Ut71KwCU6vkX9+7Rw8ELAfV1hdTzYov2vY1Uk/dX7ZHGObJPNhMa
         m5gfKEMex9c+m58m9E9g85KPt7g30hwsrU3loL4JS+qSjgZiAKbC/ngilKn37b8b+6pJ
         ka/UUjtsJmIg86yRp41z0E2/JaXlEO7NP/ob9qdTJJ5wYhugCB4QBK3jftwOuqMhAzEj
         gruA==
X-Gm-Message-State: APjAAAWD+RTy1bpwPLfqxXw6ozfa1XW/mvTwPMHsE92iBvIrIntxriLj
        P+Af3Wy93/tLqvtf9/cfGg3CXo5CJ/dwpQ==
X-Google-Smtp-Source: APXvYqwXzHlu3JKiNtpqd9JQ1Zuz75kFzJoW3m71GYzTmM+tbN7kRJeuAkAvTwJosa0b14pzQdyefw==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr2881726wrr.211.1579855444145;
        Fri, 24 Jan 2020 00:44:04 -0800 (PST)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id s16sm6651583wrn.78.2020.01.24.00.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 00:44:03 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrice Chotard <patrice.chotard@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Tony Lindgren <tony@atomide.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
Date:   Fri, 24 Jan 2020 09:43:49 +0100
Message-Id: <20200124084359.16817-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes it possible to multi v7 defconfig for stm32 and imx based devices with
full drm support.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3f1b96dc7faa..d213a35557ed 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -637,6 +637,7 @@ CONFIG_CEC_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_CEC=m
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_ML86V7667=m
+CONFIG_IMX_IPUV3_CORE=m
 CONFIG_DRM=y
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
@@ -652,6 +653,11 @@ CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
 CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
+CONFIG_DRM_IMX=m
+CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
+CONFIG_DRM_IMX_TVE=m
+CONFIG_DRM_IMX_LDB=m
+CONFIG_DRM_IMX_HDMI=m
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_RCAR_LVDS=y
-- 
2.24.1

