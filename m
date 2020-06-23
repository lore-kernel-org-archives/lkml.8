Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C593C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082A12073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CbxaxDD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbgFWUYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390440AbgFWUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:24:32 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18381C061573;
        Tue, 23 Jun 2020 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nqLuJpwpk0A53PmvRN23yoDtfY4/X7aPFQklmjH025U=; b=CbxaxDD6KGmoDKlE+iZHVS3Fdo
        WX5rKGhFi9UifHi3fhpVS0c3n5ae+3i2Al4d3lCr5Ji04Spo9FmrZxodYVQjX87tiDFWzQrx3PI3I
        NevvGJ2fT2SJF/sfTRCcx+V5LepSslMyZY/fBaQFFSFYMW3Ds6KLSk62JTmmgEstJ0GAnCI3YQrbA
        oQX43gmPUSuGcEWq5WZvkMcKClyAU3eITCvusiMPH0bQqyzC/rfkbAk4QryNwCs7993kYRBifyp+h
        285p4O1IIgAuQYXB0wrjE+7+M6vZiHzcyqAKwuKVqqEbDx8FaeBrF3IgpcgClmRCjf8NvQOcf0R2V
        zRHPIfpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnpSe-0003Y5-I2; Tue, 23 Jun 2020 20:24:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 213A9983A87; Tue, 23 Jun 2020 22:24:04 +0200 (CEST)
Date:   Tue, 23 Jun 2020 22:24:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org,
        will@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623202404.GE2483@worktop.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
 <20200623181232.GB4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623181232.GB4800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:12:32PM +0200, Peter Zijlstra wrote:
> Fair enough; I'll rip it all up and boot a KCSAN kernel, see what if
> anything happens.

OK, so the below patch doesn't seem to have any nasty recursion issues
here. The only 'problem' is that lockdep now sees report_lock can cause
deadlocks.

It is completely right about it too, but I don't suspect there's much we
can do about it, it's pretty much the standard printk() with scheduler
locks held report.

---
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 15f67949d11e..732623c30359 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -397,8 +397,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	}
 
 	if (!kcsan_interrupt_watcher)
-		/* Use raw to avoid lockdep recursion via IRQ flags tracing. */
-		raw_local_irq_save(irq_flags);
+		local_irq_save(irq_flags);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -539,7 +538,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
 	if (!kcsan_interrupt_watcher)
-		raw_local_irq_restore(irq_flags);
+		local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ac5f8345bae9..ef31c1d2dac3 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -605,14 +605,6 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	if (WARN_ON(watchpoint_idx < 0 || watchpoint_idx >= ARRAY_SIZE(other_infos)))
 		goto out;
 
-	/*
-	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
-	 * we do not turn off lockdep here; this could happen due to recursion
-	 * into lockdep via KCSAN if we detect a race in utilities used by
-	 * lockdep.
-	 */
-	lockdep_off();
-
 	if (prepare_report(&flags, type, &ai, other_info)) {
 		/*
 		 * Never report if value_change is FALSE, only if we it is
@@ -628,7 +620,6 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		release_report(&flags, other_info);
 	}
 
-	lockdep_on();
 out:
 	kcsan_enable_current();
 }

