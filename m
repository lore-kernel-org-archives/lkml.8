Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FCDC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 01:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57F62078A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 01:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sxVB+uXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHWBVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 21:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgHWBVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 21:21:49 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1A7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 18:21:48 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id k125so1657825vkh.16
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 18:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=n3DhyqY375Ipe7NVxdqGFwuYsUhvRETKMRg2jv8ryx8=;
        b=sxVB+uXNSSKW133zTCYUoY8ofixIZc2YV8vYbEE/M/ki1BlQNYvhOXxetQBykPWRw+
         nQVljL+tecLVrB8Nuz4ovUVHE8GmSABkI2N3i6nLEpKzkoXxoS0eRnT+zxnb1ccXI3GZ
         3yRuz0mrGp4NxhPkTxb9rC04cskxn549KGT79VzhRM/K8T6Vt+rSrHi5JBywlONPiBGg
         SmBO3pplsD+fpgOkKC3e1zpTI1DxHPHzdtDzqagr7NnoypAqyIzU5bJldQBAq0vQhGP1
         x5RScDzwYfqG4laTRw2hUQb6k/U7GT9RgUxMuoTzYxW1AgK3ljRLMPC81vzlZsjoW5nz
         YPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=n3DhyqY375Ipe7NVxdqGFwuYsUhvRETKMRg2jv8ryx8=;
        b=JaYaCsIb37GCy6Ui4gyJJqrEMCcZxVet3WrR8cgBU+BSINA8MckjL/GnVaUPRFntVh
         Ulp/4aIwQVBhPrQctfh3VRNTSJPZyu+hhtOhk0CHWC7jwoYROwWsonHU+Th64Y0rn7UJ
         btw28/Cgy1e1zbuwcAxcmd3ZlrcTXTjcZFPGIS6Aq3blbWuPopYCPs45OPi2OsgSh9mL
         QYSrL9LUuIWLjLVnkUy5poMiysK0i/Thl7DGWjjihpgy027ltMs5wfdbFY/wdBgHwM/m
         i6VWFBWsxSr2gGfh/mDM20oQaYs2oxo34KNofTGn6s9JAFa8HvIn+PIbOPU7pz/8Aenw
         CIjQ==
X-Gm-Message-State: AOAM530AO3VmdpwAhMljDZMWYdDjIwWqWTAWcy9nVo/0pxD7LyGXXkPs
        pInRbgzjy2kkh4bflzaI8zcPiTXkQVw=
X-Google-Smtp-Source: ABdhPJwvffrWmmEbfSl5IOGr6w9hLslpHSpEtF2b1OFHLtPJifLXlCpJTd3IASAy5zlD6pnjClqOzoJEe7E=
X-Received: from christoph.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:1fe1])
 (user=agoode job=sendgmr) by 2002:a67:eb91:: with SMTP id e17mr5274045vso.7.1598145705968;
 Sat, 22 Aug 2020 18:21:45 -0700 (PDT)
Date:   Sat, 22 Aug 2020 21:21:33 -0400
Message-Id: <20200823012134.3813457-1-agoode@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 1/2] media: uvcvideo: Ensure all probed info is returned to v4l2
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
2.28.0.297.g1956fa8f8d-goog

