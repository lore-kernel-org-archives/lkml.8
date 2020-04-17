Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92328C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750BB208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgDQHNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:13:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2343 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbgDQHNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:13:32 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 75200DDCB0D10D3F5917
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 15:13:30 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:13:19 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] locking/static_keys: make old_true_key and old_false_key static
Date:   Fri, 17 Apr 2020 15:39:45 +0800
Message-ID: <20200417073945.45851-1-yanaijie@huawei.com>
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

Fix the following sparse warning:

lib/test_static_keys.c:15:19: warning: symbol 'old_true_key' was not
declared. Should it be static?
lib/test_static_keys.c:16:19: warning: symbol 'old_false_key' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 lib/test_static_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_static_keys.c b/lib/test_static_keys.c
index 42daa74be029..41658c5bf770 100644
--- a/lib/test_static_keys.c
+++ b/lib/test_static_keys.c
@@ -12,8 +12,8 @@
 #include <linux/jump_label.h>
 
 /* old keys */
-struct static_key old_true_key	= STATIC_KEY_INIT_TRUE;
-struct static_key old_false_key	= STATIC_KEY_INIT_FALSE;
+static struct static_key old_true_key	= STATIC_KEY_INIT_TRUE;
+static struct static_key old_false_key	= STATIC_KEY_INIT_FALSE;
 
 /* new api */
 DEFINE_STATIC_KEY_TRUE(true_key);
-- 
2.21.1

