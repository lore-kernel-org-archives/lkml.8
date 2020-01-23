Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE4C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC1A2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VJhyd7m5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAWIeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:34:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:53508 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgAWIeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:34:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483Ftd6YcJz9v0nG;
        Thu, 23 Jan 2020 09:34:17 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VJhyd7m5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id s6kfSvP7omNZ; Thu, 23 Jan 2020 09:34:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483Ftd5RRQz9v0nF;
        Thu, 23 Jan 2020 09:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579768457; bh=SuuyRp8TxqDqTDz2CmZWzJ4P0VFf/WdzfLFxbafuqSc=;
        h=From:Subject:To:Cc:Date:From;
        b=VJhyd7m5N4qWSzYQzHc1PrEAr5TH3GI5PWyfsh0XvauwD0uXus55aoTicNodSsj8Z
         q14mPYXU30StB2z61t/g7mgYd5eA976ybqFGYwrck0m/etWJiJXMJH6AVXkIa2Ituj
         FMgJssGQhUAOYxdEfmiskGw9rJzsrpU8OelGHq6M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 987788B81C;
        Thu, 23 Jan 2020 09:34:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id c3No3HiXxe0b; Thu, 23 Jan 2020 09:34:18 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62DC68B75B;
        Thu, 23 Jan 2020 09:34:18 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1FA976380D; Thu, 23 Jan 2020 08:34:17 +0000 (UTC)
Message-Id: <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] lib: Reduce user_access_begin() boundaries in
 strncpy_from_user() and strnlen_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Thu, 23 Jan 2020 08:34:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The range passed to user_access_begin() by strncpy_from_user() and
strnlen_user() starts at 'src' and goes up to the limit of userspace
allthough reads will be limited by the 'count' param.

On 32 bits powerpc (book3s/32) access has to be granted for each 256Mbytes
segment and the cost increases with the number of segments to unlock.

Limit the range with 'count' param.

Fixes: 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 lib/strncpy_from_user.c | 14 +++++++-------
 lib/strnlen_user.c      | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index dccb95af6003..706020b06617 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -30,13 +30,6 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long res = 0;
 
-	/*
-	 * Truncate 'max' to the user-specified limit, so that
-	 * we only have one limit we need to check in the loop
-	 */
-	if (max > count)
-		max = count;
-
 	if (IS_UNALIGNED(src, dst))
 		goto byte_at_a_time;
 
@@ -114,6 +107,13 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 		unsigned long max = max_addr - src_addr;
 		long retval;
 
+		/*
+		 * Truncate 'max' to the user-specified limit, so that
+		 * we only have one limit we need to check in the loop
+		 */
+		if (max > count)
+			max = count;
+
 		kasan_check_write(dst, count);
 		check_object_size(dst, count, false);
 		if (user_access_begin(src, max)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 6c0005d5dd5c..41670d4a5816 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -26,13 +26,6 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
 	unsigned long align, res = 0;
 	unsigned long c;
 
-	/*
-	 * Truncate 'max' to the user-specified limit, so that
-	 * we only have one limit we need to check in the loop
-	 */
-	if (max > count)
-		max = count;
-
 	/*
 	 * Do everything aligned. But that means that we
 	 * need to also expand the maximum..
@@ -109,6 +102,13 @@ long strnlen_user(const char __user *str, long count)
 		unsigned long max = max_addr - src_addr;
 		long retval;
 
+		/*
+		 * Truncate 'max' to the user-specified limit, so that
+		 * we only have one limit we need to check in the loop
+		 */
+		if (max > count)
+			max = count;
+
 		if (user_access_begin(str, max)) {
 			retval = do_strnlen_user(str, count, max);
 			user_access_end();
-- 
2.25.0

