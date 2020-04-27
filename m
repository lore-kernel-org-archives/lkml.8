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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C49C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D01E206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASTSFY9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgD0Nkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgD0Nks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:40:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C1C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so20628688wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RiMefAOXlyaMSqnLhpchCstN7XqhLMcx22y6IQqdL4Q=;
        b=ASTSFY9F3TLwf+IKtAq5cnpC+xQXoehcFGPhx+I2SuHprkVECleJxo2/AIiJ/HY0iJ
         4w3OzeuVWBoSqpfzzzGMzOOV0SY1aQeXkyQaIqeYgJaYqikSyyJFnata+2tbeCvZoJrb
         CZviEbLqr1mMLjdHLd5JBfqFoNINVou8Vcfa/vrE1OhsfFd21V/uvPNsGFqEJFy+G9WQ
         +eRJEBp5DEchJ7CRKg39eGHhFIwpSqo62eYWU6aY7jj4l9Gy7jnsw94n2LBsda5h6D6r
         x8DX+2jGxXy+vTXK87J3lHj0JYooWETEK/0FbLDEHO047PANUc+egb5mmEpAiaY/HBqG
         AXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiMefAOXlyaMSqnLhpchCstN7XqhLMcx22y6IQqdL4Q=;
        b=ZUboW/yXLqcEh1pRmFn2Q9DKN6n0+qfd14qOwb3TKJz3SYqeiRZOSZI/U0a9zhWOso
         6NO3JvNsB5KI0hsXPWRFsHDLev1CP//klcbWO/E0r0lVSAFxO4Rh6O1pYnMBBaQwrrB7
         F7uBT341Hbu6xgOpp3pB37DhEKdtAMO9rje9W1WZGmuASN3ZUy5G44opgWsbuXDhXoII
         XwWE2DY45UNsyaAzHRA3p2oRhz7uLxro1MVYSiYJMNvJU02eIdQlHv4IvKx/grWq6vgN
         tQa593pCVgmakmgaaPEmE4FlFpaAClB8ecFiINOR2pSz1s5yGA44VRZUcAKFm7yECeNi
         Ky6Q==
X-Gm-Message-State: AGi0PuZY7QMIqTKrJ3opHtcGFCmwa6MNEkECAUGZiA4/08q5NI6x4E1R
        Ty2lDHBuKnU5uxoHYjbLf3w=
X-Google-Smtp-Source: APiQypLUOFC/DgEcn9NHO7x22MhzlTcbZ9utUziqLJQC2hJnzG4hsUvgA4WrEridvx5X5DqwVGIWeg==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr27300917wrn.197.1587994846328;
        Mon, 27 Apr 2020 06:40:46 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id g186sm16290640wme.7.2020.04.27.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:40:45 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
List-Id: <soc.lore.kernel.org>
To:     Max Krummenacher <max.krummenacher@toradex.com>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 1/5] arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
Date:   Mon, 27 Apr 2020 15:39:59 +0200
Message-Id: <20200427134003.45188-2-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427134003.45188-1-max.krummenacher@toradex.com>
References: <20200427134003.45188-1-max.krummenacher@toradex.com>
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

Changes in v3: None
Changes in v2: None

 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 37e512c135baa..5033cfdde3d8d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -613,7 +613,7 @@ CONFIG_DRM_MSM=m
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

