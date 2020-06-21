Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5256C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82738252CD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYjGmbgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgFUW2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbgFUW2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 18:28:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA42C061796;
        Sun, 21 Jun 2020 15:28:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d27so8492944lfq.5;
        Sun, 21 Jun 2020 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gpWZvRfCvlHf7NtxX+3427d5thggZdJwdjj+htiUY4=;
        b=iYjGmbgbU5QQOVUlQlQWv4yfAS1JWsQPDOc/qaef/ipp10YQTroEhWpINX3UFQT0zJ
         ej3eXlmW6YzhDbFBIpiPSUXjnQ29a7rMfWPy+091pK5hKK00rKGN/+PVjsgGW21PFzfs
         CUXRcmVK7MVjE+Z7Z5/UCgX63yeryFgsoDNQehkJ1AiahFi/NXzQoOFGXxQJrWGtFd0l
         DuIoy/18NLVznVE1SAjd9HU1Lu4hepJMJoV0JwG1k1vxdp7sR1iKd+FK3e6YWr85BnCA
         K3cKaILKbp0HZHcp4wK791gtGBlhTjn05e9oioXiV4fZ9Q+aufiFGBb9bUlatKWNbuw9
         ebLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gpWZvRfCvlHf7NtxX+3427d5thggZdJwdjj+htiUY4=;
        b=aOfy2zL/6aaNDQdKzPKUJBs3BqWBua08h5U7QpAmdorcsbxe+ZsQNjp0d0RCxQb6s8
         jx0EQbih8Kgj/ds/5DjwugfnSMiTpxVtScMGNyynlPi5d6SpezC9NFmOPXJpFGvl8GwO
         tZMQFuQTOsnvzCu6EvOyRMiYi8yfqvtPnujaz/mylbyIIxKEufGxs19hlaNT40o+A2fZ
         wGhVQT54QBnE19hU+y+V4GKQI+JI/yabX4IBF5fq19Z56zyRCqA3eY0akLEnDXfNQbnE
         jKdmBdei0Sp9t5Ev1/9hhpmUWpgpg1WAipS09VbDA3RRnwbRejOrWFnBeE0xIq/JTQuY
         qybg==
X-Gm-Message-State: AOAM5311E3mfgi1PLBYhaAlS5BrQkbE+e2d9I0cnmo8smwLUv+ZMtZF0
        dLsUm1UrJd3J6EWKpXBa2wM=
X-Google-Smtp-Source: ABdhPJxx90OzdENre2w/gS/55wOw8HSAbFai550KDVjSfFoglYrYNACk/U9n3Jr+2bVByFIJxWOj6w==
X-Received: by 2002:a19:87c2:: with SMTP id j185mr7700444lfd.183.1592778485052;
        Sun, 21 Jun 2020 15:28:05 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id 11sm2361295lju.118.2020.06.21.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 15:28:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] drm/panel-simple: Add missing BUS descriptions for some panels
Date:   Mon, 22 Jun 2020 01:27:42 +0300
Message-Id: <20200621222742.25695-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200621222742.25695-1-digetx@gmail.com>
References: <20200621222742.25695-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing BUS fields to the display panel descriptions of
the panels which are found on NVIDIA Tegra devices:

  1. AUO B101AW03
  2. Chunghwa CLAA070WP03XG
  3. Chunghwa CLAA101WA01A
  4. Chunghwa CLAA101WB01
  5. Innolux N156BGE L21
  6. Samsung LTN101NT05

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 87edd2bdf09a..986df9937650 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -698,6 +698,8 @@ static const struct panel_desc auo_b101aw03 = {
 		.width = 223,
 		.height = 125,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
@@ -1352,6 +1354,8 @@ static const struct panel_desc chunghwa_claa070wp03xg = {
 		.width = 94,
 		.height = 150,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
@@ -1375,6 +1379,8 @@ static const struct panel_desc chunghwa_claa101wa01a = {
 		.width = 220,
 		.height = 120,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
@@ -1398,6 +1404,8 @@ static const struct panel_desc chunghwa_claa101wb01 = {
 		.width = 223,
 		.height = 125,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
@@ -2071,6 +2079,8 @@ static const struct panel_desc innolux_n156bge_l21 = {
 		.width = 344,
 		.height = 193,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
@@ -3018,6 +3028,8 @@ static const struct panel_desc samsung_ltn101nt05 = {
 		.width = 223,
 		.height = 125,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
-- 
2.26.0

