Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0E2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C633220738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690856;
	bh=f/0xQXnoIu068crQhuUc/3oebvyspQdCHqf8GvIepZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0bAHMDqkZ6B77Q+BmIsfw5ajzaJ8/yu4KcV1LgnVlmHyFf8NKmeNU4dtd2xB0ITJ4
	 DG8sGwng4YsUM1WhsgAJfkCRV+3Nx9fWFXvDZMiYwDTQpX9UGLbiqN39lbGFJb4rrM
	 u4nxVcRUC0l+gmbP19Sk99IqKZiHH9jSG8yvFmDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbgHQTA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbgHQPsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5410020789;
        Mon, 17 Aug 2020 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679292;
        bh=f/0xQXnoIu068crQhuUc/3oebvyspQdCHqf8GvIepZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drrEJCJ5OShEIxtZ8CnKvQHuRR8FPskKGXpTIBD3vaFJm/sb//UWv9TvDRG41i9b/
         6qk/SpXPdBLU0oqbP6tnKaTOdvP3Ccgze+BkEjRkmkxO5Syd6e3IPoUmFrcYRd3vN3
         yqmUyAZBinFl+nr6vYyaj5qu5AHgfFLwgK6Z/hYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 154/393] media: omap3isp: Add missed v4l2_ctrl_handler_free() for preview_init_entities()
Date:   Mon, 17 Aug 2020 17:13:24 +0200
Message-Id: <20200817143827.086598505@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
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
index 4dbdf3180d108..607b7685c982f 100644
--- a/drivers/media/platform/omap3isp/isppreview.c
+++ b/drivers/media/platform/omap3isp/isppreview.c
@@ -2287,7 +2287,7 @@ static int preview_init_entities(struct isp_prev_device *prev)
 	me->ops = &preview_media_ops;
 	ret = media_entity_pads_init(me, PREV_PADS_NUM, pads);
 	if (ret < 0)
-		return ret;
+		goto error_handler_free;
 
 	preview_init_formats(sd, NULL);
 
@@ -2320,6 +2320,8 @@ static int preview_init_entities(struct isp_prev_device *prev)
 	omap3isp_video_cleanup(&prev->video_in);
 error_video_in:
 	media_entity_cleanup(&prev->subdev.entity);
+error_handler_free:
+	v4l2_ctrl_handler_free(&prev->ctrls);
 	return ret;
 }
 
-- 
2.25.1



