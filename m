Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1132067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbgFISVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbgFIRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:48:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E12C03E97C;
        Tue,  9 Jun 2020 10:48:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id B100A2A3B92
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko@sntech.de>,
        Philippe CORNU <philippe.cornu@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v9 11/11] Documentation: gpu: todo: Add dw-mipi-dsi consolidation plan
Date:   Tue,  9 Jun 2020 20:49:59 +0300
Message-Id: <20200609174959.955926-12-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174959.955926-1-adrian.ratiu@collabora.com>
References: <20200609174959.955926-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the longer-term plan to cleanup the dw-mipi-dsi bridge
based drivers after the regmap refactor and i.MX6 driver have landed.

The goal is to get the entire bridge logic in one place and continue
the refactorings under the drm/bridge tree.

Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/gpu/todo.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 658b52f7ffc6c..2b142980a4b16 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -548,6 +548,31 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
+Reorganize dw-mipi-dsi bridge-based host-controller drivers
+-----------------------------------------------------------
+
+The Synopsys DW MIPI DSI bridge is used by a number of SoC platform drivers
+(STM, Rockchip, i.MX) which don't cleanly encapsulate their bridge logic which
+gets split between the Synopsys bridge (drm/bridge/synopsys/dw-mipi-dsi.c) and
+platform drivers like drm/imx/dw_mipi_dsi-imx6.c by passing around the bridge
+configuration regmap, creating new bridges / daisy chaining in platform drivers,
+duplicating encoder creation, having too much encoder logic instead of using the
+simple encoder interface and so on.
+
+The goal of this rework is to make the dw-mipi-dsi driver a better encapsulated
+bridge by moving all bridge-related logic under drm/bridge, including the SoC
+bindings which chain to the core Synopsys code under drm/bridge/dw-mipi-dsi/
+from which they can be further consolidated and cleaned up.
+
+If this goal proves to be impossible then drm_bridge might not be the correct
+abstraction for these host controllers and unifying their logic into a helper
+library encapsulating a drm_encoder might be more desirable, in other words to
+move away from drm_bridge entirely.
+
+Contact: Adrian Ratiu, Daniel Vetter, Laurent Pinchart
+
+Level: Intermediate
+
 Bootsplash
 ==========
 
-- 
2.27.0

