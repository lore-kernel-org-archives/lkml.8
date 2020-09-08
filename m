Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC40C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917A7207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6JsxEBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgIHTrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbgIHTqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:46:12 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0981C061757;
        Tue,  8 Sep 2020 12:46:11 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r10so30741oor.5;
        Tue, 08 Sep 2020 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sB5cXzWSwS8xZ3/r8jsVyeeT+zbo9/MGNsGrKz2xEhE=;
        b=q6JsxEBfFsN852oOLbFZceYKHBIQK84dqs1vWfUDcU9FsLwmxPaAmYJg0hra091o6F
         3Ip2BlbfsiKxpuoOxLCXyaC5+iG4FNLalgIn+7TmiMF6dFpWKE/3l//H+FMa/eKtdjQV
         b2t1KH73I1X8UOrAuB+6HwjDF9LeD7RXUtfzjOyCWm0RkZYVSGyuJ0201il+U2kVtKSb
         WAUWqQfnmy5FeHo1KRPtKIbGM6U1/y6NqID4cjs+7MX6jSHD6qN4b0vmLOEgUCJbtkZq
         Ufnqd7jlpG9qbMGL6wys7ddC/vUGPKq7BXnSDTT5zxUmA0K3l0HXWuIe5w0WKt7RLew3
         zi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sB5cXzWSwS8xZ3/r8jsVyeeT+zbo9/MGNsGrKz2xEhE=;
        b=GWal8wIu0N+Q4mouzhZzucYoMdGmOGkqVqUF8eOc1fgI/Yktv6IzgKkBqiLHCNdqEL
         d1wD5EamdUR2IvqhDtc75Hfqiku8Kc0kWBu8VnIKZ0nBQRvDCKmWhhTbvHEyiOex4lAW
         0xGYm2CHzX9tAfLFQIJd20RYo3rKNLOimnASTUL+NsfD3DqcxWc+Fxly/CnS7jsSH8Da
         nOZYXt1pnD4g6iuQZRec+hFXwpm9H5E/ySvyExZbuQjBkYNs8gsCgJMKQVtjM9wzfny2
         pz1EC0vVRwgHc1gzbHtgeAIfmAT6c+xc1K606LfIU0SWau+Kc1K+qna2Ws70gqYIWy+v
         GWJQ==
X-Gm-Message-State: AOAM533xJnoNSBAs5Vr68ev3bx5Irx+LmkuVldw9yHxrusGrHqMr7AU6
        k1DhtazUQO8BMUPPSbnyFyg=
X-Google-Smtp-Source: ABdhPJwaavyJz3F8NhRPdRYQHTMWe9HkuD/34zNDgHToIdid7v1qQ0w4/fYa9Ra8+cZM3P48DW8fmg==
X-Received: by 2002:a4a:5258:: with SMTP id d85mr197181oob.72.1599594370867;
        Tue, 08 Sep 2020 12:46:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z16sm31422oth.43.2020.09.08.12.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 12:46:10 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-uvc-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 5/5] media: uvcvideo: Abort uvc_v4l2_open if video device is unregistered
Date:   Tue,  8 Sep 2020 12:45:57 -0700
Message-Id: <20200908194557.198335-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908194557.198335-1-linux@roeck-us.net>
References: <20200908194557.198335-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uvc_v4l2_open() acquires the uvc device mutex. After doing so,
it does not check if the video device is still registered. This may
result in race conditions and can result in an attempt to submit an urb
to a disconnected USB interface (from uvc_status_start).

The problem was observed after adding a call to msleep() just before
acquiring the mutex and disconnecting the camera during the sleep.

Check if the video device is still registered after acquiring the mutex
to avoid the problem. In the release function, only call uvc_status_stop()
if the video device is still registered. If the video device has been
unregistered, the urb associated with uvc status has already been killed
in uvc_status_unregister(). Trying to kill it again won't do any good
and might have unexpected side effects.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fix typo in description. The USB message is sent from uvc_status_start()
    in the open function, not from uvc_v4l2_open().

 drivers/media/usb/uvc/uvc_v4l2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 7e5e583dae5e..1f7d454557b9 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -548,6 +548,10 @@ static int uvc_v4l2_open(struct file *file)
 	}
 
 	mutex_lock(&stream->dev->lock);
+	if (!video_is_registered(&stream->vdev)) {
+		mutex_unlock(&stream->dev->lock);
+		return -ENODEV;
+	}
 	if (stream->dev->users == 0) {
 		ret = uvc_status_start(stream->dev, GFP_KERNEL);
 		if (ret < 0) {
@@ -590,7 +594,7 @@ static int uvc_v4l2_release(struct file *file)
 	file->private_data = NULL;
 
 	mutex_lock(&stream->dev->lock);
-	if (--stream->dev->users == 0)
+	if (--stream->dev->users == 0 && video_is_registered(&stream->vdev))
 		uvc_status_stop(stream->dev);
 	mutex_unlock(&stream->dev->lock);
 
-- 
2.17.1

