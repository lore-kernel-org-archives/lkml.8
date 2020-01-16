Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A462C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA97724683
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195376;
	bh=nXGUnMZlOVgaKAGVo0FWeINInUdTnY6CLR3IZhcROgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KsgZIjkZ5CkMc939f21OaKpPX0uPODw38m/fYk03D1PGC/JD7hhYnTi1hHAZTMzRu
	 dfDSlgV1PibY2H7sBcwxXy0a0ag0clzdoVFS9E2A8idFoCl23e7+AWgpC4x9Li7Lsr
	 RZu9C8dE8w6T9BI3mhU38hda2wziopsPahUq0kig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391667AbgAPRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390747AbgAPRN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B29E246AA;
        Thu, 16 Jan 2020 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194806;
        bh=nXGUnMZlOVgaKAGVo0FWeINInUdTnY6CLR3IZhcROgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+YnqHEUkfsDzrT8gJ1BnE648zGdQE5nIHswi2QGn0wKe81792TiJZlCdCac3CC44
         VvHl7RRRZiAblxekCh5rZtOlDESzuMs7znpfpQxi7q2Jk7vH9cDkSr7WU3dNA5OHTD
         LRgrLIXvFm1vRglBbTOf2WyKI+8ddr6V1ZfjM3fM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 615/671] media: ov6650: Fix .get_fmt() V4L2_SUBDEV_FORMAT_TRY support
Date:   Thu, 16 Jan 2020 12:04:13 -0500
Message-Id: <20200116170509.12787-352-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

[ Upstream commit 39034bb0c26b76a2c3abc54aa28c185f18b40c2f ]

Commit da298c6d98d5 ("[media] v4l2: replace video op g_mbus_fmt by pad
op get_fmt") converted a former ov6650_g_fmt() video operation callback
to an ov6650_get_fmt() pad operation callback.  However, the converted
function disregards a format->which flag that pad operations should
obey and always returns active frame format settings.

That can be fixed by always responding to V4L2_SUBDEV_FORMAT_TRY with
-EINVAL, or providing the response from a pad config argument, likely
updated by a former user call to V4L2_SUBDEV_FORMAT_TRY .set_fmt().
Since implementation of the latter is trivial, go for it.

Fixes: da298c6d98d5 ("[media] v4l2: replace video op g_mbus_fmt by pad op get_fmt")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov6650.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 8700b7fc0019..33a67a3685e6 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -531,10 +531,16 @@ static int ov6650_get_fmt(struct v4l2_subdev *sd,
 	*mf = ov6650_def_fmt;
 
 	/* update media bus format code and frame size */
-	mf->width	= priv->rect.width >> priv->half_scale;
-	mf->height	= priv->rect.height >> priv->half_scale;
-	mf->code	= priv->code;
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
+		mf->width = cfg->try_fmt.width;
+		mf->height = cfg->try_fmt.height;
+		mf->code = cfg->try_fmt.code;
 
+	} else {
+		mf->width = priv->rect.width >> priv->half_scale;
+		mf->height = priv->rect.height >> priv->half_scale;
+		mf->code = priv->code;
+	}
 	return 0;
 }
 
-- 
2.20.1

