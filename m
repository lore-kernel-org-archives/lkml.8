Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65DCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEB52073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGBK32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:29:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728332AbgGBK31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:29:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E1E4EFFA93159E03A4A;
        Thu,  2 Jul 2020 18:29:26 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 18:29:15 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Alasdair Kergon <agk@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dm: remove unused variable 'md'
Date:   Thu, 2 Jul 2020 18:39:28 +0800
Message-ID: <20200702103928.67693-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 5a6c35f9af41 ("block: remove direct_make_request"),
'md' is never used and gcc report build warning:

drivers/md/dm.c:1296:24: warning: unused variable 'md' [-Wunused-variable]
 1296 |  struct mapped_device *md = io->md;
      |                        ^~

Removing it to avoid build warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/md/dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a8d83d76fa9f..a02842afe358 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1293,7 +1293,6 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 	sector_t sector;
 	struct bio *clone = &tio->clone;
 	struct dm_io *io = tio->io;
-	struct mapped_device *md = io->md;
 	struct dm_target *ti = tio->ti;
 	blk_qc_t ret = BLK_QC_T_NONE;
 

