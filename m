Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2453DC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01D1214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646489;
	bh=gYdxsnJ50hEKocvMFUM901yBYLzh3YGfPiYu/8Zj+BE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j+iL//UqZPRbmGuq+hHQ+8VgKzmM77bktklAeCSd3n9nM7Cfdl+T59C1p6yOOApbC
	 7Yt+zSOE51POkbPB/JHcrUE9wHWqhLFqHGtunQWTBX68LOWKNzKPNlbHtTfu1bfjSD
	 oMTUfPpbCsVK4Y2P7epaByor8LRanuVw+gCKLJD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgDKXIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgDKXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288F6214D8;
        Sat, 11 Apr 2020 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646472;
        bh=gYdxsnJ50hEKocvMFUM901yBYLzh3YGfPiYu/8Zj+BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gez2/S86hrIvUn5d05U/YTNxx5/Trghcs5fsOGy0kbgM3fkZDuWROOT0M+kGfsAOO
         LmLlfjukt13AQWmz0us5htEn/vt7EAqhSRUR2RRB99LFPSPb/LtAiWINFIpaIyvbMz
         v6EdoOWiByYt2yidy2dmn5RlmndnQ7kzDYvT9BLQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 039/121] drm/panel: simple: fix osd070t1718_19ts sync drive edge
Date:   Sat, 11 Apr 2020 19:05:44 -0400
Message-Id: <20200411230706.23855-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit fb0629eeeedb6622c16da1aa76a4520daf9a46e2 ]

The panel datasheet says that the panel samples at falling edge, but
does not say anything about h/v sync signals. Testing shows that if the
sync signals are driven on falling edge, the picture on the panel will
be slightly shifted right.

Setting sync drive edge to the same as data drive edge fixes this issue.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20191114093950.4101-4-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 72f69709f3493..df2c7392463b5 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2431,7 +2431,8 @@ static const struct panel_desc osddisplays_osd070t1718_19ts = {
 		.height = 91,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
-	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE |
+		DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE,
 	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
-- 
2.20.1

