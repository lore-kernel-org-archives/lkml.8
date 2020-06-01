Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2901C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CD4206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFALvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:51:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgFALvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:51:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9DE07D15174F6FB97AB7;
        Mon,  1 Jun 2020 19:51:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 19:51:44 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] userfaultfd: eliminate meaningless check in userfaultfd_register()
Date:   Mon, 1 Jun 2020 19:55:21 +0800
Message-ID: <1591012521-517-1-git-send-email-linmiaohe@huawei.com>
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

When we reach here, !(cur->vm_flags & VM_MAYWRITE) is already checked and
equals to false. So the condition here always equals to false and should
be eliminated.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/userfaultfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e39fdec8a0b0..e529e6bbb57b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1409,8 +1409,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 			if (end & (vma_hpagesize - 1))
 				goto out_unlock;
 		}
-		if ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_MAYWRITE))
-			goto out_unlock;
 
 		/*
 		 * Check that this vma isn't already owned by a
-- 
2.19.1

