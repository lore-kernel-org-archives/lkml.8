Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F081DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5FE2065E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgG3Ghv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:37:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgG3Ghv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:37:51 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B002FC277C6F562E7155;
        Thu, 30 Jul 2020 14:37:46 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 14:37:43 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <colin.king@canonical.com>, <iii@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390/test_unwind: fix possible memleak in test_unwind()
Date:   Thu, 30 Jul 2020 14:36:02 +0800
Message-ID: <20200730063602.31581-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_unwind() misses to call kfree(bt) in an error path.
Add the missed function call to fix it.

Fixes: 0610154650f1 ("s390/test_unwind: print verbose unwinding results")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 arch/s390/lib/test_unwind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 32b7a30b2485..b0b12b46bc57 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -63,6 +63,7 @@ static noinline int test_unwind(struct task_struct *task, struct pt_regs *regs,
 			break;
 		if (state.reliable && !addr) {
 			pr_err("unwind state reliable but addr is 0\n");
+			kfree(bt);
 			return -EINVAL;
 		}
 		sprint_symbol(sym, addr);
-- 
2.17.1

