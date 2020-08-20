Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D249C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC0A22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917789;
	bh=lxe8g7FX23dHva9JYODgWaxoPdH/vB0tpCeu2DOon2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PKHWRlNyzpCTnxOs5+WUJ+nWqeNNSVrVRl2M0n68uPPFNTrB/d9EzpczsNOQDDD5F
	 SeJv4HIauYJADbMMxCpgbHfWNZu+0iBXYgXBJlpT8s5jmfbBLfIVExvT6xONyKlLbj
	 p+7kMoxYP048a6zc87HtEa8sQGsJKF0vh9FHUylU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgHTKCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbgHTKBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:01:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46E7622B49;
        Thu, 20 Aug 2020 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917663;
        bh=lxe8g7FX23dHva9JYODgWaxoPdH/vB0tpCeu2DOon2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q31OqFv/NGPH//+EBMVuPjiyzefj8JG/g6aczEwevinS/MJlr8F5DWH0NLrHJlaz6
         ikf5Whf1G9lApkNEs1/hCdpZaP+CVxCowFa3/qhcIrHoXiHG3LXSo7/1/yW1ksUzxX
         qxD/DShEC+mFEvlq/Gw8CAmtQOzTvQOjV1ZBd1B4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 113/212] media: omap3isp: Add missed v4l2_ctrl_handler_free() for preview_init_entities()
Date:   Thu, 20 Aug 2020 11:21:26 +0200
Message-Id: <20200820091608.055312257@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
index e981eb2330f18..ac005ae4d21b4 100644
--- a/drivers/media/platform/omap3isp/isppreview.c
+++ b/drivers/media/platform/omap3isp/isppreview.c
@@ -2290,7 +2290,7 @@ static int preview_init_entities(struct isp_prev_device *prev)
 	me->ops = &preview_media_ops;
 	ret = media_entity_pads_init(me, PREV_PADS_NUM, pads);
 	if (ret < 0)
-		return ret;
+		goto error_handler_free;
 
 	preview_init_formats(sd, NULL);
 
@@ -2323,6 +2323,8 @@ static int preview_init_entities(struct isp_prev_device *prev)
 	omap3isp_video_cleanup(&prev->video_in);
 error_video_in:
 	media_entity_cleanup(&prev->subdev.entity);
+error_handler_free:
+	v4l2_ctrl_handler_free(&prev->ctrls);
 	return ret;
 }
 
-- 
2.25.1



