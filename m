Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D445D20809
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cNmAoYlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbgF3Mqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbgF3Mqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:46:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC688C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGZ05RE9u5rvU36f9vRb+aY7/t3BEEzOQfDsOC8qjbU=; b=cNmAoYlC9e4FvFviPIUW7tLz2J
        L47rm82ptPYi8wALgnF2xNxj+BQgjiMVUutKFX3HwAbRp5IIb6g6HeqPTlpme/61sH6yULEQrJFHO
        1mEOrOhYwGyQ5cNn8dktUphYOlRF22BEPYn+RZkFGbBzn56Vp9+9LlzIxKDE2e0hVkFaiIpdOr3Bk
        CDXbp9IzuGZgY6Plbx06eDcqkaYql3DkuOjrn/p4SgGQTe+muk++zogIIWdTtkjlAYYyHCp7Y4HNT
        2vqx8s8ZxacShluPYWx3CsdYIxlW4VgyS3X9EeKpRwYoSgvocZSwWva6hf4dUPyO6+bDkpxlos922
        NOZK7wIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqFeh-0007c4-T1; Tue, 30 Jun 2020 12:46:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 065D4303CE9;
        Tue, 30 Jun 2020 14:46:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8EEF2147FFB9; Tue, 30 Jun 2020 14:46:28 +0200 (CEST)
Date:   Tue, 30 Jun 2020 14:46:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [sched] c3a340f7e7: invalid_opcode:#[##]
Message-ID: <20200630124628.GV4817@hirez.programming.kicks-ass.net>
References: <20200629003127.GB5535@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629003127.GB5535@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:31:27AM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-4.9):
> 
> commit: c3a340f7e7eadac7662ab104ceb16432e5a4c6b2 ("sched: Have sched_class_highest define by vmlinux.lds.h")

> [    1.840970] kernel BUG at kernel/sched/core.c:6652!

W T H

$ readelf -Wa defconfig-build/vmlinux | grep sched_class
62931: c1e62d20     0 NOTYPE  GLOBAL DEFAULT    2 __begin_sched_classes
65736: c1e62f40    96 OBJECT  GLOBAL DEFAULT    2 stop_sched_class
71813: c1e62dc0    96 OBJECT  GLOBAL DEFAULT    2 fair_sched_class
78689: c1e62d40    96 OBJECT  GLOBAL DEFAULT    2 idle_sched_class
78953: c1e62fa0     0 NOTYPE  GLOBAL DEFAULT    2 __end_sched_classes
79090: c1e62e40    96 OBJECT  GLOBAL DEFAULT    2 rt_sched_class
79431: c1e62ec0    96 OBJECT  GLOBAL DEFAULT    2 dl_sched_class

$ printf "%d\n" $((0xc1e62dc0 - 0xc1e62d40))
128

So even though the object is 96 bytes in size, has an explicit 32 byte
alignment, the array ends up with a stride of 128 bytes !?!?!

Consistently so with GCC-4.9. Any other GCC I tried does the sane thing.

Full patch included below.

Anybody any clue wth 4.9 is doing crazy things like this?

---
commit c3a340f7e7eadac7662ab104ceb16432e5a4c6b2
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu Dec 19 16:44:53 2019 -0500

    sched: Have sched_class_highest define by vmlinux.lds.h
    
    Now that the sched_class descriptors are defined by the linker script, and
    this needs to be aware of the existance of stop_sched_class when SMP is
    enabled or not, as it is used as the "highest" priority when defined. Move
    the declaration of sched_class_highest to the same location in the linker
    script that inserts stop_sched_class, and this will also make it easier to
    see what should be defined as the highest class, as this linker script
    location defines the priorities as well.
    
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lkml.kernel.org/r/20191219214558.682913590@goodmis.org

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 2186d7b01af6..66fb84c3dc7e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -114,11 +114,14 @@
  * relation to each other.
  */
 #define SCHED_DATA				\
+	STRUCT_ALIGN();				\
+	__begin_sched_classes = .;		\
 	*(__idle_sched_class)			\
 	*(__fair_sched_class)			\
 	*(__rt_sched_class)			\
 	*(__dl_sched_class)			\
-	*(__stop_sched_class)
+	*(__stop_sched_class)			\
+	__end_sched_classes = .;
 
 /*
  * Align to a 32 byte boundary equal to the
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0208b71bef80..81640fe0eae8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6646,6 +6646,14 @@ void __init sched_init(void)
 	unsigned long ptr = 0;
 	int i;
 
+	/* Make sure the linker didn't screw up */
+	BUG_ON(&idle_sched_class + 1 != &fair_sched_class ||
+	       &fair_sched_class + 1 != &rt_sched_class ||
+	       &rt_sched_class + 1   != &dl_sched_class);
+#ifdef CONFIG_SMP
+	BUG_ON(&dl_sched_class + 1 != &stop_sched_class);
+#endif
+
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 336887607b3d..4165c06d1d7b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1811,7 +1811,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-};
+} __aligned(32); /* STRUCT_ALIGN(), vmlinux.lds.h */
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
@@ -1825,17 +1825,18 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-#ifdef CONFIG_SMP
-#define sched_class_highest (&stop_sched_class)
-#else
-#define sched_class_highest (&dl_sched_class)
-#endif
+/* Defined in include/asm-generic/vmlinux.lds.h */
+extern struct sched_class __begin_sched_classes[];
+extern struct sched_class __end_sched_classes[];
+
+#define sched_class_highest (__end_sched_classes - 1)
+#define sched_class_lowest  (__begin_sched_classes - 1)
 
 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class = class->next)
+	for (class = (_from); class != (_to); class--)
 
 #define for_each_class(class) \
-	for_class_range(class, sched_class_highest, NULL)
+	for_class_range(class, sched_class_highest, sched_class_lowest)
 
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
