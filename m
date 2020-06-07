Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57617C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2D32075A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="V/UDgp0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgFGUZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:25:26 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:27347 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgFGUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 16:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=y4cPh0/f3xkxdbgS5qj6WkCOPZvcYGJkTGyjKr6sOYA=;
        b=V/UDgp0fOZoYYqSnEV7WYd1bN1V0iJF7T9go8ZR4/oRHNdJYs8t2JHrHab3Uh36JHfQt
        rnv2kaJZuVnYJDvc1Z6KMDn6Xr9nZEWxXrXNzX9xuz8sZODjxaEVZgfgbMjTwrle+xRbcr
        SAzf6iHLcMiPL9is3bJFs87OEGRim1rxI=
Received: by filterdrecv-p3mdw1-6f5df8956d-dtkn2 with SMTP id filterdrecv-p3mdw1-6f5df8956d-dtkn2-21-5EDD4D35-1F
        2020-06-07 20:25:25.615165994 +0000 UTC m=+346301.434158460
Received: from bionic.localdomain (unknown)
        by ismtpd0001p1lon1.sendgrid.net (SG) with ESMTP
        id 8kV6fIRtTkGGPZ3_nSj1Tg
        Sun, 07 Jun 2020 20:25:25.442 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] drm: drm_fourcc: add NV20 YUV format
Date:   Sun, 07 Jun 2020 20:25:25 +0000 (UTC)
Message-Id: <20200607202521.18438-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200607202521.18438-1-jonas@kwiboo.se>
References: <20200607202521.18438-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h=2FtF3WwO9txVSXf8F?=
 =?us-ascii?Q?HjIX=2FR2s7i+VJch9=2FwdL08LjEKxGfZ3lRwZHytH?=
 =?us-ascii?Q?crArFghPPbRhR21qGzFBxRRVKhycnM0=2F5WHlRIT?=
 =?us-ascii?Q?6nKT5f+SrOxVNM5N0PT5iPJ2SJDTNvTXqxofFWG?=
 =?us-ascii?Q?UQUkK0ZKV4eHdAld5ZgylJIE4es1iu0dVO+mKx0?=
 =?us-ascii?Q?L7z9P73ZpKFsM=2F9ZqDlqw=3D=3D?=
To:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Ben Davis <ben.davis@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM_FORMAT_NV20 is a 2 plane format suitable for linear memory layout.
The format is similar to P210 with 4:2:2 sub-sampling but has no padding
between components. Instead, luminance and chrominance samples are grouped
into 4s so that each group is packed into an integer number of bytes:

YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes

The '20' suffix refers to the optimum effective bits per pixel which is
achieved when the total number of luminance samples is a multiple of 4.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/drm_fourcc.c  | 4 ++++
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 722c7ebe4e88..2a9c8ae719ed 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -278,6 +278,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
 		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
 		  .vsub = 2, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV20,		.depth = 0,
+		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
+		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
+		  .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_Q410,		.depth = 0,
 		  .num_planes = 3, .char_per_block = { 2, 2, 2 },
 		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index b5bf1c0e630e..244d32433a67 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -242,6 +242,7 @@ extern "C" {
  * index 1 = Cr:Cb plane, [39:0] Cr1:Cb1:Cr0:Cb0 little endian
  */
 #define DRM_FORMAT_NV15		fourcc_code('N', 'V', '1', '5') /* 2x2 subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV20		fourcc_code('N', 'V', '2', '0') /* 2x1 subsampled Cr:Cb plane */
 
 /*
  * 2 plane YCbCr MSB aligned
-- 
2.17.1

