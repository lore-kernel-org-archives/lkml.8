Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349D220836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593180311;
	bh=fnsDxHfXy1GSyOaHOygYxYUOBpoJJVKUHW5eHWTrqSs=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=1vWvnYYU19046h9ctdhyBk5za4butzm7aMFmFf/6dAY/Mwq3LcQr7P0IW71+uMLfT
	 b32A1gENsIy+Mcl/91GmUD8Oe3/AwYu0okPxwfXWTz58GuK9+9cyhHlvBdXM+dvi4o
	 d0OXlhT+/qdRYj9zle6jfboveR2uUJR60MeSb9IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgFZOFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbgFZOFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:05:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B7F20DD4;
        Fri, 26 Jun 2020 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593180302;
        bh=fnsDxHfXy1GSyOaHOygYxYUOBpoJJVKUHW5eHWTrqSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EN1bxArQKJRv76d9jnhD7QOKTaqbPW/ShgeaWqpG9kLbFwp8XUhGrHHL+4BiIl/ax
         MJLoRmjZqVM2ilbiVL3phTXf/3npzbQGG5+pgvhOf0IfmaOlyCx2yU/1xMFhqsA4mV
         7BYqfAIWHELl9E+IvSXdyrSbdzbQ9RXVuISPlngE=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jooyS-00HKwH-4g; Fri, 26 Jun 2020 16:05:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] media: atomisp: fix call to g_frame_interval
Date:   Fri, 26 Jun 2020 16:04:56 +0200
Message-Id: <59524c4e6c44a3b1d30099629ee49b583532d250.1593180146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593180146.git.mchehab+huawei@kernel.org>
References: <cover.1593180146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The media core has now a check if fi->pad is bigger than zero
or bigger than sd->entity.num_pads, if the media controller
is defined.

This causes a call to g_frame_interval to return -EINVAL.

Fix it by first cleaning up the struct.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 7b936e5a5f03..388b57455204 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -109,7 +109,7 @@ struct atomisp_acc_pipe *atomisp_to_acc_pipe(struct video_device *dev)
 
 static unsigned short atomisp_get_sensor_fps(struct atomisp_sub_device *asd)
 {
-	struct v4l2_subdev_frame_interval fi;
+	struct v4l2_subdev_frame_interval fi = { 0 };
 	struct atomisp_device *isp = asd->isp;
 
 	unsigned short fps = 0;
-- 
2.26.2

