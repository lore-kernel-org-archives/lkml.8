Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC259C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978EC22522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgATRGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:06:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38224 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgATRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:06:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5C007291329
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 5/5] drm/rockchip: rk3066_hdmi: Cleanup component unbind
Date:   Mon, 20 Jan 2020 14:06:02 -0300
Message-Id: <20200120170602.3832-6-ezequiel@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120170602.3832-1-ezequiel@collabora.com>
References: <20200120170602.3832-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove drm_connector_unregister() since it should be
used only by drivers that call drm_dev_register
explicitly.

Also, call the DRM cleanups directly, instead of
(ab)using the destroy hooks, for readability reasons.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index fe203d38664e..5a2d62a2cf50 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -518,7 +518,6 @@ rk3066_hdmi_probe_single_connector_modes(struct drm_connector *connector,
 
 static void rk3066_hdmi_connector_destroy(struct drm_connector *connector)
 {
-	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 }
 
@@ -819,8 +818,8 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 	return 0;
 
 err_cleanup_hdmi:
-	hdmi->connector.funcs->destroy(&hdmi->connector);
-	hdmi->encoder.funcs->destroy(&hdmi->encoder);
+	drm_connector_cleanup(&hdmi->connector);
+	drm_encoder_cleanup(&hdmi->encoder);
 err_disable_i2c:
 	i2c_put_adapter(hdmi->ddc);
 err_disable_hclk:
@@ -834,9 +833,6 @@ static void rk3066_hdmi_unbind(struct device *dev, struct device *master,
 {
 	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
 
-	hdmi->connector.funcs->destroy(&hdmi->connector);
-	hdmi->encoder.funcs->destroy(&hdmi->encoder);
-
 	i2c_put_adapter(hdmi->ddc);
 	clk_disable_unprepare(hdmi->hclk);
 }
-- 
2.25.0

