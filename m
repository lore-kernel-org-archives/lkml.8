Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8B02054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Jb8rfLuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgEMXMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:12:20 -0400
Received: from mail.efficios.com ([167.114.26.124]:57662 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgEMXMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:12:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 753182BF375;
        Wed, 13 May 2020 19:12:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UiHRjGkxNO5V; Wed, 13 May 2020 19:12:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 05F232BF374;
        Wed, 13 May 2020 19:12:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 05F232BF374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589411537;
        bh=vT+BKs1PsOs1DwnO35m9CtzYZM/crhc3i3CUt4TuVIg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Jb8rfLuMigDJ/hlp8JnP9hGrf6As+5OrL0P7keRxLVPunppX8uwNLVUt3CZ+UUt0S
         1/oknTWyiXpXRS8HJIkg06pkNyBikhpFFsLeS665/BmdVEJc3KIzeBj3enr6QLbkv3
         iAPD3iQKW0prygVqTJhFsNanxtb1eAa9/LXRAvdc9cN5N58cY9PYUnHy4LZ1EfVxkn
         Inm6/jla2utARwzJS1YctB+lqIXCH9780UYCkVICJz8dH/OpmMdhDqUJ1vCXimDV0B
         6yLw/vUYEg9btfndeIQ/DkxTy8kJPUZXJyo1dPwL5uvurNxuMiYk5GFBo6iXGNe4jg
         FJ2twfzLy3aBA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1Z4VmZZL1zJO; Wed, 13 May 2020 19:12:16 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E7E912BF5D1;
        Wed, 13 May 2020 19:12:16 -0400 (EDT)
Date:   Wed, 13 May 2020 19:12:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Message-ID: <2135402885.20156.1589411536924.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134100.376598577@linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134100.376598577@linutronix.de>
Subject: Re: [patch V4 part 1 23/36] bug: Annotate WARN/BUG/stackfail as
 noinstr safe
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: Annotate WARN/BUG/stackfail as noinstr safe
Thread-Index: VxeXEf8ul4BHrsH8C9lKALhiviNJKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:

> Warnings, bugs and stack protection fails from noinstr sections, e.g. low
> level and early entry code, are likely to be fatal.
> 
> Mark them as "safe" to be invoked from noinstr protected code to avoid
> annotating all usage sites. Getting the information out is important.

Why instrument at the x86 level (and miss other architectures) when this
could perhaps be done directly in the macro WARN_ON_ONCE(condition) in
generic code ?

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> arch/x86/include/asm/bug.h |    3 +++
> include/asm-generic/bug.h  |    9 +++++++--
> kernel/panic.c             |    4 +++-
> 3 files changed, 13 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -70,13 +70,16 @@ do {									\
> #define HAVE_ARCH_BUG
> #define BUG()							\
> do {								\
> +	instr_begin();						\
> 	_BUG_FLAGS(ASM_UD2, 0);					\
> 	unreachable();						\
> } while (0)
> 
> #define __WARN_FLAGS(flags)					\
> do {								\
> +	instr_begin();						\
> 	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
> +	instr_end();						\
> 	annotate_reachable();					\
> } while (0)

riscv, arm64, s390, powerpc, parisc and sh also have __WARN_FLAGS.

> 
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -83,14 +83,19 @@ extern __printf(4, 5)
> void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
> 		       const char *fmt, ...);
> #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
> -#define __WARN_printf(taint, arg...)					\
> -	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
> +#define __WARN_printf(taint, arg...) do {				\
> +		instr_begin();						\
> +		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
> +		instr_end();						\
> +	} while (0)
> #else
> extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
> #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
> #define __WARN_printf(taint, arg...) do {				\
> +		instr_begin();						\
> 		__warn_printk(arg);					\
> 		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
> +		instr_end();						\
> 	} while (0)
> #define WARN_ON_ONCE(condition) ({				\

Moving the instr_begin/end here should fix it ?

Thanks,

Mathieu

> 	int __ret_warn_on = !!(condition);			\
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -662,10 +662,12 @@ device_initcall(register_warn_debugfs);
>  * Called when gcc's -fstack-protector feature is used, and
>  * gcc detects corruption of the on-stack canary value
>  */
> -__visible void __stack_chk_fail(void)
> +__visible noinstr void __stack_chk_fail(void)
> {
> +	instr_begin();
> 	panic("stack-protector: Kernel stack is corrupted in: %pB",
> 		__builtin_return_address(0));
> +	instr_end();
> }
>  EXPORT_SYMBOL(__stack_chk_fail);

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
