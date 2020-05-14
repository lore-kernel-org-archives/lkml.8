Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F60206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgENKFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:05:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33589 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgENKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:05:09 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZAjc-0006mz-HX; Thu, 14 May 2020 10:05:00 +0000
Date:   Thu, 14 May 2020 12:04:59 +0200
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
Message-ID: <20200514100459.pt7dxq2faghdds2c@wittgenstein>
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
 <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
 <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
 <20200514074606.vkc35syhdep23rzh@wittgenstein>
 <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
 <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 11:48:31AM +0200, John Paul Adrian Glaubitz wrote:
> 
> 
> On 5/14/20 9:53 AM, John Paul Adrian Glaubitz wrote:
> > The kernel is currently building, you should get it by the evening (CEST).
> > 
> > The machine also serves as a Debian buildd which is why it's a bit more
> > busy than other servers.
> I applied the patch against 5.7-rc5, it applied fine and builds fine.
> 
> It seems though that systemd crashes but I'm not sure it's related:
> 
> [   14.267489] init[1]: General Exception: IA-64 Reserved Register/Field fault (data access) 2199023255600 [1]                     
> [   14.267489] Modules linked in:                                                                                                  
> [   14.267489]                                                                                                                     
> [   14.267489] CPU: 0 PID: 1 Comm: init Not tainted 5.7.0-rc5 #1                                                                   
> [   14.267489] Hardware name: hp server BL860c                   , BIOS 04.25                                                            07/02/2010                                                                                                                   
> [   14.267489] psr : 0000121008526030 ifs : 8000000000000510 ip  : [<a00000010000c541>]    Not tainted (5.7.0-rc5)                 
> [   14.267489] ip is at sys_clone2+0x61/0x80                                                                                       
> [   14.267489] unat: 0000000000000000 pfs : 0000000000000510 rsc : 0000000000000003                                                
> [   14.267489] rnat: 0000000000000000 bsps: 0000000000000000 pr  : 000000000001a959                                                
> [   14.267489] ldrs: 0000000000000000 ccv : 0000000000000002 fpsr: 0009804c8a70033f                                                
> [   14.267489] csd : 0000000000000000 ssd : 0000000000000000                                                                       
> [   14.267489] b0  : a00000010000c540 b6  : a0000001000edf80 b7  : a000000100369560                                                
> [   14.267489] f6  : 1003e000000000000b8a4 f7  : 1003e00000001754e8d69                                                             
> [   14.267489] f8  : 1003e0000000178311d69 f9  : 100098000000000000000
> [   14.267489] f10 : 1000eb8a3fffff475c000 f11 : 1003e000000000000b8a4
> [   14.267489] r1  : a0000001017a6f10 r2  : 0000000000000000 r3  : 0000000000000006
> [   14.267489] r8  : 0000000000000066 r9  : 0000000000000060 r10 : e0000100800d8e68
> [   14.267489] r11 : 0000000000000002 r12 : e00001008027fe30 r13 : e000010080278000
> [   14.267489] r14 : e0000100800d8e04 r15 : e0000100800d8e08 r16 : 0000000000000002
> [   14.267489] r17 : 0000000000000001 r18 : 0000000000000002 r19 : 0000000000000003
> [   14.267489] r20 : 0000000000000004 r21 : e00001008027fb98 r22 : e000000001146d02
> [   14.267489] r23 : 00000000000030c8 r24 : 00000000000030c8 r25 : 00000000000030ca
> [   14.267489] r26 : 00000000000030ca r27 : 00000000000030ca r28 : e00001008027fb90
> [   14.267489] r29 : 0000000000000400 r30 : 00000000000002e8 r31 : 0000000000000400
> [   14.267489] 
> [   14.267489] Call Trace:
> [   14.267489]  [<a000000100015090>] show_stack+0x90/0xc0
> [   14.267489]                                 sp=e00001008027f9f0 bsp=e000010080279288
> [   14.267489]  [<a000000100015780>] show_regs+0x6c0/0xa20
> [   14.267489]                                 sp=e00001008027fbc0 bsp=e000010080279218
> [   14.267489]  [<a000000100029590>] die+0x1b0/0x4a0
> [   14.267489]                                 sp=e00001008027fbe0 bsp=e0000100802791d0
> [   14.267489]  [<a00000010100e690>] ia64_fault+0x770/0xd80
> [   14.267489]                                 sp=e00001008027fbe0 bsp=e000010080279180
> [   14.267489]  [<a00000010000ce60>] ia64_leave_kernel+0x0/0x270
> [   14.267489]                                 sp=e00001008027fc60 bsp=e000010080279180
> [   14.267489]  [<a00000010000c540>] sys_clone2+0x60/0x80
> [   14.267489]                                 sp=e00001008027fe30 bsp=e000010080279100
> [   14.267489] Disabling lock debugging due to kernel taint
> [   14.267489] init[102]: General Exception: IA-64 Reserved Register/Field fault (data access) 4398046511152 [2]
> [   14.350730] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>     [1 4 . 31540.733500]7 3-0-]- [- -e-n[d  eKnedr nKeelr npealn pani[c   -  1n4o.t2 6s7y4n8c9i]n g:
> :Attem [D      1 4 . 2 6 7 4 8 95]. 7C.P0U-:r c15  P#I1D
> i e1=002x 0C0o0m0m0:0 0ibn i]t- -T-a
>  nted: G      D           5.7.0-rc5 #1
> 
> I have to perform more testing. The machine boots fine with a 5.5.x kernel.

So that's interesting because systemd doesn't support itanium correctly afaict.
They have a raw_clone() function that they use which is not tailored to
ia64. __NR_clone should be defined as so to hit clone2() but they don't
pass a stack size argument down which is invalid on ia64:

static inline pid_t raw_clone(unsigned long flags) {
        pid_t ret;

        assert((flags & (CLONE_VM|CLONE_PARENT_SETTID|CLONE_CHILD_SETTID|
                         CLONE_CHILD_CLEARTID|CLONE_SETTLS)) == 0);
#if defined(__s390x__) || defined(__s390__) || defined(__CRIS__)
        /* On s390/s390x and cris the order of the first and second arguments
         * of the raw clone() system call is reversed. */
        ret = (pid_t) syscall(__NR_clone, NULL, flags);
#elif defined(__sparc__)
        {
                /**
                 * sparc always returns the other process id in %o0, and
                 * a boolean flag whether this is the child or the parent in
                 * %o1. Inline assembly is needed to get the flag returned
                 * in %o1.
                 */
                int in_child, child_pid, error;

                asm volatile("mov %3, %%g1\n\t"
                             "mov %4, %%o0\n\t"
                             "mov 0 , %%o1\n\t"
#if defined(__arch64__)
                             "t 0x6d\n\t"
#else
                             "t 0x10\n\t"
#endif
                             "addx %%g0, 0, %2\n\t"
                             "mov %%o1, %0\n\t"
                             "mov %%o0, %1" :
                             "=r"(in_child), "=r"(child_pid), "=r"(error) :
                             "i"(__NR_clone), "r"(flags) :
                             "%o1", "%o0", "%g1", "cc" );

                if (error) {
                        errno = child_pid;
                        ret = -1;
                } else
                        ret = in_child ? 0 : child_pid;
        }
#else
        ret = (pid_t) syscall(__NR_clone, flags, NULL);
#endif

        if (ret == 0)
                reset_cached_pid();

        return ret;
}
