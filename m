Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312562078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GAQujaMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgFJMBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:01:50 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:50371 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbgFJMBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:01:46 -0400
IronPort-SDR: 5eiorkW9xaD7uSKsxy7+32Jayn+pvALBTjPT3nN4vum6YXtlUIwI1TG7lkVUU/ci4xnaNSswns
 2gQblNSd6DYvHUfqsuvcXTJT5gusgnRhHvB9CEkZKOgQc9d9WxHMIC7QzP5ZDd23WAirIpYC16
 YVKnbtoGoWF5Tq5vwojvZFX0V5+Iua0yurUVmKvOKOIRrhQ9bUXdoVacw5gAmTv6nEk3gz1M/+
 GGebUSz+5TeptD+pr8ktSOLZ556Q5HGbJgwWeDhAkxGCwY513o8nZVX/NPJTeIeozsGRmJbGDZ
 x3k=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12636796"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Jun 2020 14:01:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 10 Jun 2020 14:01:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 10 Jun 2020 14:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591790499; x=1623326499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Rt6w08AmrIXv5fgWwVUD1x6J/iZEepXybm9seGqUurQ=;
  b=GAQujaMBPbez78VANruH0HcYbXhgedCOQ/U0Cb2vcN8PzOUiAaLNShf7
   /1PZ+wyxrrBi5Po+PjRSFNiKnoa2zJqgtXQWKm/Sx5mCnG6wINiQc9uEZ
   mDSEzYLSe7hSHtV5hSGd0Afa0GZeMNGxeFCdG+63jQz0gE42ZISQuIe2K
   buRSc17Cb5TyRqKxwtVZE48YRhh3V9MdtwqHC4MvEU+VFZYRakTQqMqPY
   qct3inz+PGsynHqDW0vyp3i3HmY+7DdT1Su7D6wTTFDShKfo07ujF6Dvy
   CGbJqRG6fDoyAJOu6v+oWTSJZ4rdSV+DnVjVIPNqZgpbWZExocpslMtsc
   A==;
IronPort-SDR: guSyCsrAuQ+ZKThGCqoXVMMha4x2F2IlXPqBohZ4mko7PyWScLgYmLFfXDbqkQVJbSOqJ6Eih5
 Y2lt7PZisBrtDMgUmL/xRbobipDaKa+sflzOrBU2qUfgy2WS0bTsXjdtnNThn5GVIobA46ejZm
 2H/2UWxI0ShSil0mOzMEbE+r8zN0O477UktJUC6/rXYZFeYW1EHAWPQJhkYR6Df5GerwcroqxS
 pW1rxKmgfruDRdxHzFjkQHtcBFZwBCaD0a09s9EqVeppTN24cvGRdBnXq2C4T2YPlKrqCAqYOk
 mZc=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12636795"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jun 2020 14:01:39 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 046A4280065;
        Wed, 10 Jun 2020 14:01:40 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/4] drm/panel: simple: add Tianma TM070JVHG33
Date:   Wed, 10 Jun 2020 14:01:31 +0200
Message-Id: <20200610120131.3069-5-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/gpu/drm/panel/panel-simple.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 1673113e5a5a..68fcf68da1f3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3421,6 +3421,17 @@ static const struct panel_desc tianma_tm070jdhg30 = {
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
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+};
+
 static const struct display_timing tianma_tm070rvhg71_timing = {
 	.pixelclock = { 27700000, 29200000, 39600000 },
 	.hactive = { 800, 800, 800 },
@@ -4029,6 +4040,9 @@ static const struct of_device_id platform_of_match[] = {
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

