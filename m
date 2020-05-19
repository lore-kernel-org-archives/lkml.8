Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F1A20756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgESJG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:06:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6438C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 02:06:58 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jayCh-00050m-U3; Tue, 19 May 2020 11:06:28 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1B8731006A1; Tue, 19 May 2020 11:06:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
In-Reply-To: <20200519083826.GC279861@hirez.programming.kicks-ass.net>
References: <20200518160750.GA279861@hirez.programming.kicks-ass.net> <87367xvvmy.fsf@nanos.tec.linutronix.de> <20200519083826.GC279861@hirez.programming.kicks-ass.net>
Date:   Tue, 19 May 2020 11:06:26 +0200
Message-ID: <87ftbwuwdp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Mon, May 18, 2020 at 10:24:53PM +0200, Thomas Gleixner wrote:
> So tglx/entry-v8-full + below patch:
>
> $ make O=defconfig-build clean
> ...
> $ make CC=gcc-9 O=defconfig-build/ vmlinux -j40 -s
> vmlinux.o: warning: objtool: exc_debug()+0x158: call to trace_hwlat_timestamp() leaves .noinstr.text section
> vmlinux.o: warning: objtool: exc_nmi()+0x190: call to trace_hwlat_timestamp() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_machine_check()+0x46: call to mce_rdmsrl() leaves .noinstr.text section
> $
>
> (it really isn't defconfig, but your config-fail + DEBUG_ENTRY)
>  
> +#ifdef CONFIG_DEBUG_ENTRY
>  /* Begin/end of an instrumentation safe region */
> -#define instrumentation_begin() ({						\
> +#define instrumentation_begin() ({					\
>  	asm volatile("%c0:\n\t"						\
>  		     ".pushsection .discard.instr_begin\n\t"		\
>  		     ".long %c0b - .\n\t"				\
>  		     ".popsection\n\t" : : "i" (__COUNTER__));		\
>  })
>  
> -#define instrumentation_end() ({							\
> -	asm volatile("%c0:\n\t"						\
> +#define instrumentation_end() ({					\
> +	asm volatile("%c0: nop\n\t"					\

Bah. I fatfingered that nop out when I fixed up that noinstr wreckage.
With that added back it does was it claims to do.
