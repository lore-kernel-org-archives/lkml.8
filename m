Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A766C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40232084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXOXHu1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgGBKAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGBKAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:00:41 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 03:00:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so22974771edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1WmqaiuNVEclhw1nheIOKjVRtzcxai6WdQ/gqQ3uQU0=;
        b=UXOXHu1D0F24K3OUpBILll5QvME8IZtFs+VI5ew2fgi4DGF6uphasPQlgwD3tiha5P
         J28aJ8XibystXpzzUP5wdOBTPhbYub3QxMsT823jN1b2hyZj/wQ1XNrzfxPr17M8QHkL
         emObXTk4eTI3jJR90vMuqRbW1EnxCrkoBjE+RoiFA0yhrCCprUDEYy+KgVztPrq+Vra9
         HF9Vl+Ms8V3vvyViuisi0GlozlWCC1JZ5VOu+4+yv+o4GWJ7f2IARYh4B1GISOKymi9D
         f+XWApHOmDeciQ/RYPGcDLBmZeXt4nvIVuHw9lyow8Cp8Q1Zre8VMsPiQPuznjdiw97U
         1qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1WmqaiuNVEclhw1nheIOKjVRtzcxai6WdQ/gqQ3uQU0=;
        b=Wh079BlDPucHlwn4z1GBwgTvt8bmioo+RV5sBwlw4cUjbkbEnzVAlaZXgzLdMI1734
         ZM0XB2h5PkkLzYECFYyUbitV5WLGLojFGC/rypGepVB75pM9dmYMpULcdaV0oVcNrVa8
         +NKAL28yZZ7Xmnd8dWkuRJ8SmOKbLU+f7Ig7WnTJcHwqD2AQmBNqk6Jv1zx02OSNeURJ
         KU3k35m3PQlF+KzOIezP+AH1VfhhcIABSmfVdXRtALqOzJMqf/9UeEXznVBGvrpIoeaG
         UKoIuG0NbeOtMTkXv7vk3RBHl+7YoD8Hg7SwoU+AHoawklKDVwtKYwpOjJ2AIPElnOrI
         NzPA==
X-Gm-Message-State: AOAM531SuDhtQrdrac7ViKz9gVTm0oorXEha/cav+4rVD/oEvJ0VOMhV
        CX7NA2NVXb6LQxSx65J1Kn+0uXpmJC0Jow==
X-Google-Smtp-Source: ABdhPJwvSrP2yk3JxD/etBT3oruIbHt9NNkFuJzBvzODmeTfr+ZiAh36o2Ez3YTzVxG9QTsIEySPmA==
X-Received: by 2002:a05:6402:1544:: with SMTP id p4mr34522450edx.334.1593684038529;
        Thu, 02 Jul 2020 03:00:38 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-220.ip.btc-net.bg. [212.5.158.220])
        by smtp.gmail.com with ESMTPSA id bm21sm6334501ejb.13.2020.07.02.03.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:00:37 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] v4l: Add source change event for colorimetry
Date:   Thu,  2 Jul 2020 13:00:17 +0300
Message-Id: <20200702100017.24700-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This event indicate that the source colorspace is changed
during run-time. The client has to retrieve the new colorspace
identifiers by getting the format (G_FMT).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../userspace-api/media/v4l/vidioc-dqevent.rst        | 11 ++++++++++-
 .../userspace-api/media/videodev2.h.rst.exceptions    |  1 +
 include/uapi/linux/videodev2.h                        |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
index a9a176d5256d..3f69c753db58 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
@@ -381,7 +381,16 @@ call.
 	that many Video Capture devices are not able to recover from a temporary
 	loss of signal and so restarting streaming I/O is required in order for
 	the hardware to synchronize to the video signal.
-
+    * - ``V4L2_EVENT_SRC_CH_COLORIMETRY``
+      - 0x0002
+      - This event gets triggered when a colorspace change is detected at
+	an input. By colorspace change here we include also changes in the
+	colorspace specifiers (transfer function, Y'CbCr encoding and
+	quantization). This event can come from an input or from video decoder.
+	Once the event has been send to the client the driver has to update
+	the colorspace specifiers internally so that they could be retrieved by
+	client. In that case queue re-negotiation is not needed as this change
+	only reflects on the interpretation of the data.
 
 Return Value
 ============
diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
index ca05e4e126b2..54fc21af852d 100644
--- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
+++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
@@ -492,6 +492,7 @@ replace define V4L2_EVENT_CTRL_CH_FLAGS ctrl-changes-flags
 replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
 
 replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
+replace define V4L2_EVENT_SRC_CH_COLORIMETRY src-changes-flags
 
 replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 303805438814..b5838bc4e3a3 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2351,6 +2351,7 @@ struct v4l2_event_frame_sync {
 };
 
 #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
+#define V4L2_EVENT_SRC_CH_COLORIMETRY		(1 << 1)
 
 struct v4l2_event_src_change {
 	__u32 changes;
-- 
2.17.1

