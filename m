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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B358CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8694D208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6kM14Ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgDHObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:31:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38444 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgDHOa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:30:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id f20so119407wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLLY+/8fyb+tDQXWdYgnIl/tWBr/7d984i2uDCH3Huw=;
        b=k6kM14Ab5Rm+t+feaQvmbnYXUFlxQOitXL475ByXwqgRGUMkPtGvGLjs9Nv9A0r0f5
         PArwglkr4ojfMmXBP/rOctRuy4QJHg5as8l/G4xVe9xlcboVVmsBdVor67Zv/cjXAFkQ
         EbzZm2fQz6FY7i5E+gZatvrOqij9ncMEatRvvS+/uvjTlLNNx24HDVPVriHoYE6Ev/8N
         Ct8Ao184t54E3vxDrLbRzZFEK/z3piqU06db/kq95ravFFOZ97J8HQF5pLmv7CR/ut85
         1lHIYp0JXkg9bq8fD75923g/fJxAqmpWnC5vk7DRMIVGNpPQ8dIKCTX472pqSeoPbF5T
         Sbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLLY+/8fyb+tDQXWdYgnIl/tWBr/7d984i2uDCH3Huw=;
        b=OFDy6YRKtp/9LsP1S6vRgHhZPyfyq6BFx+t+p0tRg0JI9UMJF1XbaU7Lj/2wR9A3x8
         OQjOAdS/K8QJA1igxAmtFpjnY6okLVWUdhwHm8TUoXHtbxPgEg6FvS6ldwOcMFo57F98
         J3F3tKgGEdwwcQ89un/26/5miyM3HU47mt1I5pPBqdQfJ90JezNMQfcBx8zhZJ54OuHN
         C9kHhF+J7AZqK2t+5x3L+H9nEoui8I3mgaItnsPt34YY0t8uVlranefxT6x5SNAsLBLM
         vyo+ey2XfT3LNPffWqe6MPyB4gNPFViMAsNEUzBO0IdormMXn9PgLihNQuuqZBWuYlQH
         MrOQ==
X-Gm-Message-State: AGi0PuYaq3i5ZS4NnozIsL4O7Np1KVb90ZpSmiHMukoNzwBoWq17g5Rj
        RpW9BBV9TptgMEVP6xqct0c=
X-Google-Smtp-Source: APiQypJh22VLyz5dqbb74SwPacdHhPu3FLYn+W8SmOsQPCZbfBy9giMe9q1XUUf00SUwrWhDS/d9Sw==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr5235802wme.5.1586356257471;
        Wed, 08 Apr 2020 07:30:57 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a10sm36268828wrm.87.2020.04.08.07.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:30:57 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 2/5] arm64: defconfig: add DRM_DISPLAY_CONNECTOR
Date:   Wed,  8 Apr 2020 16:30:37 +0200
Message-Id: <20200408143040.57458-3-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408143040.57458-1-max.krummenacher@toradex.com>
References: <20200408143040.57458-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DRM_DISPLAY_CONNECTOR. This got introduced with the bridge rework
Which renamed among others DRM_DUMB_VGA_DAC.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- additional patch adding DRM_DISPLAY_CONNECTOR as recommended by Geert and Laurent

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ae908c3f43c76..d765a920a20b9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -612,6 +612,7 @@ CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
+CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_THINE_THC63LVD1024=m
 CONFIG_DRM_TI_SN65DSI86=m
-- 
2.20.1

