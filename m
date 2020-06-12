Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD585C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B1620801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QMFZxGZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgFLHXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:23:01 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:36117 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgFLHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:22:47 -0400
IronPort-SDR: 3954E3DTKgSIxSoM0oSWkLqhg6efcdxhIx+1QHJKLFYjBZ/RB+aP+Ujsw1NBe87MUFAg6fj1oZ
 MQ0mgFlpYJvfC+ofHz0rq4HwyKHg10rIikcRwv8J4ogaPQ3uiqGtwWagN2VrJOg4vA0lxABEot
 wOyaZqNAyuOAAXxu/IaBHMUapHkfZ9DVsOsJAF1vRJMXxwV6H6qqeFiZgqTPhqgicuckwnQGDW
 m1PX1lJVnjG3pxsLnhSENIrzyg/2k89isa7mwoW/8c0IeKjGtS1i8gcX6bpVlruWBGo9HBFJUl
 3OA=
X-IronPort-AV: E=Sophos;i="5.73,502,1583190000"; 
   d="scan'208";a="12657246"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Jun 2020 09:22:40 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 12 Jun 2020 09:22:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 12 Jun 2020 09:22:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591946560; x=1623482560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=w92AlLWT7nwDfbklnB9I+khUvogaeBHHV8tKD4NSxZk=;
  b=QMFZxGZG2SQTwddBs22c9sYofK38L41y4lFLe7im3YvyACjbinPSnWf4
   p2Eje16qzwwYQNCyTldWjb/RsZdZlNwQYT7sRoLG+LId/GuRI5eK6kSGG
   UzQBPsUMGJkIjzBMD4Z4PQ4XUF2ZyHnlKqrIe4aPd4TZpVzCavsQ8HEIN
   bFjgFaDuT6CaVU4XBUDcXYk/SYmfoLcb3/JlgUjd5zwA+2+0Ozri5G1yv
   P7w2MYfmhDeMgA2Y3yVgHCXPLDUjFEl8/QvxIUzJ+HnojcVQtOYg+14RN
   +3EmVuuk9z6U2OdoPgCr2pSll6cLFFvDLRjZ8A3xlSp6Ouh0a+rxsVWXc
   A==;
IronPort-SDR: XRSdfTKADavB8LljBiS1q3LzFqsRVLsQf26V3C57Lw4Y5EVMfu5BcvvimJSVKli0sAfJCUhzXy
 mv1xbLDOdOxaeddzprOR0EOwvCBgv8nvC5AE1+YIWjBOeCS81fTzkmKVV1UAM17G38eJTahXF5
 nT+rHYveu4tkGa4x942SXgZ1EEE2ApqZMnPtwaTkIvT1/LH4MaSeY+eU1aSQLZKIh9ErhnMuVI
 Ccr9A+Cdwe5c/GRYjgmlXccIU/jq9aKy2odbrdegSEqLgxKOOk6vTA09XIyoTIwjJgdcswesQM
 NOA=
X-IronPort-AV: E=Sophos;i="5.73,502,1583190000"; 
   d="scan'208";a="12657245"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Jun 2020 09:22:40 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id DB565280075;
        Fri, 12 Jun 2020 09:22:40 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH RESEND v2 3/4] drm/panel: simple: add CDTech S070PWS19HP-FC21 and S070SWV29HG-DC44
Date:   Fri, 12 Jun 2020 09:22:18 +0200
Message-Id: <20200612072219.13669-4-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
References: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>

Add support for the CDTech Electronics displays S070PWS19HP-FC21
(7.0" WSVGA) and S070SWV29HG-DC44 (7.0" WVGA) to panel-simple.

Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2:
- removed vrefresh
- added connector_type

 drivers/gpu/drm/panel/panel-simple.c | 60 ++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 6764ac630e22..ee9815e5eee8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1296,6 +1296,60 @@ static const struct panel_desc cdtech_s043wq26h_ct7 = {
 	.bus_flags = DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 };
 
+/* S070PWS19HP-FC21 2017/04/22 */
+static const struct drm_display_mode cdtech_s070pws19hp_fc21_mode = {
+	.clock = 51200,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 160,
+	.hsync_end = 1024 + 160 + 20,
+	.htotal = 1024 + 160 + 20 + 140,
+	.vdisplay = 600,
+	.vsync_start = 600 + 12,
+	.vsync_end = 600 + 12 + 3,
+	.vtotal = 600 + 12 + 3 + 20,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc cdtech_s070pws19hp_fc21 = {
+	.modes = &cdtech_s070pws19hp_fc21_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
+/* S070SWV29HG-DC44 2017/09/21 */
+static const struct drm_display_mode cdtech_s070swv29hg_dc44_mode = {
+	.clock = 33300,
+	.hdisplay = 800,
+	.hsync_start = 800 + 210,
+	.hsync_end = 800 + 210 + 2,
+	.htotal = 800 + 210 + 2 + 44,
+	.vdisplay = 480,
+	.vsync_start = 480 + 22,
+	.vsync_end = 480 + 22 + 2,
+	.vtotal = 480 + 22 + 2 + 21,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc cdtech_s070swv29hg_dc44 = {
+	.modes = &cdtech_s070swv29hg_dc44_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode cdtech_s070wv95_ct16_mode = {
 	.clock = 35000,
 	.hdisplay = 800,
@@ -3674,6 +3728,12 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "cdtech,s043wq26h-ct7",
 		.data = &cdtech_s043wq26h_ct7,
+	}, {
+		.compatible = "cdtech,s070pws19hp-fc21",
+		.data = &cdtech_s070pws19hp_fc21,
+	}, {
+		.compatible = "cdtech,s070swv29hg-dc44",
+		.data = &cdtech_s070swv29hg_dc44,
 	}, {
 		.compatible = "cdtech,s070wv95-ct16",
 		.data = &cdtech_s070wv95_ct16,
-- 
2.17.1

