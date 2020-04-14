Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4365C2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF43206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439416AbgDNLiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:38:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439385AbgDNLiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:38:17 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CD9FA45AF00F09E57F75;
        Tue, 14 Apr 2020 19:36:07 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Apr 2020
 19:35:57 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <namjae.jeon@samsung.com>, <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] exfat: remove the assignment of 0 to bool variable
Date:   Tue, 14 Apr 2020 20:02:25 +0800
Message-ID: <20200414120225.35540-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to init 'sync' in exfat_set_vol_flags().
This also fixes the following coccicheck warning:

fs/exfat/super.c:104:6-10: WARNING: Assignment of 0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/exfat/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 16ed202ef527..b86755468904 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -101,7 +101,7 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct pbr64 *bpb;
-	bool sync = 0;
+	bool sync;
 
 	/* flags are not changed */
 	if (sbi->vol_flag == new_flag)
-- 
2.21.1

