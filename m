Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60841C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EFE2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWAyEiNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCQNgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:36:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41437 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCQNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:36:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so2612681plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=YXH/xNjxfleJEOV9byMjccsKxIs9a6z9OWbDdfpz6zc=;
        b=JWAyEiNuawTbzorI83x8So0gmfsgpwNOs6jttV8hfKCHYkRXRBaT+C+hh87XItsDBm
         vPgKo0OZ3oIVlb6gTgvnxKtV1zz3tRx5tzYAU5gs0JfLy/xBcGXBsBPWRZzBLEEaXfIV
         28uEueo9T1tDm+axDqubcH/w1zJYyTpnbaXJeUiDY1FSKtQxmULUN4ZaUSmDr+O6rr83
         lt/F5WUbANR/ANSEw/aNW2OVy233bGggVheNCdEls8PSMuwWinSVvwxKx5yhYWGsQC5T
         coCaY+Sr/nSPn9lWGHCO5W5ehx3hv6xphbd1kR0WTalMsf0zPMUA55xRRc/977aj4zU6
         B9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=YXH/xNjxfleJEOV9byMjccsKxIs9a6z9OWbDdfpz6zc=;
        b=swUwsHFZVn1PRB8+a4dYDu5jfOPKX+J2cbYOcMciAkC/uYt5u5sOFpBQbJ384AKTdQ
         VgLv92N21DPx6qaqtUZy5xPEq1z0sGbyC88OcllhwEOTiPzrk2RqZJyf+4mIr4RFWswY
         aYxXDNoqe7+6YfAgs2FWMk01/O9CSIgfQkgY5pQLmvD+F4IpTSQkTtDx88zsNtr4quB7
         RwMcoMwUJYGtwPWUMXxl9LahTpDYLDpATCHzl2+hQt2hTCyySWyLohiLn1ECL6eoJpWd
         LbgFezJXNpGtrETvivdaoHMiT07hgqs/jJDmpnQVSzJQuMLkMrG1ufCTwtYPuu6Ex721
         olVw==
X-Gm-Message-State: ANhLgQ1jr4gSDl5Emi4T5n9RzV8A+zxA92EqC2mtiqNkkYJIl7c9Ngzu
        YwMiWoqdhgUchEOHGIRtlSaufvEZ
X-Google-Smtp-Source: ADFU+vsdKkZOSbYKYTdaP996gRlC8ZEsAXNNtMSQ+NHtfA057RJVAxylFVonGmibsVEfMno0CouzLw==
X-Received: by 2002:a17:90a:3a8c:: with SMTP id b12mr5498911pjc.48.1584452178849;
        Tue, 17 Mar 2020 06:36:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s125sm2853594pgc.53.2020.03.17.06.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 06:36:17 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH] lib/test_lockup: Rename disable_irq to fix build error
Date:   Tue, 17 Mar 2020 06:36:14 -0700
Message-Id: <20200317133614.23152-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mips:allmodconfig fails to build.

lib/test_lockup.c:87:13: error:
	'disable_irq' redeclared as different kind of symbol
   87 | static bool disable_irq;
      |             ^~~~~~~~~~~
In file included from arch/mips/include/asm/highmem.h:24,
                 from arch/mips/include/asm/pgtable-32.h:22,
                 from arch/mips/include/asm/pgtable.h:14,
                 from include/linux/mm.h:95,
                 from lib/test_lockup.c:15:
include/linux/interrupt.h:237:13: note:
	previous declaration of 'disable_irq' was here
  237 | extern void disable_irq(unsigned int irq);

Rename the variable to fix the problem.

Fixes: 0e86238873f3 ("lib/test_lockup: test module to generate lockups")
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/test_lockup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index b45afd3ad7cb..83683ec1f429 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -84,8 +84,8 @@ static unsigned long lock_wait_threshold = ULONG_MAX;
 module_param(lock_wait_threshold, ulong, 0400);
 MODULE_PARM_DESC(lock_wait_threshold, "print lock wait time longer than this in nanoseconds, default off");
 
-static bool disable_irq;
-module_param(disable_irq, bool, 0400);
+static bool test_disable_irq;
+module_param_named(disable_irq, test_disable_irq, bool, 0400);
 MODULE_PARM_DESC(disable_irq, "disable interrupts: generate hard-lockups");
 
 static bool disable_softirq;
@@ -179,7 +179,7 @@ static void test_lock(bool master, bool verbose)
 			down_write(&main_task->mm->mmap_sem);
 	}
 
-	if (disable_irq)
+	if (test_disable_irq)
 		local_irq_disable();
 
 	if (disable_softirq)
@@ -252,7 +252,7 @@ static void test_unlock(bool master, bool verbose)
 	if (disable_softirq)
 		local_bh_enable();
 
-	if (disable_irq)
+	if (test_disable_irq)
 		local_irq_enable();
 
 	if (lock_mmap_sem && master) {
@@ -479,8 +479,8 @@ static int __init test_lockup_init(void)
 	if ((wait_state != TASK_RUNNING ||
 	     (call_cond_resched && !reacquire_locks) ||
 	     (alloc_pages_nr && gfpflags_allow_blocking(alloc_pages_gfp))) &&
-	    (disable_irq || disable_softirq || disable_preempt || lock_rcu ||
-	     lock_spinlock_ptr || lock_rwlock_ptr)) {
+	    (test_disable_irq || disable_softirq || disable_preempt ||
+	     lock_rcu || lock_spinlock_ptr || lock_rwlock_ptr)) {
 		pr_err("refuse to sleep in atomic context\n");
 		return -EINVAL;
 	}
@@ -495,7 +495,7 @@ static int __init test_lockup_init(void)
 		  cooldown_secs, cooldown_nsecs, iterations, state,
 		  all_cpus ? "all_cpus " : "",
 		  iowait ? "iowait " : "",
-		  disable_irq ? "disable_irq " : "",
+		  test_disable_irq ? "disable_irq " : "",
 		  disable_softirq ? "disable_softirq " : "",
 		  disable_preempt ? "disable_preempt " : "",
 		  lock_rcu ? "lock_rcu " : "",
-- 
2.17.1

