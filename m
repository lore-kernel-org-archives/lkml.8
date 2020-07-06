Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E83C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACEE20674
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="eHn0cmBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGFVzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:55:09 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:17189 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgGFVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=f4gyh5BbpSNrHqLWYRO43egmkaJ0ArYD/IydQmU1/fw=;
        b=eHn0cmBPH0r8LYqSgN26UoBdh2iFUGj66BfDvhV62GrcFwE782/WYQD6g4VtA3H79JkA
        wtH3tuRapEcsLXxz4l6unM/ufOSH/cKb66sqyYhMTWPmkbFYkQBYDR0flAKG9hquSiGeqT
        3rpePa3ymbqPD8WcmMmkxK6Rhr7bQGloo=
Received: by filterdrecv-p3iad2-5b55dcd864-l2x6n with SMTP id filterdrecv-p3iad2-5b55dcd864-l2x6n-19-5F039D9B-18
        2020-07-06 21:54:35.393097943 +0000 UTC m=+881114.024848071
Received: from bionic.localdomain (unknown)
        by ismtpd0008p1lon1.sendgrid.net (SG) with ESMTP
        id 3AFt_t2JSWu7UKeWJ0wpVA
        Mon, 06 Jul 2020 21:54:35.147 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 05/12] media: rkvdec: h264: Do not override output buffer
 sizeimage
Date:   Mon, 06 Jul 2020 21:54:35 +0000 (UTC)
Message-Id: <20200706215430.22859-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706215430.22859-1-jonas@kwiboo.se>
References: <20200701215616.30874-1-jonas@kwiboo.se>
 <20200706215430.22859-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h=2FZQMlPTDcLuCQ0tV?=
 =?us-ascii?Q?zeXPkGBV4qNq3S0YEgC=2FN9LaI6=2FaUWSS1BRUTm0?=
 =?us-ascii?Q?RQgkvcSeULS8rxgiQ9lbE=2Fdrjo+gB1JTTsuMhPY?=
 =?us-ascii?Q?XoLheuWdMRTKg8zy5XVCOL8iO4Uqy6aws92gvCA?=
 =?us-ascii?Q?y94eCOxaGIFjVEr7hxGC8VXa2XLQWAAtZXSo1UV?=
 =?us-ascii?Q?f4sB+HZPeTNlIyRZoJTDA=3D=3D?=
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

The output buffer sizeimage is currently forced to 2 bytes per pixel, this
can lead to high memory usage for 4K content when multiple output buffers
is created by userspace.

Do not override output buffer sizeimage and let userspace have control of
output buffer sizeimage by only setting sizeimage if none is provided.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- New patch
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 6576b4a101ae..3a85545bcb38 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1012,8 +1012,9 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
 	struct v4l2_pix_format_mplane *fmt = &f->fmt.pix_mp;
 
 	fmt->num_planes = 1;
-	fmt->plane_fmt[0].sizeimage = fmt->width * fmt->height *
-				      RKVDEC_H264_MAX_DEPTH_IN_BYTES;
+	if (!fmt->plane_fmt[0].sizeimage)
+		fmt->plane_fmt[0].sizeimage = fmt->width * fmt->height *
+					      RKVDEC_H264_MAX_DEPTH_IN_BYTES;
 	return 0;
 }
 
-- 
2.17.1

