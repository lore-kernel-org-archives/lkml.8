Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1ACC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AF120715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="u4PFrkck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBJRRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:17:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45652 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBJRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:17:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id a2so6755893qko.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cZqj50IftZxjPRTyAG3UBz7+gJFCeN+WZs9KU/8IF9Y=;
        b=u4PFrkckW2UcATA5IxC3SY0oAfo6+BnzD/bSibOXEwogG9bxZnwBxLacMjrotEjjZE
         VbzTq8fnMGYcSxngibL6ctR/gsgzN4uoEdIviyvRrSngTl1V5M4X8jjqcAL4mIiNtVmW
         lDTXSbGm8nDDong7zxEPmDzMIlQfdxFMpsi9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZqj50IftZxjPRTyAG3UBz7+gJFCeN+WZs9KU/8IF9Y=;
        b=h2XShoMpk3xO+mnCpdwe48nSssqN/U4tDC9x+b5Nr3zL+AqUefXMOfrUVzwgHU/rHW
         muoaJet28hnFCFDR57acYRiWwuMuPfC2UTxnxWAfGW8+WQ6bqO0jppl7UsSTzbxyp+jg
         vzIAMyuMnLwN8rSILSTW2KifH7Jm+ZlULFiuiQUrtCTO3QLDS7c8AKUgogGzEXE4Yw3Z
         F9TlogijwFI05r10FJw5vuz+6K9Ao8Md3n+kIIhBVc6pDs6cscg3rPFP97MaT10ERPFh
         hJ4lvhpJQSwFVwRSDkHhXgjZAvwbu97kLrqt8ojU91179FOFilikNMdmGYOxJFrldFtB
         sXpw==
X-Gm-Message-State: APjAAAVpGan+FP6X21uOgFOTMaqyaaiQKMVR0Gz/ijMHnVCNrHagoYbg
        MK7QmYgvkYTLgSI3Ux8hKTY1tA==
X-Google-Smtp-Source: APXvYqwf91q8QGoKS6La6EIHSo6XwbCspFPiHcgVGfon1sj4IcHS33S3QsX1lPtgdxKmq3/rjoHG9A==
X-Received: by 2002:a37:6752:: with SMTP id b79mr2404234qkc.224.1581355027309;
        Mon, 10 Feb 2020 09:17:07 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 11sm419271qko.76.2020.02.10.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 09:17:06 -0800 (PST)
Date:   Mon, 10 Feb 2020 12:17:06 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200210171706.GC246160@google.com>
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
 <20200210094616.GC14879@hirez.programming.kicks-ass.net>
 <20200210133652.GV2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210133652.GV2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:36:52AM -0800, Paul E. McKenney wrote:
[snip]
> > The best we can do is move that rcu_irq_enter/exit_*() crud into the
> > perf tracepoint glue I suppose.
> 
> One approach would be to define a synchronize_preempt_disable() that
> waits only for pre-existing disabled-preemption regions (including
> of course diabled-irq and NMI-handler regions.  Something like Steve
> Rostedt's workqueue-baed schedule_on_each_cpu(ftrace_sync) implementation
> might work.
> 
> There are of course some plusses and minuses:

Thanks for enlisting them.

> +	Works on preempt-disable regions in idle-loop code without
> 	the need to invoke rcu_idle_exit() and rcu_idle_enter()..
> 
> +	Straightforward implementation.
> 
> -	Does not work on preempt-disable regions on offline CPUs.
> 	(I have no idea if this really matters.)

One more area where it would not work is, if in the future we made it
possible to sleep within tracepoint callbacks (something like what Mathieu
said about handling page faults properly in callback code), then such an
implementation would not work there.

thanks,

 - Joel

