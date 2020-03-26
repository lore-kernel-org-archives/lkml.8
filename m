Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01774C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC6A21D81
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlyYPdUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgCZQdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:33:14 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:54292 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgCZQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:33:14 -0400
Received: by mail-wm1-f74.google.com with SMTP id t22so2408778wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cj1yXAqU8AkYqnSowOMnKDwXe28Nmz4NKXcTv1E5rr8=;
        b=QlyYPdUEjthYFChxgCVdTAxTBsSjtTEujh8fKUyVe2X1M4qIaDAIIGpHdB3HEuhn8O
         QEHyMF0kfFNraTl/rH78GO9+Ome/PyBhr0br3HrVEZ1FPPb8WWaI50wDtJOyiz3DL/eY
         5f5b7/Fm9M/hKVDEMkK2nYbOYR2Tp5CpPa9azj8zpoXjyXMOTGjAf/ata6fYlw+vdMXg
         lTUrS96iVX9uKMVnqLc6Fn3RtkI0rAVGhJWje4JdlfDWrgXURBOnllcC/ZyjlGS3aFlD
         Cm/8BXBTIPSl22F9vQxx0Dxngmircdao+AmRW3bnMOsux8FVfdbIWZ18ERPGH609bz/o
         1lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cj1yXAqU8AkYqnSowOMnKDwXe28Nmz4NKXcTv1E5rr8=;
        b=NdjHYWD7OPa2iVWzQsaZSczQpYIqsWHFNpXkjiA0VXEq9FExO1Fzu8Y1tUC64cFfni
         KrdFBnJDZv4Av7rLdLiV2H3fcI0cmrloDLtwx4Uqjve8cP66MEPzcE8xjWDDWRH5YDY6
         MAdHPj0bDSqt4nmpmaay1xUHJfGXV4WhbxlzcktI3+/KNObGxiVmykZZNri5RHClh02u
         RSG/yQHstUu5irempsYnPp/XxdbMaKosYmPk6POW/L/Mz8bh8a86OwizgaAIFI7/f26A
         3/lmn/H3Fdl/jnAU5NxtxbJ437gfsPZmb3XioRj1oX0R/2jxQXKoP5mw6p1YzlKBnqbs
         c86w==
X-Gm-Message-State: ANhLgQ3EGP+aoSvRak4GN/iIA5ikC0+VcON4MxMndz2wAR5iOyvXWVxT
        UpxAu3+uqgdeEOA8mFfVer9E7weTAg==
X-Google-Smtp-Source: ADFU+vt4y7onh9o9+kAT94HkWd8Pf04QxJp3qnGSHOe6xI1l+AZna1QGr4UpTELU485gJTHK1dqLBpbWxA==
X-Received: by 2002:adf:ea03:: with SMTP id q3mr9842558wrm.267.1585240391265;
 Thu, 26 Mar 2020 09:33:11 -0700 (PDT)
Date:   Thu, 26 Mar 2020 17:32:44 +0100
In-Reply-To: <20200326163245.119670-1-jannh@google.com>
Message-Id: <20200326163245.119670-2-jannh@google.com>
Mime-Version: 1.0
References: <20200326163245.119670-1-jannh@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 1/2] irq_work: Reinitialize list heads for secondary CPUs
From:   Jann Horn <jannh@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When printk_deferred() is used before percpu initialization, it will queue
up lazy IRQ work on the boot CPU; percpu initialization then copies the
work list head to all secondary CPUs. To ensure that the secondary CPUs
don't re-execute the boot CPU's work and whatever its ->next pointer leads
to, zero out the secondary CPUs' work list heads before bringing up SMP.

Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/irq_work.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 828cc30774bc..903e5be9aebf 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -152,6 +152,7 @@ static void irq_work_run_list(struct llist_head *list)
 		 * while we are in the middle of the func.
 		 */
 		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
+		WARN_ON_ONCE((flags & IRQ_WORK_PENDING) == 0);
 
 		work->func(work);
 		/*
@@ -195,3 +196,24 @@ void irq_work_sync(struct irq_work *work)
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+/*
+ * If we queued up IRQ work before fully initializing the percpu subsystem, e.g.
+ * via printk_deferred(), the head pointer of the boot CPU will have been copied
+ * over to all the other CPUs.
+ * To fix that, manually initialize the list heads of all secondary processors
+ * before bringing up SMP.
+ */
+static int __init irq_work_percpu_fixup(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		per_cpu(raised_list.first, cpu) = NULL;
+		per_cpu(lazy_list.first, cpu) = NULL;
+	}
+	return 0;
+}
+early_initcall(irq_work_percpu_fixup)
-- 
2.25.1.696.g5e7596f4ac-goog

