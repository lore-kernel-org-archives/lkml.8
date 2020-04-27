Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2CC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D3C20661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgD0IXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:23:01 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:34789 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbgD0IXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:23:01 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583161200"; 
   d="scan'208";a="45816403"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Apr 2020 17:22:59 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [172.29.51.26])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id BC8874017274;
        Mon, 27 Apr 2020 17:22:55 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/panel: simple: Add Newhaven ATXL#-CTP panel
Date:   Mon, 27 Apr 2020 09:21:49 +0100
Message-Id: <1587975709-2092-4-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587975709-2092-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1587975709-2092-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for the Newhaven ATXL#-CTP panel used by the
Renesas RZ/N1 Demo Board.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5a93c4e..0b57b0e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2021,6 +2021,30 @@ static const struct panel_desc newhaven_nhd_43_480272ef_atxl = {
 		     DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE,
 };
 
+static const struct display_timing newhaven_nhd_50_800480tf_atxl_timing = {
+	.pixelclock = { 33300000, 33400000, 33500000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 40, 40, 40 },
+	.hback_porch = { 88, 88, 88 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 13, 13, 13 },
+	.vback_porch = { 32, 32, 32 },
+	.vsync_len = { 3, 3, 3 },
+	.flags = DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH,
+};
+
+static const struct panel_desc newhaven_nhd_50_800480tf_atxl = {
+		.timings = &newhaven_nhd_50_800480tf_atxl_timing,
+		.num_timings = 1,
+		.bpc = 8,
+		.size = {
+			.width = 400,
+			.height = 300,
+		},
+		.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+};
+
 static const struct display_timing nlt_nl192108ac18_02d_timing = {
 	.pixelclock = { 130000000, 148350000, 163000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -2964,6 +2988,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "newhaven,nhd-4.3-480272ef-atxl",
 		.data = &newhaven_nhd_43_480272ef_atxl,
 	}, {
+		.compatible = "newhaven,nhd-5.0-800480tf-atxl",
+		.data = &newhaven_nhd_50_800480tf_atxl,
+	}, {
 		.compatible = "nlt,nl192108ac18-02d",
 		.data = &nlt_nl192108ac18_02d,
 	}, {
-- 
2.7.4

