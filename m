Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF738C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92E220829
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgEVQIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEVQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:08:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F6BC05BD43;
        Fri, 22 May 2020 09:08:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcAE3-00009T-0i; Fri, 22 May 2020 18:08:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AAF171C0475;
        Fri, 22 May 2020 18:08:46 +0200 (CEST)
Date:   Fri, 22 May 2020 16:08:46 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] compiler.h: Remove data_race() and unnecessary
 checks from {READ,WRITE}_ONCE()
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521142047.169334-9-elver@google.com>
References: <20200521142047.169334-9-elver@google.com>
MIME-Version: 1.0
Message-ID: <159016372659.17951.9279233583704092655.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     777f73c4e79106d45b304f6af0d31917864dbdf1
Gitweb:        https://git.kernel.org/tip/777f73c4e79106d45b304f6af0d31917864dbdf1
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 21 May 2020 16:20:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 May 2020 15:19:53 +02:00

compiler.h: Remove data_race() and unnecessary checks from {READ,WRITE}_ONCE()

The volatile accesses no longer need to be wrapped in data_race()
because compilers that emit instrumentation distinguishing volatile
accesses are required for KCSAN.

Consequently, the explicit kcsan_check_atomic*() are no longer required
either since the compiler emits instrumentation distinguishing the
volatile accesses.

Finally, simplify __READ_ONCE_SCALAR() and remove __WRITE_ONCE_SCALAR().

 [ bp: Convert commit message to passive voice. ]

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200521142047.169334-9-elver@google.com
---
 include/linux/compiler.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 17c98b2..7444f02 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -228,9 +228,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
-	typeof(x) *__xp = &(x);						\
-	__unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));	\
-	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
 	smp_read_barrier_depends();					\
 	(typeof(x))__x;							\
 })
@@ -246,17 +244,10 @@ do {									\
 	*(volatile typeof(x) *)&(x) = (val);				\
 } while (0)
 
-#define __WRITE_ONCE_SCALAR(x, val)					\
-do {									\
-	typeof(x) *__xp = &(x);						\
-	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
-	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
-} while (0)
-
 #define WRITE_ONCE(x, val)						\
 do {									\
 	compiletime_assert_rwonce_type(x);				\
-	__WRITE_ONCE_SCALAR(x, val);					\
+	__WRITE_ONCE(x, val);						\
 } while (0)
 
 #ifdef CONFIG_KASAN
