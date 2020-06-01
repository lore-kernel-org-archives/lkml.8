Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260C6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022B920734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFAGXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:23:20 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48572 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFAGXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:23:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 57FE22004CA;
        Mon,  1 Jun 2020 08:23:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 90AAA200480;
        Mon,  1 Jun 2020 08:23:10 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 60F9D40280;
        Mon,  1 Jun 2020 14:23:03 +0800 (SGT)
From:   sandor.yu@nxp.com
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, heiko@sntech.de, hjc@rock-chips.com,
        Sandor.yu@nxp.com, dkos@cadence.com,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH 0/7] Initial support for Cadence MHDP(HDMI/DP)
Date:   Mon,  1 Jun 2020 14:17:30 +0800
Message-Id: <cover.1590982881.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandor Yu <Sandor.yu@nxp.com>

The patch set initial support for Cadence MHDP(HDMI/DP) drm bridge
driver and iMX8MQ HDMI/DP.

The first patch drm/rockchip: prepare common code for cdns and rk dpi/dp driver
is from the link https://patchwork.kernel.org/patch/10788309/
that still in reviewing.

Files in drm/bridge/cadence compose with serveral parties,
drm bridge driver, Audio and API functions.
 -cdns-dp-core.c: Displayport bridge driver
 -cdns-hdmi-core.c: HDMI bridge driver 
 -cdns-mhdp-audio.c: DP/HDMI Audio
 -cdns-mhdp-common.c: MHDP common API functions
 -cdns-mhdp-dp.c: MHDP DP API functions
 -cdns-mhdp-hdmi.c: MHDP HDMI API functions

Sandor Yu (7):
  drm/rockchip: prepare common code for cdns and rk dpi/dp driver
  drm: bridge: cadence: Create cadence fold
  drm: bridge: cadence: initial support for MHDP DP bridge driver
  drm: imx: mhdp: initial support for i.MX8MQ MHDP Displayport
  drm: bridge: cadence: Initial support for MHDP HDMI bridge driver
  drm: imx: mhdp: Initial support for i.MX8MQ MHDP HDMI
  dt-bindings: display: Document Cadence MHDP HDMI/DP bindings

 .../bindings/display/bridge/cdns,mhdp.yaml    |  46 +
 .../devicetree/bindings/display/imx/mhdp.yaml |  59 ++
 drivers/gpu/drm/bridge/Kconfig                |   2 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/cadence/Kconfig        |  15 +
 drivers/gpu/drm/bridge/cadence/Makefile       |   5 +
 drivers/gpu/drm/bridge/cadence/cdns-dp-core.c | 530 ++++++++++
 .../gpu/drm/bridge/cadence/cdns-hdmi-core.c   | 600 +++++++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp-audio.c  | 298 ++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp-common.c | 682 +++++++++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp-common.h |  40 +
 drivers/gpu/drm/bridge/cadence/cdns-mhdp-dp.c | 206 ++++
 .../gpu/drm/bridge/cadence/cdns-mhdp-hdmi.c   | 330 ++++++
 drivers/gpu/drm/imx/Kconfig                   |   1 +
 drivers/gpu/drm/imx/Makefile                  |   1 +
 drivers/gpu/drm/imx/mhdp/Kconfig              |   9 +
 drivers/gpu/drm/imx/mhdp/Makefile             |   4 +
 drivers/gpu/drm/imx/mhdp/cdns-mhdp-dp-phy.c   | 390 +++++++
 drivers/gpu/drm/imx/mhdp/cdns-mhdp-hdmi-phy.c | 588 +++++++++++
 drivers/gpu/drm/imx/mhdp/cdns-mhdp-imxdrv.c   | 142 +++
 drivers/gpu/drm/imx/mhdp/cdns-mhdp-phy.h      | 148 +++
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/Makefile             |   2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 247 ++---
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  44 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c         | 960 ------------------
 .../drm/bridge/cdns-mhdp.h                    | 257 ++++-
 27 files changed, 4464 insertions(+), 1144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
 create mode 100644 Documentation/devicetree/bindings/display/imx/mhdp.yaml
 create mode 100644 drivers/gpu/drm/bridge/cadence/Kconfig
 create mode 100644 drivers/gpu/drm/bridge/cadence/Makefile
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dp-core.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-hdmi-core.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp-audio.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp-common.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp-common.h
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp-dp.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp-hdmi.c
 create mode 100644 drivers/gpu/drm/imx/mhdp/Kconfig
 create mode 100644 drivers/gpu/drm/imx/mhdp/Makefile
 create mode 100644 drivers/gpu/drm/imx/mhdp/cdns-mhdp-dp-phy.c
 create mode 100644 drivers/gpu/drm/imx/mhdp/cdns-mhdp-hdmi-phy.c
 create mode 100644 drivers/gpu/drm/imx/mhdp/cdns-mhdp-imxdrv.c
 create mode 100644 drivers/gpu/drm/imx/mhdp/cdns-mhdp-phy.h
 delete mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 rename drivers/gpu/drm/rockchip/cdn-dp-reg.h => include/drm/bridge/cdns-mhdp.h (64%)

-- 
2.17.1

