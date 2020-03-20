Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EBC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CAB20784
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pascalroeleven.nl header.i=@pascalroeleven.nl header.b="FLBfp2e7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCTLZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:25:16 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:56898 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgCTLZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D4dn5xv1jw6ViZLrXaslqz7DLr1R4Uo+6Hf42tlM8Q4=; b=FLBfp2e7/0Qa/v9Fudx1ORiNXS
        JV+b8iUSNJpkJrzaIwwkiQopeQZ+qTCveHWN3jx4RM6ab+/t3NQGBbkFlRIRjB8I06dicoCwxg94+
        Rxip8VdkQ9gwM9dkTnjZfm3c5Kup10Dq9TyzHtlpbSUwQjY7DdnXbcIUtgAH2vo5bFyqx/rToICcM
        H/QkNaDtbsI9ZgsJc2vKz6wjl2t7/DFcV5PT4JVHpfJRy7yKAxY8ZjHUIHjx0/Gi+/YS0p5dB4n15
        nWOWUmVJF0qlafkbZgdUtvdLVDlGANH8YIyLGioeIzA2hYZLUt268RZIFCiPlFqDOr51b4r5p+IlT
        V0bpqgJw==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:57936 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jFFm3-0011ci-4I; Fri, 20 Mar 2020 12:25:11 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [PATCH v2 2/5] drm: panel: Add Starry KR070PE2T
Date:   Fri, 20 Mar 2020 12:21:33 +0100
Message-Id: <20200320112205.7100-3-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320112205.7100-1-dev@pascalroeleven.nl>
References: <20200320112205.7100-1-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: dev@pascalroeleven.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KR070PE2T is a 7" panel with a resolution of 800x480.

KR070PE2T is the marking present on the ribbon cable. As this panel is
probably available under different brands, this marking will catch
most devices.

As I can't find a datasheet for this panel, the bus_flags are instead
from trial-and-error. The flags seem to be common for these kind of
panels as well.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e14c14ac6..b3d257257 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2842,6 +2842,32 @@ static const struct panel_desc shelly_sca07010_bfn_lnn = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode starry_kr070pe2t_mode = {
+	.clock = 33000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 209,
+	.hsync_end = 800 + 209 + 1,
+	.htotal = 800 + 209 + 1 + 45,
+	.vdisplay = 480,
+	.vsync_start = 480 + 22,
+	.vsync_end = 480 + 22 + 1,
+	.vtotal = 480 + 22 + 1 + 22,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc starry_kr070pe2t = {
+	.modes = &starry_kr070pe2t_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 152,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode starry_kr122ea0sra_mode = {
 	.clock = 147000,
 	.hdisplay = 1920,
@@ -3474,6 +3500,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "shelly,sca07010-bfn-lnn",
 		.data = &shelly_sca07010_bfn_lnn,
+	}, {
+		.compatible = "starry,kr070pe2t",
+		.data = &starry_kr070pe2t,
 	}, {
 		.compatible = "starry,kr122ea0sra",
 		.data = &starry_kr122ea0sra,
-- 
2.20.1

