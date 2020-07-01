Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957D4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E72820780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbgGANQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:16:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45804 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgGANQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:16:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E0EA42A56CE
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 2/6] hantro: h264: Rename scaling list handling function
Date:   Wed,  1 Jul 2020 10:16:03 -0300
Message-Id: <20200701131607.121988-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200701131607.121988-1-ezequiel@collabora.com>
References: <20200701131607.121988-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e17f08e3166 ("media: hantro: Do not reorder
H264 scaling list") removed the scaling list reordering,
which was wrong and not needed.

However, the name of the function stayed, which is
confusing for anyone reading the code. Rename
from "reorder" to "assemble" which is cleaner.

This is just a cosmetic cleanup.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/hantro/hantro_h264.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
index dd935d7009bf..194d05848077 100644
--- a/drivers/staging/media/hantro/hantro_h264.c
+++ b/drivers/staging/media/hantro/hantro_h264.c
@@ -193,7 +193,7 @@ static const u32 h264_cabac_table[] = {
 };
 
 static void
-reorder_scaling_list(struct hantro_ctx *ctx)
+assemble_scaling_list(struct hantro_ctx *ctx)
 {
 	const struct hantro_h264_dec_ctrls *ctrls = &ctx->h264_dec.ctrls;
 	const struct v4l2_ctrl_h264_scaling_matrix *scaling = ctrls->scaling;
@@ -235,7 +235,7 @@ static void prepare_table(struct hantro_ctx *ctx)
 	tbl->poc[32] = dec_param->top_field_order_cnt;
 	tbl->poc[33] = dec_param->bottom_field_order_cnt;
 
-	reorder_scaling_list(ctx);
+	assemble_scaling_list(ctx);
 }
 
 static bool dpb_entry_match(const struct v4l2_h264_dpb_entry *a,
-- 
2.26.0.rc2

