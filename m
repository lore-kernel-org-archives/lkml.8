Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E074A2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="oXom7lgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGAV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:56:27 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:62027 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgGAV4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=x8pjW6TLR+SQF49vxCxwQlIssNxtmW5lEIJnRKN/noI=;
        b=oXom7lgfCZGjQ63fDwwXmq4xaXRbsvoZZyJYM2P6GGnMXTU3xV75c4tdnXANCddIhZCT
        FHTDS6trO47W9iqy0r7rWE99XCMZo+UUtCDUxkdxu9viutmB1EtdJrP/fJqR9lHjUmKWDA
        bhXU2qRcnQUTiz784xvnvh9R7k2yXfQnI=
Received: by filterdrecv-p3iad2-5b55dcd864-d2lx7 with SMTP id filterdrecv-p3iad2-5b55dcd864-d2lx7-18-5EFD0685-18
        2020-07-01 21:56:21.373950182 +0000 UTC m=+449219.026043672
Received: from bionic.localdomain (unknown)
        by ismtpd0001p1lon1.sendgrid.net (SG) with ESMTP
        id bim62XYeQrOv5R9hIYElFQ
        Wed, 01 Jul 2020 21:56:21.119 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/9] media: rkvdec: h264: Fix reference frame_num wrap for
 second field
Date:   Wed, 01 Jul 2020 21:56:21 +0000 (UTC)
Message-Id: <20200701215616.30874-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701215616.30874-1-jonas@kwiboo.se>
References: <20200701215616.30874-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h1783C2MVdgrW5Lqx?=
 =?us-ascii?Q?p00UHjwcuImHPDqMe3RyKxPbQzLCwhuE5Qid432?=
 =?us-ascii?Q?TRiZGHHQzwzQ=2FGwg1C9DE3BApMARs1BqSadnIUS?=
 =?us-ascii?Q?zjiV9y0r4Aq1Xrfx5GPCUkiibq0W3jbmKb8tOD7?=
 =?us-ascii?Q?f0u6461YlXgcY7vKHj0i4ULe9OKTTqptJ=2F9SNMe?=
 =?us-ascii?Q?nzbLJlAuR5St0W0J1Qbvg=3D=3D?=
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

When decoding the second field in a complementary field pair the second
field is sharing the same frame_num with the first field.

Currently the frame_num for the first field is wrapped when it matches the
field being decoded, this cause issues to decode the second field in a
complementary field pair.

Fix this by using inclusive comparison, less than or equal.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 7b66e2743a4f..f0cfed84d60d 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -754,7 +754,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
 			continue;
 
 		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
-		    dpb[i].frame_num < sl_params->frame_num) {
+		    dpb[i].frame_num <= sl_params->frame_num) {
 			p[i] = dpb[i].frame_num;
 			continue;
 		}
-- 
2.17.1

