Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE0CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B011B20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="hGRFbE36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGFVzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:55:13 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:50269 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=oQDyTyk1JzCRldIwq9SBmCjNp7iNMJTbJziH/eYuor0=;
        b=hGRFbE36/plQ2L4O1mrPAGqBLc6ZqlUA/94+IA9YgLQrhlkO9XI/DfxPby1W2liHgk/q
        eaL1wqNghDqNJOB7EUz0WdAzeqLgjfmSrdnplHYYX/C8Aqzb3xGF2llFZs8ZZJe+TzuGx5
        /5fEK6nUoKiTSqeZNB8NMsTaiqeBhlllE=
Received: by filterdrecv-p3iad2-5b55dcd864-pbk2w with SMTP id filterdrecv-p3iad2-5b55dcd864-pbk2w-17-5F039D9A-68
        2020-07-06 21:54:34.983629525 +0000 UTC m=+881115.107033651
Received: from bionic.localdomain (unknown)
        by ismtpd0008p1lon1.sendgrid.net (SG) with ESMTP
        id J3M56gfURVypOe2JLmhI8A
        Mon, 06 Jul 2020 21:54:34.738 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 04/12] media: rkvdec: h264: Fix bit depth wrap in pps
 packet
Date:   Mon, 06 Jul 2020 21:54:35 +0000 (UTC)
Message-Id: <20200706215430.22859-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706215430.22859-1-jonas@kwiboo.se>
References: <20200701215616.30874-1-jonas@kwiboo.se>
 <20200706215430.22859-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h1efvHYa9=2FptEut3+?=
 =?us-ascii?Q?r5e7y4PIlttPYGcFfLug8A7ah0XXMgBi9nG7Dhj?=
 =?us-ascii?Q?Cn8wOxRy91+3nOQ5fIrAIRprtQBVJN40mqxpula?=
 =?us-ascii?Q?VW4fmG7wzr+nHHcHyl5h85q+UMLbTol8UXVdLlF?=
 =?us-ascii?Q?0MZprPsjhE4CrDCoYvj8UkkQnvLZ4w552Kxzmi5?=
 =?us-ascii?Q?nB=2Fid+kqVgbqRVcJBRDIg=3D=3D?=
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

The luma and chroma bit depth fields in the pps packet is 3 bits wide.
8 is wrongly added to the bit depth value written to these 3-bit fields.
Because only the 3 LSB is written the hardware is configured correctly.

Correct this by not adding 8 to the luma and chroma bit depth value.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
---
Changes in v2:
- Collect r-b tag
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 3498e9eec3d8..6576b4a101ae 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -662,8 +662,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
 	WRITE_PPS(0xff, PROFILE_IDC);
 	WRITE_PPS(1, CONSTRAINT_SET3_FLAG);
 	WRITE_PPS(sps->chroma_format_idc, CHROMA_FORMAT_IDC);
-	WRITE_PPS(sps->bit_depth_luma_minus8 + 8, BIT_DEPTH_LUMA);
-	WRITE_PPS(sps->bit_depth_chroma_minus8 + 8, BIT_DEPTH_CHROMA);
+	WRITE_PPS(sps->bit_depth_luma_minus8, BIT_DEPTH_LUMA);
+	WRITE_PPS(sps->bit_depth_chroma_minus8, BIT_DEPTH_CHROMA);
 	WRITE_PPS(0, QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
 	WRITE_PPS(sps->log2_max_frame_num_minus4, LOG2_MAX_FRAME_NUM_MINUS4);
 	WRITE_PPS(sps->max_num_ref_frames, MAX_NUM_REF_FRAMES);
-- 
2.17.1

