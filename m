Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A74C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236162064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="B5sA1Vsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFJIVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:21:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:44721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJIVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591777291;
        bh=x5aadDaqrIihBmmALCfxUeDqFnf5xbDyu5Y5Kyxlrf0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=B5sA1Vsk/+OAulZdoeee+ek/4UygCrPthihSjj5ipNUaXywJxvgC5QZytJSF+LK8A
         Kqxb8DseOmwi5komg7Np2NwNubLfucdOshXaLfeW9kZkG8hLeX+dq7UbMv1HhoBZN2
         R6uIeY+PdAWFNPzFaAOna2+ZGQ/QgZnL0PO0wlzU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([178.9.97.46]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1j9bEg3zAu-00ZNp1; Wed, 10
 Jun 2020 10:21:31 +0200
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
Date:   Wed, 10 Jun 2020 10:21:29 +0200
In-Reply-To: <20200609202339.cgy57twm2zdtjhje@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Tue, 9 Jun 2020 22:23:39 +0200")
Message-ID: <87tuzjcovq.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4YtUnL3jYnMQw82rzAuoCy8SrIuHB1gv82ukl7limmBQx2INjIz
 bnsNob0mWxLX1NoYesMv3btF/HgFmdaaX0LVm1n78cXxgJf6ihqzHYVC5UFjjdECwsa1+WL
 frxgBXMBv5ZLV3ObjA628Q2mf+FW0qYdKbGHixYUh1f46LyxZE+l7FGaTOlRJ+yjSypY8Wr
 KgwBXHzR0BxVTZ0l9mhuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w2yE0NrAzdU=:mWdPzH9CdNTCCh9Ov0+hmr
 z+4CfOVojJ/urQmpI2K1Pep2PcHh+k9LwwOl8m7U/YRaH+VuihpLW8I+6eWR4xbkeT2wzKlbt
 +bd0wu6QZXLeidlZ7/6Am/Tk6u5pCOf+QMN+5vQTrqUzjSzwYRPqFLMLgY1Z0/bvpNG1yDrWb
 fc/nrDT/fwnmJrf8PCovl1OjgkbBYOVdEjrQNfkMowW8ldmJSSS0VFgUAeXoKkboDkguEaiEB
 dfbGQRahT9PL5alC4QNhXY817cDK5aKsWaSBoWdUjMsifHrrCMK9gkduOPGCWEMXuCQmYGCZG
 /3iXt7M4T0vDuN/lxJ6rBbKatUojGDJYwlrAnp6ccnKYa+pWrcxyahuQ5O1kLnnCyeNUGih8r
 x3R0bW6GMhzt9xzqf0fj8pOEpDUH/G5yCP31vHnc0mo82w79LY5H9ubQ0AUSLxGHH0MfhXULE
 17elNwxkJiJWejBourkHma0IRUm4B9eDMEkdlFPbENshHYoSfGOx8x9FXLOvDkFdSe8AdJROi
 /j8qMqY/yRaGCaBVPwR0f2CAsNO5VuocpZ8tbqKRt7rYeQ2+FaIesjePWdumpDm21WvCejAUD
 B8vBtBD2Dwu/O6z09gt3M45SHMAFbBwVf6xdiigHHTDIhzkqNFRN6iOYQaKH0OlRRNFwZugEY
 IC+HDqtzZPJLl2ayRT4nohJ0WPPnl+Dh8lbOx7UZnZVhJzmj/WjFRitgmQEEV+z4L/KmnsaNJ
 owWpCMDAPY8GQtck6qO6ZjwedB5mM/XQ4xpGzyAgUXU0JZdqf2qByBa8uaJ5J2BoZHu1PW11v
 Ibxu7NCeC/v1YxB2SbR6rG0mJx03UnnKdGq/SDklDKt2B3ffrFzYHUSF4x0p4IrjQokQBss/0
 s3UroYE6wPim8q3KiO1hxwEkB0QuiQd0BzBWp0PdIUzPV79M4Ppqf3TjcrYkY69i9utI7Ttx+
 oLeF8/XE/S9P9XYgArTmR0Mxzd/XXLTpOKLEVjrCGedPBYQ1+VXwxNrt3c/gkxzXmwoIsmM1x
 OdlDs/lxqAzr5tCLBqZK7VGIOxcKrq/VriET7x66qjZQbHNoF2owLSB/rdgZegIlZUlD64bnC
 e4qz3fivF141005t1ZpRbvmjnPsxu0OPNvUN8rcPDaBpguowWM5SQ2bjhvBgejcYI3Civzoph
 juVfmZk5HCnsYlOwkuhQiX0RcnOvP4gAtz+VpcoP587tEqZdN1T3guzloV7LHSRlgnKaz/mP9
 JxaQNxii0iqvk2ShI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(GMX put your email into my spam folder, so I didn't see it before I
sent my followup about removing the wifi firmware.)

On Tue, 9 Jun 2020 22:23:39 +0200 Sebastian Andrzej Siewior <bigeasy@linutr=
onix.de> wrote:

> On 2020-06-09 12:06:23 [+0200], Stephen Berman wrote:
>> I recompiled kernel 5.6.4 with the printk() call you suggested, then
>> booted the kernel with "ignore_loglevel initcall_debug" (but leaving the
>> CDROM and wifi intact for now).  After working as I normally do, I
>> called `shutdown -h now', again as usual.  After the "Bringing down the
>> loopback interface" message there were these two messages:
>>=20
>> reboot: __do_sys_reboot(317)CMD: 89abcdef
>> reboot: __do_sys_reboot(317)CMD: 4321fedc
>>=20
>> Then nothing more for two minutes, then, as previously:
>>=20
>> sr 5:0:0:0: tag#10 timing out command, waited 120 seconds.
>>=20
>> Then I did a hard reboot.
>>=20
>> This morning I detached the cables to the CDROM (but left the disk in
>> the box) and again booted 5.6.4 with "ignore_loglevel initcall_debug".
>> After working for a bit, I called `shutdown -h now', and now there were
>> quite a few more messages, but again the machine did not power off.
>> Here is the ouput, which I transcribed carefully, hopefully without
>> error (I omitted the fractional parts of the timestamps and some of the
>> usb1-portX messages):
>
> If it helps you could delay printks on shutdown (via
> /proc/sys/kernel/printk_delay) and record a video clip. I could make
> storage available for an upload.

So far this hasn't been necessary, since the new output until the first
two-minute pause fit on one screen and I could photograph it.

> | *   Bringing down the loopback interface...
> | [1123.***] reboot: __do_sys_reboot(317)CMD: 89abcdef
> | [1123.***] reboot: __do_sys_reboot(317)CMD: 4321fedc
> This happens quicker than I expected. Initially I assumed that you are
> not there yet and userland is still poking at your cdrom. Accordin
> =E2=80=A6
> | [1124.***] sd 4:0:0:0: shutdown
> | [1124.***] sd 4:0:0:0: shutdown [sda] Synchronizing SCSI cache
> | [1124.***] sd 4:0:0:0: shutdown [sda] Stopping disk
>
> After this, there shouldn't be any outstanding disk requests.
> =E2=80=A6
> | [1125.***] ahci 0000:00:17.0: shutdown
>
> This disables the ahci controller which means disk/cdrom requests won't
> be answered by the hardware.
> =E2=80=A6
> | [1125.***] ACPI: Preparing to enter system sleep state S5
> | [1352.***] INFO: task halt:5187 blocked for more than 122 seconds.
> | [1352.***]                  Not tainted 5.6.4 #4
> | [1352.***] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message
> | [1352.***] halt            D13856  5187   5186 0x00004000
> | [1352.***] Call Trace:
> | [1352.***]  ? __schedule+0x272/0x5b0
> | [1352.***]  schedule+0x45/0xb0
> | [1352.***]  schedule_timeout+0x204/0x2f0
> | [1352.***]  ? acpi_os_release_object+0x5/0x10
> | [1352.***]  ? acpi_ut_update_object_reference+0x14e/0x1d2
> | [1352.***]  wait_for_completion+0xa3/0x100
> | [1352.***]  ? wake_up_q+0x90/0x90
> | [1352.***]  flush_workqueue+0x130/0x420
>
> I have no idea where this flush_workqueue() is coming from. The command
>   scripts/decode_stacktrace.sh vmlinux $(pwd)/ kernel_power_off+0x3d/0x70
>
> should reveal that.

I saved the call trace lines to a file and did this (with `$(pwd)/' the
script did not run):

steve [ /sources/linux-5.6.4 ]$ ./scripts/decode_stacktrace.sh vmlinux . ke=
rnel_power_off+0x3d/0x70 < /home/steve/temp/call_trace=20
[1352.***] Call Trace:
[1352.***] ? __schedule (core.c:?)=20
[1352.***] schedule (??:?)=20
[1352.***] schedule_timeout (??:?)=20
[1352.***] ? acpi_os_release_object (??:?)=20
[1352.***] ? acpi_ut_update_object_reference (??:?)=20
[1352.***] wait_for_completion (??:?)=20
[1352.***] ? wake_up_q (??:?)=20
[1352.***] flush_workqueue (??:?)=20
[1352.***] kernel_power_off (??:?)=20
[1352.***] __do_sys_reboot (reboot.c:?)=20
[1352.***] ? do_send_sig_info (??:?)=20
[1352.***] ? kill_pid_info (??:?)=20
[1352.***] ? kill_something_info (signal.c:?)=20
[1352.***] ? __x64_sys_kill (??:?)=20
[1352.***] do_syscall_64 (??:?)=20
[1352.***] entry_SYSCALL_64_after_hwframe (??:?)=20
[1352.***] RIP: 0033:0x7f95dd6992c3
[1352.***] Code: Bad RIP value.
objdump: '/tmp/tmp.BlpNDdSQpG.o': No such file

Did I do something wrong or do I need to pass certain compiler flags
when building the kernel (when I build Emacs I pass CFLAGS=3D'-Og -g3')?

> The cdrom is polled by the kernel every two seconds. I *think* the
> kernel is blocked for some reason and then the cdrom polled. This can't
> complete and you see the srX warning. The window is quite small but not
> impossible.=20
> I managed to fabricate this case but after=20
> |[  137.581613] sr 3:0:0:0: tag#1 timing out command, waited 120s
>
> The system shutdowns. So you are facing something different. I am
> surprised that the workqueue stall detector did not yell here. The patch
> at the bottom should get rid of the sr warnings.

But the cdrom seems to have nothing to do with power-off failing, since
it happens even when the cdrom is detached (and hence there were no sr
warnings in the log output), or am I misunderstanding you?

> | [1352.***]  kernel_power_off+0x3d/0x70
> | [1352.***]  __do_sys_reboot+0x140/0x220
> =E2=80=A6
>
>> After the last message here, the "echo", Call Trace, RIP and register
>> messages were repeated exactly as above.  At this point I did a hard
>> reboot.  A web search found something similar to the above output
>> ("System hangs (bad RIP value) when disk used in pool is removed"), but
>> didn't otherwise seem to be related to the problem I'm having.
>>=20
>> Do you still want me to check whether removing the iwlwifi driver makes
>> a differece?  And with the CDROM still detached, or does that not
>> matter?
>
> I assumed the wifi driver shuts the AHCI port for some reason. But
> according to this log it does not happen, the ahci port is shutdown
> properly. The patch at the bottom should get rid of the sr warning. Then
> could you please try the other patch so we see which workqueue is
> blocked? I am curious to see why the system is blocked.

By the other patch do you mean the following?  (This email was also put
into my spam by GMX and AFAICT has not yet shown up on the vger list.)

From: Hillf Danton <hdanton@sina.com>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
To: Stephen Berman <stephen.berman@gmx.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	linux-kernel@vger.kernel.org
Date: Tue,  9 Jun 2020 23:06:07 +0800
[...]
Curious what the workqueue it is blocking halt.

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2826,7 +2826,14 @@ void flush_workqueue(struct workqueue_st
=20
 	mutex_unlock(&wq->mutex);
=20
-	wait_for_completion(&this_flusher.done);
+	if (system_state =3D=3D SYSTEM_POWER_OFF) {
+		/*
+		 * save data before running at warned risk in any form
+		 */
+		wait_for_completion_timeout(&this_flusher.done, 2*HZ);
+		pr_info("workqueue %s 2s since SYSTEM_POWER_OFF\n", wq->name);
+	} else
+		wait_for_completion(&this_flusher.done);
=20
 	/*
 	 * Wake-up-and-cascade phase

Steve Berman
