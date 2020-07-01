Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D4EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86D42077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="cg9ZzczD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgGAV4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:56:22 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:46978 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAV4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:to:cc:content-type:content-transfer-encoding;
        s=001; bh=w6MV/RRXKb9vZZR8jzoa9J1Ki5R23xSZpPoVXmzDoyQ=;
        b=cg9ZzczD1MaMllJV/I916OuTJAHyMj+kj2r3Tp/1VV7OV+83jg6k5SyFGEajqKGHn1Go
        n2HZ/Ld6c9osGgoYs91IifSgVg8YNRVMyW4UBr7bBhdJbP2ucHET0HOtJwmSquTeHjaEGy
        TVN268A4jiXy+lkMqIzpD+Ev47xRxTl40=
Received: by filterdrecv-p3iad2-5b55dcd864-pbk2w with SMTP id filterdrecv-p3iad2-5b55dcd864-pbk2w-17-5EFD0684-19
        2020-07-01 21:56:20.443253013 +0000 UTC m=+449220.566657132
Received: from bionic.localdomain (unknown)
        by ismtpd0001p1lon1.sendgrid.net (SG) with ESMTP
        id 4EzSe7fsQ3uiQ9DePBdOZg
        Wed, 01 Jul 2020 21:56:20.097 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/9] media: rkvdec: Add H.264 High 10 and 4:2:2 profile
 support
Date:   Wed, 01 Jul 2020 21:56:20 +0000 (UTC)
Message-Id: <20200701215616.30874-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hz8iDw7yYGWZEJAfA?=
 =?us-ascii?Q?ke8qOYfmOhodYtXACLNhR2cwQWSNYX=2FbUxaNFkt?=
 =?us-ascii?Q?EGrL+t5FTaCt7iBRMILz+SNMc43ia0ybGVNnazg?=
 =?us-ascii?Q?gHcJKAOlQ1joDUUy7uPRSBik3JzRi4bqXuWQHW=2F?=
 =?us-ascii?Q?udBefSp7lwv6YgDo2FkDosW1mHA30d3zKMcD=2FUF?=
 =?us-ascii?Q?dNeZ+SdM9EGKNpTrNPsfw=3D=3D?=
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains minor fixes and adds H.264 High 10 and 4:2:2 profile
support to the Rockchip Video Decoder driver.

Patch 1 adds profile and level controls.

Patch 2 and 3 fixes two issues when decoding field encoded content. Patch 3
also prepare for changes to step_width in the final patch.

Patch 5 updates the v4l2_format helpers to consider block width and height
when calculating plane bytesperline and sizeimage.

Patch 6 adds two new pixelformats for 10-bit 4:2:0/4:2:2.

Patch 7 change to use bytesperline and buffer height to configure strides.

Patch 8 and 9 adds final bits to support H.264 High 10 and 4:2:2 profiles.

This series depend on the "handle unsupported H.264 bitstreams" series at [1].

To fully runtime test this series you may need drm patches from [2] and
ffmpeg patches from [3], this series and drm patches is also available at [4].

[1] https://patchwork.linuxtv.org/cover/64977/
[2] https://patchwork.freedesktop.org/series/78099/
[3] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-hwaccel-4.3-rkvdec-high-10
[4] https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec-high-10

Regards,
Jonas

Jonas Karlman (9):
  media: rkvdec: h264: Support profile and level controls
  media: rkvdec: h264: Fix reference frame_num wrap for second field
  media: rkvdec: h264: Fix pic width and height in mbs
  media: rkvdec: h264: Fix bit depth wrap in pps packet
  media: v4l2-common: Add helpers to calculate bytesperline and
    sizeimage
  media: v4l2: Add NV15 and NV20 pixel formats
  media: rkvdec: h264: Use bytesperline and buffer height to calculate
    stride
  media: rkvdec: Add validate_fmt ops for pixelformat validation
  media: rkvdec: h264: Support High 10 and 4:2:2 profiles

 .../userspace-api/media/v4l/pixfmt-nv15.rst   | 101 ++++++++++++++++
 .../userspace-api/media/v4l/pixfmt-nv20.rst   |  99 ++++++++++++++++
 .../userspace-api/media/v4l/yuv-formats.rst   |   2 +
 drivers/media/v4l2-core/v4l2-common.c         |  80 ++++++-------
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 drivers/staging/media/rkvdec/rkvdec-h264.c    | 108 +++++++++++++++---
 drivers/staging/media/rkvdec/rkvdec.c         |  43 +++++--
 drivers/staging/media/rkvdec/rkvdec.h         |   1 +
 include/uapi/linux/videodev2.h                |   3 +
 9 files changed, 369 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-nv15.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-nv20.rst

-- 
2.17.1

