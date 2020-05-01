Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E1C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCD92173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgEAPXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:23:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33470 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgEAPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:23:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CD1842A21CA
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 0/7] Convert mtk-dsi to drm_bridge API and get EDID for ps8640 bridge
Date:   Fri,  1 May 2020 17:23:28 +0200
Message-Id: <20200501152335.1805790-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PS8640 dsi-to-eDP bridge driver is using the panel bridge API,
however, not all the components in the chain have been ported to the
drm_bridge API. Actually, when a panel is attached the default panel's mode
is used, but in some cases we can't get display up if mode getting from
eDP control EDID is not chosen.

This series address that problem, first implements the .get_edid()
callback in the PS8640 driver (which is not used until the conversion is
done) and then, converts the Mediatek DSI driver to use the drm_bridge
API.

As far as I know, we're the only users of the mediatek dsi driver in
mainline, so should be safe to switch to the new chain of drm_bridge API
unconditionally.

The patches has been tested on a Acer Chromebook R13 (Elm) running a
Chrome OS userspace and checking that the valid EDID mode reported by
the bridge is selected.

Enric Balletbo i Serra (7):
  drm/bridge: ps8640: Get the EDID from eDP control
  drm/bridge_connector: Set default status connected for eDP connectors
  drm/mediatek: mtk_dsi: Rename bridge to next_bridge
  drm/mediatek: mtk_dsi: Convert to bridge driver
  drm/mediatek: mtk_dsi: Use simple encoder
  drm/mediatek: mtk_dsi: Use the drm_panel_bridge API
  drm/mediatek: mtk_dsi: Create connector for bridges

 drivers/gpu/drm/bridge/parade-ps8640.c |  12 ++
 drivers/gpu/drm/drm_bridge_connector.c |   1 +
 drivers/gpu/drm/mediatek/mtk_dsi.c     | 277 ++++++++-----------------
 3 files changed, 97 insertions(+), 193 deletions(-)

-- 
2.26.2

