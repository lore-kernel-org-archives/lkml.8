Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB56C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB7D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pls34hdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbgF3Otq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgF3Otq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:49:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30BFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XuIrTfd6FKIWnhjMqRUNR92xxhPWX2ZGaRHGeZHKxck=; b=pls34hdQZzDFvIgK2hrNq2xmHP
        9yVquCEfjxxJPPQnG6RK7FqZneaNBKDzwoQK59KwjS1eqxWO1pqM+lDO6rsyZSEvkT8MqGMCw1N5o
        H9LoYs6D3CpwyywdpS4hrbH5lEGtD7w4DYt1chMjW55jgkeNjQIMie2tGQWifkqnkWAKjtwNwtUuV
        lsZKDspozuzHadruj0xv+p0AdkK3ceFjT+AZLzNYezzBla6sr1y0MhmaCL9LxZVLsFd/B1/71gGm2
        FKU3SMW3i4c2MylYMa0bnSx43xnfcjsj0PXVD7nLwADH/GQDM3YK1nUCAPBFvId3PvWn5ygIn51KO
        8zUiHNbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqHZL-0006PY-JJ; Tue, 30 Jun 2020 14:49:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC92F3011B2;
        Tue, 30 Jun 2020 16:49:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B804B20CF3986; Tue, 30 Jun 2020 16:49:05 +0200 (CEST)
Date:   Tue, 30 Jun 2020 16:49:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [sched] c3a340f7e7: invalid_opcode:#[##]
Message-ID: <20200630144905.GX4817@hirez.programming.kicks-ass.net>
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630124628.GV4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:46:28PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 29, 2020 at 08:31:27AM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-4.9):
> > 
> > commit: c3a340f7e7eadac7662ab104ceb16432e5a4c6b2 ("sched: Have sched_class_highest define by vmlinux.lds.h")
> 
> > [    1.840970] kernel BUG at kernel/sched/core.c:6652!
> 
> W T H
> 
> $ readelf -Wa defconfig-build/vmlinux | grep sched_class
> 62931: c1e62d20     0 NOTYPE  GLOBAL DEFAULT    2 __begin_sched_classes
> 65736: c1e62f40    96 OBJECT  GLOBAL DEFAULT    2 stop_sched_class
> 71813: c1e62dc0    96 OBJECT  GLOBAL DEFAULT    2 fair_sched_class
> 78689: c1e62d40    96 OBJECT  GLOBAL DEFAULT    2 idle_sched_class
> 78953: c1e62fa0     0 NOTYPE  GLOBAL DEFAULT    2 __end_sched_classes
> 79090: c1e62e40    96 OBJECT  GLOBAL DEFAULT    2 rt_sched_class
> 79431: c1e62ec0    96 OBJECT  GLOBAL DEFAULT    2 dl_sched_class
> 
> $ printf "%d\n" $((0xc1e62dc0 - 0xc1e62d40))
> 128
> 
> So even though the object is 96 bytes in size, has an explicit 32 byte
> alignment, the array ends up with a stride of 128 bytes !?!?!
> 
> Consistently so with GCC-4.9. Any other GCC I tried does the sane thing.
> 
> Full patch included below.
> 
> Anybody any clue wth 4.9 is doing crazy things like this?
> 
> ---

This seems to make everything work, it builds and boots for 4.9 and
builds x86_64-defconfig with clang11 (just to check a !GCC compiler).

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 66fb84c3dc7ee..49a9aaa1e2424 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -108,6 +108,17 @@
 #define SBSS_MAIN .sbss
 #endif
 
+/*
+ * Align to a 32 byte boundary equal to the
+ * alignment gcc 4.5 uses for a struct
+ */
+#if __GNUC__ == 4 && __GNUC_MINOR__ == 9
+#define STRUCT_ALIGNMENT 64
+#else
+#define STRUCT_ALIGNMENT 32
+#endif
+#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
+
 /*
  * The order of the sched class addresses are important, as they are
  * used to determine the order of the priority of each sched class in
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
index 4165c06d1d7bd..33251d0ab62e7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,6 +67,7 @@
 #include <linux/tsacct_kern.h>
 
 #include <asm/tlb.h>
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
@@ -1811,7 +1812,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-} __aligned(32); /* STRUCT_ALIGN(), vmlinux.lds.h */
+} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
