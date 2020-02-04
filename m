Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEEEC3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DCF217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk0UNyyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgBDXto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:49:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33347 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgBDXtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:49:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so80174plb.0;
        Tue, 04 Feb 2020 15:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GoHwA/NUt6bdmcBWMk3GrpTBSbEsSYQ8eBgsnOl6FH8=;
        b=Yk0UNyyAlkctNhCEl0XmAo9v2tutCjwPUMuD76Z53N2E4FftV6cTkCjAHeQGoJsHj7
         QIKwetLhpjlSd9i0Ats6RVGMrEEDEVRLioAxbYfLaBN5889APinEf0m55r5x3KXaVIrZ
         oSQTl6kQyV8sFLASP/vjlidXEX6iS/0RE8mVwS2tKLHUio+gpN488xI69k9G6e56oy9i
         HblJhv895SVGOBfy9iEga1oD2MUI/OGK6OvL9p3QKBzi///hzUbXJEi5AxaXBdj3RDze
         QjNQ3hoaGObwKZyWme74zSLdWqs4meGDHX2FHwsCWvwW5CszqBNMc8y4NEJu8dbbYXWw
         Aa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GoHwA/NUt6bdmcBWMk3GrpTBSbEsSYQ8eBgsnOl6FH8=;
        b=np0QXmpHtU/uqjUkLJhmVY6/thDn85ltdwC/0R81vjwNFuQ8f+tA2Oxn85qcZK2d7j
         k/Oc8HLVACR1Jbmw6gX3iZ5mY7f2wQCBMoGhxEZbUDmVyFxqWeyCO1DyERZ6JbFM0gd/
         1j0gTQl6NQH27piGVgcqm75DSwbQlCLdpqew3UEsY4tEoO3h+7i59L6xpWftT7cxp3fB
         Io+Iw4Vv2yctkttx7xF2cj3K681OhuWzEla0EgziCuKF9OeKtgAh1FLl9NI3U7FyawnI
         mWGzj0O6knYmAI8gZvt1XwIHhxU9vFbnkF+9Rc09HR4NWIPLrJT10oaFiZNRY7MxNcwo
         XCbw==
X-Gm-Message-State: APjAAAU7GcYahxEbUeUz88X7Hupqnt5F6Y8KY87qZ2WGRzxl/3g8UIAu
        ZWYbLHuh48r1AjaQy2hZTOlEdAC3
X-Google-Smtp-Source: APXvYqzscwmenowcDy7Jeog/8AGe1JciDVrcX+rmRLWuTOpy9AufsDtRKO3ndcrFvHB5apSnObXHOw==
X-Received: by 2002:a17:902:a514:: with SMTP id s20mr32054509plq.300.1580860181981;
        Tue, 04 Feb 2020 15:49:41 -0800 (PST)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id u2sm24607929pgj.7.2020.02.04.15.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 15:49:41 -0800 (PST)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/17] media: imx: mipi csi-2: Implement get_fwnode_pad op
Date:   Tue,  4 Feb 2020 15:49:05 -0800
Message-Id: <20200204234918.20425-5-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204234918.20425-1-slongerbeam@gmail.com>
References: <20200204234918.20425-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement get_fwnode_pad operation. If the endpoint is owned by the MIPI
CSI-2 receiver, return the endpoint's port number. The MIPI CSI-2 receiver
maps port numbers and pad indexes 1:1.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index c1d1afeea53a..e27a342751fc 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -507,9 +507,37 @@ static int csi2_registered(struct v4l2_subdev *sd)
 				      640, 480, 0, V4L2_FIELD_NONE, NULL);
 }
 
+static int csi2_get_fwnode_pad(struct media_entity *entity,
+			       struct fwnode_endpoint *endpoint)
+{
+	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
+	struct csi2_dev *csi2 = sd_to_dev(sd);
+	struct fwnode_handle *csi2_ep;
+
+	/*
+	 * If the endpoint is one of ours, return the endpoint's port
+	 * number. This device maps port numbers and pad indexes 1:1.
+	 */
+	fwnode_graph_for_each_endpoint(dev_fwnode(csi2->dev), csi2_ep) {
+		if (endpoint->local_fwnode == csi2_ep) {
+			struct fwnode_endpoint fwep;
+			int ret;
+
+			ret = fwnode_graph_parse_endpoint(csi2_ep, &fwep);
+
+			fwnode_handle_put(csi2_ep);
+
+			return ret ? ret : fwep.port;
+		}
+	}
+
+	return -ENXIO;
+}
+
 static const struct media_entity_operations csi2_entity_ops = {
 	.link_setup = csi2_link_setup,
 	.link_validate = v4l2_subdev_link_validate,
+	.get_fwnode_pad = csi2_get_fwnode_pad,
 };
 
 static const struct v4l2_subdev_video_ops csi2_video_ops = {
-- 
2.17.1

