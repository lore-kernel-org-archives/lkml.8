Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743A9C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0152065E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgIDN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:57:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40803 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbgIDN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:57:05 -0400
Received: from [179.93.167.229] (helo=mussarela)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1kEBeg-0003nr-LX; Fri, 04 Sep 2020 13:21:27 +0000
Date:   Fri, 4 Sep 2020 10:21:21 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [LTP] [PATCH] syscall/ptrace08: Simplify the test.
Message-ID: <20200904132121.GE4768@mussarela>
References: <20200904115817.8024-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904115817.8024-1-chrubis@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 01:58:17PM +0200, Cyril Hrubis wrote:
> The original test was attempting to crash the kernel by setting a
> breakpoint on do_debug kernel function which, when triggered, caused an
> infinite loop in the kernel. The problem with this approach is that
> kernel internal function names are not stable at all and the name was
> changed recently, which made the test fail for no good reason.
> 
> So this patch changes the test to read the breakpoint address back
> instead, which also means that we can drop the /proc/kallsyms parsing as
> well.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Alexandre Chartre <alexandre.chartre@oracle.com>

Hi, Cyril.

This is failing on our 4.4 and 4.15 kernels, though they passed with the
previous test and have commit f67b15037a7a applied.

So, this is dependent on some other behavior/commit that has changed. It passes
on 5.4, for example. I'll try to investigate further.

Cascardo.

> ---
>  testcases/kernel/syscalls/ptrace/ptrace08.c | 120 ++++++++++----------
>  1 file changed, 60 insertions(+), 60 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
> index 591aa0dd2..5587f0bbb 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace08.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
> @@ -5,8 +5,17 @@
>   *
>   * CVE-2018-1000199
>   *
> - * Test error handling when ptrace(POKEUSER) modifies debug registers.
> - * Even if the call returns error, it may create breakpoint in kernel code.
> + * Test error handling when ptrace(POKEUSER) modified x86 debug registers even
> + * when the call returned error.
> + *
> + * When the bug was present we could create breakpoint in the kernel code,
> + * which shoudn't be possible at all. The original CVE caused a kernel crash by
> + * setting a breakpoint on do_debug kernel function which, when triggered,
> + * caused an infinite loop. However we do not have to crash the kernel in order
> + * to assert if kernel has been fixed or not. All we have to do is to try to
> + * set a breakpoint, on any kernel address, then read it back and check if the
> + * value has been set or not.
> + *
>   * Kernel crash partially fixed in:
>   *
>   *  commit f67b15037a7a50c57f72e69a6d59941ad90a0f0f
> @@ -26,69 +35,42 @@
>  #include "tst_safe_stdio.h"
>  
>  #if defined(__i386__) || defined(__x86_64__)
> -#define SYMNAME_SIZE 256
> -#define KERNEL_SYM "do_debug"
>  
> -static unsigned long break_addr;
>  static pid_t child_pid;
>  
> -static void setup(void)
> -{
> -	int fcount;
> -	char endl, symname[256];
> -	FILE *fr = SAFE_FOPEN("/proc/kallsyms", "r");
> -
> -	/* Find address of do_debug() in /proc/kallsyms */
> -	do {
> -		fcount = fscanf(fr, "%lx %*c %255s%c", &break_addr, symname,
> -			&endl);
> -
> -		if (fcount <= 0 && feof(fr))
> -			break;
> -
> -		if (fcount < 2) {
> -			fclose(fr);
> -			tst_brk(TBROK, "Unexpected data in /proc/kallsyms %d",
> -				fcount);
> -		}
> -
> -		if (fcount >= 3 && endl != '\n')
> -			while (!feof(fr) && fgetc(fr) != '\n');
> -	} while (!feof(fr) && strcmp(symname, KERNEL_SYM));
> -
> -	SAFE_FCLOSE(fr);
> -
> -	if (strcmp(symname, KERNEL_SYM))
> -		tst_brk(TBROK, "Cannot find address of kernel symbol \"%s\"",
> -			KERNEL_SYM);
> -
> -	if (!break_addr)
> -		tst_brk(TCONF, "Addresses in /proc/kallsyms are hidden");
> -
> -	tst_res(TINFO, "Kernel symbol \"%s\" found at 0x%lx", KERNEL_SYM,
> -		break_addr);
> -}
> +#if defined(__x86_64__)
> +# define KERN_ADDR_MIN 0xffff800000000000
> +# define KERN_ADDR_MAX 0xffffffffffffffff
> +# define KERN_ADDR_BITS 64
> +#elif defined(__i386__)
> +# define KERN_ADDR_MIN 0xc0000000
> +# define KERN_ADDR_MAX 0xffffffff
> +# define KERN_ADDR_BITS 32
> +#endif
>  
> -static void debug_trap(void)
> +static void setup(void)
>  {
> -	/* x86 instruction INT1 */
> -	asm volatile (".byte 0xf1");
> +	/*
> +	 * When running in compat mode we can't pass 64 address to ptrace so we
> +	 * have to skip the test.
> +	 */
> +	if (tst_kernel_bits() != KERN_ADDR_BITS)
> +		tst_brk(TCONF, "Cannot pass 64bit kernel address in compat mode");
>  }
>  
>  static void child_main(void)
>  {
>  	raise(SIGSTOP);
> -	/* wait for SIGCONT from parent */
> -	debug_trap();
>  	exit(0);
>  }
>  
> -static void run(void)
> +static void ptrace_try_kern_addr(unsigned long kern_addr)
>  {
>  	int status;
> -	pid_t child;
>  
> -	child = child_pid = SAFE_FORK();
> +	tst_res(TINFO, "Trying address 0x%lx", kern_addr);
> +
> +	child_pid = SAFE_FORK();
>  
>  	if (!child_pid)
>  		child_main();
> @@ -103,22 +85,41 @@ static void run(void)
>  		(void *)offsetof(struct user, u_debugreg[7]), (void *)1);
>  
>  	/* Return value intentionally ignored here */
> -	ptrace(PTRACE_POKEUSER, child_pid,
> +	TEST(ptrace(PTRACE_POKEUSER, child_pid,
>  		(void *)offsetof(struct user, u_debugreg[0]),
> -		(void *)break_addr);
> +		(void *)kern_addr));
> +
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "ptrace() breakpoint with kernel addr succeeded");
> +	} else {
> +		if (TST_ERR == EINVAL) {
> +			tst_res(TPASS | TTERRNO,
> +				"ptrace() breakpoint with kernel addr failed");
> +		} else {
> +			tst_res(TFAIL | TTERRNO,
> +				"ptrace() breakpoint on kernel addr should return EINVAL, got");
> +		}
> +	}
> +
> +	unsigned long addr;
> +
> +	addr = ptrace(PTRACE_PEEKUSER, child_pid,
> +	              (void*)offsetof(struct user, u_debugreg[0]), NULL);
> +
> +	if (addr == kern_addr)
> +		tst_res(TFAIL, "Was able to set breakpoint on kernel addr");
>  
>  	SAFE_PTRACE(PTRACE_DETACH, child_pid, NULL, NULL);
>  	SAFE_KILL(child_pid, SIGCONT);
>  	child_pid = 0;
> +	tst_reap_children();
> +}
>  
> -	if (SAFE_WAITPID(child, &status, 0) != child)
> -		tst_brk(TBROK, "Received event from unexpected PID");
> -
> -	if (!WIFSIGNALED(status))
> -		tst_brk(TBROK, "Received unexpected event from child");
> -
> -	tst_res(TPASS, "Child killed by %s", tst_strsig(WTERMSIG(status)));
> -	tst_res(TPASS, "We're still here. Nothing bad happened, probably.");
> +static void run(void)
> +{
> +	ptrace_try_kern_addr(KERN_ADDR_MIN);
> +	ptrace_try_kern_addr(KERN_ADDR_MAX);
> +	ptrace_try_kern_addr(KERN_ADDR_MIN + (KERN_ADDR_MAX - KERN_ADDR_MIN)/2);
>  }
>  
>  static void cleanup(void)
> @@ -133,7 +134,6 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.forks_child = 1,
> -	.taint_check = TST_TAINT_W | TST_TAINT_D,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "f67b15037a7a"},
>  		{"CVE", "2018-1000199"},
> -- 
> 2.26.2
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
