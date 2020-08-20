Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39456C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C83020658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919524;
	bh=6FhLavvRW1IYPm5muXfh+oDJE0gjyK0gs84mcs6Ez/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WSmqNrlmlx2/gjSVAgSDUPrcLyaZDurK5Rp4s76x0/yN2/l66rtQTpx2OfUntoGSO
	 3a+P3jtUFjtb4BWFMMDsb8mI5H+eBoNczVeojKrUFJcwcm1n6malkbmIO4F2ebxOXW
	 VJyH5l7jjBJ/4E9q62dBi2qW2q7N5D74fuSDLW0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgHTKcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbgHTKUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:20:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE4020658;
        Thu, 20 Aug 2020 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918828;
        bh=6FhLavvRW1IYPm5muXfh+oDJE0gjyK0gs84mcs6Ez/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhR3Y+V9s8JHLYG4MmVqzOSwn5oDqHqpfuIG+z99vcxbzP836PV4WLNzNYyOv/7yI
         /kSkZ+oEd4fHrPU3G2LM/FGAu4w6ODFc+ZXUSn9K1GOR3EWXZTWN2xk3fUMCY1SdVk
         NRRj6hxacFLZtpwpdlOzlZzJaI2V4TBvfPZ2ROTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 082/149] media: omap3isp: Add missed v4l2_ctrl_handler_free() for preview_init_entities()
Date:   Thu, 20 Aug 2020 11:22:39 +0200
Message-Id: <20200820092129.694754829@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit dc7690a73017e1236202022e26a6aa133f239c8c ]

preview_init_entities() does not call v4l2_ctrl_handler_free() when
it fails.
Add the missed function to fix it.

Fixes: de1135d44f4f ("[media] omap3isp: CCDC, preview engine and resizer")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/omap3isp/isppreview.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/omap3isp/isppreview.c b/drivers/media/platform/omap3isp/isppreview.c
index c9e8845de1b1d..c3336a2cbe145 100644
--- a/drivers/media/platform/omap3isp/isppreview.c
+++ b/drivers/media/platform/omap3isp/isppreview.c
@@ -2285,7 +2285,7 @@ static int preview_init_entities(struct isp_prev_device *prev)
 	me->ops = &preview_media_ops;
 	ret = media_entity_init(me, PREV_PADS_NUM, pads, 0);
 	if (ret < 0)
-		return ret;
+		goto error_handler_free;
 
 	preview_init_formats(sd, NULL);
 
@@ -2331,6 +2331,8 @@ static int preview_init_entities(struct isp_prev_device *prev)
 	omap3isp_video_cleanup(&prev->video_in);
 error_video_in:
 	media_entity_cleanup(&prev->subdev.entity);
+error_handler_free:
+	v4l2_ctrl_handler_free(&prev->ctrls);
 	return ret;
 }
 
-- 
2.25.1



