Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35947C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095302074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIDP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:28:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgIDP2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:28:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97B0CACBA;
        Fri,  4 Sep 2020 15:28:11 +0000 (UTC)
Subject: Re: [LTP] [PATCH v2] syscall/ptrace08: Simplify the test.
To:     Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200904140931.10153-1-chrubis@suse.cz>
From:   Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
Message-ID: <5d127ee5-56d1-01c5-c364-dcb004204e9d@suse.cz>
Date:   Fri, 4 Sep 2020 17:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904140931.10153-1-chrubis@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
looks good and the test passes on older fixed kernels. Just one
compatibility issue below. Otherwise:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 04. 09. 20 16:09, Cyril Hrubis wrote:
> The original test was attempting to crash the kernel by setting a
> breakpoint on do_debug kernel function which, when triggered, caused an
> infinite loop in the kernel. The problem with this approach is that
> kernel internal function names are not stable at all and the name was
> changed recently, which made the test fail for no good reason.
> 
> The original kernel fix made it however poissible to set a kernel
> address as a breakpoint and instead disabled the breakpoint on userspace
> modification. The error checks were deffered to write to the dr7 that
> enabled the breakpoint again.
> 
> So on newer kernels we do not allow to set the breakpoint to the kernel
> addres at all, which means that the POKEUSR to dr0 has to fail with an
> address in a kernel range and also we read back the breakpoint address
> and check that it wasn't set just to be sure.
> 
> On older kernels we check that the POKEUSER to dr7 that enables the
> breakpoint fails properly after the dr0 has been set to an address in
> the kernel range.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace08.c | 136 +++++++++++---------
>  1 file changed, 76 insertions(+), 60 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
> index 591aa0dd2..1b84ce376 100644
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
> @@ -26,69 +35,54 @@
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
> -	tst_res(TINFO, "Kernel symbol \"%s\" found at 0x%lx", KERNEL_SYM,
> -		break_addr);
> -}
> +static int deffered_check;
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
> +
> +
> +	/*
> +	 * The original fix for the kernel haven't rejected the kernel address
> +	 * right away when breakpoint was modified from userspace it was
> +	 * disabled and the EINVAL was returned when dr7 was written to enable
> +	 * it again.
> +	 */
> +	if (tst_kvercmp(4, 17, 0) < 0)
> +		deffered_check = 1;
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
> @@ -102,23 +96,46 @@ static void run(void)
>  	SAFE_PTRACE(PTRACE_POKEUSER, child_pid,
>  		(void *)offsetof(struct user, u_debugreg[7]), (void *)1);
>  
> -	/* Return value intentionally ignored here */
> -	ptrace(PTRACE_POKEUSER, child_pid,
> +	TEST(ptrace(PTRACE_POKEUSER, child_pid,
>  		(void *)offsetof(struct user, u_debugreg[0]),
> -		(void *)break_addr);
> +		(void *)kern_addr));
> +
> +	if (deffered_check) {
> +		TEST(ptrace(PTRACE_POKEUSER, child_pid,
> +			(void *)offsetof(struct user, u_debugreg[7]), (void *)1));
> +	}
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

AFAICT, we're not compiling with --std=c99 so older compilers may
complain about the variable declaration here.

> +
> +	addr = ptrace(PTRACE_PEEKUSER, child_pid,
> +	              (void*)offsetof(struct user, u_debugreg[0]), NULL);
> +
> +	if (!deffered_check && addr == kern_addr)
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
> @@ -133,7 +150,6 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.forks_child = 1,
> -	.taint_check = TST_TAINT_W | TST_TAINT_D,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "f67b15037a7a"},
>  		{"CVE", "2018-1000199"},
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
