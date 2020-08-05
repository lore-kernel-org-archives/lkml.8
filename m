Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8661C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9642076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7rF0IMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgHET6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgHEQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:42:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E1C094244
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 06:26:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so5798446wrf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rz+460zN+OkszOn8+vBru36XCbCu8scZ/4ePoWYVtUg=;
        b=F7rF0IMWYFHctSXsi4L5jkI7s2rDEICofDZEIFb/Mnc0olQ1F9dR20+N7FHkksIJge
         SmA4W+izSWd2xpr3HvHbsiAy+2J1K2AMgrnaQYZfVaf/c7SlSw0yYJXZZUv7p6LI3a9x
         D3IL3vF8GSwDnq/h9THfUWuSperQHqsQwJvjVuh5vhouVgLuNqrJ899nDX2jWX6RbkR1
         63wyQypBQ963B/M2vWSesAEOtHwCqDpsPef7QwKCS2VITQpHYr0zVrx+NxMd6fDsFBHA
         rHmBhDoDO4Y4D9FJa9440x3SsTx2KeUrt7UW4Rc8UBLwgdJz5Jsph0fgwQqOakfu3+FB
         QZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rz+460zN+OkszOn8+vBru36XCbCu8scZ/4ePoWYVtUg=;
        b=G5ik7JP//DytjiDkyFf3qJowtQz5zWa7IofNbSW8Sj5gmF40cj5aMPS4BEpeKTUjoj
         GIMETKCBXsTNb+LwBEeND47xoQiwhghTYyU1UwFZUcYpDK3Mcwt4EvmguE0yQ9mkiFo9
         rNuFpEvO775uuXt/eNtuJvazTziGvtGx6lsAeTqx3l3KUWn5J1Dw8qjAyduES+qN2De1
         td+lGdC0u2cbUk1ZNpsYVUREv17Q9ec2bEdq5nKy1HeevTzfGojx6nbqV0nWZCCg/Dtm
         nF335uAKjO9ztwUL9VkPy+SlimnsNwVt3+8oC/+qeGFwnXalKWC52tm9BltGNlT+nAHH
         D0iw==
X-Gm-Message-State: AOAM533ZhL5PMSdLjCVSJoA1IpHpIdULxHwHCA3uM8RAz9t5IMKxW4WT
        lciJrA+VHxLxfwq32niZZVUH8Q==
X-Google-Smtp-Source: ABdhPJyERtYQbOcIa35dXAjlEnTUCu9FuPXaK99mV4OPiJJJ9/GGeawbtGASUnjMiR7XXrPMsQzglA==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr2613948wrj.380.1596633996070;
        Wed, 05 Aug 2020 06:26:36 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id p15sm2718271wrj.61.2020.08.05.06.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:26:34 -0700 (PDT)
Date:   Wed, 5 Aug 2020 15:26:29 +0200
From:   Marco Elver <elver@google.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org, yu-cheng.yu@intel.com,
        peterz@infradead.org, jgross@suse.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev@googlegroups.com
Cc:     syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Subject: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
Message-ID: <20200805132629.GA87338@elver.google.com>
References: <0000000000007d3b2d05ac1c303e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0000000000007d3b2d05ac1c303e@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing noinstr to arch_local*() helpers, as they may be called from
noinstr code.

On a KCSAN config with CONFIG_PARAVIRT=3Dy, syzbot stumbled across corrupt
IRQ trace state, with lockdep_assert_irqs_enabled() failing spuriously.
When enabling CONFIG_DEBUG_LOCKDEP=3Dy, we get a warning about

	DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())

which we had seen before due to KCSAN-lockdep recursion. Due to
"lockdep: Prepare for NMI IRQ state tracking", KCSAN was changed to use
non-raw local_irq_{save,restore}(), assuming there is no more
KCSAN-lockdep recursion.

It turns out that the arch_local*() helpers in paravirt.h were missing
noinstr, as they themselves are used from noinstr code that is called
=66rom lockdep. When inserting debug-code that warns us if lockdep is in
the stacktrace from KCSAN, we get,

	RIP: 0010:kcsan_setup_watchpoint[...]
	[...]
	Call Trace:
	 arch_local_save_flags+0x11/0x30 arch/x86/include/asm/paravirt.h:765
	 check_preemption_disabled+0x51/0x140 lib/smp_processor_id.c:19
	 __this_cpu_preempt_check+0x18/0x20 lib/smp_processor_id.c:65
	 lockdep_hardirqs_off+0xaa/0x130 kernel/locking/lockdep.c:3801
	 trace_hardirqs_off+0x14/0x80 kernel/trace/trace_preemptirq.c:76
	 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
	 _raw_spin_lock_irqsave+0x48/0x90 kernel/locking/spinlock.c:159
	 wake_up_new_task+0x2c/0x270 kernel/sched/core.c:3338
	 _do_fork+0x27b/0x4f0 kernel/fork.c:2474
	 kernel_thread+0x85/0xb0 kernel/fork.c:2502
	 create_kthread kernel/kthread.c:315 [inline]
	 kthreadd+0x427/0x500 kernel/kthread.c:634
	 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

pointing to arch_local_save_flags() in paravirt.h, which is called from
noinstr functions in smp_processor_id.c, which in turn are called from
lockdep.

Link: https://lkml.kernel.org/r/0000000000007d3b2d05ac1c303e@google.com
Reported-by: syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/paravirt.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravir=
t.h
index 3d2afecde50c..a606f2ba2b5e 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -760,27 +760,27 @@ bool __raw_callee_save___native_vcpu_is_preempted(lon=
g cpu);
 	((struct paravirt_callee_save) { func })
=20
 #ifdef CONFIG_PARAVIRT_XXL
-static inline notrace unsigned long arch_local_save_flags(void)
+static inline noinstr unsigned long arch_local_save_flags(void)
 {
 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
 }
=20
-static inline notrace void arch_local_irq_restore(unsigned long f)
+static inline noinstr void arch_local_irq_restore(unsigned long f)
 {
 	PVOP_VCALLEE1(irq.restore_fl, f);
 }
=20
-static inline notrace void arch_local_irq_disable(void)
+static inline noinstr void arch_local_irq_disable(void)
 {
 	PVOP_VCALLEE0(irq.irq_disable);
 }
=20
-static inline notrace void arch_local_irq_enable(void)
+static inline noinstr void arch_local_irq_enable(void)
 {
 	PVOP_VCALLEE0(irq.irq_enable);
 }
=20
-static inline notrace unsigned long arch_local_irq_save(void)
+static inline noinstr unsigned long arch_local_irq_save(void)
 {
 	unsigned long f;
=20
--=20
2.28.0.163.g6104cc2f0b6-goog
