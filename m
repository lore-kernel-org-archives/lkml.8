Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D3C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF41120848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/UWEYcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgBLS3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:29:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37140 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:29:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so1654585pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 10:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6nkeq4IElfNcbA594NdtfjWIHWSvvy/+fIwKOGEIic=;
        b=M/UWEYcClXJt4koZZu9anY8iRjVv5/2FUz8wdqZqIeQo7O34n5l1d6mvuovcydo6dM
         Aw+Ov6OrSsPKXVE4vjgzLwxQe+bAQgeYKGxQMyxw9n45F6FMZpb3evWuHHPIUqOu9fSR
         hFmzE5LJYrZrF+3QZ+92xY3ryc1+R5VLrhyxa+ds42pdp5kxUhLjJtYiROKC2rwYRACt
         fOtjVRt5muKuWOZC9/urzfX3xIQaeoVRCecLxwVaCHL7nyALHvYqsdAQKYnYXKvfJoMf
         xCJQzYWD5AZHaQBFwxSMmCKI8nHvBhP37jtlAkIhIRClJETU/D2hd83G68ddSMYv8037
         LM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6nkeq4IElfNcbA594NdtfjWIHWSvvy/+fIwKOGEIic=;
        b=obUPNRiAopwwjTEwx4dTQRqwAdWzAViXyI7qv68FUf4BI/z9tCqAQdE+WcM+DjJzBC
         EsgMiHZieSst8l/5Q+DXB+GbJshrvWLMgZYXD9dOgtMbIMbU0hbSvo2ChEQMTiqckacG
         mjPzglwOMXz07QmEO/rRvouJgeaqV+x9W98aU8SzHjqRBdi8WTDoHTEKFVg1gXZwMqzg
         +06LWBhhkrybjjcUaZnYmQ1Vo1SDmWycuaIAhZOAYXKXRrR6GtO0jP6lyHQjkef/4/SF
         jOIWlRVZdt9BqWcDuRapGh/i8qCIxON5xoAccuNKGckBlvocuwUAuB7BJi+y5tJ7mJm1
         prNA==
X-Gm-Message-State: APjAAAUbM1j/3MGE19i/srvujaysv+K60nQIgGFfXG4xJVRT8ZO9jvGt
        IErkYBnQWrXJ4+rTViRQAjV1hAcdOhkkpXhcVDApCg==
X-Google-Smtp-Source: APXvYqxqQJWTfGcLPUJMx4ShIEteG/StOi7+XdfPZEevXxRqzMKH82zz4mTf/L39L6Tk1rySQR8hoDbbqcot2AsM1NA=
X-Received: by 2002:a62:1615:: with SMTP id 21mr9709788pfw.84.1581532161233;
 Wed, 12 Feb 2020 10:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20200212054001.GA27071@ubuntu-m2-xlarge-x86>
In-Reply-To: <20200212054001.GA27071@ubuntu-m2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Feb 2020 10:29:10 -0800
Message-ID: <CAKwvOdnTW1AjB8nVKFd9i=ur88QtEp7taT2jo8R2-FXdBzZthQ@mail.gmail.com>
Subject: Re: Status of building and booting the RISCV64 kernel with Clang
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, asb@lowrisc.org
Cc:     linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Palmer, Alex

On Tue, Feb 11, 2020 at 9:40 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> We (ClangBuiltLinux) have started looking at building the RISCV64
> kernel with clang and booting it in QEMU. I thought it would be nice to
> give some sort of status update and go over the issues we have notice
> so far and see what people's thoughts are for solving them. If this
> email is unwelcome, apologies! This testing was done with clang-11 (tip
> of tree) and QEMU 4.2.0 with this rootfs (built with
> buildroot-2019.02.9):
>
> https://github.com/nathanchance/continuous-integration/blob/21ea056022f9cf1d62b7f805c3862daf9d89736f/images/riscv/rootfs.cpio
>
>
>
> Outstanding issues on the LLVM side:
>
> 1. LLVM output over -mno-save-restore (https://github.com/ClangBuiltLinux/linux/issues/804)
>
> The kernel passes -mno-save-restore to KBUILD_CFLAGS which causes a ton
> of warning spam from LLVM:
>
> '-save-restore' is not a recognized feature for this target (ignoring feature)
>
> This has been reported upstream as https://llvm.org/pr44853 but it could
> easily be fixed in the kernel by guarding the call against
> CONFIG_CC_IS_CLANG (although this is obviously fragile if the ABI ever
> changes to -msave-restore by default).
>
> 2. -fPIC causes issues when using Clang + GNU as (https://github.com/ClangBuiltLinux/linux/issues/865)
>
> The kernel on a whole builds with -fno-integrated-as so we fall back to
> GNU as when assembling. Kernel modules are built with -fPIC and fail to
> build with a bunch of assembler errors like so (seen with binutils
> 2.31.1 and ToT):
>
> /tmp/flexfilelayout-2d0cdc.s:359: Error: bad expression
> /tmp/flexfilelayout-2d0cdc.s:359: Error: illegal operands `auipc a0,%got_pcrel_hi(mem_map)'
> /tmp/flexfilelayout-2d0cdc.s:367: Error: bad expression
> /tmp/flexfilelayout-2d0cdc.s:367: Error: illegal operands `auipc a2,%got_pcrel_hi(pfn_base)'
> /tmp/flexfilelayout-2d0cdc.s:374: Error: bad expression
> /tmp/flexfilelayout-2d0cdc.s:374: Error: illegal operands `auipc a3,%got_pcrel_hi(va_pa_offset)'
>
> This has been reported upstream as https://llvm.org/pr44854. The way to
> work around this in the kernel is to just disable CONFIG_MODULES (which
> is a big hammer but that obviously won't be sent upstream in any form).
>
>
>
>
> Outstanding issues on the kernel side:
>
> 1. -Wuninitialized warnings around local register variables
>
> There are a few warnings around local "register" variables, which are
> uninitialized when using clang:
>
> In file included from ../arch/riscv/kernel/asm-offsets.c:10:
> In file included from ../include/linux/sched.h:12:
> ../arch/riscv/include/asm/current.h:30:9: warning: variable 'tp' is uninitialized when used here [-Wuninitialized]
>         return tp;
>                ^~
> ../arch/riscv/include/asm/current.h:29:33: note: initialize the variable 'tp' to silence this warning
>         register struct task_struct *tp __asm__("tp");
>                                        ^
>                                         = NULL
> 1 warning generated.
>
> ../arch/riscv/kernel/process.c:112:19: warning: variable 'gp' is uninitialized when used here [-Wuninitialized]
>                 childregs->gp = gp;
>                                 ^~
> ../arch/riscv/kernel/process.c:110:34: note: initialize the variable 'gp' to silence this warning
>                 const register unsigned long gp __asm__ ("gp");
>                                                ^
>                                                 = 0
> 1 warning generated.
>
> ../arch/riscv/kernel/stacktrace.c:34:8: warning: variable 'current_sp' is uninitialized when used here [-Wuninitialized]
>                 sp = current_sp;
>                      ^~~~~~~~~~
> ../arch/riscv/kernel/stacktrace.c:32:42: note: initialize the variable 'current_sp' to silence this warning
>                 const register unsigned long current_sp __asm__ ("sp");
>                                                        ^
>                                                         = 0
> 1 warning generated.
>
> The way to solve these is to make these register variables global, where
> they are properly initialized and work. This has been done in the kernel
> a few times:
>
> fe92da0f355e ("MIPS: Changed current_thread_info() to an equivalent supported by both clang and GCC")
> 3337a10e0d0c ("arm64: LLVMLinux: Add current_stack_pointer() for arm64")
> 786248705ecf ("arm64: LLVMLinux: Calculate current_thread_info from current_stack_pointer")
> 0abc08baf2dd ("ARM: 8170/1: Add global named register current_stack_pointer for ARM")
> f6c9cbf091a4 ("ARM: 8173/1: Calculate current_thread_info from current_stack_pointer")
>
> The LLVM community has rejected adopting GCC's behavior of allowing
> local register variables because it would seriously complicate the
> register allocator; the full discussion can be viewed here:
> http://lists.llvm.org/pipermail/llvm-dev/2014-March/071472.html
>
> This is the diff I am currently working with; I am not sure of any side
> effects aside from two that I will list below.
>
> https://gist.github.com/b5fda253a243127736fd2ac5d317dcdd
>
>
>
> Booting in QEMU:
>
> This is where things get interesting... The kernel does not start at all
> when the registers are purely local. It does start when the tp register
> is moved globally (arch/riscv/include/asm/current.h diff above) but it
> does not finish getting to userspace. Additionally, the diff in
>  -s ARCH=riscv CC=clang CROSS_COMPILE=riscv64-linux-gnu- O=out.riscv distclean defconfig all
> ...
> $ timeout 30s qemu-system-riscv64 -M virt -m 512M -no-reboot -bios default -kernel out.riscv/arch/riscv/boot/Image -display none -serial mon:stdio -initrd out.riscv/rootfs.cpio
> ...
> [    0.000000] Linux version 5.6.0-rc1-00001-g90c81dfc010e (nathan@ubuntu-m2-xlarge-x86) (ClangBuiltLinux clang version 11.0.0 (git://github.com/llvm/llvm-project 9c1a88c96457ffde71f13c74fd4d52a77d86cc9f)) #1 SMP Tue Feb 11 22:13:03 MST 2020
> ...
> [    0.624295] Run /init as init process
> /init: exec: line 7: /sbin/init: Text file busy
> [    0.712090] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000200
> [    0.712739] CPU: 0 PID: 1 Comm: init Not tainted 5.6.0-rc1-00001-g90c81dfc010e #1
> [    0.713228] Call Trace:
> [    0.713508] [<ffffffe00004a3e6>] walk_stackframe+0x0/0xc6
> [    0.713832] [<ffffffe0007c0070>] dump_stack+0x9e/0xd6
> [    0.714112] [<ffffffe00004f250>] panic+0x112/0x2dc
> [    0.714387] [<ffffffe000051886>] exit_mm+0x0/0x12a
> [    0.714676] [<ffffffe000051a80>] sys_exit_group+0x0/0xe
> [    0.714965] [<ffffffe000051aa4>] __wake_up_parent+0x0/0x24
> [    0.715262] [<ffffffe000051a8e>] __do_sys_exit_group+0x0/0x16
> [    0.715568] [<ffffffe000048e3e>] ret_from_syscall+0x0/0x2
> [    0.716409] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000200 ]---
> qemu-system-riscv64: terminating on signal 15 from pid 55965 (timeout)
>
> GCC 9.2.0 works just fine.
>
> $ make -j$(nproc) -s ARCH=riscv CROSS_COMPILE=riscv64-linux- O=out.riscv distclean defconfig all
> $ timeout 30s qemu-system-riscv64 -M virt -m 512M -no-reboot -bios default -kernel out.riscv/arch/riscv/boot/Image -display none -serial mon:stdio -initrd out.riscv/rootfs.cpio
> ...
> [    0.634854] Run /init as init process
> Starting syslogd: OK
> Starting klogd: OK
> Initializing random number generator... [    1.329410] random: dd: uninitialized urandom read (512 bytes read)
> done.
> Starting network: OK
> Linux version 5.6.0-rc1-00001-g90c81dfc010e (nathan@ubuntu-m2-xlarge-x86) (gcc version 9.2.0 (GCC)) #1 SMP Tue Feb 11 22:20:36 MST 2020
> Linux version 5.6.0-rc1-00001-g90c81dfc010e (nathan@ubuntu-m2-xlarge-x86) (gcc version 9.2.0 (GCC)) #1 SMP Tue Feb 11 22:20:36 MST 2020
> Stopping network: OK
> Saving random seed... [    2.165960] random: dd: uninitialized urandom read (512 bytes read)
> done.
> Stopping klogd: OK
> Stopping syslogd: OK
> umount: devtmpfs busy - remounted read-only
> umount: can't unmount /: Invalid argument
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system poweroff
> [    4.412388] reboot: Power down
>
> I have tried to do some debugging in gdb to see where things are going
> wrong and I see it get to run_init_process, succeed, then jump to the
> exception handler and panic so I am not really sure where things are
> going wrong. Any sort of ideas on where to go from here would certainly
> be appreciated :)
>
> Thanks for all the hard work everyone has done, hopefully we can help
> add to it!
>
> Cheers,
> Nathan
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200212054001.GA27071%40ubuntu-m2-xlarge-x86.



-- 
Thanks,
~Nick Desaulniers
