Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C00AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3982077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFAN2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:28:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgFAN2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:28:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C68A164AF3E1A136B09;
        Mon,  1 Jun 2020 21:28:01 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 21:27:54 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-afs@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dhowells@redhat.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2] afs: Fix memory leak in afs_put_sysnames()
Date:   Mon, 1 Jun 2020 21:27:34 +0800
Message-ID: <20200601132734.4148325-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysnames should be freed after refcnt being decreased to zero in
afs_put_sysnames().

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <Stable@vger.kernel.org> # v4.17+
Fixes: 6f8880d8e681557 ("afs: Implement @sys substitution handling")
---
 fs/afs/proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 468e1713bce1..6f34c84a0fd0 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -563,6 +563,7 @@ void afs_put_sysnames(struct afs_sysnames *sysnames)
 			if (sysnames->subs[i] != afs_init_sysname &&
 			    sysnames->subs[i] != sysnames->blank)
 				kfree(sysnames->subs[i]);
+		kfree(sysnames);
 	}
 }
 
-- 
2.25.4

