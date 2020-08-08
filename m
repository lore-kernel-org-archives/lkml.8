Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFCCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 09:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8FA2087C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 09:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgHHJTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 05:19:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbgHHJTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 05:19:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C8169DEA7AD9721ED9F6;
        Sat,  8 Aug 2020 17:19:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 8 Aug 2020
 17:18:58 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <xiang@kernel.org>, <chao@kernel.org>
CC:     <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] erofs: Convert to use the fallthrough macro
Date:   Sat, 8 Aug 2020 17:21:26 +0800
Message-ID: <1596878486-23499-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/erofs/zmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7d40d78ea864..ae325541884e 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -359,7 +359,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		return z_erofs_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		map->m_flags &= ~EROFS_MAP_ZIPPED;
-		/* fallthrough */
+		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
@@ -416,7 +416,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		if (endoff >= m.clusterofs)
 			map->m_flags &= ~EROFS_MAP_ZIPPED;
-		/* fallthrough */
+		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		if (endoff >= m.clusterofs) {
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -433,7 +433,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		end = (m.lcn << lclusterbits) | m.clusterofs;
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
-		/* fallthrough */
+		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
-- 
2.19.1

