Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B881C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BA22074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgDHH1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:27:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbgDHH1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:27:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CF5A5AEDFCA8666080F;
        Wed,  8 Apr 2020 15:27:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 15:27:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] dm integrity: remove set but not used variables
Date:   Wed, 8 Apr 2020 07:29:48 +0000
Message-ID: <20200408072948.156175-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/md/dm-integrity.c: In function 'integrity_metadata':
drivers/md/dm-integrity.c:1557:12: warning:
 variable 'save_metadata_offset' set but not used [-Wunused-but-set-variable]
drivers/md/dm-integrity.c:1556:12: warning:
 variable 'save_metadata_block' set but not used [-Wunused-but-set-variable]

They are never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/md/dm-integrity.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b989d109d55d..94fb584854b8 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1553,8 +1553,6 @@ static void integrity_metadata(struct work_struct *w)
 		char checksums_onstack[max((size_t)HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 		sector_t sector;
 		unsigned sectors_to_process;
-		sector_t save_metadata_block;
-		unsigned save_metadata_offset;
 
 		if (unlikely(ic->mode == 'R'))
 			goto skip_io;
@@ -1605,8 +1603,6 @@ static void integrity_metadata(struct work_struct *w)
 			goto skip_io;
 		}
 
-		save_metadata_block = dio->metadata_block;
-		save_metadata_offset = dio->metadata_offset;
 		sector = dio->range.logical_sector;
 		sectors_to_process = dio->range.n_sectors;



