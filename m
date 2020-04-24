Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF5EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177602075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6R/vIhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDXFhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbgDXFhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:37:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903ADC09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:37:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w6so9672277qtt.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ba6IqQSg7dp3Ida1PYjzOznOfgdID1kXp0iD3EB/4hc=;
        b=Q6R/vIhnj9wkvl9/0VhPB4lOhFtXtTq4M2zoGYo16T+kbFVZz3q8RE2UMDc5j2hf6+
         QycEowVAxCzg3Q7hLh05iteTdJOaJ5MGMklo0BQ5Sk/VcUhTma6EYKXbhIw27giX+3Yy
         b0Yq3pNM9iL5hyq/Eov1X55QLaFVfwe7oIrs0V22vmg79UX1zSjg29FkmeRPojlQp2If
         tNLsQcpXs1yzVd4n/RXhPq1yzxOvkCM0TOomjJwLjppnA0kLfXSlD4Qb/IqG/b/6rWNJ
         jOgWIj9s1MG73e5rhLuG0xa2TS+N6yrDLz3IQyKwuTVei4bM9OVNZPljyPYCheDhEZa9
         JjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ba6IqQSg7dp3Ida1PYjzOznOfgdID1kXp0iD3EB/4hc=;
        b=IbUehGiB+eAy0IIuGEeVOZVl5PgWXXO28xL7IVtOT4NZi93iJQlM2SnVRPbK5sktkx
         VnyWauVrghbqLd2CsWetAj/KKUzEwJG0mmvRZPCO4bCN2d3+IcfnXprPLxaN/mrBUj/Z
         8FR1q+zO3JhGWKmBtVcShr+BX7PVEpdJ9tnchE00fWoJ2IZjxTXZYxjvRwC+lx5Ta1Jk
         Rba3IelKSVqvI1nQ6mpCeygFSpMKzI4SsXzsWUyPFMX78w+qCjI66aAWggPkivOvakMV
         VdM7yZ1vrJ58gGqWdwgqTNSAbnCpb1/sSQ1xWX/WSyfvz9OwJSeFmixHaFvyVirpTEn8
         3dSg==
X-Gm-Message-State: AGi0PuYHrVtGG/+7IKxrQvjX3EiS9uREgnMxXRr8IxuFDEw1T0qkI7uW
        NllWsIuTWREtpgK306PstAmiSVmyIVY=
X-Google-Smtp-Source: APiQypII/80USr8zG4fc+TTJkuFeFerRBO5LSzbcGR3CQZUXMc5HVz87ohksQS7lRIP9tsn47RRO/V7JLIs=
X-Received: by 2002:ac8:66d8:: with SMTP id m24mr7780393qtp.175.1587706626733;
 Thu, 23 Apr 2020 22:37:06 -0700 (PDT)
Date:   Fri, 24 Apr 2020 01:36:51 -0400
Message-Id: <20200424053651.61226-1-agoode@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] media: uvcvideo: Ensure all probed info is returned to v4l2
From:   Adam Goode <agoode@google.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Goode <agoode@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bFrameIndex and bFormatIndex can be negotiated by the camera during
probing, resulting in the camera choosing a different format than
expected. v4l2 can already accommodate such changes, but the code was
not updating the proper fields.

Without such a change, v4l2 would potentially interpret the payload
incorrectly, causing corrupted output. This was happening on the
Elgato HD60 S+, which currently always renegotiates to format 1.

As an aside, the Elgato firmware is buggy and should not be renegotating,
but it is still a valid thing for the camera to do. Both macOS and Windows
will properly probe and read uncorrupted images from this camera.

With this change, both qv4l2 and chromium can now read uncorrupted video
from the Elgato HD60 S+.

Signed-off-by: Adam Goode <agoode@google.com>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 0335e69b70ab..7f14096cb44d 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -247,11 +247,37 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
 	if (ret < 0)
 		goto done;
 
+	/* After the probe, update fmt with the values returned from
+	 * negotiation with the device.
+	 */
+	for (i = 0; i < stream->nformats; ++i) {
+		if (probe->bFormatIndex == stream->format[i].index) {
+			format = &stream->format[i];
+			break;
+		}
+	}
+	if (i == stream->nformats) {
+		uvc_trace(UVC_TRACE_FORMAT, "Unknown bFormatIndex %u.\n",
+			  probe->bFormatIndex);
+		return -EINVAL;
+	}
+	for (i = 0; i < format->nframes; ++i) {
+		if (probe->bFrameIndex == format->frame[i].bFrameIndex) {
+			frame = &format->frame[i];
+			break;
+		}
+	}
+	if (i == format->nframes) {
+		uvc_trace(UVC_TRACE_FORMAT, "Unknown bFrameIndex %u.\n",
+			  probe->bFrameIndex);
+		return -EINVAL;
+	}
 	fmt->fmt.pix.width = frame->wWidth;
 	fmt->fmt.pix.height = frame->wHeight;
 	fmt->fmt.pix.field = V4L2_FIELD_NONE;
 	fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(format, frame);
 	fmt->fmt.pix.sizeimage = probe->dwMaxVideoFrameSize;
+	fmt->fmt.pix.pixelformat = format->fcc;
 	fmt->fmt.pix.colorspace = format->colorspace;
 
 	if (uvc_format != NULL)
-- 
2.25.3

