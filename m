Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C45C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55506206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mrboOzb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgCGHrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:47:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32772 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGHrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 02:47:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id d22so3549831qtn.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJaGuE6xjlwUdKde+nh834lDDnUaVIY1l9gUCqflQZs=;
        b=mrboOzb015mzZ3cdDvl8jKCqwe6B++cNC3lPjplgSU3Rn2LrOOqmFKlya7+9SnKiKE
         K9IGQleQRLSPUPNSg3t4FDzKjrls7eqdvZQjcrllrAbZl7OtPfK9NW8FB7y0xDgVZahC
         UYHbP/kZVR6JzdYRDnaOaRBj3k1aF+6UR14kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJaGuE6xjlwUdKde+nh834lDDnUaVIY1l9gUCqflQZs=;
        b=SruRzSxFr1VbLEcRR1tFpNqn2j1ptzQj1iBOch7f9OwS74d1W3DlkqPhaW2zPJKfTZ
         atAvb4xUlyGkDL22SQm2Imuy23s/f8yyxr/fs/DZ73ZkSLtI7nEPssBAe8pZ31ExYKBH
         UwWXGqReogPTy1S/IhqyZCBvsDDd2kSIMq6B4GfTXL956pk62InrOHlyGll6TDxC9Gqv
         oduJRvGIC8n33jtTQZSELd9emGx+Pr/bZn3H4So397nms2pmhG3yDE9iC9KTolaMcrz5
         pJqzK4oiq+RwoeZLkYuymClWGBUWNkcggPtgLbMeRcrffvGmLw5VgdpVYIwOVmqYeAvp
         aBYQ==
X-Gm-Message-State: ANhLgQ13REIjqFhk+b94Qu0RT3ixzRmPfwrYOj0+cpHg0j2o7QNst1cz
        6KTofrh/0rrPjR2vzXJ1zagBIw==
X-Google-Smtp-Source: ADFU+vtziRMfTg1yps/AiQZAfaYNlrFmOCmXTvfWuxMug3AFf0WhRHxfqc72oVQu22YI2hEdemYf6g==
X-Received: by 2002:aed:38c8:: with SMTP id k66mr3241657qte.50.1583567223388;
        Fri, 06 Mar 2020 23:47:03 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i132sm19278276qke.41.2020.03.06.23.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 23:47:02 -0800 (PST)
Date:   Sat, 7 Mar 2020 02:47:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Prohibit probing on rcu_nmi_exit() and
 ist_exit()
Message-ID: <20200307074702.GA231616@google.com>
References: <158355013189.14191.9105069890402942867.stgit@devnote2>
 <20200307032831.GL2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307032831.GL2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 07:28:31PM -0800, Paul E. McKenney wrote:
> On Sat, Mar 07, 2020 at 12:02:12PM +0900, Masami Hiramatsu wrote:
> > Prohibit probing on rcu_nmi_exit() and ist_exit() which
> > are called from do_int3()'s kprobe path after kprobe_int3_handler().
> > 
> > The commit c13324a505c7 ("x86/kprobes: Prohibit probing on
> > functions before kprobe_int3_handler()") tried to fix similar
> > issue, but it only marks the functions before kprobe_int3_handler()
> > in do_int3().
> > 
> > If we put a kprobe on rcu_nmi_exit() or ist_exit(), the kprobes
> > will detect reentrance. However, it only skips the kprobe handler,
> > exits from do_int3() and hits ist_exit() and rcu_nmi_exit() again.
> > Thus, it causes another int3 exception and finally we will get
> > the kernel panic with "Unrecoverable kprobe detected." error message.
> > 
> > This is reproducible by the following commands.
> > 
> > / # echo 0 > /proc/sys/debug/kprobes-optimization
> > / # echo p vfs_read > /sys/kernel/debug/tracing/kprobe_events
> > / # echo p rcu_nmi_exit >> /sys/kernel/debug/tracing/kprobe_events
> > / # echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> > 
> > Fixes: c13324a505c7 ("x86/kprobes: Prohibit probing on functions before kprobe_int3_handler()")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> 
> From an RCU perspective:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> > ---
> >  arch/x86/kernel/traps.c |    1 +
> >  kernel/rcu/tree.c       |    1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 6ef00eb6fbb9..c63fb7697794 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -115,6 +115,7 @@ void ist_exit(struct pt_regs *regs)
> >  	if (!user_mode(regs))
> >  		rcu_nmi_exit();
> >  }
> > +NOKPROBE_SYMBOL(ist_exit);
> >  
> >  /**
> >   * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d91c9156fab2..c49ea0e919f9 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -670,6 +670,7 @@ void rcu_nmi_exit(void)
> >  {
> >  	rcu_nmi_exit_common(false);
> >  }
> > +NOKPROBE_SYMBOL(rcu_nmi_exit);
> >  
> >  /**
> >   * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
> > 
