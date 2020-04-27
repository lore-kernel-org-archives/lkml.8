Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE8C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CCE2098B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBvWnAwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgD0Nkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgD0Nks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:40:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF4EC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so20636592wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMGGl/RQGQGl3Tw0MqZYpAx5bAhfZ7cMnl8wQSYyYX4=;
        b=bBvWnAwPttxWPqi+FB6EnQYGIS6iy13c+V47NjPym6tFachGQ8LlSVV9d1LZt1IgJ2
         kuyHenHVCmuM1sO4Bo639XJGxVLEArIpXUSh4A5ixGh8kUypH4lr61WoufBhV93u66+L
         NB5m/QXHT3nmCUjtDvbix1e8pGtMFjO/lbwFm1zVjiMy2wun/YDRmXr2jse+dqLUrcO4
         CmuGweedt9tVddX0SRbaOekAZ44OGSwH9fi5TgdRJAEobfCHQ+bdHAErWCHQFuscHkzc
         tDyld+9CQczAB6hD+2SBretDJsa9Aih2DXwENjIe9jtC4mQsZxtQLntvE5WRt305CR4W
         dgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMGGl/RQGQGl3Tw0MqZYpAx5bAhfZ7cMnl8wQSYyYX4=;
        b=JG3wfyAwO+jFGze8NcL88QuxrAmzSx9BKTBvbH6guRLKm3RcAqXGvPQw3ZTwRJqyc+
         jKxlcQPpvx5X/wyBsVqNl3UGRX2Y+fzKN38OZGcYJ8MabWFdGBa6vOB/PJTfmyEHzTbZ
         tYMRsQSkg2Z0zmj4v0Kzt5HGN5Z1dceY3Jk91PWvAzh3w8zOeEmmVe2SaUROwE2p/kB+
         Za9eT71OMTzMgudSWgnGCi1CEGWbW+m1RU5XDR/JYKDaw8MjLEFizekgALVXLu6yLS0c
         Nj98SCAf1cn1GdY112RwJlrYh9SxxpO9UVGi764+FuWKgjCoFceWLAr7UDj7xqualFRT
         2nDA==
X-Gm-Message-State: AGi0PuaRfhK0r+eIhExNGPJxm4nkv5jOfAwAoR0DETbjr8U3QOYydnNI
        ZOG2RVWa/fGuBS918F1Y9h8=
X-Google-Smtp-Source: APiQypJ+vpd3j8uFk33qsEeNwSqj96zUOachqA2BOBjSIjOt1H2vebbvjiOSu5MZ7Av6DR3rhS+zWA==
X-Received: by 2002:a5d:6188:: with SMTP id j8mr26599361wru.119.1587994847336;
        Mon, 27 Apr 2020 06:40:47 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id g186sm16290640wme.7.2020.04.27.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:40:46 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
List-Id: <soc.lore.kernel.org>
To:     Max Krummenacher <max.krummenacher@toradex.com>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 2/5] arm64: defconfig: add DRM_DISPLAY_CONNECTOR
Date:   Mon, 27 Apr 2020 15:40:00 +0200
Message-Id: <20200427134003.45188-3-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427134003.45188-1-max.krummenacher@toradex.com>
References: <20200427134003.45188-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DRM_DISPLAY_CONNECTOR. This got introduced with the bridge rework
Which renamed among others DRM_DUMB_VGA_DAC.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v3: None
Changes in v2:
- additional patch adding DRM_DISPLAY_CONNECTOR as recommended by Geert and Laurent

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5033cfdde3d8d..218aa4fa74734 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -615,6 +615,7 @@ CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
+CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_THINE_THC63LVD1024=m
 CONFIG_DRM_TI_SN65DSI86=m
-- 
2.20.1

