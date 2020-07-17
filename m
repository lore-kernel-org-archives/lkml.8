Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A3C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F0B2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPh7MrXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9SYZJUm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGQLWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:22:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:22:07 -0400
Date:   Fri, 17 Jul 2020 11:22:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594984925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8s6cNM7MtRlSok9GImSXnEBbHubXILx7M8AacRQ5vs=;
        b=HPh7MrXw4k+Uo1fnmMy+2X+kRt3R6iC3VROmeHGvq3vniTn98CYphHK99ZTLd+meJRg5CL
        HxV3of6r8pbnrDw9SWSzruuRvG3wrqzZsxEfQx78/xFKMBO29zjXwLkuqIhlBU2/11/K2E
        hKQvHn5bM3nBF6oWPJ4TvZJptRbR3E6dy3A92tkCsUcGT7wwDNoe0a02BNc+57xOJgwiy0
        kzz6XmHnPwegh+vQ2adi9bdyBgs04zINjYjEnd5xAw3FbqqD0KKWzVRnlVfPj35rmSYYQq
        kr/g/qtRr7gldg42JwRafDjwUsDjODtgYPHJSSBdPHrj/399HY1raA5LkqWc/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594984925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8s6cNM7MtRlSok9GImSXnEBbHubXILx7M8AacRQ5vs=;
        b=9SYZJUm4Svq6Yc8bDnv7qA4RvuEbj05n5oU38P8SppoIzWwvkAKlQpZsONgmL0FuSheFyS
        aI78NEQHAieLvABg==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rwsem: fix commas in initialisation
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200711145954.GA1178171@localhost.localdomain>
References: <20200711145954.GA1178171@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <159498492487.4006.3074738466487716575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a9232dc5607dbada801f2fe83ea307cda762969a
Gitweb:        https://git.kernel.org/tip/a9232dc5607dbada801f2fe83ea307cda762969a
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Sat, 11 Jul 2020 17:59:54 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Jul 2020 23:19:51 +02:00

rwsem: fix commas in initialisation

Leading comma prevents arbitrary reordering of initialisation clauses.
The whole point of C99 initialisation is to allow any such reordering.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200711145954.GA1178171@localhost.localdomain
---
 include/linux/rwsem.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 7e5b2a4..25e3fde 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -60,39 +60,39 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 }
 
 #define RWSEM_UNLOCKED_VALUE		0L
-#define __RWSEM_INIT_COUNT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
+#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
 
 /* Common initializer macros and functions */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
-	, .dep_map = {					\
+	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
-	}
+	},
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
 #endif
 
 #ifdef CONFIG_DEBUG_RWSEMS
-# define __DEBUG_RWSEM_INITIALIZER(lockname) , .magic = &lockname
+# define __RWSEM_DEBUG_INIT(lockname) .magic = &lockname,
 #else
-# define __DEBUG_RWSEM_INITIALIZER(lockname)
+# define __RWSEM_DEBUG_INIT(lockname)
 #endif
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-#define __RWSEM_OPT_INIT(lockname) , .osq = OSQ_LOCK_UNLOCKED
+#define __RWSEM_OPT_INIT(lockname) .osq = OSQ_LOCK_UNLOCKED,
 #else
 #define __RWSEM_OPT_INIT(lockname)
 #endif
 
 #define __RWSEM_INITIALIZER(name)				\
-	{ __RWSEM_INIT_COUNT(name),				\
+	{ __RWSEM_COUNT_INIT(name),				\
 	  .owner = ATOMIC_LONG_INIT(0),				\
-	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
-	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock)	\
 	  __RWSEM_OPT_INIT(name)				\
-	  __DEBUG_RWSEM_INITIALIZER(name)			\
+	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),\
+	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
+	  __RWSEM_DEBUG_INIT(name)				\
 	  __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
