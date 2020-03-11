Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C0C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA86A2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgCKLTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:19:06 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46984 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgCKLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:19:05 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jBzO2-0019K5-FE; Wed, 11 Mar 2020 12:18:54 +0100
Message-ID: <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Date:   Wed, 11 Mar 2020 12:18:53 +0100
In-Reply-To: <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
References: <20200226004608.8128-1-trishalfonso@google.com>
         <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
         (sfid-20200306_010352_481400_662BF174) <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 11:32 +0100, Johannes Berg wrote:
> 
> I do see issues with modules though, e.g. 
> https://p.sipsolutions.net/1a2df5f65d885937.txt
> 
> where we seem to get some real confusion when lockdep is storing the
> stack trace??
> 
> And https://p.sipsolutions.net/9a97e8f68d8d24b7.txt, where something
> convinces ASAN that an address is a user address (it might even be
> right?) and it disallows kernel access to it?

I can work around both of these by not freeing the original module copy
in kernel/module.c:

        /* Get rid of temporary copy. */
//      free_copy(info);

but I really have no idea why we get this in the first place?

Another interesting data point is that it never happens on the first
module.

Also, I've managed to get a report like this:

Memory state around the buggy address:
 000000007106cf00: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 000000007106cf80: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>000000007106d000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
                   ^
 000000007106d080: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 000000007106d100: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b


which indicates that something's _really_ off with the KASAN shadow?


Ohhh ...

$ gdb -p ...
(gdb) p/x task_size
$1 = 0x7fc0000000
(gdb) p/x __end_of_fixed_addresses
$2 = 0x0
(gdb) p/x end_iomem
$3 = 0x70000000
(gdb) p/x __va_space

#define TASK_SIZE (task_size)
#define FIXADDR_TOP        (TASK_SIZE - 2 * PAGE_SIZE)

#define FIXADDR_START      (FIXADDR_TOP - FIXADDR_SIZE)
#define FIXADDR_SIZE       (__end_of_fixed_addresses << PAGE_SHIFT)

#define VMALLOC_END       (FIXADDR_START-2*PAGE_SIZE)

#define MODULES_VADDR   VMALLOC_START
#define MODULES_END       VMALLOC_END
#define VMALLOC_START ((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
#define VMALLOC_OFFSET  (__va_space)
#define __va_space (8*1024*1024)


So from that, it would look like the UML vmalloc area is from
0x  70800000 all the way to
0x7fbfffc000, which obviously clashes with the KASAN_SHADOW_OFFSET being
just 0x7fff8000.


I'm guessing that basically the module loading overwrote the kasan
shadow then?

I tried changing it

 config KASAN_SHADOW_OFFSET
        hex
        depends on KASAN
-       default 0x7fff8000
+       default 0x8000000000


and also put a check in like this:

+++ b/arch/um/kernel/um_arch.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/kmsg_dump.h>
+#include <linux/kasan.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -267,9 +268,11 @@ int __init linux_main(int argc, char **argv)
        /*
         * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
         * out
         */
        task_size = host_task_size & PGDIR_MASK;
 
+       if (task_size > KASAN_SHADOW_OFFSET)
+               panic("KASAN shadow offset must be bigger than task size");


but now I just crash accessing the shadow even though it was mapped fine?


Pid: 504, comm: modprobe Tainted: G           O      5.5.0-rc6-00009-g09462ab4014b-dirty
RIP:  
RSP: 000000006d68fa90  EFLAGS: 00010202
RAX: 000000800e0210cd RBX: 000000007010866f RCX: 00000000601a9777
RDX: 000000800e0210ce RSI: 0000000000000004 RDI: 000000007010866c
RBP: 000000006d68faa0 R08: 000000800e0210cd R09: 0000000060041432
R10: 000000800e0210ce R11: 0000000000000001 R12: 000000800e0210cd
R13: 0000000000000000 R14: 0000000000000001 R15: 00000000601c2e82
Kernel panic - not syncing: Kernel mode fault at addr 0x800e0210cd, ip 0x601c332b
CPU: 0 PID: 504 Comm: modprobe Tainted: G           O      5.5.0-rc6-00009-g09462ab4014b-dirty #24
Stack:
601c2f89 70108638 6d68fab0 601c1209
6d68fad0 601a9777 6cf2b240 7317f000
6d68fb40 601a2ae9 6f15b118 00000001
Call Trace:
? __asan_load8 (/home/tester/vlab/linux/mm/kasan/generic.c:252) 
__kasan_check_write (/home/tester/vlab/linux/mm/kasan/common.c:102) 
__free_pages (/home/tester/vlab/linux/./arch/x86/include/asm/atomic.h:125 /home/tester/vlab/linux/./include/asm-generic/atomic-instrumented.h:748 /home/tester/vlab/linux/./include/linux/page_ref.h:139 /home/tester/vlab/linux/./include/linux/mm.h:593 /home/tester/vlab/linux/mm/page_alloc.c:4823) 
__vunmap (/home/tester/vlab/linux/mm/vmalloc.c:2303 (discriminator 2)) 
? __asan_load4 (/home/tester/vlab/linux/mm/kasan/generic.c:251) 
? sysfs_create_bin_file (/home/tester/vlab/linux/fs/sysfs/file.c:537) 
__vfree (/home/tester/vlab/linux/mm/vmalloc.c:2356) 
? delete_object_full (/home/tester/vlab/linux/mm/kmemleak.c:693) 
vfree (/home/tester/vlab/linux/mm/vmalloc.c:2386) 
? sysfs_create_bin_file (/home/tester/vlab/linux/fs/sysfs/file.c:537) 
? __asan_load8 (/home/tester/vlab/linux/mm/kasan/generic.c:252) 
load_module (/home/tester/vlab/linux/./include/linux/jump_label.h:254 /home/tester/vlab/linux/./include/linux/jump_label.h:264 /home/tester/vlab/linux/./include/trace/events/module.h:31 /home/tester/vlab/linux/kernel/module.c:3927) 
? kernel_read_file_from_fd (/home/tester/vlab/linux/fs/exec.c:993) 
? __asan_load8 (/home/tester/vlab/linux/mm/kasan/generic.c:252) 
__do_sys_finit_module (/home/tester/vlab/linux/kernel/module.c:4019) 
? sys_finit_module (/home/tester/vlab/linux/kernel/module.c:3995) 
? __asan_store8 (/home/tester/vlab/linux/mm/kasan/generic.c:252) 
sys_finit_module (/home/tester/vlab/linux/kernel/module.c:3995) 
handle_syscall (/home/tester/vlab/linux/arch/um/kernel/skas/syscall.c:44) 
userspace (/home/tester/vlab/linux/arch/um/os-Linux/skas/process.c:173 /home/tester/vlab/linux/arch/um/os-Linux/skas/process.c:416) 
? save_registers (/home/tester/vlab/linux/arch/um/os-Linux/registers.c:18) 
? arch_prctl (/home/tester/vlab/linux/arch/x86/um/syscalls_64.c:65) 
? calculate_sigpending (/home/tester/vlab/linux/kernel/signal.c:200) 
? __asan_load8 (/home/tester/vlab/linux/mm/kasan/generic.c:252) 
? __asan_load8 (/home/tester/vlab/linux/mm/kasan/generic.c:252) 
? __asan_load8 (/home/tester/vlab/linux/mm/kasan/generic.c:252) 
fork_handler (/home/tester/vlab/linux/arch/um/kernel/process.c:154) 

johannes

