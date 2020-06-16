Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7B32078E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgFPKAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:00:47 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36135 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgFPKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:00:43 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 0BB363C0588;
        Tue, 16 Jun 2020 12:00:42 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S-vVknBfQk2h; Tue, 16 Jun 2020 12:00:36 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id E147D3C00BA;
        Tue, 16 Jun 2020 12:00:36 +0200 (CEST)
Received: from vmlxhi-110.adit-jv.com (10.72.93.196) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 16 Jun
 2020 12:00:36 +0200
From:   Ramzi BEN MEFTAH <rbmeftah@de.adit-jv.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Michael Rodin <mrodin@de.adit-jv.com>, <efriedrich@de.adit-jv.com>,
        <erosca@de.adit-jv.com>, Ramzi BEN MEFTAH <rbmeftah@de.adit-jv.com>
Subject: [PATCH 3/3] media: i2c: adv748x: add enuminput control to adv748x hdmi subdev
Date:   Tue, 16 Jun 2020 12:00:17 +0200
Message-ID: <1592301619-17631-3-git-send-email-rbmeftah@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592301619-17631-1-git-send-email-rbmeftah@de.adit-jv.com>
References: <1592301619-17631-1-git-send-email-rbmeftah@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.196]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for enuminput control to the adv748x hdmi subdev.
This will allow userspace for example to query input hdmi signal status.

Signed-off-by: Ramzi BEN MEFTAH <rbmeftah@de.adit-jv.com>
---
 drivers/media/i2c/adv748x/adv748x-hdmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/adv748x/adv748x-hdmi.c
index c557f8f..2d748b2 100644
--- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -350,6 +350,22 @@ static int adv748x_hdmi_g_input_status(struct v4l2_subdev *sd, u32 *status)
 	return 0;
 }
 
+static int adv748x_hdmi_enuminput(struct v4l2_subdev *sd,
+				 struct v4l2_input *input)
+{
+	if (input->index != 0)
+		return -EINVAL;
+
+	input->type = V4L2_INPUT_TYPE_CAMERA;
+	input->capabilities = V4L2_IN_CAP_DV_TIMINGS;
+	input->status = V4L2_IN_ST_NO_SIGNAL;
+	input->std = V4L2_STD_UNKNOWN;
+
+	snprintf(input->name, sizeof(input->name), "%s", sd->name);
+
+	return adv748x_hdmi_g_input_status(sd, &input->status);
+}
+
 static int adv748x_hdmi_s_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct adv748x_hdmi *hdmi = adv748x_sd_to_hdmi(sd);
@@ -386,6 +402,7 @@ static const struct v4l2_subdev_video_ops adv748x_video_ops_hdmi = {
 	.g_dv_timings = adv748x_hdmi_g_dv_timings,
 	.query_dv_timings = adv748x_hdmi_query_dv_timings,
 	.g_input_status = adv748x_hdmi_g_input_status,
+	.enuminput = adv748x_hdmi_enuminput,
 	.s_stream = adv748x_hdmi_s_stream,
 	.g_pixelaspect = adv748x_hdmi_g_pixelaspect,
 };
-- 
2.7.4

