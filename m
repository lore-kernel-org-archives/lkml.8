Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185FDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8892073E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgENKdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:33:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34615 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENKdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:33:04 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZBAi-0000rK-CJ; Thu, 14 May 2020 10:33:00 +0000
Date:   Thu, 14 May 2020 12:32:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Message-ID: <20200514103259.tdfjc5ds4igpmoxj@wittgenstein>
References: <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
 <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
 <20200514074606.vkc35syhdep23rzh@wittgenstein>
 <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
 <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
 <20200514100459.pt7dxq2faghdds2c@wittgenstein>
 <2e22b0d2-b9ce-420d-48a0-0d9134108a5c@physik.fu-berlin.de>
 <20200514101540.25hvle74w63t66fs@wittgenstein>
 <20200514101914.fu7xhgaxtb5fy2ky@wittgenstein>
 <4aad9ad5-b0e9-12b0-0ad2-ac23fceae87b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aad9ad5-b0e9-12b0-0ad2-ac23fceae87b@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:21:13PM +0200, John Paul Adrian Glaubitz wrote:
> On 5/14/20 12:19 PM, Christian Brauner wrote:
> > Scratch that. It's even worse. On ia64 it is _invalid_ to pass a NULL
> > stack. That's at least what the glibc assembly assumes:
> > 
> > 	cmp.eq p6,p0=0,in0
> > 	cmp.eq p7,p0=0,in1
> > 	mov r8=EINVAL
> > 	mov out0=in3		/* Flags are first syscall argument.	*/
> > 	mov out1=in1		/* Stack address.			*/
> > (p6)	br.cond.spnt.many __syscall_error	/* no NULL function pointers */
> > (p7)	br.cond.spnt.many __syscall_error	/* no NULL stack pointers */
> > 	;;
> > 	mov out2=in2		/* Stack size.				*/
> > 
> > so newer systemd just works by accident on ia64 if at all correctly
> > afaict.
> 
> Hmm, interesting. I really wasn't aware of that. Thanks for the heads-up.
> 
> I'll ask Michael whether he can come up for a solution for that problem.
> 
> Maybe that's also why systemd crashes.

Do you have a very minimalistic ia64 userspace preferably without systemd where
you could simply test. That should give us an idea whether things work:

#define _GNU_SOURCE
#include <sys/wait.h>
#include <sys/utsname.h>
#include <sched.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

#define STACK_SIZE (8 * 1024 * 1024) /* standard stack size for threads in glibc */

int main(int argc, char *argv[])
{
	char *stack;
        pid_t pid;

	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
	if (stack == MAP_FAILED)
		exit(EXIT_FAILURE);

        /* 
	 * Note that legacy clone() has different argument ordering on
         * different architectures so this won't work everywhere.
         */
        pid = syscall(189 /* __NR_clone2 */, SIGCHLD, stack, STACK_SIZE, NULL, NULL);
        if (pid < 0)
                exit(EXIT_FAILURE);
        if (pid == 0)
                exit(EXIT_SUCCESS);
        if (wait(NULL) != pid)
                exit(EXIT_FAILURE);

        exit(EXIT_SUCCESS);
}
