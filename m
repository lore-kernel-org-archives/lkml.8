Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D62C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E94C2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063063;
	bh=1OCEDwU9HDg1YRkwjzMBn5RpJKhK/uC509VN2U3vg0c=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=F+PFNOaC5OO0nYgL7awIScbc6+kp1UcLKtru2WXd97EWoQiH69Tb7mLt1OxRvLGj3
	 aBmHBh5RqvnethUI1eW2UKih4GrO+lMO3uxWZTZteSZ2tJAk8Q4E4byROuqaMib8pu
	 DK7vmnZDIWXLjjMovBsczSPmWrQKaot7EXMmuipI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgIBQLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgIBQKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:10:46 -0400
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B0320829;
        Wed,  2 Sep 2020 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063046;
        bh=1OCEDwU9HDg1YRkwjzMBn5RpJKhK/uC509VN2U3vg0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifhvhUuYT6pd0LE2qsDDFfRrMs8OdIaCz9X7BIOgxoGIjS6nbjFk3zb/jSh37oh2k
         nF6OongzJKq2WaCYU3KSWPiKn5o9cVjdXfv0Jh96z4VXkZpBNguFTgU0YhvGGBUa+O
         Ypt7/TzZzQ1xyDr+AhnWN65zCsVHK6mfMlG7CzEI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kDVLP-000t9r-Oh; Wed, 02 Sep 2020 18:10:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/38] media: wl128x: get rid of a potential spectre issue
Date:   Wed,  2 Sep 2020 18:10:08 +0200
Message-Id: <17a07bd5f4a690a388ba03daf8d01b30bd9cd8d9.1599062230.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599062230.git.mchehab+huawei@kernel.org>
References: <cover.1599062230.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by smatch:
	drivers/media/radio/wl128x/fmdrv_common.c:736 fm_irq_handle_rdsdata_getcmd_resp() warn: potential spectre issue 'rds_fmt.data.groupdatabuff.buff>

Address it by using array_index_nospec().

While here, reorder the linux/ includes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 5c395da74e17..9abc8e0283c1 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -19,9 +19,11 @@
  *  Author: Manjunatha Halli <manjunatha_halli@ti.com>
  */
 
-#include <linux/module.h>
-#include <linux/firmware.h>
 #include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/nospec.h>
+
 #include "fmdrv.h"
 #include "fmdrv_v4l2.h"
 #include "fmdrv_common.h"
@@ -700,7 +702,7 @@ static void fm_irq_handle_rdsdata_getcmd_resp(struct fmdev *fmdev)
 	struct fm_rds *rds = &fmdev->rx.rds;
 	unsigned long group_idx, flags;
 	u8 *rds_data, meta_data, tmpbuf[FM_RDS_BLK_SIZE];
-	u8 type, blk_idx;
+	u8 type, blk_idx, idx;
 	u16 cur_picode;
 	u32 rds_len;
 
@@ -733,9 +735,11 @@ static void fm_irq_handle_rdsdata_getcmd_resp(struct fmdev *fmdev)
 		}
 
 		/* Skip checkword (control) byte and copy only data byte */
-		memcpy(&rds_fmt.data.groupdatabuff.
-				buff[blk_idx * (FM_RDS_BLK_SIZE - 1)],
-				rds_data, (FM_RDS_BLK_SIZE - 1));
+		idx = array_index_nospec(blk_idx * (FM_RDS_BLK_SIZE - 1),
+				         FM_RX_RDS_INFO_FIELD_MAX - (FM_RDS_BLK_SIZE - 1));
+
+		memcpy(&rds_fmt.data.groupdatabuff.buff[idx], rds_data,
+		       FM_RDS_BLK_SIZE - 1);
 
 		rds->last_blk_idx = blk_idx;
 
-- 
2.26.2

