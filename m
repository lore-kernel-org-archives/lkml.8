Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1349C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E9C20672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcK/laqx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1qDs5C/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGIIqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGIIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:45:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B733CC061A0B;
        Thu,  9 Jul 2020 01:45:59 -0700 (PDT)
Date:   Thu, 09 Jul 2020 08:45:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594284358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjTJHow2R2XKL/tp30Tx1s7Zv1GQqNVD5CZB7vIOE/s=;
        b=kcK/laqx/M0C9cBFddVrS2wjjFbjKpMLce2ezvFvs1anLVwgvJCHZ2w5E+OdWCspbT7QEJ
        EznydsYqVU/wT38BTUsqdwSW+iRqGPzATpM9+PJU24D95ElJYLbXf6LPEi/ELDTTZWxMiO
        v4vBH3Zy//WeHXA3eSbjg4K5ZsHnBCfNeMQiVFfkrTXnkvA1FxWK3urmCy3yD5QXe8nYyz
        i17z+EK+I2O5oEsKlC8M7JKgforUeZUv0s2+29Px7l7+Hdc/uPuyMcl19dVs9IZnNHJGkv
        dOAhhokja4Hlg7tUaVNwO9kzD39eHxasmIqqc3mP/auPiTKP24rJYVcNdY2bFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594284358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjTJHow2R2XKL/tp30Tx1s7Zv1GQqNVD5CZB7vIOE/s=;
        b=S1qDs5C/hynlBnpgDM68zB1RDixP4rt5BqTEeE5vY4Fih6snVfcLNqOOTYn/4wOolYxXOH
        8NifYeGUlqJpjNDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched, vmlinux.lds: Increase STRUCT_ALIGNMENT to 64
 bytes for GCC-4.9
Cc:     kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200630144905.GX4817@hirez.programming.kicks-ass.net>
References: <20200630144905.GX4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159428435768.4006.17156231921502478446.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     85c2ce9104eb93517db2037699471c517e81f9b4
Gitweb:        https://git.kernel.org/tip/85c2ce9104eb93517db2037699471c517e81f9b4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 30 Jun 2020 16:49:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:39:00 +02:00

sched, vmlinux.lds: Increase STRUCT_ALIGNMENT to 64 bytes for GCC-4.9

For some mysterious reason GCC-4.9 has a 64 byte section alignment for
structures, all other GCC versions (and Clang) tested (including 4.8
and 5.0) are fine with the 32 bytes alignment.

Getting this right is important for the new SCHED_DATA macro that
creates an explicitly ordered array of 'struct sched_class' in the
linker script and expect pointer arithmetic to work.

Fixes: c3a340f7e7ea ("sched: Have sched_class_highest define by vmlinux.lds.h")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200630144905.GX4817@hirez.programming.kicks-ass.net
---
 include/asm-generic/vmlinux.lds.h | 18 +++++++++++-------
 kernel/sched/sched.h              |  3 ++-
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 66fb84c..3ceb4b7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -109,6 +109,17 @@
 #endif
 
 /*
+ * GCC 4.5 and later have a 32 bytes section alignment for structures.
+ * Except GCC 4.9, that feels the need to align on 64 bytes.
+ */
+#if __GNUC__ == 4 && __GNUC_MINOR__ == 9
+#define STRUCT_ALIGNMENT 64
+#else
+#define STRUCT_ALIGNMENT 32
+#endif
+#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
+
+/*
  * The order of the sched class addresses are important, as they are
  * used to determine the order of the priority of each sched class in
  * relation to each other.
@@ -123,13 +134,6 @@
 	*(__stop_sched_class)			\
 	__end_sched_classes = .;
 
-/*
- * Align to a 32 byte boundary equal to the
- * alignment gcc 4.5 uses for a struct
- */
-#define STRUCT_ALIGNMENT 32
-#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
-
 /* The actual configuration determine if the init/exit sections
  * are handled as text/data or they can be discarded (which
  * often happens at runtime)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5aa6661..9bef2dd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,6 +67,7 @@
 #include <linux/tsacct_kern.h>
 
 #include <asm/tlb.h>
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
@@ -1810,7 +1811,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-} __aligned(32); /* STRUCT_ALIGN(), vmlinux.lds.h */
+} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
