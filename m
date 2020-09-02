Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C245C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2048D20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XopMhjZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgIBPPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgIBPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:12:03 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB43C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:12:02 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so2349435qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vAvnVJ2C0HDa5znBhLliHVbA1rx/NHVEivHZZRcheUY=;
        b=XopMhjZ2PAUrj8VpQlQNWEYvxy1KXpmPvftFZMfV2+PyXzE+FodZ6WgP+mymMpZT6r
         WyJDW0n5P6de3D02kp0TEV8NI2FWhhNl8vacyIhDQA7XsK74VldEWEJlTrryCtKi8dc5
         9ag+HKibRGKiikfGoAXhMICibSXIxWDyxWu5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vAvnVJ2C0HDa5znBhLliHVbA1rx/NHVEivHZZRcheUY=;
        b=kC3Mv02Hip6rmjcDIKM4ZjRnFvkprH3iOgJblEuIv1ynd6cdcuh4IqZkgS2/boIp+x
         +e11EEhte+44nbHRL9LBnUKRwuhzo/rfLA0pcjtSEQ/l6SC24wmXO60Hnt5HUdtM29Cn
         IEUmRoUT23YGyuHIlc9Wes8WnNec11F3+GhllN2UcOQLMm1aGTLhmrDtnCRaTdYA4Pnp
         pn6P14UfmSd1N7nkvOog+WrRImgbfGle5f3AYkEYJuXyl3L7zJOJxuw5NO5HYPJze6+R
         mKz3tqvVXf9Kw3PN4QR+cv16VYNvKhFae0ZdbQk0qAZyCgsBbtiopW6tOoPpdFn0sFPh
         JOxw==
X-Gm-Message-State: AOAM531LfBwrM9i2eROPXFzgfoUEEWwxi1ZaY3EScFbvz0rsN0yuqQvH
        Vug6mjlQ0730ETfbPvZ9/DFnMw==
X-Google-Smtp-Source: ABdhPJw0YYC2AT+yF7C++CYVj38G0sfihc5hBaSEHFnxFo9CwzMYrWfIJnTA/2RhtzFkgkmtxFx5DQ==
X-Received: by 2002:a0c:e04e:: with SMTP id y14mr6912253qvk.117.1599059521585;
        Wed, 02 Sep 2020 08:12:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id s184sm4556270qkf.50.2020.09.02.08.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 08:12:00 -0700 (PDT)
Date:   Wed, 2 Sep 2020 11:12:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide
 protection of kernel-mode
Message-ID: <20200902151200.GA2474204@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
 <87y2lth4qa.fsf@nanos.tec.linutronix.de>
 <20200901165052.GA1662854@google.com>
 <875z8xl0zh.fsf@nanos.tec.linutronix.de>
 <20200902012905.GB1703315@google.com>
 <87h7sgk41y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7sgk41y.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Sep 02, 2020 at 09:53:29AM +0200, Thomas Gleixner wrote:
[...]
> >> --- /dev/null
> >> +++ b/include/linux/pretend_ht_secure.h
> >> @@ -0,0 +1,21 @@
> >> +#ifndef _LINUX_PRETEND_HT_SECURE_H
> >> +#define _LINUX_PRETEND_HT_SECURE_H
> >> +
> >> +#ifdef CONFIG_PRETEND_HT_SECURE
> >> +static inline void enter_from_user_ht_sucks(void)
> >> +{
> >> +	if (static_branch_unlikely(&pretend_ht_secure_key))
> >> +		enter_from_user_pretend_ht_is_secure();
> >> +}
> >> +
> >> +static inline void exit_to_user_ht_sucks(void)
> >> +{
> >> +	if (static_branch_unlikely(&pretend_ht_secure_key))
> >> +		exit_to_user_pretend_ht_is_secure();
> >
> > We already have similar config and static keys for the core-scheduling
> > feature itself. Can we just make it depend on that?
> 
> Of course. This was just for illustration. :)

Got it. :)

> > Or, are you saying users may want 'core scheduling' enabled but may want to
> > leave out the kernel protection?
> 
> Core scheduling per se without all the protection muck, i.e. a relaxed
> version which tries to gang schedule threads of a process on a core if
> feasible has advantages to some workloads.

Sure. So I will make it depending on the existing core-scheduling
config/static-key so the kernel protection is there when core scheduling is
enabled (so both userspace and with this patch the kernel is protected).

> 
> >> @@ -111,6 +113,12 @@ static __always_inline void exit_to_user
> >>  /* Workaround to allow gradual conversion of architecture code */
> >>  void __weak arch_do_signal(struct pt_regs *regs) { }
> >>  
> >> +static inline unsigned long exit_to_user_get_work(void)
> >> +{
> >> +	exit_to_user_ht_sucks();
> >
> > Ok, one issue with your patch is it does not take care of the waiting logic.
> > sched_core_unsafe_exit_wait() needs to be called *after* all of the
> > exit_to_user_mode_work is processed. This is because
> > sched_core_unsafe_exit_wait() also checks for any new exit-to-usermode-work
> > that popped up while it is spinning and breaks out of its spin-till-safe loop
> > early. This is key to solving the stop-machine issue. If the stopper needs to
> > run, then the need-resched flag will be set and we break out of the spin and
> > redo the whole exit_to_user_mode_loop() as it should.
> 
> And where is the problem?
> 
> syscall_entry()
>   ...
>     sys_foo()
>       ....
>       return 0;
> 
>   local_irq_disable();
>   exit_to_user_mode_prepare()
>     ti_work = exit_to_user_get_work()
>        {
>         if (ht_muck)
>           syscall_exit_ht_muck() {
>             ....
>             while (wait) {
>             	local_irq_enable();
>                 while (wait) cpu_relax();
>                 local_irq_disable();
>             }
>           }
>         return READ_ONCE(current_thread_info()->flags);
>        }
> 
>     if (unlikely(ti_work & WORK))
>     	ti_work = exit_loop(ti_work)
> 
>         while (ti_work & MASK) {
>           local_irq_enable();
>           .....
>           local_irq_disable();
>           ti_work = exit_to_user_get_work()
>             {
>               See above
>             }
>        }
> 
> It covers both the 'no work' and the 'do work' exit path. If that's not
> sufficient, then something is fundamentally wrong with your design.

Yes, you are right, I got confused from your previous patch. This works too
and is exactly as my design. I will do it this way then. Thank you, Thomas!

 - Joel

