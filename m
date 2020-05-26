Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA22D208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590480902;
	bh=yFH7pO/FKYGlRj3fBVTbIX+fF9EUD3fDaUcGPnoJoUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gO+uMMTxr2wHxyEMfQr8nr2wjZN3iPXgu9YiZlqum4ITkTcFW/B1juR4S3YopVD6K
	 9LN2j8zJm/RZCBbsTcRLicPg2vmIcIfMIM5hSftXOuhgqAQU1hyO0SWidticQhLmrj
	 /dAkQGnZj2QkFBkn7rETS7m7uheQVqm5ersA875Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgEZIPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:15:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF9C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:15:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so2343242wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Lbw+7slKXAlWjtLEKLR+76MIuZ9sac+BvYMoV5Lxqw=;
        b=YbZ/C77tdqriEgHiZE6DZzpZvP2zAzMxV90zMvPieWt4NtA/a93ffI+Yht2mF728Ey
         Cgkc0aJ9rY4dhxP+9wxZPXnZmJ3MvSK56+ePSqJtErg6Z38bHMWLuYFr1fGEy8lYImLs
         X+vHLOvmxvHKP6aIMExGZCOEexakRmOgVfOab3Ps2YdOWZasqSpOSXXMiueK2uzSR2hy
         1ozYaIwFMaMxUGiRLQi7Vy+8cGYTowgG9l1n6Du9vyS5Tv90g370mzTrVBDuv6O5ABaN
         /O+jvpZwht5l3QTcWyjVjww3mIE0ob8DmvxE3mJUH88+fJDVkuaa5LV3nYLwff+ioGu9
         LTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/Lbw+7slKXAlWjtLEKLR+76MIuZ9sac+BvYMoV5Lxqw=;
        b=Rf1JaxpadaHTm8qt5GrrweaEh+hxGkJtsn+KC30DyLJbxOPcGBLvd2pUNh6oOVBMOD
         8E0uTsaDXUxZFxnFcY7a3gZWnQRHQ1lGCFmzBiHbWcbxETdUnkz13Mh7hxycfaakI7qz
         fE0PuRUG7l0KtTX0+BcKLOwoerZMWuL+6fiFGH4r7DuaeWoZILnAM28iVzJVjREWTLd7
         NM6sWX04tFHgJrDMgKgKygatof6UN3h444Xgi/NkW7KDcKj1PEZbJ1tzDh/5uCNm6KuS
         4vDGByRB0Xfir7yqc7es0t9+H2/Y0RlmFSvRTiMB+GCsJ+yOQxLoip9Cz4HFYpYCZqKh
         o4kA==
X-Gm-Message-State: AOAM530LFLLntM9Pad7nh+d4gLyRaVhknjrbvcWHvhKx8DzsPuLhJYyT
        aPbr1l3tJhIhhZECNzKRdLLhLoR0
X-Google-Smtp-Source: ABdhPJw8cH/fjPJxxaaTB8X2hrnos0KNusW99o75M4aqMYss1jYSz9fye2C1C8uQ/514tdPUu+y90A==
X-Received: by 2002:a1c:7712:: with SMTP id t18mr233566wmi.182.1590480899851;
        Tue, 26 May 2020 01:14:59 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a16sm6037950wrx.8.2020.05.26.01.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 01:14:58 -0700 (PDT)
Date:   Tue, 26 May 2020 10:14:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V9 02/39] rcu: Abstract out rcu_irq_enter_check_tick()
 from rcu_nmi_enter()
Message-ID: <20200526081456.GA35238@gmail.com>
References: <20200521200513.656533920@linutronix.de>
 <20200521202116.996113173@linutronix.de>
 <20200521210339.GC2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521210339.GC2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> > +	if (!tick_nohz_full_cpu(rdp->cpu) ||
> > +	    !READ_ONCE(rdp->rcu_urgent_qs) ||
> > +	    READ_ONCE(rdp->rcu_forced_tick)) {
> > +		// RCU doesn't need nohz_full help from this CPU, or it is
> > +		// already getting that help.
> > +		return;
> > +	}
> > +
> > +	// We get here only when not in an extended quiescent state and
> > +	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
> > +	// already watching and (2) The fact that we are in an interrupt
> > +	// handler and that the rcu_node lock is an irq-disabled lock
> > +	// prevents self-deadlock.  So we can safely recheck under the lock.
> > +	// Note that the nohz_full state currently cannot change.
> > +	raw_spin_lock_rcu_node(rdp->mynode);
> > +	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > +		// A nohz_full CPU is in the kernel and RCU needs a
> > +		// quiescent state.  Turn on the tick!
> > +		WRITE_ONCE(rdp->rcu_forced_tick, true);
> > +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> > +	}
> > +	raw_spin_unlock_rcu_node(rdp->mynode);

BTW., can we please not ever use this weird comment style in the future?

Linus gave an exception to single-line C++ style comments - but I 
don't think that should be extrapolated to a license to uglify the 
kernel with inconsistent muck like this. :-/

I've sanitized it via the patch below.

( I also fixed the whitespace damage and a capitalization typo while 
  at it, and fixed the spelling in the big comment explaining 
  __rcu_irq_enter_check_tick(). )

Thanks,

	Ingo

--- tip.orig/kernel/rcu/tree.c
+++ tip/kernel/rcu/tree.c
@@ -850,14 +850,14 @@ void noinstr rcu_user_exit(void)
 }
 
 /**
- * __rcu_irq_enter_check_tick - Enable scheduler tick on CPU if RCU needs it.
+ * __rcu_irq_enter_check_tick - Enable the scheduler tick on a CPU if RCU needs it.
  *
  * The scheduler tick is not normally enabled when CPUs enter the kernel
  * from nohz_full userspace execution.  After all, nohz_full userspace
  * execution is an RCU quiescent state and the time executing in the kernel
- * is quite short.  Except of course when it isn't.  And it is not hard to
+ * is quite short.  Except of course when it isn't: it is not hard to
  * cause a large system to spend tens of seconds or even minutes looping
- * in the kernel, which can cause a number of problems, include RCU CPU
+ * in the kernel, which can cause a number of problems, including RCU CPU
  * stall warnings.
  *
  * Therefore, if a nohz_full CPU fails to report a quiescent state
@@ -879,7 +879,7 @@ void __rcu_irq_enter_check_tick(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	 // Enabling the tick is unsafe in NMI handlers.
+	/* Enabling the tick is unsafe in NMI handlers. */
 	if (WARN_ON_ONCE(in_nmi()))
 		return;
 
@@ -889,21 +889,27 @@ void __rcu_irq_enter_check_tick(void)
 	if (!tick_nohz_full_cpu(rdp->cpu) ||
 	    !READ_ONCE(rdp->rcu_urgent_qs) ||
 	    READ_ONCE(rdp->rcu_forced_tick)) {
-		// RCU doesn't need nohz_full help from this CPU, or it is
-		// already getting that help.
+		/*
+		 * RCU doesn't need nohz_full help from this CPU, or it is
+		 * already getting that help.
+		 */
 		return;
 	}
 
-	// We get here only when not in an extended quiescent state and
-	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
-	// already watching and (2) The fact that we are in an interrupt
-	// handler and that the rcu_node lock is an irq-disabled lock
-	// prevents self-deadlock.  So we can safely recheck under the lock.
-	// Note that the nohz_full state currently cannot change.
+	/*
+	 * We get here only when not in an extended quiescent state and
+	 * from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
+	 * already watching and (2) the fact that we are in an interrupt
+	 * handler and that the rcu_node lock is an irq-disabled lock
+	 * prevents self-deadlock.  So we can safely recheck under the lock.
+	 * Note that the nohz_full state currently cannot change.
+	 */
 	raw_spin_lock_rcu_node(rdp->mynode);
 	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-		// A nohz_full CPU is in the kernel and RCU needs a
-		// quiescent state.  Turn on the tick!
+		/*
+		 * A nohz_full CPU is in the kernel and RCU needs a
+		 * quiescent state.  Turn on the tick!
+		 */
 		WRITE_ONCE(rdp->rcu_forced_tick, true);
 		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
