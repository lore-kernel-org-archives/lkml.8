Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D342BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73A220768
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgDIQck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:32:40 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:25858 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDIQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:32:39 -0400
Received: from localhost.localdomain ([93.22.150.119])
        by mwinf5d45 with ME
        id QgYb2200C2aoYT903gYbdg; Thu, 09 Apr 2020 18:32:38 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 09 Apr 2020 18:32:38 +0200
X-ME-IP: 93.22.150.119
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] lib/math: avoid trailing '\n' hidden in pr_fmt()
Date:   Thu,  9 Apr 2020 18:32:34 +0200
Message-Id: <20200409163234.22830-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_xxx() functions usually have '\n' at the end of the logging message.
Here, this '\n' is added via the 'pr_fmt' macro.

In order to be more consistent with other files, use a more standard
convention and put these '\n' back in the messages themselves and remove it
from the pr_fmt macro.

While at it, use __func__ instead of hardcoding a function name in the
last message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 lib/math/prime_numbers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
index 052f5b727be7..d42cebf7407f 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "prime numbers: " fmt "\n"
+#define pr_fmt(fmt) "prime numbers: " fmt
 
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -253,7 +253,7 @@ static void dump_primes(void)
 
 	if (buf)
 		bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
-	pr_info("primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s",
+	pr_info("primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s\n",
 		p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
 
 	rcu_read_unlock();
@@ -273,7 +273,7 @@ static int selftest(unsigned long max)
 		bool fast = is_prime_number(x);
 
 		if (slow != fast) {
-			pr_err("inconsistent result for is-prime(%lu): slow=%s, fast=%s!",
+			pr_err("inconsistent result for is-prime(%lu): slow=%s, fast=%s!\n",
 			       x, slow ? "yes" : "no", fast ? "yes" : "no");
 			goto err;
 		}
@@ -282,14 +282,14 @@ static int selftest(unsigned long max)
 			continue;
 
 		if (next_prime_number(last) != x) {
-			pr_err("incorrect result for next-prime(%lu): expected %lu, got %lu",
+			pr_err("incorrect result for next-prime(%lu): expected %lu, got %lu\n",
 			       last, x, next_prime_number(last));
 			goto err;
 		}
 		last = x;
 	}
 
-	pr_info("selftest(%lu) passed, last prime was %lu", x, last);
+	pr_info("%s(%lu) passed, last prime was %lu\n", __func__, x, last);
 	return 0;
 
 err:
-- 
2.20.1

