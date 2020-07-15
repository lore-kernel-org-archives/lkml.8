Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736BDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F2A2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGOUXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:23:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37156 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgGOUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:23:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 9D35C2A5175
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 05/10] media: uapi: h264: Increase size of 'first_mb_in_slice' field
Date:   Wed, 15 Jul 2020 17:22:28 -0300
Message-Id: <20200715202233.185680-6-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715202233.185680-1-ezequiel@collabora.com>
References: <20200715202233.185680-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slice header syntax element 'first_mb_in_slice' can point
to the last macroblock, currently the field can only reference
65536 macroblocks which is insufficient for 8K videos.

Although unlikely, a 8192x4320 video (where macroblocks are 16x16),
would contain 138240 macroblocks on a frame.

As per the H264 specification, 'first_mb_in_slice' can be up to
PicSizeInMbs - 1, so increase the size of the field to 32-bits.

Note that v4l2_ctrl_h264_slice_params struct will be modified
in a follow-up commit, and so we defer its 64-bit padding.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 +-
 include/media/h264-ctrls.h                                | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 86e30b80a6c1..dd8e5a2e8986 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1774,7 +1774,7 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
     * - __u32
       - ``header_bit_size``
       -
-    * - __u16
+    * - __u32
       - ``first_mb_in_slice``
       -
     * - __u8
diff --git a/include/media/h264-ctrls.h b/include/media/h264-ctrls.h
index da2ffb77b491..620ee8863d74 100644
--- a/include/media/h264-ctrls.h
+++ b/include/media/h264-ctrls.h
@@ -164,7 +164,8 @@ struct v4l2_ctrl_h264_slice_params {
 	/* Offset in bits to slice_data() from the beginning of this slice. */
 	__u32 header_bit_size;
 
-	__u16 first_mb_in_slice;
+	__u32 first_mb_in_slice;
+
 	__u8 slice_type;
 	__u8 pic_parameter_set_id;
 	__u8 colour_plane_id;
-- 
2.27.0

