Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07CFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:55:32 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B055A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B055A20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgDMHzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:55:30 -0400
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBDFC008651
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:55:30 -0700 (PDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6806FF8B2A26912A7069;
        Mon, 13 Apr 2020 15:55:27 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 15:55:18 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <dhowells@redhat.com>, <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <yanaijie@huawei.com>,
        <linux@rasmusvillemoes.dk>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] user.c: make uidhash_table static
Date:   Mon, 13 Apr 2020 16:21:46 +0800
Message-ID: <20200413082146.22737-1-yanaijie@huawei.com>
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

kernel/user.c:85:19: warning: symbol 'uidhash_table' was not declared.
Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 kernel/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/user.c b/kernel/user.c
index 5235d7f49982..b1635d94a1f2 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(init_user_ns);
 #define uidhashentry(uid)	(uidhash_table + __uidhashfn((__kuid_val(uid))))
 
 static struct kmem_cache *uid_cachep;
-struct hlist_head uidhash_table[UIDHASH_SZ];
+static struct hlist_head uidhash_table[UIDHASH_SZ];
 
 /*
  * The uidhash_lock is mostly taken from process context, but it is
-- 
2.21.1

