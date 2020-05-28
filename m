Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E33DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD9F207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406388AbgE1T2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406269AbgE1T2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:28:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352CC08C5C6;
        Thu, 28 May 2020 12:28:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeOCL-0007H0-0A; Thu, 28 May 2020 21:28:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 49FAB1C0051;
        Thu, 28 May 2020 21:28:12 +0200 (CEST)
Date:   Thu, 28 May 2020 19:28:12 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/spinlock: Remove obsolete ticket spinlock
 macros and types
Cc:     Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526122014.25241-1-longman@redhat.com>
References: <20200526122014.25241-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <159069409208.17951.7617521732201159999.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     2ca41f555e857ec5beef6063bfa43a17ee76d7ec
Gitweb:        https://git.kernel.org/tip/2ca41f555e857ec5beef6063bfa43a17ee76d7ec
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 26 May 2020 08:20:14 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 May 2020 21:18:40 +02:00

x86/spinlock: Remove obsolete ticket spinlock macros and types

Even though the x86 ticket spinlock code has been removed with

  cfd8983f03c7 ("x86, locking/spinlocks: Remove ticket (spin)lock implementation")

a while ago, there are still some ticket spinlock specific macros and
types left in the asm/spinlock_types.h header file that are no longer
used. Remove those as well to avoid confusion.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200526122014.25241-1-longman@redhat.com
---
 arch/x86/include/asm/spinlock_types.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
index bf3e34b..323db6c 100644
--- a/arch/x86/include/asm/spinlock_types.h
+++ b/arch/x86/include/asm/spinlock_types.h
@@ -3,29 +3,7 @@
 #define _ASM_X86_SPINLOCK_TYPES_H
 
 #include <linux/types.h>
-
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-#define __TICKET_LOCK_INC	2
-#define TICKET_SLOWPATH_FLAG	((__ticket_t)1)
-#else
-#define __TICKET_LOCK_INC	1
-#define TICKET_SLOWPATH_FLAG	((__ticket_t)0)
-#endif
-
-#if (CONFIG_NR_CPUS < (256 / __TICKET_LOCK_INC))
-typedef u8  __ticket_t;
-typedef u16 __ticketpair_t;
-#else
-typedef u16 __ticket_t;
-typedef u32 __ticketpair_t;
-#endif
-
-#define TICKET_LOCK_INC	((__ticket_t)__TICKET_LOCK_INC)
-
-#define TICKET_SHIFT	(sizeof(__ticket_t) * 8)
-
 #include <asm-generic/qspinlock_types.h>
-
 #include <asm-generic/qrwlock_types.h>
 
 #endif /* _ASM_X86_SPINLOCK_TYPES_H */
