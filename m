Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB8C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B523B221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgIKLsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:48:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbgIKLrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:47:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9FDFB7BABC0350C4F33;
        Fri, 11 Sep 2020 19:46:24 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 19:46:22 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <hdegoede@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] fs: vboxsf: Fix a kernel-doc warning in vboxsf_wrappers.c
Date:   Fri, 11 Sep 2020 19:43:39 +0800
Message-ID: <20200911114339.62308-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/vboxsf/vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/vboxsf/vboxsf_wrappers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
index bfc78a097dae..3b6630e2847d 100644
--- a/fs/vboxsf/vboxsf_wrappers.c
+++ b/fs/vboxsf/vboxsf_wrappers.c
@@ -114,7 +114,7 @@ int vboxsf_unmap_folder(u32 root)
  * vboxsf_create - Create a new file or folder
  * @root:         Root of the shared folder in which to create the file
  * @parsed_path:  The path of the file or folder relative to the shared folder
- * @param:        create_parms Parameters for file/folder creation.
+ * @create_parms: create_parms Parameters for file/folder creation.
  *
  * Create a new file or folder or open an existing one in a shared folder.
  * Note this function always returns 0 / success unless an exceptional condition
-- 
2.17.1

