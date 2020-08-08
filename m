Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A25C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC573206C0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLirilH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHHXXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHXXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:23:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84559C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:23:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so2916149ply.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SqiaPfyjupIsj5uhY9EYAWpSWNQLsVtimF63ycRbI1U=;
        b=vLirilH9byfRlLNFP67MUb86LoPNd3MlOtumcoHeslUIkHthkixAEF2SQGwMxbEbHC
         3L1uoGGUt9McOoYg4Iv9et7bIl7Yoey27hBXkGyOoVZiZfj0JDUQFzKoAxX21x4Ov02S
         eA0Xiaebof1CVoIXmoyDO64QZ88bTXR64k+miwZ5krX/VIxNEm+K9lfUmlx8TdP5QQrM
         1GG4BZqgVY3Ro+0f5rlacdpDKO7tVIZ/dPdjWF7fnOtx/YIybvwmHRKq0Ot0qZlLnm75
         wy6/PzTM2ffE4fFdus/iCzUFQkMPTVEuC1hB5inkULYj9eATEcG/UVw0k16GOXVZKVcG
         OaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqiaPfyjupIsj5uhY9EYAWpSWNQLsVtimF63ycRbI1U=;
        b=oZVI3763OWticIzzr4odp+RBdApCjG/m9IL5If5oDtnms6vp1hO7S4Ef65wEdOqXV/
         w4aUvTuZrBQUpAPcEoQZxDrB14q4w6mtvKlkR/MrIgtYeAJR8XhVH9xTdj0KyeMrkdAL
         +8+1AGBjUF4cSN7KkjvtzXZYjEyh+rdrefrJZnZ6LQOTHoV2aGigYmBJ9k14KmyAXCWY
         so21qRxUzGXvuNz+f0zoALQg2I0zABXC2F7qr6oB2meayw9kN2ZH2w9PDnHcYR5PK2SV
         V73P/NYMBSb9OCHbTFWX5a7hdcXfGcZo9A4foKZJyTNtjPUelJr19Ho34UT7qCrssqXQ
         O2Gw==
X-Gm-Message-State: AOAM533P/ZLgR8S3y/eQ5RITXJRxnZspQwMx97xOV+TYXVCjNNOv28In
        J382SHPmUhjP0MyN34DXEdA=
X-Google-Smtp-Source: ABdhPJymAcbRpeFIxERzuNzYiqWAFmFZjffV22fWghmybjje/3vqU+ilAilrMbMYzqVFN1Cy4oMU+A==
X-Received: by 2002:a17:90a:a58d:: with SMTP id b13mr21385146pjq.55.1596928986137;
        Sat, 08 Aug 2020 16:23:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10sm17666113pfb.82.2020.08.08.16.23.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Aug 2020 16:23:05 -0700 (PDT)
Date:   Sat, 8 Aug 2020 16:23:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/24] seqlock: lockdep assert non-preemptibility on
 seqcount_t write
Message-ID: <20200808232304.GA186931@roeck-us.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-9-a.darwish@linutronix.de>
 <20200808232122.GA176509@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808232122.GA176509@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 04:21:22PM -0700, Guenter Roeck wrote:
> On Mon, Jul 20, 2020 at 05:55:14PM +0200, Ahmed S. Darwish wrote:
> > Preemption must be disabled before entering a sequence count write side
> > critical section.  Failing to do so, the seqcount read side can preempt
> > the write side section and spin for the entire scheduler tick.  If that
> > reader belongs to a real-time scheduling class, it can spin forever and
> > the kernel will livelock.
> > 
> > Assert through lockdep that preemption is disabled for seqcount writers.
> > 
> 
> This patch is causing compile failures for various images (eg arm:allmodconfig,
> arm:imx_v6_v7_defconfig, mips:allmodconfig).
> 
> In file included from arch/arm/include/asm/bug.h:60,
>                  from include/linux/bug.h:5,
>                  from include/linux/thread_info.h:12,
>                  from include/asm-generic/current.h:5,
>                  from ./arch/arm/include/generated/asm/current.h:1,
>                  from include/linux/sched.h:12,
>                  from arch/arm/kernel/asm-offsets.c:11:
> include/linux/seqlock.h: In function 'write_seqcount_begin_nested':
> include/asm-generic/percpu.h:31:40: error: implicit declaration of function 'raw_smp_processor_id'
> 

Also:

Building sparc64:allmodconfig ... failed
--------------
Error log:
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from arch/sparc/include/asm/bug.h:25,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:12,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/sparc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:51,
                 from include/linux/seqlock.h:15,
                 from include/linux/time.h:6,
                 from arch/sparc/vdso/vclock_gettime.c:16:
include/linux/seqlock.h: In function 'write_seqcount_begin_nested':
arch/sparc/include/asm/percpu_64.h:19:25: error: '__local_per_cpu_offset' undeclared

Again, reverting this patch fixes the problem.

Guenter

> Reverting it fixes the problem. Is this being addressed ?
> 
> Guenter
> 
> > Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> > ---
> >  include/linux/seqlock.h | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index e885702d8b82..54bc20496392 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -266,6 +266,12 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
> >  	kcsan_nestable_atomic_end();
> >  }
> >  
> > +static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
> > +{
> > +	raw_write_seqcount_begin(s);
> > +	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
> > +}
> > +
> >  /**
> >   * write_seqcount_begin_nested() - start a seqcount_t write section with
> >   *                                 custom lockdep nesting level
> > @@ -276,8 +282,19 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
> >   */
> >  static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
> >  {
> > -	raw_write_seqcount_begin(s);
> > -	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
> > +	lockdep_assert_preemption_disabled();
> > +	__write_seqcount_begin_nested(s, subclass);
> > +}
> > +
> > +/*
> > + * A write_seqcount_begin() variant w/o lockdep non-preemptibility checks.
> > + *
> > + * Use for internal seqlock.h code where it's known that preemption is
> > + * already disabled. For example, seqlock_t write side functions.
> > + */
> > +static inline void __write_seqcount_begin(seqcount_t *s)
> > +{
> > +	__write_seqcount_begin_nested(s, 0);
> >  }
> >  
> >  /**
> > @@ -575,7 +592,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
> >  static inline void write_seqlock(seqlock_t *sl)
> >  {
> >  	spin_lock(&sl->lock);
> > -	write_seqcount_begin(&sl->seqcount);
> > +	__write_seqcount_begin(&sl->seqcount);
> >  }
> >  
> >  /**
> > @@ -601,7 +618,7 @@ static inline void write_sequnlock(seqlock_t *sl)
> >  static inline void write_seqlock_bh(seqlock_t *sl)
> >  {
> >  	spin_lock_bh(&sl->lock);
> > -	write_seqcount_begin(&sl->seqcount);
> > +	__write_seqcount_begin(&sl->seqcount);
> >  }
> >  
> >  /**
> > @@ -628,7 +645,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
> >  static inline void write_seqlock_irq(seqlock_t *sl)
> >  {
> >  	spin_lock_irq(&sl->lock);
> > -	write_seqcount_begin(&sl->seqcount);
> > +	__write_seqcount_begin(&sl->seqcount);
> >  }
> >  
> >  /**
> > @@ -649,7 +666,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&sl->lock, flags);
> > -	write_seqcount_begin(&sl->seqcount);
> > +	__write_seqcount_begin(&sl->seqcount);
> >  	return flags;
> >  }
> >  
> > -- 
> > 2.20.1
> > 
