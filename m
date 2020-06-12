Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721ACC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E4820801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ksOpC1Qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFLHW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:22:56 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:36108 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgFLHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:22:47 -0400
IronPort-SDR: JvtKvJgNDhMfCgb8pjHZ0UFAXd48YST0yC8xM5K/DtmUebebOnrCWQ7d44uOlpEW+YtSZmBoTq
 qf0Z5QQTT1C4Rq0myE2N0vDAnT0cHbGnNxzwuaWLfUu4RBRHnDImQInTmNb3S/3v8WftDGZ8rx
 2c4kHCL4zDXYR+joSj6Jd3gjldX2aXM+l21uixN4AolY8S2b/Obc22kiVOwFG/8APHmRZ7IAkb
 7XZqpoHx1f+QFDM+jDnKqV+KSiP4EoUUxgR5ISvyqL/ZYOfBG6uD92C/zpVPXyUuwzeD1LTOiu
 xfU=
X-IronPort-AV: E=Sophos;i="5.73,502,1583190000"; 
   d="scan'208";a="12657248"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Jun 2020 09:22:41 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 12 Jun 2020 09:22:41 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 12 Jun 2020 09:22:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591946561; x=1623482561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Z1KnUC/hvmXTSff/Y1nN8ENTL/SaSbNXTvnFH3mC13w=;
  b=ksOpC1QxMZUaC+fKqe8AZGIEGnPP1QT2ItyDAMQJcnh0ryy0ST+uF2xv
   RMEjVePZQEd0k5LjGkpvyIphxZZhMfarYkf1L0jmiwAbr41YS55xxA3eN
   BzWToZgtrSgoUJOibkREjbfTxamk+fMKhlREplRAB2tQVUJNKmAabp2hM
   D6MkTNgb5kqeQlfd5ciUOxC8499w0W7p1djiR/b4EPs8e0a1r61BtVBax
   d+CX4+RjVbQvC+TywzoFJcUu7u909v+i1ZgqfWtakSuLgl4EoUTd3/9rT
   13M/cLYLlpgevvINiHD01d/b+ypFs0K0glxQM9KxEJ6jnJcfa4Oyt1sbW
   g==;
IronPort-SDR: ciwQqwqYChn3hIWeHbgQTR5ZdwT/blv2K37gknapFQwgtI71iFbw4X/1MmkT70W1e+eVczqF/5
 R8OVaRAvFJ6Ua93WXKP3vbUdH/0jufIojJZjD6cLnx/tO/Uwc9Q5sbSK3yNVc0xiQ5SqRrzciv
 ipi+rgQaYDsQaSK3kIfFuMZk/WCq2Htzh9NOBa0aYdwVz38pwUaB72ahrMqGyBZu43uZvjaIuR
 ZCmwT/fOKJnthBrPJ4NOmyJES/O57cD/FDixjYIqZbJcT6opsjEcv4OTTJOSAS2M3GAaUq1tSN
 Yps=
X-IronPort-AV: E=Sophos;i="5.73,502,1583190000"; 
   d="scan'208";a="12657247"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Jun 2020 09:22:41 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 11917280065;
        Fri, 12 Jun 2020 09:22:41 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH RESEND v2 4/4] drm/panel: simple: add Tianma TM070JVHG33
Date:   Fri, 12 Jun 2020 09:22:19 +0200
Message-Id: <20200612072219.13669-5-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
References: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
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

