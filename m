Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B746C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3822078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pc8rpVQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFKMmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:42:42 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:55549 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgFKMmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:42:38 -0400
IronPort-SDR: BDhnoII0M5j0AM5ACfu2EdEEfKtrSoGwXs9TITsJg5tafTNqmjMvEAdbtBJqsIf8yK4TN9pjls
 JFVMi70zHZr4Zz+6UyNfU3SvC/6p7vsqJwtE/xxnhbKxRpdaIaEbDwPidJlhyC99oTRuMyz+EQ
 KHZUIFWKJUohBpOW1RLHlZ6RgX7sknV958rtKcuKEUbRH63+9m6yYPP3I2yxqpTGI0XCQkVM9i
 ipGjQZiqb9GpXVvmM/3IUeJqjzlSH4MVoXPqraC048EF5gHJe64xgeK+jIc5dhudLxSOUdiHgi
 Wtk=
X-IronPort-AV: E=Sophos;i="5.73,499,1583190000"; 
   d="scan'208";a="12649669"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Jun 2020 14:42:27 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 11 Jun 2020 14:42:27 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 11 Jun 2020 14:42:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591879347; x=1623415347;
  h=from:to:cc:subject:date:message-id;
  bh=Z1KnUC/hvmXTSff/Y1nN8ENTL/SaSbNXTvnFH3mC13w=;
  b=pc8rpVQOhu/QjvRZxn7gEiZmQB6oEVOsz6+VCEFDkTsOyUpI+sirlVsV
   b2Xng+to8yUgRBX7CMnDA0XkEmxNSZ3V7wli22Tf3TZiHMrmZAWfkHW1u
   7OK99hr5N9PqVMP8lKxBzK1JEMFrEQH7dkv1hHK/huabZXk8CBE22vfzq
   EToeBCc2lv5prSD7/RDbpVoElZq1wcQJ9FdFmSb7PDIvmMFJFFpoPn5CS
   HUqpoDkc7J5JTC/wHVl2DfdD27pEyRZfFl32Vu983ZJSra1dVIR76vglJ
   Pd+q7+GOY2R5vKUIdJEkkBi3I0itc9XWZFcwI2jOTW3ecOSkjnZJLBVHv
   Q==;
IronPort-SDR: 58/fS4MqYbuzlu3KiGn9d8ovU5yqdtmXhZBT2zOLsLVH/zAWlKKz1NSz1tjEOFoWi8n8tkDAFB
 dJ/eGD9hpkqOFmUhF7lRLw52COW55B8y2kRzkKyTug90MFV/zCKswY8fszabEGN7niA3Ya6lZ1
 Jrjc+JzKkETrMigGLrLZkGy4BvxUBiBZ7Y4noLGKO16+PRTTdD6XxUftpllzy00Wi09s2dtr/v
 +1c6HR0Sa9qIEiFib4OsReL3wD6PEf5Q16m22459Iyd7FUq7yChjDLFN9sWQfGIqq/fq+ldOAv
 r1k=
X-IronPort-AV: E=Sophos;i="5.73,499,1583190000"; 
   d="scan'208";a="12649668"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Jun 2020 14:42:27 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 56D71280075;
        Thu, 11 Jun 2020 14:42:28 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 4/4] drm/panel: simple: add Tianma TM070JVHG33
Date:   Thu, 11 Jun 2020 14:42:09 +0200
Message-Id: <20200611124209.25028-4-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611124209.25028-1-matthias.schiffer@ew.tq-group.com>
References: <20200611124209.25028-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
References: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Merchel <Max.Merchel@tq-group.com>

Add support for the Tianma Micro-electronics TM070JVHG33 7.0" WXGA display
to panel-simple.

Signed-off-by: Max Merchel <Max.Merchel@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2:
- added connector_type
- fixed bus_format

 drivers/gpu/drm/panel/panel-simple.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ee9815e5eee8..54f121256832 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3380,6 +3380,18 @@ static const struct panel_desc tianma_tm070jdhg30 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct panel_desc tianma_tm070jvhg33 = {
+	.timings = &tianma_tm070jdhg30_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 150,
+		.height = 94,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing tianma_tm070rvhg71_timing = {
 	.pixelclock = { 27700000, 29200000, 39600000 },
 	.hactive = { 800, 800, 800 },
@@ -3983,6 +3995,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "tianma,tm070jdhg30",
 		.data = &tianma_tm070jdhg30,
+	}, {
+		.compatible = "tianma,tm070jvhg33",
+		.data = &tianma_tm070jvhg33,
 	}, {
 		.compatible = "tianma,tm070rvhg71",
 		.data = &tianma_tm070rvhg71,
-- 
2.17.1

