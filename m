Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCFAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229A520639
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHNI6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:58:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbgHNI6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:58:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C1072DB640A2C392284;
        Fri, 14 Aug 2020 16:58:30 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 14 Aug 2020
 16:58:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <tglx@linutronix.de>,
        <christian.brauner@ubuntu.com>, <vbabka@suse.cz>,
        <daniel.m.jordan@oracle.com>, <Nicolas.Viennot@twosigma.com>,
        <walken@google.com>, <mchristi@redhat.com>, <arnd@arndb.de>,
        <viro@zeniv.linux.org.uk>, <thomascedeno@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] kernel/sys.c: Convert to use the preferred fallthrough macro
Date:   Fri, 14 Aug 2020 04:57:18 -0400
Message-ID: <20200814085718.40326-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index ca11af9d815d..ab6c409b1159 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1753,7 +1753,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 
 		if (who == RUSAGE_CHILDREN)
 			break;
-		/* fall through */
+		fallthrough;
 
 	case RUSAGE_SELF:
 		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-- 
2.19.1

