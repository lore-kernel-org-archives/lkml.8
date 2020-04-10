Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7531CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4941B212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491407;
	bh=YoydgxVY04JUElx6pTX1WVnIwMMo7Gnp01oStplhfd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mc9/wyw8u9sodQ5pWsolgGXdIouy8Z2Lhlw2bap0Ftx2WCvPUQ4/fYVHEOM5gccoa
	 jyPF7BefvNaZu0wleTIqHt+11N7zYLzjm+qAplRWZu3EHFSrI71ulJJIMthysl/M0e
	 +EUeR3g/jXREQAO5Boj+ykuxx2PZQ7NQISv56dw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDJDqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgDJDql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:46:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B6520CC7;
        Fri, 10 Apr 2020 03:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490401;
        bh=YoydgxVY04JUElx6pTX1WVnIwMMo7Gnp01oStplhfd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfDuU9ztnGp46tQbTvbJs1R/NhbP3red+60Z+ftBz6Jj27Wm38vPy2WRgHY/is9N9
         awjIXbBdyoMnKoq8LnFHmcu7nWKNjfSnJPgM5BnnTnM8JoHa/l8Cmrx0q4RJ/SPJ1f
         Bp/Q41qk/yZbsCEYV+h3grwED25Fx6BY6dyBKKi8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 05/68] media: vimc: streamer: fix memory leak in vimc subdevs if kthread_run fails
Date:   Thu,  9 Apr 2020 23:45:30 -0400
Message-Id: <20200410034634.7731-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

[ Upstream commit ceeb2e6166dddf3c9757abbbf84032027e2fa2d2 ]

In case kthread_run fails, the vimc subdevices
should be notified that streaming stopped so they can
release the memory for the streaming. Also, kthread should be
set to NULL.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vimc/vimc-streamer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-streamer.c b/drivers/media/platform/vimc/vimc-streamer.c
index cd6b55433c9ee..43e494df61d88 100644
--- a/drivers/media/platform/vimc/vimc-streamer.c
+++ b/drivers/media/platform/vimc/vimc-streamer.c
@@ -207,8 +207,13 @@ int vimc_streamer_s_stream(struct vimc_stream *stream,
 		stream->kthread = kthread_run(vimc_streamer_thread, stream,
 					      "vimc-streamer thread");
 
-		if (IS_ERR(stream->kthread))
-			return PTR_ERR(stream->kthread);
+		if (IS_ERR(stream->kthread)) {
+			ret = PTR_ERR(stream->kthread);
+			dev_err(ved->dev, "kthread_run failed with %d\n", ret);
+			vimc_streamer_pipeline_terminate(stream);
+			stream->kthread = NULL;
+			return ret;
+		}
 
 	} else {
 		if (!stream->kthread)
-- 
2.20.1

