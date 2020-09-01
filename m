Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D401C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586BA207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mcXMBgTr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lpw3BGSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbgIAUCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbgIAUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:02:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61657C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 13:02:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598990530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgSfVN3YpVZ6JpX+NU+pZI0+w1g1cMMgKLi6CxrStU0=;
        b=mcXMBgTrcAKfw0cUVZuwLAsTWPw5qETOF7r3kf3Vs/6SKHpRqLq59u6/q2dtZCjO2JESnT
        0VVocNBOXzBDTDtRYMXQrHZznSiwIFXN8GCC+GE2qpQ9HIDzp7jyvFif7xs5NlKAvyQzYx
        uuz3wc8RctcKLNFTfcZ3XQvt6CWctLRmS/xPGBSRPxNCm97hozuaKkP/zgdNjaENrZr5qg
        2tpkrj0xVzsuDMNLSzcYRHeRc++mZUkP/p1Zr/XrDy4sDOIRMV3y0Oec02zXN3mjWhRalH
        5NfFnn1myK2ReLXGPEecxeBPIRIoJ1P2oQd1mgRLDWtGJhB30GAv6e8jq0eMvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598990530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgSfVN3YpVZ6JpX+NU+pZI0+w1g1cMMgKLi6CxrStU0=;
        b=Lpw3BGSPDBGWg0fU1imYEz5fiIEdAHCeQ1KTGqKCwfci0GqE9wc7xsGT9Ox26yRIp2jtF7
        uaIIkTRkpKF8pFAg==
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide protection of kernel-mode
In-Reply-To: <20200901165052.GA1662854@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com> <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com> <87y2lth4qa.fsf@nanos.tec.linutronix.de> <20200901165052.GA1662854@google.com>
Date:   Tue, 01 Sep 2020 22:02:10 +0200
Message-ID: <875z8xl0zh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

On Tue, Sep 01 2020 at 12:50, Joel Fernandes wrote:
> On Tue, Sep 01, 2020 at 05:54:53PM +0200, Thomas Gleixner wrote:
>> On Fri, Aug 28 2020 at 15:51, Julien Desfossez wrote:
>> >  		/*
>> > -		 * Disable interrupts and reevaluate the work flags as they
>> > -		 * might have changed while interrupts and preemption was
>> > -		 * enabled above.
>> > +		 * Reevaluate the work flags as they might have changed
>> > +		 * while interrupts and preemption were enabled.
>> 
>> What enables preemption and interrupts? Can you pretty please write
>> comments which explain what's going on.
>
> Yes, sorry. So, sched_core_unsafe_exit_wait() will spin with IRQs enabled and
> preemption disabled. I did it this way to get past stop_machine() issues
> where you were unhappy with us spinning in IRQ disabled region.

So the comment is even more nonsensical :)

>> > -	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>> > -		ti_work = exit_to_user_mode_loop(regs, ti_work);
>> > +	ti_work = exit_to_user_mode_loop(regs);
>> 
>> Why has the above loop to be invoked unconditionally even when that core
>> scheduling muck is disabled? Just to make all return to user paths more
>> expensive unconditionally, right?
>
> If you see the above loop, we are calling exit_to_user_mode_work()
> conditionally by calling exit_to_user_mode_work_pending() which does the same
> thing.

It does the same thing technically, but the fastpath, i.e. no work to
do, is not longer straight forward. Just look at the resulting ASM
before and after. It's awful.

> So we are still conditionally doing the usual exit_to_user_mode work, its
> just that now we have to unconditionally invoke the 'loop' anyway.

No.

> The reason for that is, the loop can switch into another thread, so we
> have to do unsafe_exit() for the old thread, and unsafe_enter() for
> the new one while handling the tif work properly. We could get
> migrated to another CPU in this loop itself, AFAICS. So the
> unsafe_enter() / unsafe_exit() calls could also happen on different
> CPUs.

That's fine. It still does not justify to make everything slower even if
that 'pretend that HT is secure' thing is disabled.

Something like the below should be sufficient to do what you want
while restricting the wreckage to the 'pretend ht is secure' case.

The generated code for the CONFIG_PRETENT_HT_SECURE=n case is the same
as without the patch. With CONFIG_PRETENT_HT_SECURE=y the impact is
exactly two NOP-ed out jumps if the muck is not enabled on the command
line which should be the default behaviour.

Thanks,

        tglx

---
--- /dev/null
+++ b/include/linux/pretend_ht_secure.h
@@ -0,0 +1,21 @@
+#ifndef _LINUX_PRETEND_HT_SECURE_H
+#define _LINUX_PRETEND_HT_SECURE_H
+
+#ifdef CONFIG_PRETEND_HT_SECURE
+static inline void enter_from_user_ht_sucks(void)
+{
+	if (static_branch_unlikely(&pretend_ht_secure_key))
+		enter_from_user_pretend_ht_is_secure();
+}
+
+static inline void exit_to_user_ht_sucks(void)
+{
+	if (static_branch_unlikely(&pretend_ht_secure_key))
+		exit_to_user_pretend_ht_is_secure();
+}
+#else
+static inline void enter_from_user_ht_sucks(void) { }
+static inline void exit_to_user_ht_sucks(void) { }
+#endif
+
+#endif
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -17,6 +17,7 @@
  * 1) Tell lockdep that interrupts are disabled
  * 2) Invoke context tracking if enabled to reactivate RCU
  * 3) Trace interrupts off state
+ * 4) Pretend that HT is secure
  */
 static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 {
@@ -28,6 +29,7 @@ static __always_inline void enter_from_u
 
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
+	enter_from_user_ht_sucks();
 	instrumentation_end();
 }
 
@@ -111,6 +113,12 @@ static __always_inline void exit_to_user
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal(struct pt_regs *regs) { }
 
+static inline unsigned long exit_to_user_get_work(void)
+{
+	exit_to_user_ht_sucks();
+	return READ_ONCE(current_thread_info()->flags);
+}
+
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
@@ -149,7 +157,7 @@ static unsigned long exit_to_user_mode_l
 		 * enabled above.
 		 */
 		local_irq_disable_exit_to_user();
-		ti_work = READ_ONCE(current_thread_info()->flags);
+		ti_work = exit_to_user_get_work();
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
@@ -158,7 +166,7 @@ static unsigned long exit_to_user_mode_l
 
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work = exit_to_user_get_work();
 
 	lockdep_assert_irqs_disabled();
 
