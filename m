Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43509208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsMgvt1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHUIzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHUIzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:55:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14BC061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9I+CPHtwNh52Myl7R/ps1QfNvu2GLg9g228MpAOwUUo=; b=XsMgvt1DL0/CGZ0EtEPgC7rWuV
        jehs+aAL3+wCvpR7WaOjcpCc6nQlyYiYKJpIpRtGz6hcWwbNOenRjk5BfiKUZbvivfTx95ILsfwDf
        D8hpjb+ridBEURxxdokfKZpPZA8afH/wqeA1aEpcwk4j+KjQu76YVxlnIpRXovCWf00Jmu8RhwCnu
        wHVu3jxeV+NL9Bu9xYoDb+qQTzsVsKNmfHArFAz/JMnHj5/QGBMsMJFLvxUmLJi3M7XugA2MJJUZF
        Ryac9/oXmCzqXvOgCbAUcuzyf01wFhD7lymCU/eF9jSYn7OWIj6TOm0AFGeuEwQ+QO/jo/MxMA3A8
        TsIf1srQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92p3-0008UG-DB; Fri, 21 Aug 2020 08:54:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBA17302526;
        Fri, 21 Aug 2020 10:54:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D60902B64990F; Fri, 21 Aug 2020 10:54:49 +0200 (CEST)
Message-ID: <20200821084738.508092956@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH v2 00/11] TRACE_IRQFLAGS wreckage
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


TRACE_IRQFLAGS

local_irq_*() keeps a software state that mirrors the hardware state,
used for lockdep, includes tracepoints.

raw_local_irq_*() does not update the software state, no tracing.

---

Problem 1:

	raw_local_irq_save(); // software state on
	local_irq_save(); // software state off
	...
	local_irq_restore(); // software state still off, because we don't enable IRQs
	raw_local_irq_restore(); // software state still off, *whoopsie*

existing instances:

 - lock_acquire()
     raw_local_irq_save()
     __lock_acquire()
       arch_spin_lock(&graph_lock)
         pv_wait() := kvm_wait() (same or worse for Xen/HyperV)
           local_irq_save()

 - trace_clock_global()
     raw_local_irq_save()
     arch_spin_lock()
       pv_wait() := kvm_wait()
	 local_irq_save()

 - apic_retrigger_irq()
     raw_local_irq_save()
     apic->send_IPI() := default_send_IPI_single_phys()
       local_irq_save()

Possible solutions:

 A) make it work by enabling the tracing inside raw_*()
 B) make it work by keeping tracing disabled inside raw_*()
 C) call it broken and clean it up now

Now, given that the only reason to use the raw_* variant is because you don't
want tracing. Therefore A) seems like a weird option (although it can be done).
C) is tempting, but OTOH it ends up converting a _lot_ of code to raw just
because there is one raw user, this strips the validation/tracing off for all
the other users.

So we pick B) and declare any code that ends up doing:

	raw_local_irq_save()
	local_irq_save()
	lockdep_assert_irqs_disabled();

broken. AFAICT this problem has existed forever, the only reason it came
up is because I changed IRQ tracing vs lockdep recursion and the first
instance is fairly common, the other cases hardly ever happen.

---

Problem 2:

	raw_local_irq_save(); // software state on
	trace_*()
          ...
          perf_tp_event()
            ...
            perf_callchain()
	    <#PF>
	      trace_hardirqs_off(); // software state off
	      ...
	      if (regs_irqs_disabled(regs)) // false
	        trace_hardirqs_on();
	    </#PF>
	raw_local_irq_restore(); // software state stays off, *whoopsie*

existing instances:

 - lock_acquire() / lock_release()
     raw_local_irq_save()
     trace_lock_acquire() / trace_lock_release()

 - function tracing

Possible solutions:

 A) fix every architecture's entry code
 B) only fix kernel/entry/common.c
 C) fix lockdep tracepoints and pray

This series does C, AFAICT this problem has existed forever.

---

Problem 3:

	raw_local_irq_save(); // software state on
	<#NMI>
	  trace_hardirqs_off(); // software state off
	  ...
	  if (regs_irqs_disabled(regs)) // false
	    trace_hardirqs_on();
	</#NMI>
	raw_local_irq_restore(); // software state stays off, *whoopsie*

Possible solutions:

This *should* not be a problem if an architecture has it's entry ordering
right. In particular we rely on the architecture doing nmi_enter() before
trace_hardirqs_off().

In that case, in_nmi() will be true, and lockdep_hardirqs_*() should NO-OP,
except if CONFIG_TRACE_IRQFLAGS_NMI (x86).

There might be a problem with using lockdep_assert_irqs_disabled() from NMI
context, if so, those needs a little TLC.

---

The patches in this series do (in reverse order):

 - 2C
 - 1B
 - fix fallout in idle due to the trace_lock_*() tracepoints suddenly
   being visible to rcu-lockdep.

---

Change since -v1:

 - typo (rostedt)
 - split WARN (rostedt)
 - reorder start_critical_section / rcu_idle_enter (rostedt)
 - added arm64 patch (kernel test robot)

---

 arch/arm/mach-omap2/pm34xx.c      |    4 --
 arch/arm64/include/asm/irqflags.h |    5 ++
 arch/arm64/kernel/process.c       |    2 -
 arch/nds32/include/asm/irqflags.h |    5 ++
 arch/powerpc/include/asm/hw_irq.h |   11 ++---
 arch/s390/kernel/idle.c           |    3 -
 arch/x86/entry/thunk_32.S         |    5 --
 arch/x86/include/asm/mmu.h        |    1 
 arch/x86/kernel/process.c         |    4 --
 arch/x86/mm/tlb.c                 |   13 +-----
 drivers/cpuidle/cpuidle.c         |   19 +++++++--
 drivers/idle/intel_idle.c         |   16 --------
 include/linux/cpuidle.h           |   13 +++---
 include/linux/irqflags.h          |   73 ++++++++++++++++++++------------------
 include/linux/lockdep.h           |   18 ++++++---
 include/linux/mmu_context.h       |    5 ++
 kernel/locking/lockdep.c          |   18 +++++----
 kernel/sched/idle.c               |   25 +++++--------
 18 files changed, 118 insertions(+), 122 deletions(-)


