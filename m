Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFDDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E6A20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHLIgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:36:42 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:57902 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgHLIgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:36:42 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id EEF85C0E68;
        Wed, 12 Aug 2020 16:36:37 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P18983T140547182274304S1597221393900250_;
        Wed, 12 Aug 2020 16:36:38 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4de425ab9edd523934713eb06a4f3632>
X-RL-SENDER: algea.cao@rock-chips.com
X-SENDER: algea.cao@rock-chips.com
X-LOGIN-NAME: algea.cao@rock-chips.com
X-FST-TO: a.hajda@samsung.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Algea Cao <algea.cao@rock-chips.com>
To:     a.hajda@samsung.com, kuankuan.y@gmail.com, hjc@rock-chips.com,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org, airlied@linux.ie, heiko@sntech.de,
        jernej.skrabec@siol.net, algea.cao@rock-chips.com,
        Laurent.pinchart@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com, jonas@kwiboo.se,
        mripard@kernel.org, darekm@google.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, cychiang@chromium.org,
        linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, maarten.lankhorst@linux.intel.com,
        daniel@ffwll.ch
Subject: [PATCH 6/6] drm: bridge: dw-hdmi: Get output bus format when dw-hdmi is the only bridge
Date:   Wed, 12 Aug 2020 16:36:31 +0800
Message-Id: <20200812083631.4411-1-algea.cao@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812083120.743-1-algea.cao@rock-chips.com>
References: <20200812083120.743-1-algea.cao@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If plat_data->get_output_bus_format() is exist, we can
use it to get hdmi output bus format when dw-hdmi is the
only bridge. The hdmi output bus format can be set by vendor
properties.

Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
---

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 1eb4736b9b59..878e9e506963 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2644,6 +2644,8 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 					unsigned int *num_output_fmts)
 {
 	struct drm_connector *conn = conn_state->connector;
+	struct dw_hdmi *hdmi = bridge->driver_private;
+	void *data = hdmi->plat_data->phy_data;
 	struct drm_display_info *info = &conn->display_info;
 	struct drm_display_mode *mode = &crtc_state->mode;
 	u8 max_bpc = conn_state->max_requested_bpc;
@@ -2662,7 +2664,11 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	/* If dw-hdmi is the only bridge, avoid negociating with ourselves */
 	if (list_is_singular(&bridge->encoder->bridge_chain)) {
 		*num_output_fmts = 1;
-		output_fmts[0] = MEDIA_BUS_FMT_FIXED;
+		if (hdmi->plat_data->get_output_bus_format)
+			output_fmts[0] =
+				hdmi->plat_data->get_output_bus_format(data);
+		else
+			output_fmts[0] = MEDIA_BUS_FMT_FIXED;
 
 		return output_fmts;
 	}
-- 
2.25.1



