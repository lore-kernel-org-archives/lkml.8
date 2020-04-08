Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F8B20780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8xoTfHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgDHObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:31:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37349 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgDHOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:30:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so127249wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNUJmyW/0AurvAI4tkIhYfgnlohv2nTKpbi6mh0xlvI=;
        b=X8xoTfHrd0Sfw1q3Hr8N4cLgFngKYZapoPfYdenjpWtKorpNb5Bstn+5+41Ssfnj0I
         3sz44ghiVSqWdxNKPvZAVTk6U9Xo/+gVt2xsodyMvSICQt3vhaoT4F29P1GlyMYj18vR
         OQbiuMQO46GdndqXdj1hCRBvKM62fSO3lGqYy1DtgPcVMNlHQ6ZOU7R/LecDdCpPjb9u
         fAsKWiEC/kxAvOCNCnFVSYD6sTRTyRL5r3pZsjjIA7KcZlIVdR3bKpyuqKWQ9kqa0/lG
         /KmhWjNid1ltzY8w/dkmnagUSdqXvvXy5vqAvGKmFWERKgMQlY9z07CIOiZUBMyMiVxJ
         7k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNUJmyW/0AurvAI4tkIhYfgnlohv2nTKpbi6mh0xlvI=;
        b=mlb1nUzEWfkKbny4GLr0Rw65SnlKxzP73roCbS8CGl0rv0YfIxmdmfU65GmzjLO2tR
         O1hJl+u4MIz4BNAgYIqUYlVyCKw7yq8/C7/7yH9J0ihl2fXdUVvVeRW/ZLcYeOX0JoO9
         o6AXboPYypaVrYVdM6YHPrLTZfPsS7sxfoxTLvx8582Gs6h8VHFui0Z59mirfl0og3x6
         FWZZSG5vKRgDS4w8CI//u3o6ylzz6JR5vRtpwrmwtjUt2FoVdhT8M0GFc6338VEIXdvX
         m3PaFVXEhqu40unJsBJXzr+pTbI129its1KDqzOYP1YFV+S7mLA4cA/CJlsZuGwqUQy4
         5lEA==
X-Gm-Message-State: AGi0PuaeY3yjQI1miVAjuIGjyuwLiAwauqKdDpFB1RWhR3SdSReR+Ib/
        CWKatL8VmVGCpYA2IiCLd5E=
X-Google-Smtp-Source: APiQypKfQ60dQO/USHfHn1Zyi5ma7wDcLwDkDFMWIdbvlhovNGEmXJ2l9V9IELW6acmB3eORhypqLA==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr4876811wmc.124.1586356256589;
        Wed, 08 Apr 2020 07:30:56 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a10sm36268828wrm.87.2020.04.08.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:30:56 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/5] arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
Date:   Wed,  8 Apr 2020 16:30:36 +0200
Message-Id: <20200408143040.57458-2-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408143040.57458-1-max.krummenacher@toradex.com>
References: <20200408143040.57458-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This occurrence wasn't changed in the original rename commit.

Fixes commit 0411374bdf2b3 ("drm/bridge: dumb-vga-dac: Rename driver to
simple-bridge").

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes in v2: None

 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 24e534d850454..ae908c3f43c76 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -610,7 +610,7 @@ CONFIG_DRM_MSM=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
-CONFIG_DRM_DUMB_VGA_DAC=m
+CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_THINE_THC63LVD1024=m
-- 
2.20.1

