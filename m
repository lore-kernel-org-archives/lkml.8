Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC915C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC2A207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6QA/AMr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+QmL6DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIBHxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:53:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60BC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 00:53:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599033210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z372Am4vPf/CJeTK/KgLAMIsy+dYVzx7F+QrRDb1NWY=;
        b=k6QA/AMri08ntNzWG5DZ34oPWTzkVMVU9cX1fpU2kKkp4WuTIXyaL4LZwdeGzgx+1uPIR8
        w8ahD0IaKPdCWb+wiBlPlBA2JFfqbO6bqRgAvUurgK6NBPPTPKM4p2yPYyTZXxPBP2Hb7X
        V7UgudsS63GBjwr2svzc41UIJwyQTPp8TSYWhpcpEBa8OcIxzFKzwwLI1Zg2uGghN0B5JC
        5WKtnZv/SUuRTnXqWEQQH4Ow5noIGFUkhRnUUV6DFeQD6Uh6V7dqfW3TUBugfqwyXZxJ1C
        6NlsTqT+sXe0HorNPQ2PuEZA65esaBURJ00fxyNy9MZipoyGX2HSezM/1difyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599033210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z372Am4vPf/CJeTK/KgLAMIsy+dYVzx7F+QrRDb1NWY=;
        b=g+QmL6DKAniWx8SzkcsI5yZ2l7xKvemaFaDH8G+0diqAhrwoxmO9BnLjTXz9D6pKFTho3A
        pOJvkToQwn0BqQAg==
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
In-Reply-To: <20200902012905.GB1703315@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com> <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com> <87y2lth4qa.fsf@nanos.tec.linutronix.de> <20200901165052.GA1662854@google.com> <875z8xl0zh.fsf@nanos.tec.linutronix.de> <20200902012905.GB1703315@google.com>
Date:   Wed, 02 Sep 2020 09:53:29 +0200
Message-ID: <87h7sgk41y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

On Tue, Sep 01 2020 at 21:29, Joel Fernandes wrote:
> On Tue, Sep 01, 2020 at 10:02:10PM +0200, Thomas Gleixner wrote:
>> The generated code for the CONFIG_PRETENT_HT_SECURE=n case is the same
>
> When you say 'pretend', did you mean 'make' ? The point of this patch is to
> protect the kernel from the other hyperthread thus making HT secure for the
> kernel contexts and not merely pretending.

I'm paranoid and don't trust HT at all. There is too much shared state.

>> --- /dev/null
>> +++ b/include/linux/pretend_ht_secure.h
>> @@ -0,0 +1,21 @@
>> +#ifndef _LINUX_PRETEND_HT_SECURE_H
>> +#define _LINUX_PRETEND_HT_SECURE_H
>> +
>> +#ifdef CONFIG_PRETEND_HT_SECURE
>> +static inline void enter_from_user_ht_sucks(void)
>> +{
>> +	if (static_branch_unlikely(&pretend_ht_secure_key))
>> +		enter_from_user_pretend_ht_is_secure();
>> +}
>> +
>> +static inline void exit_to_user_ht_sucks(void)
>> +{
>> +	if (static_branch_unlikely(&pretend_ht_secure_key))
>> +		exit_to_user_pretend_ht_is_secure();
>
> We already have similar config and static keys for the core-scheduling
> feature itself. Can we just make it depend on that?

Of course. This was just for illustration. :)

> Or, are you saying users may want 'core scheduling' enabled but may want to
> leave out the kernel protection?

Core scheduling per se without all the protection muck, i.e. a relaxed
version which tries to gang schedule threads of a process on a core if
feasible has advantages to some workloads.

>> @@ -111,6 +113,12 @@ static __always_inline void exit_to_user
>>  /* Workaround to allow gradual conversion of architecture code */
>>  void __weak arch_do_signal(struct pt_regs *regs) { }
>>  
>> +static inline unsigned long exit_to_user_get_work(void)
>> +{
>> +	exit_to_user_ht_sucks();
>
> Ok, one issue with your patch is it does not take care of the waiting logic.
> sched_core_unsafe_exit_wait() needs to be called *after* all of the
> exit_to_user_mode_work is processed. This is because
> sched_core_unsafe_exit_wait() also checks for any new exit-to-usermode-work
> that popped up while it is spinning and breaks out of its spin-till-safe loop
> early. This is key to solving the stop-machine issue. If the stopper needs to
> run, then the need-resched flag will be set and we break out of the spin and
> redo the whole exit_to_user_mode_loop() as it should.

And where is the problem?

syscall_entry()
  ...
    sys_foo()
      ....
      return 0;

  local_irq_disable();
  exit_to_user_mode_prepare()
    ti_work = exit_to_user_get_work()
       {
        if (ht_muck)
          syscall_exit_ht_muck() {
            ....
            while (wait) {
            	local_irq_enable();
                while (wait) cpu_relax();
                local_irq_disable();
            }
          }
        return READ_ONCE(current_thread_info()->flags);
       }

    if (unlikely(ti_work & WORK))
    	ti_work = exit_loop(ti_work)

        while (ti_work & MASK) {
          local_irq_enable();
          .....
          local_irq_disable();
          ti_work = exit_to_user_get_work()
            {
              See above
            }
       }

It covers both the 'no work' and the 'do work' exit path. If that's not
sufficient, then something is fundamentally wrong with your design.

Thanks,

        tglx
