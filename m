Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC636C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA64820671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgEOBnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgEOBnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:43:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 224802065F;
        Fri, 15 May 2020 01:43:51 +0000 (UTC)
Date:   Thu, 14 May 2020 21:43:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [patch V5 04/38] x86: Make hardware latency tracing explicit
Message-ID: <20200514214349.24642172@oasis.local.home>
In-Reply-To: <20200512213809.784331304@linutronix.de>
References: <20200512210059.056244513@linutronix.de>
        <20200512213809.784331304@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 23:01:03 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1916,7 +1916,7 @@ static __always_inline void exc_machine_
>  	    mce_check_crashing_cpu())
>  		return;
>  
> -	nmi_enter();
> +	nmi_enter_notrace();

Now a machine check exception could happen and be a cause of latency
(although there may be more issues if it does). The "nmi_enter trace"
version does two things. One is for time measurements (if available),
and the other is just letting the hardware latency know it happen (a
simple increment).

The only thing that is checked is "smp_processor_id()" (I just
remembered it doesn't need per cpu, as it only runs on a single CPU at
a time).

Could the notrace version supply the increment, and leave the
trace_clock() in the trace version?

-- Steve


>  	/*
>  	 * The call targets are marked noinstr, but objtool can't figure
>  	 * that out because it's an indirect call. Annotate it.
> 
