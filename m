Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CFFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A1D206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4W3X0HW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgGMIPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMIPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:15:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D22C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:15:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a1so15431541ejg.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QmsCPrjsmF9ge6HxrBzs06s6K7Fzeye/XmayjmsFHts=;
        b=o4W3X0HWod6I8G+MqrbvI720nnYRbPalw90Q4ujasVKbLO0fEGRyAnhUNWCXWL1/9+
         fWYzZvnX5BrfksAvL/o4bBt9ykx/q3H3vXjURDZAV8WznnRMZf8FqV9Lty912PKBoOLi
         zEoy8osXqbQ3vFRlsrsy554DJlX/tl7W9gLMRkjjccOH1o5Xhhgi9J4fYbVGvi77a8s0
         uupbghw2wCl0NCGmPMonPtalDsyn2DhFbd/Z1nVssYQcLbLL8oWWDYFXy/Ga4TpyeXVP
         Zxwuw29DcQYUgYtdmMhtDEIRVyjMHBqgTdvaLYeP/jVG9wvnErzgFg2qGZI0Ve077/8b
         bC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QmsCPrjsmF9ge6HxrBzs06s6K7Fzeye/XmayjmsFHts=;
        b=re0qLnzDFeyDuNx7zJs2ceJEbehIs6Cw35tHVlDx7rKn5VK/p2fidu0HHbRjR55NWK
         v/Dm6t1ZC44qXLu3B9kKcOOj6dzSE57BsJ8iamRRpIduDFfJj9AXWt7dNx5VfhLMHamh
         wXNWDNB4Xc0D7HTWFmjsXZfMaXUX6C0atm3CiW5Nqb9NfRdahguBjsdL3BKAZkAvC2Ny
         BSxXpoZC6DSe2WDcNuXT2rKaxEdEwTvn6jcscnjK/WfB3See4FycZKrkgIybpLxgf9rQ
         IE4fDWHHvC27WZdxPe7SC7Wuv06pDwgrRy1THEknVw1phElnYkZPRtsyb8B1dhKFq0gf
         oY4A==
X-Gm-Message-State: AOAM5328GJBHzTeswwnKynIpZqUszbk2sUBWWNzj7bSijOQoTYVfpuBh
        vNCNpwBpEXAtnywgiiiIDdtLuw==
X-Google-Smtp-Source: ABdhPJyrc4lrFNKmJoah8Opz7rVlPN6JXN7FEpuxIPb+M5Z5QWxTLOJildCJSTLH8zHcsCDdFcfUuA==
X-Received: by 2002:a17:906:2799:: with SMTP id j25mr58883707ejc.466.1594628114456;
        Mon, 13 Jul 2020 01:15:14 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-188.ip.btc-net.bg. [212.5.158.188])
        by smtp.gmail.com with ESMTPSA id q3sm10721085eds.41.2020.07.13.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:15:13 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] v4l2-ctrl: Add VP9 codec levels
Date:   Mon, 13 Jul 2020 11:15:01 +0300
Message-Id: <20200713081501.28609-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add menu control for VP9 codec levels. A total of 14 levels are
defined for Profile 0 (8bit) and Profile 2 (10bit). Each level
is a set of constrained bitstreams coded with targeted resolutions,
frame rates, and bitrates.

The definition has been taken from webm project.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../media/v4l/ext-ctrls-codec.rst             | 42 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls.c          | 21 ++++++++++
 include/uapi/linux/v4l2-controls.h            | 17 ++++++++
 3 files changed, 80 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index d0d506a444b1..d49bdafa768a 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -3316,6 +3316,48 @@ enum v4l2_mpeg_video_vp9_profile -
     * - ``V4L2_MPEG_VIDEO_VP9_PROFILE_3``
       - Profile 3
 
+.. _v4l2-mpeg-video-vp9-level:
+
+``V4L2_CID_MPEG_VIDEO_VP9_LEVEL (enum)``
+
+enum v4l2_mpeg_video_vp9_level -
+    This control allows selecting the level for VP9 encoder.
+    This is also used to enumerate supported levels by VP9 encoder or decoder.
+    Possible values are:
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_1_0``
+      - Level 1
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_1_1``
+      - Level 1.1
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_2_0``
+      - Level 2
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_2_1``
+      - Level 2.1
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_3_0``
+      - Level 3
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_3_1``
+      - Level 3.1
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_4_0``
+      - Level 4
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_4_1``
+      - Level 4.1
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_5_0``
+      - Level 5
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_5_1``
+      - Level 5.1
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_5_2``
+      - Level 5.2
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_0``
+      - Level 6
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_1``
+      - Level 6.1
+    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
+      - Level 6.2
+
 
 High Efficiency Video Coding (HEVC/H.265) Control Reference
 ===========================================================
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 3f3fbcd60cc6..359dc737053d 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -474,6 +474,23 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"3",
 		NULL,
 	};
+	static const char * const vp9_level[] = {
+		"1",
+		"1.1",
+		"2",
+		"2.1",
+		"3",
+		"3.1",
+		"4",
+		"4.1",
+		"5",
+		"5.1",
+		"5.2",
+		"6",
+		"6.1",
+		"6.2",
+		NULL,
+	};
 
 	static const char * const flash_led_mode[] = {
 		"Off",
@@ -685,6 +702,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return vp8_profile;
 	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
 		return vp9_profile;
+	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:
+		return vp9_level;
 	case V4L2_CID_JPEG_CHROMA_SUBSAMPLING:
 		return jpeg_chroma_subsampling;
 	case V4L2_CID_DV_TX_MODE:
@@ -938,6 +957,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP:		return "VPX P-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:			return "VP8 Profile";
 	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:			return "VP9 Profile";
+	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:			return "VP9 Level";
 	case V4L2_CID_MPEG_VIDEO_VP8_FRAME_HEADER:		return "VP8 Frame Header";
 
 	/* HEVC controls */
@@ -1294,6 +1314,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL:
 	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
+	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:
 	case V4L2_CID_DETECT_MD_MODE:
 	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 62271418c1be..1b0bc79c1bc3 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -650,6 +650,23 @@ enum v4l2_mpeg_video_vp9_profile {
 	V4L2_MPEG_VIDEO_VP9_PROFILE_2				= 2,
 	V4L2_MPEG_VIDEO_VP9_PROFILE_3				= 3,
 };
+#define V4L2_CID_MPEG_VIDEO_VP9_LEVEL			(V4L2_CID_MPEG_BASE+513)
+enum v4l2_mpeg_video_vp9_level {
+	V4L2_MPEG_VIDEO_VP9_LEVEL_1_0	= 0,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_1_1	= 1,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_2_0	= 2,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_2_1	= 3,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_3_0	= 4,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_3_1	= 5,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_4_0	= 6,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_4_1	= 7,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_5_0	= 8,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_5_1	= 9,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_5_2	= 10,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_6_0	= 11,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_6_1	= 12,
+	V4L2_MPEG_VIDEO_VP9_LEVEL_6_2	= 13,
+};
 
 /* CIDs for HEVC encoding. */
 
-- 
2.17.1

