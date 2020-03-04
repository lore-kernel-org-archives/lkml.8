Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1644B20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgCDMsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:48:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728953AbgCDMso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:48:44 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C18B397235A83F66C401;
        Wed,  4 Mar 2020 20:48:33 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Mar 2020
 20:48:25 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "Scott Wood" <oss@buserror.net>, Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH] vfsprintf: only hash addresses in security environment
Date:   Wed, 4 Mar 2020 20:47:07 +0800
Message-ID: <20200304124707.22650-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I am implementing KASLR for powerpc, Scott Wood argued that format
specifier "%p" always hashes the addresses that people do not have a
choice to shut it down: https://patchwork.kernel.org/cover/11367547/

It's true that if in a debug environment or security is not concerned,
such as KASLR is absent or kptr_restrict = 0,  there is no way to shut
the hashing down except changing the code and build the kernel again
to use a different format specifier like "%px". And when we want to
turn to security environment, the format specifier has to be changed
back and rebuild the kernel.

As KASLR is available on most popular platforms and enabled by default,
print the raw value of address while KASLR is absent and kptr_restrict
is zero. Those who concerns about security must have KASLR enabled or
kptr_restrict set properly.

Cc: Scott Wood <oss@buserror.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Tobin C . Harding" <tobin@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Axtens <dja@axtens.net>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 lib/vsprintf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a1ce318..f74131b152a1 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2253,8 +2253,15 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return err_ptr(buf, end, ptr, spec);
 	}
 
-	/* default is to _not_ leak addresses, hash before printing */
-	return ptr_to_id(buf, end, ptr, spec);
+	/*
+	 * In security environment, while kaslr is enabled or kptr_restrict is
+	 * not zero, hash before printing so that addresses will not be
+	 * leaked. And if not in a security environment, print the raw value
+	 */
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) || kptr_restrict)
+		return ptr_to_id(buf, end, ptr, spec);
+	else
+		return pointer_string(buf, end, ptr, spec);
 }
 
 /*
-- 
2.17.2

