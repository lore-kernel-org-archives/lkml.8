Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC168C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2642074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OPGPSH4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgFJWtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:49:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:46595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgFJWtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591829368;
        bh=j3hC4oAUXZOBfrkW+scqzZaZRl6WUmjs0P8oOgWJjik=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=OPGPSH4E6lDtSLkEBMv0vFyL0RrwHQHrKnC3GkcsBQi01kCmhRBy4xZ4T3GH4IBsP
         0SAnUYpa1j+TGcBpm/vdL4mKatnwDsJcKnfwAFWivjpSQ+ESQaln5g6/c6wYp8Ng8l
         3iYvaNzDn6pUoc14lNw5FfnNaTYpVbVdMRdI0dNU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([178.9.97.46]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1j4ZVs0k84-00lRL7; Thu, 11
 Jun 2020 00:49:28 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87bln7ves7.fsf@gmx.net>
        <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
        <87v9l65d2y.fsf@gmx.net>
        <20200513220428.4nksinis2qs5dtmh@linutronix.de>
        <87mu6aurfn.fsf@gmx.net>
        <20200522164012.ynyvrjompv42jtmx@linutronix.de>
        <87y2owwo2o.fsf@rub.de>
        <20200609202339.cgy57twm2zdtjhje@linutronix.de>
        <87tuzjcovq.fsf@gmx.net>
        <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
Date:   Thu, 11 Jun 2020 00:49:26 +0200
In-Reply-To: <20200610102514.4vdzu5u7d6vnpicn@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Wed, 10 Jun 2020 12:25:14 +0200")
Message-ID: <87imfyh6yx.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Provags-ID: V03:K1:nhyg7hR1YpDpFMuOKpCP6yF19SKTqdw6qMXghZw69swK2TzHuKf
 /iEPMAPcFvy8ApJll00ZO4OwxUjA08xavvp8iqI8kPPyKplSJO1U6GnjkYsas/4MF3VTVnx
 9JFPlPHFzYGRA5HqSmnuf2RcVToiUqZxHAc1gzAJkiTMOSUYxfmBdWxbRPf+JW6FgBkxs2R
 HRUepZaGot4iv0TxwUpTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JTcjI7HRyi8=:St9JE24hf+Ur1ujuwxgknE
 rb9FFo1gnBlRAhRDUdUNyVH0OISXMamxc/LbhPu+ZlLZ9rJ66bqsu7RneM5CbmBGI48UzBWZX
 UugZ3dvqa+xi0KovE8ekL3o7UawhluWdNRPMckSXQaLQ73KvXTEdvvLHfvWPrIUzLsRh6KTKl
 voOQRuM9+UOMieD3XVQf4B6Tb0agUFmENvRM2xQGBXbH2zpglUxfYGJfXKwgVwV3Ghhy1o1VG
 LXAF/JZXJ8K+vJmgxjwsni8I5HvBRS4BSnOil9LPrkCOa97h4qmNJUMvyCaBV0ZJxQd47lGN0
 ajZYBSSaAsIYHua1MV8z+NxrsjyRbEd0GMW7Do+sYzLV4yuV0s8p0Cx1klGa2zgaau5SDkmUP
 JayuBYfm8bY+87tkONaY+vmNoQdZddhkVLLay3PbmeuhVHCO6lnT/t/WwZ25rfQUp9w6UuLqa
 W4lwXjdk1m6Ije07fHlrxOgObf4JQBQFsyQzv9hyVYnGGr+gab0aBCIh7omjbMqths4vPLKCB
 DpbO3hzNs5VHencWNy//Y4cZg+75svuWq0bYZxlT2JSCcgwEY4Kx++23IK7hhzhb+gXfLcyqE
 ZKRdnnzVa4U1AsBpvX/a9mvys1AkAYSmZoUxGl8Zg1VG65OcJ5DWiZfQ880lcEsuwO+OG2qKl
 YdKYGGDD2E1D2dY2o0Zt6B8ziadAMBKl578XGoDEJts+9kDS0pg6N4RnT3XJWMjKccz81EKre
 Jj+MpGbcNK1BKTYubbXnXfTaYC1SUoFMiFENBte0/XSHLQhOxSdQtZFU8ZX1hDAP/rDZ5Nnri
 vubs2SC7ksiw8eHyTEU+JrP1XbmbnQxVc+s5bb34LEcywXmvtkW70dMTpst4itAiY7EwA3OhE
 szZwgBnkTu7V580a6VS/PP0X+o1avyUmx+zdQJ22PKSPxTuvRo8Z/Juu+fh0jESFNTWyIr8Il
 rzargWi7RGhaiYhZk9qlJ2r1gJdEwjqsnE/WmoYEGEzyuvEzWz69H/8KKyc/KeYgZZU94Q+Lj
 /23xQxweuNPqGeMznFBiY0lYrP+FEEmlkSaZh8JEMqOq3i81xE6Lay7i8iDg32i+Pe//liRm+
 M9N56SY+5oWATf+r3pVCr4Kg2K+2LgWLn9erK8gxEZvQGwpoOCohsOWKUS5L6B9PHXkcyzVkA
 63P9a0fVX2awSHmsEy3wIuu17XfIsZ5SToRvbyPjuPFl+y/aJvSwhimZN8Te9Od7rk1zxRYch
 XAY8hDatyELLIXX+6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2020 12:25:14 +0200 Sebastian Andrzej Siewior <bigeasy@linu=
tronix.de> wrote:

> On 2020-06-10 10:21:29 [+0200], Stephen Berman wrote:
>> (GMX put your email into my spam folder, so I didn't see it before I
>> sent my followup about removing the wifi firmware.)
>
> okay.
>
>> On Tue, 9 Jun 2020 22:23:39 +0200 Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>> >   scripts/decode_stacktrace.sh vmlinux $(pwd)/ kernel_power_off+0x3d/=
0x70
>> >
>> > should reveal that.
>>
>> I saved the call trace lines to a file and did this (with `$(pwd)/' the
>> script did not run):
>>
>> steve [ /sources/linux-5.6.4 ]$ ./scripts/decode_stacktrace.sh vmlinux
>> . kernel_power_off+0x3d/0x70 < /home/steve/temp/call_trace
>> [1352.***] Call Trace:
>> [1352.***] ? __schedule (core.c:?)
>> [1352.***] schedule (??:?)
>> [1352.***] schedule_timeout (??:?)
>> [1352.***] ? acpi_os_release_object (??:?)
>> [1352.***] ? acpi_ut_update_object_reference (??:?)
>> [1352.***] wait_for_completion (??:?)
>> [1352.***] ? wake_up_q (??:?)
>> [1352.***] flush_workqueue (??:?)
>> [1352.***] kernel_power_off (??:?)
>> [1352.***] __do_sys_reboot (reboot.c:?)
>> [1352.***] ? do_send_sig_info (??:?)
>> [1352.***] ? kill_pid_info (??:?)
>> [1352.***] ? kill_something_info (signal.c:?)
>> [1352.***] ? __x64_sys_kill (??:?)
>> [1352.***] do_syscall_64 (??:?)
>> [1352.***] entry_SYSCALL_64_after_hwframe (??:?)
>> [1352.***] RIP: 0033:0x7f95dd6992c3
>> [1352.***] Code: Bad RIP value.
>> objdump: '/tmp/tmp.BlpNDdSQpG.o': No such file
>>
>> Did I do something wrong or do I need to pass certain compiler flags
>> when building the kernel (when I build Emacs I pass CFLAGS=3D'-Og -g3')=
?
>
> the arguments last argument should not be kernel_power_off+0x3d/0x70. I
> should have been entered after "enter" but you can also pipe the whole
> file as you did.
> If it gives you the ?? then might need
>   CONFIG_DEBUG_INFO

Thanks.  I set that, recompiled and now get this:


--=-=-=
Content-Type: application/text/plain
Content-Disposition: attachment; filename=decode_stacktrace
Content-Transfer-Encoding: quoted-printable

steve [ /sources/linux-5.6.4 ]$ ./scripts/decode_stacktrace.sh vmlinux $(pw=
d)/ < /home/steve/temp/call_trace
[1352.***] Call Trace:
[1352.***] ? __schedule (/sources/linux-5.6.4/kernel/sched/core.c:3380 /sou=
rces/linux-5.6.4/kernel/sched/core.c:4080)=20
[1352.***] schedule (/sources/linux-5.6.4/./arch/x86/include/asm/bitops.h:2=
07 (discriminator 1) /sources/linux-5.6.4/./include/asm-generic/bitops/inst=
rumented-non-atomic.h:111 (discriminator 1) /sources/linux-5.6.4/./include/=
linux/thread_info.h:84 (discriminator 1) /sources/linux-5.6.4/./include/lin=
ux/sched.h:1820 (discriminator 1) /sources/linux-5.6.4/kernel/sched/core.c:=
4156 (discriminator 1))=20
[1352.***] schedule_timeout (/sources/linux-5.6.4/kernel/time/timer.c:1872)=
=20
[1352.***] ? acpi_os_release_object (/sources/linux-5.6.4/drivers/acpi/osl.=
c:1698)=20
[1352.***] ? acpi_ut_update_object_reference (/sources/linux-5.6.4/drivers/=
acpi/acpica/utdelete.c:631)=20
[1352.***] wait_for_completion (/sources/linux-5.6.4/./include/linux/spinlo=
ck.h:363 /sources/linux-5.6.4/kernel/sched/completion.c:84 /sources/linux-5=
.6.4/kernel/sched/completion.c:104 /sources/linux-5.6.4/kernel/sched/comple=
tion.c:115 /sources/linux-5.6.4/kernel/sched/completion.c:136)=20
[1352.***] ? wake_up_q (/sources/linux-5.6.4/kernel/sched/core.c:4348)=20
[1352.***] flush_workqueue (/sources/linux-5.6.4/kernel/workqueue.c:2831)=20
[1352.***] kernel_power_off (/sources/linux-5.6.4/kernel/reboot.c:292)=20
[1352.***] __do_sys_reboot (/sources/linux-5.6.4/kernel/reboot.c:366)=20
[1352.***] ? do_send_sig_info (/sources/linux-5.6.4/kernel/signal.c:1295)=20
[1352.***] ? kill_pid_info (/sources/linux-5.6.4/kernel/signal.c:1447)=20
[1352.***] ? kill_something_info (/sources/linux-5.6.4/kernel/signal.c:1562=
)=20
[1352.***] ? __x64_sys_kill (/sources/linux-5.6.4/kernel/signal.c:3639)=20
[1352.***] do_syscall_64 (/sources/linux-5.6.4/arch/x86/entry/common.c:294)=
=20
[1352.***] entry_SYSCALL_64_after_hwframe (/sources/linux-5.6.4/arch/x86/en=
try/entry_64.S:184)=20
[1352.***] RIP: 0033:0x7f95dd6992c3
[1352.***] Code: Bad RIP value.
objdump: '/tmp/tmp.AjlgcOiArF.o': No such file

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[1352.***] RSP: 002b:00007ffc4a3e4b88 EFLAGS: 00000202 ORIG_RAX: 0000000000=
0000a9
[1352.***] RAX: ffffffffffffffda RBX: 00007ffc4a3e4cd8 RCX: 00007f95dd6992c3
[1352.***] RDX: 000000004321fedc RSI: 0000000028121969 RDI: 00000000fee1dead
[1352.***] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
[1352.***] R10: 0000000000400968 R11: 0000000000000282 R12: 0000000000000000
[1352.***] R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000

--=-=-=
Content-Type: text/plain


[...]
>> By the other patch do you mean the following?  (This email was also put
>> into my spam by GMX and AFAICT has not yet shown up on the vger list.)
>
> Yes. But now that I played a little with it, I made dis:
[...]
> So you should have output like:
> |[   14.131696] Flushing events_freezable_power_
> the flush that hangs
>
> |[   17.203246] Flushing events_freezable_power_ over, 0
> It has been noticed (0 at the end)
>
> |[   17.203849] Showing busy workqueues and worker pools:
> |[   17.204400] workqueue events_freezable_power_: flags=0x84
> |[   17.205009]   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> |[   17.205774]     in-flight: 2147:disk_events_workfn
> |[   17.206268] workqueue kblockd: flags=0x18
> |[   17.206682]   pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
> |[   17.207428]     pending: blk_mq_requeue_work
> |[ 17.207958] pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=2s workers=3 idle:
> | 535 42
>
> A dump of all pending worqueue items.
>
> |[   20.275239] Flushing events_freezable_power_ over, 0
> |[   20.275812] Showing busy workqueues and worker pools:
> |[   20.276385] workqueue events_freezable_power_: flags=0x84
> |[   20.276972]   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> |[   20.277712]     in-flight: 2147:disk_events_workfn
> |[   20.278245] workqueue kblockd: flags=0x18
> |[   20.278685]   pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
> |[   20.279471]     pending: blk_mq_requeue_work
> |[ 20.279989] pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=5s workers=3 idle:
> | 535 42
>
> Another atempt. As you see `blk_mq_requeue_work' is references in both
> outputs but it makes progress (it is scheduled multiple times). The item
> `disk_events_workfn' stucks.

I rebuilt kernel 5.6.4 with that patch, but before calling `shutdown -h
now' I guess I should have set printk_delay, because this time there was
a lot of output and it went by too fast.  I'll try to delay it the next
time.  After the initial output (which went by too fast for me to
photograph) there were endlessly repeated screenfuls of output like this:

[ 2578.402398] , acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred, acpi_os_execute_deferred

and at the bottom of the screen this:

[ 2578.427680] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=0s workers=4 idle: 1331

After this line there was a brief pause (so I was able to photograph it)
and then it repeated, always the same.  In the last line pool, cpus,
node, flags, nice and hung were always 0, and workers was always 4.
Only idle changed, but seemed to cycle through a few values.  After
watching this repetition for several minutes, I finally did a hard
reboot.

Steve Berman

--=-=-=--
