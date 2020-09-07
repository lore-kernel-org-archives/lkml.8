Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3131C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DE521481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eq8pdz4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIGISr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgIGISc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:18:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5497C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:18:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so13295849wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVkpcj81glnSnuras7YrChzwHxX/+ElP6dnTPDpVflM=;
        b=eq8pdz4bEvw8Drm9IiyKHHS/9tFdgbwA08m44Eo5/3AjXDsoVvgB9xtCqI9yTDhZHe
         JWhhbtGcwt6X672OqK0uhjV9ZpDs1Wdnkrdm8HSe0aMBznreCxHk7OroTON3aUfddLm1
         NC7fuE0Ak5aP4nwxtYkewvg/z0Jq9O03FCVjJetdv4XeVtDXiq+/CAXBQIDTxuM4AraI
         A0oDMSoo3d7XD6D3VHC5oDtBsyl3T/aSCS37kU3emyahVkV4GBseZ06BTPRVOUCjQQHw
         UdA8A5B3ZNrRfqyEoUmZH8v1Ac+suW/fzeN/twc47tAJbxfPkd7NYADS+cFIg3nobAEI
         5k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVkpcj81glnSnuras7YrChzwHxX/+ElP6dnTPDpVflM=;
        b=jfNHUuR9ANtL57CsYL3GrjpM46I7uAB4h4Q/+HbVhoZifTWo8ui37PjZ/IIddD0aMl
         AoSG4qFu/FyOVaEg9jfMQtjIeYPIrB4gIORDYILfNR1dc3ekIbJadUhdtFZUVu1/uR5P
         bpBOJsZzgxUklFM3DpWmdHLt0c8TxqGQNLqMos3Uzffgbxk5gaVeHqYh840YLtupN8mt
         ln3KYhUGsQsUC8JuX5i/adz5lHeiK54h9vMkTSXNRSH+xhiebns076NXHlFeHa8CtDFD
         tEqPDa0vd/10JTAGbsqjOOnsWYyMkDc2xeIZqAPbPPRmUx/hizYASAm838FkgWzlQkrT
         ySaA==
X-Gm-Message-State: AOAM5324dGP/zKgTOYYh+gtUzexDeNXc/FvLyU3MeeVFBmz40dp1Lk7G
        SFrNVQGeMlrdAgYTECuhyX7KOg==
X-Google-Smtp-Source: ABdhPJwn6ZvGBo3Zj+uG7oJh3C4n8ndDDZO8Lx+buWNryuDkwiOI7oTl6RG79ry/EWhvW7HUBLE4WA==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr19191231wme.8.1599466710211;
        Mon, 07 Sep 2020 01:18:30 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id q186sm28032205wma.45.2020.09.07.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:18:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/6] drm/meson: add support for AXG & MIPI-DSI
Date:   Mon,  7 Sep 2020 10:18:19 +0200
Message-Id: <20200907081825.1654-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG SoC family has a downgraded VPU with the following
changes :
- Only a single OSD plane, no overlay video plane
- The primary plane doesn't support HW scaling
- The pixels are read directly from DDR without any Canvas module
- Doesn't support HDMI or CVBS
- Ouputs only with ENCL encoder to a DPI-to-DSI Synopsys DW-MIPI-DSI transceiver

The Amlogic AXg SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a), with a custom
glue managing the IP resets, clock and data input similar to the DW-HDMI Glue on other
Amlogic SoCs.

This adds support for the Glue managing the transceiver, mimicing the init flow provided
by Amlogic to setup the ENCl encoder, the glue, the transceiver, the digital D-PHY and the
Analog PHY in the proper way.

The DW-MIPI-DSI transceiver + D-PHY are directly clocked by the VCLK2 clock, which pixel clock
is derived and feeds the ENCL encoder and the VIU pixel reader.

An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
DW-MIPI-DSI transceiver.

Neil Armstrong (6):
  dt-bindings: display: amlogic,meson-vpu: add bindings for VPU found in
    AXG SoCs
  dt-bindings: display: add Amlogic MIPI DSI Host Controller bindings
  drm/meson: add support for VPU found in AXG SoCs
  drm/meson: venc: add ENCL encoder setup for MIPI-DSI output
  drm/meson: remove useless recursive components matching
  drm/meson: add support for MIPI-DSI transceiver

 .../display/amlogic,meson-dw-mipi-dsi.yaml    | 115 ++++
 .../bindings/display/amlogic,meson-vpu.yaml   |  36 +-
 drivers/gpu/drm/meson/Kconfig                 |   7 +
 drivers/gpu/drm/meson/Makefile                |   1 +
 drivers/gpu/drm/meson/meson_crtc.c            |   8 +-
 drivers/gpu/drm/meson/meson_drv.c             | 163 ++---
 drivers/gpu/drm/meson/meson_drv.h             |  10 +-
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c     | 562 ++++++++++++++++++
 drivers/gpu/drm/meson/meson_plane.c           |  74 ++-
 drivers/gpu/drm/meson/meson_registers.h       |   1 +
 drivers/gpu/drm/meson/meson_venc.c            | 230 ++++++-
 drivers/gpu/drm/meson/meson_venc.h            |   6 +
 drivers/gpu/drm/meson/meson_viu.c             |  50 +-
 drivers/gpu/drm/meson/meson_vpp.c             |   6 +-
 drivers/gpu/drm/meson/meson_vpp.h             |   2 +
 15 files changed, 1176 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
 create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c

-- 
2.22.0

