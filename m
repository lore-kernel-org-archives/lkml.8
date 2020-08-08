Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C06BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C6D206C0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh9uE+cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgHHXVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHXVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:21:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6DFC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:21:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so2911513plb.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AWgV0TUiQnHJyaEDKZ8T6708KuYJ16tS2Wq4QOoyN9U=;
        b=Mh9uE+cCA44fhESTNcRPPdoxSVHQUak6zk9hG6zBlpoNylZ8WLS8M3bVIgyaKMNN2+
         MDL77NYFVmEEnAq73ePi3wcwqbVuPps6P/QJ40Vxte5AR28h0UoJXGI80rnRxHZBuDRx
         yiSsSXJ+BW0Jv13KlK/vQDA7Fj2lif8q1JuxBr94KS2gDk88GMdwkXYnxmvoNUmjMwdS
         IKBaV9ldILHYTlZzUUMzvZjmpMA50YihxPyu3zusb4uP0yS8LlfQCttuAjxOZOAqlOTq
         SGZWCYdxszTVAudSY0pVIAidoB7MxcoNmsK3QTeNVg+aB42g5a0W+8dp3mpJixmIB68p
         rTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AWgV0TUiQnHJyaEDKZ8T6708KuYJ16tS2Wq4QOoyN9U=;
        b=OKYeB1hEUpCPgyXqagMmMNVdXR8VLxULTkmcmtwRLGwguxHvC1xatheSpx+PaY/5uM
         JUhmCyc2jpOnXCcTLmWi6WEya1FkteQ2FCQ3c6TdcahjJ0aNTa8ucfzPjQVK7ngRIJWP
         gdEtZCqwKOEpcNuhpkFy7KH/bLEbpB4wkvD0LiyuqpWgnX2OUHjmT/m+2nVSmbfHeuOS
         9kdxln8ltzNn7tS1PBOtsvolYq8jUHmXi0/QdGz/FKfm7oHFLy9ROU0ALTbzxfEwz5rl
         yri6Ns9zsy/4zCDRFOoXQMAqo4MpAu/6n25pA8Os0MCVFMo8K8AvoGXsDx8LQSXxvM22
         G28g==
X-Gm-Message-State: AOAM532rTs3kei6N4qBmUBCm+gff+hMjxb1VFArpnToU3/9ogUdZO5US
        KVO9ic43aBq5PDN/sF0mCLTW1ShU
X-Google-Smtp-Source: ABdhPJz3W6+eEO4m7d+WHwsTiQJWHNOayYPJBBmhIyarAMRTf0bd3yaJRNMljRmyrOZ5bizK1XioZg==
X-Received: by 2002:a17:90b:3685:: with SMTP id mj5mr21207370pjb.50.1596928884853;
        Sat, 08 Aug 2020 16:21:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z17sm11158422pfq.38.2020.08.08.16.21.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Aug 2020 16:21:23 -0700 (PDT)
Date:   Sat, 8 Aug 2020 16:21:22 -0700
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
Message-ID: <20200808232122.GA176509@roeck-us.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-9-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720155530.1173732-9-a.darwish@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 05:55:14PM +0200, Ahmed S. Darwish wrote:
> Preemption must be disabled before entering a sequence count write side
> critical section.  Failing to do so, the seqcount read side can preempt
> the write side section and spin for the entire scheduler tick.  If that
> reader belongs to a real-time scheduling class, it can spin forever and
> the kernel will livelock.
> 
> Assert through lockdep that preemption is disabled for seqcount writers.
> 

This patch is causing compile failures for various images (eg arm:allmodconfig,
arm:imx_v6_v7_defconfig, mips:allmodconfig).

In file included from arch/arm/include/asm/bug.h:60,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:12,
                 from include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from include/linux/sched.h:12,
                 from arch/arm/kernel/asm-offsets.c:11:
include/linux/seqlock.h: In function 'write_seqcount_begin_nested':
include/asm-generic/percpu.h:31:40: error: implicit declaration of function 'raw_smp_processor_id'

Reverting it fixes the problem. Is this being addressed ?

Guenter

> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> ---
>  include/linux/seqlock.h | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index e885702d8b82..54bc20496392 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -266,6 +266,12 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
>  	kcsan_nestable_atomic_end();
>  }
>  
> +static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
> +{
> +	raw_write_seqcount_begin(s);
> +	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
> +}
> +
>  /**
>   * write_seqcount_begin_nested() - start a seqcount_t write section with
>   *                                 custom lockdep nesting level
> @@ -276,8 +282,19 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
>   */
>  static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
>  {
> -	raw_write_seqcount_begin(s);
> -	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
> +	lockdep_assert_preemption_disabled();
> +	__write_seqcount_begin_nested(s, subclass);
> +}
> +
> +/*
> + * A write_seqcount_begin() variant w/o lockdep non-preemptibility checks.
> + *
> + * Use for internal seqlock.h code where it's known that preemption is
> + * already disabled. For example, seqlock_t write side functions.
> + */
> +static inline void __write_seqcount_begin(seqcount_t *s)
> +{
> +	__write_seqcount_begin_nested(s, 0);
>  }
>  
>  /**
> @@ -575,7 +592,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
>  static inline void write_seqlock(seqlock_t *sl)
>  {
>  	spin_lock(&sl->lock);
> -	write_seqcount_begin(&sl->seqcount);
> +	__write_seqcount_begin(&sl->seqcount);
>  }
>  
>  /**
> @@ -601,7 +618,7 @@ static inline void write_sequnlock(seqlock_t *sl)
>  static inline void write_seqlock_bh(seqlock_t *sl)
>  {
>  	spin_lock_bh(&sl->lock);
> -	write_seqcount_begin(&sl->seqcount);
> +	__write_seqcount_begin(&sl->seqcount);
>  }
>  
>  /**
> @@ -628,7 +645,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
>  static inline void write_seqlock_irq(seqlock_t *sl)
>  {
>  	spin_lock_irq(&sl->lock);
> -	write_seqcount_begin(&sl->seqcount);
> +	__write_seqcount_begin(&sl->seqcount);
>  }
>  
>  /**
> @@ -649,7 +666,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&sl->lock, flags);
> -	write_seqcount_begin(&sl->seqcount);
> +	__write_seqcount_begin(&sl->seqcount);
>  	return flags;
>  }
>  
> -- 
> 2.20.1
> 
