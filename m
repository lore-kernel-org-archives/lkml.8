Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75121C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A2320736
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgEFQIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:08:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:28209 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgEFQIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:08:32 -0400
IronPort-SDR: yrlxRYEaFP4Y3VvlTB+Q0ona/Tf3zP3fMIucSanXsqDQb1+H7ATUOBA4Gh9xl+6IXfXkVBp4nV
 8nPGA1mKELEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 09:08:31 -0700
IronPort-SDR: NU3ZhMKaIkYLN4PShP2gq588DCSUTnjimPOb+vM6IGIQSBcOMsYzAPwucL6a0CIrs/CAwSIMPK
 o4titVUmP0Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="296231988"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2020 09:08:31 -0700
Date:   Wed, 6 May 2020 09:08:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 20/36] vmlinux.lds.h: Create section for
 protection against instrumentation
Message-ID: <20200506160831.GB3329@linux.intel.com>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.075416272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134100.075416272@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:16:22PM +0200, Thomas Gleixner wrote:
> Provide also a set of markers: instr_begin()/end()
> 
> These are used to mark code inside a noinstr function which calls
> into regular instrumentable text section as safe.

...

> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -120,10 +120,27 @@ void ftrace_likely_update(struct ftrace_
>  /* Annotate a C jump table to allow objtool to follow the code flow */
>  #define __annotate_jump_table __section(.rodata..c_jump_table)
>  
> +/* Begin/end of an instrumentation safe region */
> +#define instr_begin() ({						\
> +	asm volatile("%c0:\n\t"						\
> +		     ".pushsection .discard.instr_begin\n\t"		\
> +		     ".long %c0b - .\n\t"				\
> +		     ".popsection\n\t" : : "i" (__COUNTER__));		\
> +})
> +
> +#define instr_end() ({							\
> +	asm volatile("%c0:\n\t"						\
> +		     ".pushsection .discard.instr_end\n\t"		\
> +		     ".long %c0b - .\n\t"				\
> +		     ".popsection\n\t" : : "i" (__COUNTER__));		\
> +})

Any chance we could spell these out, i.e. instrumentation_begin/end()?  I
can't help but read these as "instruction_begin/end".  At a glance, the
long names shouldn't cause any wrap/indentation issues.

E.g. some of the usage in KVM is especially confusing

--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -146,7 +146,9 @@ do {						\
 			  : : op1 : "cc" : error, fault);		\
 	return;								\
 error:									\
+	instr_begin();							\
 	insn##_error(error_args);					\
+	instr_end();							\
 	return;								\
 fault:									\
 	kvm_spurious_fault();						\
@@ -161,7 +163,9 @@ do {						\
 			  : : op1, op2 : "cc" : error, fault);		\
 	return;								\
 error:									\
+	instr_begin();							\
 	insn##_error(error_args);					\
+	instr_end();							\
 	return;								\
 fault:									\
 	kvm_spurious_fault();						\

