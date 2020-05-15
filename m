Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA23BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4BB206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEONM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:12:28 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53422 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEONMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:12:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 52D22FB09;
        Fri, 15 May 2020 15:12:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MkNYiLtyIAdX; Fri, 15 May 2020 15:12:16 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5C6A9445A7; Fri, 15 May 2020 15:12:15 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/6] drm/bridge: Add mux input selection bridge
Date:   Fri, 15 May 2020 15:12:09 +0200
Message-Id: <cover.1589548223.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bridge driver allows to select the input to a downstream bridge (or panel)
via device tree.

It can be useful to separate the pixel source selection from the actual bridge
processing the pixel data. E.g. NXP's imx8mq has two display controllers. Both
can feed the pixel data to the NWL DSI IP core. The input selection is done via
a separate mux register elsewhere on the chip, so separating this out avoids SoC
specific code in such drivers.

The current implementation allows to select the input source via device tree.
The long term goal is to allow to switch the input source at run time. This
can be useful to e.g. use the less power hungry display controller for normal
operation but switch to a the other display controller when running full screen
games (since it can detile textures more efficiently).

This was initially suggested by Laurent Pinchart¹. It is similar in spirit to
the video-mux in the media subsystem but for DRM bridges.

Besides the actual driver this series includes the necessary bits to demo the
usage for the Librem5 devkit.

The series is based on linux-next as of next-20200512.

¹ https://lore.kernel.org/dri-devel/20200415021908.GH19819@pendragon.ideasonboard.com/

Guido Günther (6):
  dt-bindings: display/bridge: Add binding for input mux bridge
  drm/bridge: Add mux-input bridge
  dt-bindings: display/bridge/nwl-dsi: Drop mux handling
  drm/bridge/nwl-dsi: Drop mux handling
  arm64: dts: imx8mq: Add NWL dsi controller
  arm64: dts: imx8mq-librem5-devkit: Enable MIPI DSI panel

 .../display/bridge/mux-input-bridge.yaml      | 123 +++++++++
 .../bindings/display/bridge/nwl-dsi.yaml      |   6 -
 .../dts/freescale/imx8mq-librem5-devkit.dts   |  81 ++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  31 +++
 drivers/gpu/drm/bridge/Kconfig                |  10 +-
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/mux-input.c            | 238 ++++++++++++++++++
 drivers/gpu/drm/bridge/nwl-dsi.c              |  61 -----
 8 files changed, 483 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
 create mode 100644 drivers/gpu/drm/bridge/mux-input.c

-- 
2.26.1

