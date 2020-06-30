Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B962072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TY+YXW2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbgF3OLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgF3OLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:11:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99462C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YJD6TTLpz8/8gN7B9DDKH/+ajtfA3gfjfVSXPv470ZY=; b=TY+YXW2P4Y22gzauf6MPYCwCJ8
        5LBOy2A/fFl/357ObSg8eM/BxKanIRodczo8oknJBdGaNAsqcASUkCnbVPYlA5u5404dGkAhlWmn5
        yApk4MWgahauxrdxp1qI/IBAzmADoEUNqgyjvoB6m2iJvwiOQd+aPm/z3rWF6ywMhrMcGrRernEP8
        +bTjj8dYUnq8V/52q6t2yEgiWeON9yYiA5IuTXo/+0MSBZREV1gdw374dQ/ogdjzP5klgIXKCD231
        k9ir0tDj6k2YL0J2/FxadUnXLdLP+YoEHQk4xnD9ejWA8ZKISSMuQy5IR0J0zZU90D9iVec4nC5qz
        bSMH8xVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqGz1-0001R4-0J; Tue, 30 Jun 2020 14:11:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC5E7302753;
        Tue, 30 Jun 2020 16:11:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 993822122FE70; Tue, 30 Jun 2020 16:11:32 +0200 (CEST)
Date:   Tue, 30 Jun 2020 16:11:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com
Subject: Re: [sched] c3a340f7e7: invalid_opcode:#[##]
Message-ID: <20200630141132.GH117543@hirez.programming.kicks-ass.net>
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <5b7286c9-ef4f-c1d0-fae3-ebb198aa0742@rasmusvillemoes.dk>
 <20200630140231.GW4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630140231.GW4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 04:02:31PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 03:55:05PM +0200, Rasmus Villemoes wrote:
> 
> > > Consistently so with GCC-4.9. Any other GCC I tried does the sane thing.
> > 
> > Does that include gcc 4.8, or is it only "anything newer than 4.9"?
> 
> It includes 4.8 :-)
> 
> > so the section it was put in has an alignment of 64. The generated
> > assembly is indeed
> > 
> >         .globl  fair_sched_class
> >         .section        __fair_sched_class,"a",@progbits
> >         .align 64
> > 
> > /me goes brew coffee
> 
> Right.. so I now have the below patch, and with that I get:
> 
> 62931: c1e62c20     0 NOTYPE  GLOBAL DEFAULT    2 __begin_sched_classes
> 65736: c1e62e40   128 OBJECT  GLOBAL DEFAULT    2 stop_sched_class
> 71813: c1e62cc0   128 OBJECT  GLOBAL DEFAULT    2 fair_sched_class
> 78689: c1e62c40   128 OBJECT  GLOBAL DEFAULT    2 idle_sched_class
> 78953: c1e62ec0     0 NOTYPE  GLOBAL DEFAULT    2 __end_sched_classes
> 79090: c1e62d40   128 OBJECT  GLOBAL DEFAULT    2 rt_sched_class
> 79431: c1e62dc0   128 OBJECT  GLOBAL DEFAULT    2 dl_sched_class
> 
> 
> Which has me stumped on __begin_sched_classes being on a 32byte edge
> (and crashes differently due to that).
> 
> Argh!!

Steve suggested adding a dummy variable before the lot and this actually
works... But this just cannot be right :-(


---
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 66fb84c3dc7ee..9c0ee5cf73a50 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -108,6 +108,17 @@
 #define SBSS_MAIN .sbss
 #endif
 
+/*
+ * Align to a 32 byte boundary equal to the
+ * alignment gcc 4.5 uses for a struct
+ */
+#if GCC_VERSION >= 40900 && GCC_VERSION < 50000
+#define STRUCT_ALIGNMENT 64
+#else
+#define STRUCT_ALIGNMENT 32
+#endif
+#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
+
 /*
  * The order of the sched class addresses are important, as they are
  * used to determine the order of the priority of each sched class in
@@ -115,6 +126,7 @@
  */
 #define SCHED_DATA				\
 	STRUCT_ALIGN();				\
+	*(__dummy_sched_class)			\
 	__begin_sched_classes = .;		\
 	*(__idle_sched_class)			\
 	*(__fair_sched_class)			\
@@ -123,13 +135,6 @@
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81640fe0eae8f..f8535a3438819 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6641,6 +6641,9 @@ static struct kmem_cache *task_group_cache __read_mostly;
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 
+const struct sched_class dummy_sched_class
+	__attribute__((section("__dummy_sched_class")));
+
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
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
