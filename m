Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCEBC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B5A21D81
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZb2CWvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgCZQdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:33:22 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:41990 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgCZQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:33:22 -0400
Received: by mail-wm1-f74.google.com with SMTP id v184so2694977wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BTSoe6DkYNZH5BddOxOmXTzuoelDRmUvluUlJbA7LXg=;
        b=jZb2CWvTWONnA3PrlR7yLTBu8UbvXrO1vido/kl4jzRrxuEXNocipKzkyP6sYmrVL7
         SGqEPC7daMGhqW/pyxZWMAHCBWkeNdKjdN+jdv9pHQgR5FLcGcAfInOWY56u+nReDLhj
         hIefxLH3t0J9z1+hWxQFKs/uBokZvWEsJW+FAvtL/0+7K5KtU5UdwD2/WacHcJAhqFZE
         AaemQCe58Jfk/DfyhxiyGErBRcty5bwPhk2Z5v2xE1qq3rq0SCmjBHR5bJ8rxDokHd/Z
         IMZgdyYl37Ogb7qKde9uLESdCenT9mnJN8bF9VPy7HwlmEy1aIydVIK0mSNpWDQgYqTy
         nM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BTSoe6DkYNZH5BddOxOmXTzuoelDRmUvluUlJbA7LXg=;
        b=axkK6H9DmSMZfVeXkzCHYhAtvMB8ioyrksm1Gdp1DI0PWSrqE1ltnsEAVUz+gkqDxc
         gMnTp4Qg6+LNipnTLCxRQSDoLL3jxFomlm3xbwwku2ikZRWi3bst2/k5nug0ZE0Z91Z4
         IoJ6H/8QRedK5qofpsNpdZFIribEUafEoBUHJDt3iRpQloRSEuC2OXQkFdg0lAiDMOq1
         UVotEK7vbHNJfdbPAZF51Rqnh6+jFIDkTqCcqv4oDwKlewmUcd65x9I28mtQxwkpp/cz
         SLlKZsNbd65fy3KQPRqZxy459e3lnPxhj2vD6qc184Y5HS48cgIGXjj+G3EIirqfcf1/
         Ct/Q==
X-Gm-Message-State: ANhLgQ1wowWTeIc7O2BnY8fKGo1uaQcIbmiP/8EWpYA5MErI7Sbc9YgT
        kEDI94Pq4eaMiBaCqY/+m8PLU7SE5w==
X-Google-Smtp-Source: ADFU+vsJmGK3ZN6sdJ9iuiL2QlTUBnd8nY2ARCzRymwmFRKW8OOF6mbRMeVz+JGdJazZFXSGI73vH/RRgw==
X-Received: by 2002:adf:d849:: with SMTP id k9mr10175956wrl.108.1585240395876;
 Thu, 26 Mar 2020 09:33:15 -0700 (PDT)
Date:   Thu, 26 Mar 2020 17:32:45 +0100
In-Reply-To: <20200326163245.119670-1-jannh@google.com>
Message-Id: <20200326163245.119670-3-jannh@google.com>
Mime-Version: 1.0
References: <20200326163245.119670-1-jannh@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 2/2] printk: Reinitialize klogd percpu state for secondary CPUs
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
up wake_up_klogd_work and set printk_pending on the boot CPU; percpu
initialization then copies the the pending work's state and the
printk_pending flag to all secondary CPUs. The end result is that e.g.
if you run "dmesg -w" when the system is up, it won't notice new printk
messages.
To ensure that the secondary CPUs don't think that they already have
pending printk work, reset the secondary CPUs' work items and
printk_pending state.

Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/printk/printk.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fada22dc4ab6..e531407188f1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2964,6 +2964,29 @@ static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
 	.flags = ATOMIC_INIT(IRQ_WORK_LAZY),
 };
 
+/*
+ * If we called defer_console_output() before fully initializing the percpu
+ * subsystem, e.g. via printk_deferred(), the irq_work flags and the
+ * printk_pending flag may have been copied from the boot CPU to the others
+ * while work was pending.
+ * To fix that, manually reset the percpu data for all secondary processors
+ * before bringing up SMP.
+ */
+static int __init klogd_percpu_fixup(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		atomic_set(&per_cpu(wake_up_klogd_work.flags, cpu),
+			   IRQ_WORK_LAZY);
+		per_cpu(printk_pending, cpu) = 0;
+	}
+	return 0;
+}
+early_initcall(klogd_percpu_fixup)
+
 void wake_up_klogd(void)
 {
 	preempt_disable();
-- 
2.25.1.696.g5e7596f4ac-goog

