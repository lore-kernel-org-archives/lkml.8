Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF09C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C49A20731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgHGDJuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgDGKgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:36:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33773 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:36:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so3325306wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 03:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPds7mBnkEpkQwy+qSjMo7aN1Cxu/qv8fnAKewhN5TY=;
        b=XgHGDJuhlWB53K7kSOMCeUU+d2LLI13DU6SbFx73xSB3dGcXh3lWrdaVLYHXbhEXam
         UMSIxiBjmvypThjWEw0rPAOpJNKS56qNQURYwXtydsIlJODoqXcLAJkCQFbeUttPdmMT
         nFULO+JQm9nCqPIKCzmfro/NVlCz/2PJtUJuR0Z0pIDfK3A1J5W0UmgGVZg61SlFgl2r
         PvnVHOJthhXcORRBuPWBh3BwY0WHOIbwpsvDA4RhICLlRtcCdYt9SLxtRSOvHlMTEXDQ
         NGMLcdF+wmkm9c76sPZr5B9NP7nbeHXAY1A6ToQnjucT2mSnp4fJh18iWngG3DtO6hlO
         AYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPds7mBnkEpkQwy+qSjMo7aN1Cxu/qv8fnAKewhN5TY=;
        b=ggyNlgsXxtR+u1qMw5mjxOXNf8efUCh+VR2QeswKFy58AZ9wmUzH7PEPh3oN1TvPru
         /F6iNbh5Ut2P4OltX0IJfFMHK+78576e83+NQo+f6UPMiln6NA9jiPFajg4NXisYx4a7
         UzaYOYNz4P8aY566yr93YXuJ9/2cWFyxFNTBDuilSAkhsBUS4ZUDl6ITjdN7RGRMfi0N
         MtmclKBWrhUV1UXTu74o1N6MgTxnwmc0TVlRpTIieVmf+8WWo9w1uZrXCgwPGOdMDCcY
         X9R8WPs3g5XRZBGGDJC0RTYD1qdy/+8+SPNprOT5/VxxMMh+AyjoE6JjGs/ovPYTuB+s
         id0A==
X-Gm-Message-State: AGi0PubwQ8IW2rckVRx4u5C7F8aP4w5xhrWGykjbO8irV3BQO3e56ev6
        0k2FlgDkFLbHyrfz3NrFmxE=
X-Google-Smtp-Source: APiQypJCbIb+EF4w6L0bLgEKdLTmTLmcq/2wjVvUlpt/OF2HSK4ZsVgDMeKDsUVL4EcT/GVVyL1WRw==
X-Received: by 2002:adf:904a:: with SMTP id h68mr1900019wrh.291.1586255806173;
        Tue, 07 Apr 2020 03:36:46 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id c17sm25016722wrp.28.2020.04.07.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:36:45 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 1/4] arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
Date:   Tue,  7 Apr 2020 12:35:34 +0200
Message-Id: <20200407103537.4138-2-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407103537.4138-1-max.krummenacher@toradex.com>
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
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

---

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

