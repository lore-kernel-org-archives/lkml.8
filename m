Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DEC352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E24B21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DxnTXJPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBFTSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:18:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43574 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFTSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:18:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id z9so8541817wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7C4Ha7zAXoHJLeQuNXMkRQPbmeP4ogREDDVwBdo96PU=;
        b=DxnTXJPqXXPnizJLFNrqa8GwJ8gMWT/axeWYGzcs3ljXjPgGTyKNnBVVA21YieyHxn
         k6v/3pUpzARJ8UF8hbtsbjgwA5koasldIhE9esnWmv9fb8wrU30l7FpIa2j9RZLV21nM
         NQjz6sWEVlRvKoNM9icc+5FvS9SOzdX5tWCRYpAigUOBi1QUUh+f8YhLwrw+zvOyEecl
         ppc45FZOr/DBqaSDGmVBYBlRWqs1Q0h8ACoyqG1Oglt2yIRBAB92tqdBciC2LQEBu6hm
         DF49GWWLO91Z3pIJDuBYpqgB/w8lx5C5sV0p+/R7MhYxbVu2s7Vs+bUszVITV2jVje+G
         Cf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7C4Ha7zAXoHJLeQuNXMkRQPbmeP4ogREDDVwBdo96PU=;
        b=mgCEItdcMUzwz5Z6eFtOgExDs4jtrk027aOalmnxYUBJnFwjXAy8JDnV1cnpFFm4Pe
         E3h6Dzii1AIF/GkbK1YnceE9f3n7xEy8loPWKF90eksqRtrd16u/tWi2TSrD3emMSnlg
         X38Ll6x9l2SJQ+yeiyQNvOhL/dqEI5L3hDUMXUIkqhrkhNjbCMaiz2w68aLTe+YqaW9R
         7LFT7d2A/7ITaMw4nvNBewmEj2LZ7ORj8wEzSfFlFRzUyHob+4cDffY/ZH04MMmYdLzZ
         k8zz3sm5S+eicbuZ656+fPEuPHDHPIY5hBFD/Ln3QBMia7wyia2XpMyo6BV4zFJGNd+R
         lKRQ==
X-Gm-Message-State: APjAAAW6fHUPDyWv5E4CTMI3bfhwDVpfryANSMBx5Sk7ifGavWgnOab2
        dxAZJd79icO4hJ5vM9IHs4cXTw==
X-Google-Smtp-Source: APXvYqyUIKBo5GX0ik0zx1IEIcuY8em6EMApdnkWu4ZdvEAKTEYUUM/sB0yoLyYs2WmHo5wQQH3+Fg==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr5608872wrx.403.1581016717398;
        Thu, 06 Feb 2020 11:18:37 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id m3sm272662wrs.53.2020.02.06.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:18:36 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] drm/bridge: dw-hdmi: implement bus-format negotiation and YUV420 support
Date:   Thu,  6 Feb 2020 20:18:23 +0100
Message-Id: <20200206191834.6125-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Boris's v10 "drm: Add support for bus-format negotiation" at [1]
patchset to implement full bus-format negotiation for DW-HDMI, including YUV420 support and
10/12/16bit YUV444, YUV422 and RGB. The Color Space Converter support is already implemented.

And the counterpart implementation in the Amlogic Meson VPU dw-hdmi glue :
- basic bus-format negotiation to select YUV444 bus-format as DW-HDMI input
- YUV420 support when HDMI2.0 YUV420 modeset

This is a follow-up from the previous attempts :
- "drm/meson: Add support for HDMI2.0 YUV420 4k60" at [2]
- "drm/meson: Add support for HDMI2.0 4k60" at [3]

Changes sincd v3 at [6]:
- Added "Plug atomic state hooks to the default implementation" on drm/bridge: dw-hdmi
- Also added these atomic state hooks in meson-dw-hdmi in patch 7
- Rebased on latest drm-misc-next including patches 1-7 of [1]

Changes since RFC v2 at [5]:
- Added fixes from Jonas, who tested and integrated it for Rockchip SoCs
- Added support for 10/12/16bit tmds clock calculation
- Added support for max_bcp connector property
- Adapted to Boris's v4 patchset
- Fixed typos reported by boris

Changes since RFC v1 at [4]:
- Rewrote negociation using the v2 patchset, including full DW-HDMI fmt negociation

[1] https://patchwork.freedesktop.org/patch/msgid/20200128135514.108171-1-boris.brezillon@collabora.com
[2] https://patchwork.freedesktop.org/patch/msgid/20190520133753.23871-1-narmstrong@baylibre.com
[3] https://patchwork.freedesktop.org/patch/msgid/1549022873-40549-1-git-send-email-narmstrong@baylibre.com
[4] https://patchwork.freedesktop.org/patch/msgid/20190820084109.24616-1-narmstrong@baylibre.com
[5] https://patchwork.freedesktop.org/patch/msgid/20190827081425.15011-1-narmstrong@baylibre.com
[6] https://patchwork.freedesktop.org/patch/msgid/20191218154637.17509-1-narmstrong@baylibre.com

Jonas Karlman (2):
  drm/bridge: dw-hdmi: set mtmdsclock for deep color
  drm/bridge: dw-hdmi: add max bpc connector property

Neil Armstrong (9):
  drm/bridge: dw-hdmi: Plug atomic state hooks to the default
    implementation
  drm/bridge: synopsys: dw-hdmi: add bus format negociation
  drm/bridge: synopsys: dw-hdmi: allow ycbcr420 modes for >= 0x200a
  drm/meson: venc: make drm_display_mode const
  drm/meson: meson_dw_hdmi: add bridge and switch to drm_bridge_funcs
  drm/meson: dw-hdmi: stop enforcing input_bus_format
  drm/meson: venc: add support for YUV420 setup
  drm/meson: vclk: add support for YUV420 setup
  drm/meson: Add YUV420 output support

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 302 +++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 200 +++++++++++---
 drivers/gpu/drm/meson/meson_vclk.c        |  93 +++++--
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |  10 +-
 drivers/gpu/drm/meson/meson_venc.h        |   4 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   6 +-
 include/drm/bridge/dw_hdmi.h              |   1 +
 8 files changed, 548 insertions(+), 75 deletions(-)

-- 
2.22.0

