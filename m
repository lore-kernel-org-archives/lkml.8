Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D420EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A664420715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="j0Ml1RuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgGFVyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:54:35 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:52314 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgGFVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=5txQuAYNmGaU8Nd4lJkjbzMqb30VPI9NYZ7MC6DEj1w=;
        b=j0Ml1RuAt+c/U6xC0bWI21e1cYRXKqaZoxydlpSUDj0SOTWSGz9MlgjYUfpEAFOwoXuv
        guGFshEHJTPM7WNL8x1iW1MlBlwwtT6KQ8CJM7IJARPd7GVUuBGjPCd7OZFtXuWZ0+PpLo
        vl8AKTewiMO/YYLeYhkPumE0p2g7d4ZLw=
Received: by filterdrecv-p3iad2-5b55dcd864-v6r54 with SMTP id filterdrecv-p3iad2-5b55dcd864-v6r54-19-5F039D99-5C
        2020-07-06 21:54:33.767276128 +0000 UTC m=+881107.614285949
Received: from bionic.localdomain (unknown)
        by ismtpd0008p1lon1.sendgrid.net (SG) with ESMTP
        id OHp0ZKomRAG6VTmnegSU3A
        Mon, 06 Jul 2020 21:54:33.516 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 01/12] media: rkvdec: h264: Fix reference frame_num wrap
 for second field
Date:   Mon, 06 Jul 2020 21:54:33 +0000 (UTC)
Message-Id: <20200706215430.22859-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706215430.22859-1-jonas@kwiboo.se>
References: <20200701215616.30874-1-jonas@kwiboo.se>
 <20200706215430.22859-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+NCRrAaiddgiZamr?=
 =?us-ascii?Q?HL+cGPmHoqntE5sMJmmMqzxuYqSmGLayo0XcIwD?=
 =?us-ascii?Q?38=2F0P1dX24xvgtJBcr4hYEb8ZS=2Fl6VJQzUcZ=2FyT?=
 =?us-ascii?Q?AWaBw8mzPnJkGcx6EMKEnF=2FQv5SZEQz=2FS17W0DE?=
 =?us-ascii?Q?r0s+fjUsnvaSVZEFTp7TbxOO8kpBPBKLcrejUm3?=
 =?us-ascii?Q?aOfimmTtp76EPL2u=2FatrA=3D=3D?=
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
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
---
Changes in v2:
- Collect r-b tag
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

