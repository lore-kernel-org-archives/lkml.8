Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C70C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0021B20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Zu4c/PHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgEOTAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:00:43 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:00:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id a4so1627709qvj.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ISYBaVCiDO7G5hPAvDuNoncP6nuCvkrm7rgsOcxjwcw=;
        b=Zu4c/PHwsdfJkmCnGu9P/wrmQcgMeRlEqyF6qOivOv0eYkFGKg2LsgCcwQC0GiElbQ
         niUipZAUXLSU3JRvMKMwDElZNeOLp0Pg8W+i9/NAy7Ksf5z6BiBwFd+EQjRToKVF6AQd
         gJN7/wiwQzro1D+3XWfUAq5s58kzu+4TVVt7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ISYBaVCiDO7G5hPAvDuNoncP6nuCvkrm7rgsOcxjwcw=;
        b=Vo1NrRUo36Jhl6V1V2Fv/jQHVslJp5F0/o/qUsHBTUf/0s+9nf3LsLtSG6rjRGZNO9
         F2E6OLTHh9725KWAt+u0vEgssvVOgN8c/3GFJWrvicMjDWEtVQR43WfPkcRTj4F98vGi
         5OfMlERvmdirI1v43lLCVi/ofefufSgPlNDcpA5JVTAh0mfWzOVkn3uxAn1AhuRX0ZwX
         NAlMlH+kWPEQPA3TUPMeB0eSeluR4oTf3W7CV50z4sNoWgIGbaJ1FZUBP8uk98svpPBm
         FLusoFprnK/ktLlNPy01Zkfq8bGQuGJHIEp6Nlr+LiUSuozWSh4njIXrXb4Tw4qGnx8H
         /30Q==
X-Gm-Message-State: AOAM5328kJi1XAPU6HbAMZTtwQtxnahg4bm0fwBo5FKb1AKfsIl4hCe/
        bhK0ufTPl+fQkV4hdc8ISAoE4Q==
X-Google-Smtp-Source: ABdhPJxodmJR2jrTOwrNyQoVsBIAqnIl/D5rerN8cdwppymJfPeg15LAWni3z06SHGuuWvMThd6nng==
X-Received: by 2002:a05:6214:188a:: with SMTP id cx10mr5024693qvb.119.1589569242461;
        Fri, 15 May 2020 12:00:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z25sm2700717qtj.75.2020.05.15.12.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 12:00:41 -0700 (PDT)
Date:   Fri, 15 May 2020 15:00:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 11/29] rcu: Provide rcu_irq_exit_preempt()
Message-ID: <20200515190041.GB40692@google.com>
References: <20200505134354.774943181@linutronix.de>
 <20200505134904.364456424@linutronix.de>
 <20200514024116.GA231286@google.com>
 <87blmqziek.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blmqziek.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:43:31PM +0200, Thomas Gleixner wrote:
[...] 
> > Or, if [1] is merged, then we could just combine the checks into one check.
> > 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) != 1,
> > 			 "Bad RCU dynticks_nmi_nesting counter\n");
> >
> >> +	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
> >> +			 "RCU in extended quiescent state!");
> >
> > Makes sense.
> >
> > BTW, I wonder if a better place to do this "don't enter scheduler while RCU
> > is not watching" is rcu_note_context_switch()...
> 
> I actually want to catch even the case where we don't schedule, i.e.
> 
>   if (ret_to_kernel) {
>      if (interrupts_on_after_return((regs)) {
>         if (IS_ENABLED(CONFIG_PREEMPTION)) {
>   	   if (!preempt_count()) {
>               /* Preemption is possible ... */
>        	      rcu_irq_exit_preempt();
>                  if (need_resched())
>                     schedule_preempt_irq();
> 
> that catches any exit where preemption is possible and RCU is not
> watching after rcu_irq_exit().
> 
> It does not matter whether need-resched is set here or not. Any
> interrupt/exception could set it.

Yes, your way of doing it is better. Let us do it this way then.

Thanks!

 - Joel

