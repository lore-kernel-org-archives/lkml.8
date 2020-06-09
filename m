Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14692C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D204C2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CwDv6h59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgFIKGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:06:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:57469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgFIKGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591697185;
        bh=EwhaBQOdiYCidrgctpcsX9zltiUK0MBAkp11JEpMwRA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=CwDv6h59gjgVzAyFCdQh0i7CcLh5IyOyNBj+iXGEI9bL72Bg7uKuBHqVN6E/lI+ht
         wPw5lB9OCm4TxFYpgMfqFf4VW+3LwTlxPomGdncj9ndA9Lypw2QP2kLUgzITYJcSzN
         lGm4hYVEGmsfyT5rea1JFe6mfSfjPwokmmZNP35Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.195.90]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1j8zDP16A6-00ZyJt; Tue, 09
 Jun 2020 12:06:25 +0200
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
Date:   Tue, 09 Jun 2020 12:06:23 +0200
In-Reply-To: <20200522164012.ynyvrjompv42jtmx@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Fri, 22 May 2020 18:40:12 +0200")
Message-ID: <87y2owwo2o.fsf@rub.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Provags-ID: V03:K1:AoGTmDMi7SD8YKO7yIKagDuTPkqG56ExDo+yh5lYXRXSjyl57CH
 oUaDTVVi83Kl8owY2OQKXS1tphc2JyvPfhn5hmV4NkoW3BqIVKI0f5nLPTCwlyqfJLAUY7K
 6yQHCvT2V9550e/K/Zz+cOszpYGNkDe0hPiPH9aBXgcjkr+OGaBKGpxOE/GpJ25vXaRsiUO
 tMWrkjpIwT2sG15t/iEMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k3a0DdMkZmA=:0+ZltzJJZJX5j0sqVCunfY
 /CVoXL/w9IhFm/+1cToXPIfj2qYMrEPJlENEY/Njmbj8mHid0R9Q7818ap5+33fg1DL57NvPL
 GfXN8fyw7EjPCe7YER3pYMcbi+NPcYXOMnfbntkXNDs65+ZjTmf953HnCf8r9TgS4Nj5JNiX+
 SeWt5H+HlvTnx5V3Z6YwDOTKT0ltxyB867Io45gFw/ChUd8TUA1uWZy1GHxzrNyYnQi7KzlZy
 jNz/r3Kpyt8f2ZscPHp0Akh2IuNBm0wq3sQVd4QIP4xQL04k6I0253fAuuZTHwanowfFmvBdq
 i+AvanzLLefCgXl8FdmoD7qAMjEF5JFe9khdub8tbaqDWRn5JBtI7+VSC191Tst5dl8cCZcG7
 An53T9mDxaVT2jGPbs1mQrPzDjaxc9vQB9PW3TZ8xJrOU9uwpKG7nMCzyimLL+CPSNRU13x71
 PdY/EU4PzAStxwfxiC+w4Z4je6bmq4SAhOo3F1Qjsd8vFoJv0ta4Y2H8la2pV05/uyF6hcUnj
 LBcWlVPTP/a6FK8CLL4cMYXhJuJEiUjA4BoItoUAA8+J1gY6qpO0gpsCQXg7fJeusnTbQO3JC
 TpUM3mHJ1SOUSRd1b7h7t5wqc1Ixw1S4zeChX5BbLIPTrKtz64KwDAlkKqarFMwxc4H2WnbIH
 6gDcAHTm59g6Urr0I5qKwnLy4mVPknAzq4kkPnTVSLts6IDMrKguazhY4P6mLywyAA5aAa09J
 2pL2h5dmx410VT1X1K7Hk82vN366SAbsF/weUgLBSIZ+LNEDfT9QmJ2pozeL9MFYrE204ilpc
 jcfxIKs0UkI396X3VUIzeoTXK81HHzDZzZgvy9MWqSS8XKrt2lUPCDJP6vB0tDdBwsC371ibM
 2jC6LzIRF1UZTpUzOxIGdrMkLl/87npFnu5Kwm5xVyvKL19odcC0oaMISShP8lzj6Jb5177zJ
 Pt2GxvxI3C5Cuoi+HKcgYlHtgL11wT06+o3Rcs/SsGr/0e//xC0xA59cv+d0DZCqMCmq/5Gf6
 eUa3jM8O8zG6RgtzsaQu90vF2I/VIAyOvdR2cSOliEodtMmfHWkobasf2lxivDZNv7gqZX8SD
 1jNMEUMNfKu/q4BRn4fn7XXiSapNf9ko57w2Qn1jDlJpdGXEiPBl9CgnZkFfsn7Ss8Voc5C6V
 gVMMTIIsl7fi9Q3TN4g5J0IUsI4vJxCERZl1fXhgr5bRh17cW0VWdW5ing+bcYC9NNmkubcGP
 382aYtL2Cl/qO1O4Q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2020 18:40:12 +0200 Sebastian Andrzej Siewior <bigeasy@linu=
tronix.de> wrote:

> Sorry for the late reply.

No problem, since as it turned out, I didn't have to time till now to
follow up on your latest suggestions.  Details below.

> On 2020-05-14 23:39:40 [+0200], Stephen Berman wrote:
>> >> How will I know if that happens, is there a specific message in the =
tty?
>> >
>> > On the tty console where you see the "timing out command, waited"
>> > message, there should be something starting with
>> > |BUG: workqueue lockup - pool
>> >
>> > following with the pool information that got stuck. That code checks =
the
>> > workqueues every 30secs by default. So if you waited >=3D 60secs then
>> > system is not detecting a stall.
>>
>> As you can see in the photo, there was no message about a workqueue
>> lockup, only "task halt:5320 blocked for more than <XXX> seconds" every
>> two minutes.  I suppose that comes from one of the other options I
>> enabled.  Does it reveal anything about the problem?
>
>>From the picture, you are on your way to level 0, which would issue the
> final shutdown command, but you are not quite there yet.
>
> If you add a printk() to the reboot syscall, then I wouldn't expect you
> to see it. (something like that):
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index c4d472b7f1b42..19bc35bc0cda0 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -314,6 +314,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, un=
signed int, cmd,
>  	char buffer[256];
>  	int ret =3D 0;
>
> +	pr_err("%s(%d)CMD: %lx\n", __func__, __LINE__, cmd);
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!ns_capable(pid_ns->user_ns, CAP_SYS_BOOT))
>  		return -EPERM;
>
> If you add "ignore_loglevel initcall_debug" to the command line then you
> should see the init callbacks of each driver. But there will be nothing
> on your shutdown (as I expect it).
>
> The "task X blocked for more than 120 secs" is part of the hung task
> detector. With the "ignore_loglevel" above you should be able to see the
> callchain of the task. I suspect that the task poked the cd-drive which
> isn't answering. So from detector's point of view, the task issued a
> system call which appears to hang an makes no progress.
>
>> > Could
>> > you please check if the stall-dector says something?
>>
>> Is that the message I repeated above or do you mean the workqueue?
>
> The hung message is not workqueue related. It is the task `halt' that
> makes no progress. There is not stall of the workqueue as far as the
> system can tell.
> The two boot options, I suggested above, may reveal additional
> information that are printed but suppressed due to the loglevel.
>
> My guess now is that maybe shutting down wifi also paused the AHCI
> controller which makes no progress now. So booting without cdrom/disk
> should not cause any problems.
>
> Could you please:
> - try booting with "ignore_loglevel initcall_debug" and see if
>   additional information is printed on the console.
>
> - Remove cd / ATA-disk to check if anything else causes a stall. As by
>   your report you only mentioned those two (and if I see it correctly,
>   you rootFS is on nvme so removing the disk might be doable).
>
> - Could you remove the Wifi (just the driver, no the physical hw) to see
>   if it makes any difference?

I recompiled kernel 5.6.4 with the printk() call you suggested, then
booted the kernel with "ignore_loglevel initcall_debug" (but leaving the
CDROM and wifi intact for now).  After working as I normally do, I
called `shutdown -h now', again as usual.  After the "Bringing down the
loopback interface" message there were these two messages:

reboot: __do_sys_reboot(317)CMD: 89abcdef
reboot: __do_sys_reboot(317)CMD: 4321fedc

Then nothing more for two minutes, then, as previously:

sr 5:0:0:0: tag#10 timing out command, waited 120 seconds.

Then I did a hard reboot.

This morning I detached the cables to the CDROM (but left the disk in
the box) and again booted 5.6.4 with "ignore_loglevel initcall_debug".
After working for a bit, I called `shutdown -h now', and now there were
quite a few more messages, but again the machine did not power off.
Here is the ouput, which I transcribed carefully, hopefully without
error (I omitted the fractional parts of the timestamps and some of the
usb1-portX messages):


--=-=-=
Content-Type: application/text/plain
Content-Disposition: attachment; filename=no-cdrom-shutdown-5.6.4
Content-Transfer-Encoding: quoted-printable

Sending all processes the TERM signal...
[1123.***] elogind-daemon[4318]: Received signal 15 [TERM]
Sending all processes the KILL signal...
Deactivating all swap files/partitions...
Unmounting all other currently mounted file systems...
[1123.***] EXT4-fs (nvme0n1p5):re-mounted. Opts: (null)
 *   Bringing down the loopback interface...
[1123.***] reboot: __do_sys_reboot(317)CMD: 89abcdef
[1123.***] reboot: __do_sys_reboot(317)CMD: 4321fedc
[1124.***] snd_hda_codec_generic hdaudioC0D2: shutdown
[1124.***] snd_hda_codec_realtek hdaudioC0D0: shutdown
[1124.***] snd_hda_intel 0000:00:1f.3: shutdown
[1124.***] sd 4:0:0:0: shutdown
[1124.***] sd 4:0:0:0: shutdown [sda] Synchronizing SCSI cache
[1124.***] sd 4:0:0:0: shutdown [sda] Stopping disk
[1125.***] i2c i2c-4: shutdown
[1125.***] alarmtimer alarmtimer.0.auto: shutdown
[1125.***] usb usb2-port10: shutdown
[1125.***] usb usb2-port9: shutdown
[1125.***] usb usb2-port8: shutdown
[1125.***] usb usb2-port7: shutdown
[1125.***] usb usb2-port6: shutdown
[1125.***] usb usb2-port5: shutdown
[1125.***] usb usb2-port4: shutdown
[1125.***] usb usb2-port3: shutdown
[1125.***] usb usb2-port2: shutdown
[1125.***] usb usb2-port1: shutdown
[1125.***] usb usb1-port16: shutdown
[1125.***] ...
[1125.***] usb usb1-port1: shutdown
[1125.***] i2c i2c-3: shutdown
[1125.***] i2c i2c-2: shutdown
[1125.***] i2c i2c-1: shutdown
[1125.***] i2c i2c-0: shutdown
[1125.***] serial8250 serial8250: shutdown
[1125.***] aer 0000:00:1b.4:pcie002: shutdown
[1125.***] aer 0000:00:1b.2:pcie002: shutdown
[1125.***] efi-framebuffer efi-framebuffer.0: shutdown
[1125.***] pcspkr pcspkr: shutdown
[1125.***] system 00:08: shutdown
[1125.***] system 00:07: shutdown
[1125.***] system 00:06: shutdown
[1125.***] system 00:05: shutdown
[1125.***] system 00:04: shutdown
[1125.***] rtc_cmos 00:03: shutdown
[1125.***] system 00:02: shutdown
[1125.***] serial 00:01: shutdown
[1125.***] system 00:00: shutdown
[1125.***] acpi-fan PNP0C0B:04: shutdown
[1125.***] acpi-fan PNP0C0B:03: shutdown
[1125.***] acpi-fan PNP0C0B:02: shutdown
[1125.***] acpi-fan PNP0C0B:01: shutdown
[1125.***] acpi-fan PNP0C0B:00: shutdown
[1125.***] nvme 0000:03:00.0: shutdown
[1125.***] iwlwifi 0000:02:00.0: shutdown
[1125.***] e1000e 0000:00:1f.0: shutdown
[1125.***] e1000e EEE TX LPI TIMER: 00000011
[1125.***] pci 0000:00:1f.5: shutdown
[1125.***] i801_smbus 0000:00:1f.4: shutdown
[1125.***] pcieport 0000:00:1d.0: shutdown
[1125.***] pcieport 0000:00:1c.0: shutdown
[1125.***] pcieport 0000:00:1b.4: shutdown
[1125.***] pcieport 0000:00:1b.2: shutdown
[1125.***] pcieport 0000:00:1b.0: shutdown
[1125.***] ahci 0000:00:17.0: shutdown
[1125.***] pci 0000:00:16.0: shutdown
[1125.***] pci 0000:00:14.2: shutdown
[1125.***] xhci_hcd 0000:00:14.0: shutdown
[1125.***] pci 0000:00:12.0: shutdown
[1125.***] i915 0000:00:02.0: shutdown
[1125.***] skl_uncore 0000:00:00.0: shutdown
[1125.***] ACPI: Preparing to enter system sleep state S5
[1352.***] INFO: task halt:5187 blocked for more than 122 seconds.
[1352.***]                  Not tainted 5.6.4 #4
[1352.***] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this=
 message
[1352.***] halt            D13856  5187   5186 0x00004000
[1352.***] Call Trace:
[1352.***]  ? __schedule+0x272/0x5b0
[1352.***]  schedule+0x45/0xb0
[1352.***]  schedule_timeout+0x204/0x2f0
[1352.***]  ? acpi_os_release_object+0x5/0x10
[1352.***]  ? acpi_ut_update_object_reference+0x14e/0x1d2
[1352.***]  wait_for_completion+0xa3/0x100
[1352.***]  ? wake_up_q+0x90/0x90
[1352.***]  flush_workqueue+0x130/0x420
[1352.***]  kernel_power_off+0x3d/0x70
[1352.***]  __do_sys_reboot+0x140/0x220
[1352.***]  ? do_send_sig_info+0x58/0x90
[1352.***]  ? kill_pid_info+0x34/0x60
[1352.***]  ? kill_something_info+0x133/0x160
[1352.***]  ? __x64_sys_kill+0x9a/0xc0
[1352.***]  do_syscall_64+0x43/0x130
[1352.***]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[1352.***] RIP: 0033:0x7f95dd6992c3
[1352.***] Code: Bad RIP value.
[1352.***] RSP: 002b:00007ffc4a3e4b88 EFLAGS: 00000202 ORIG_RAX: 0000000000=
0000a9
[1352.***] RAX: ffffffffffffffda RBX: 00007ffc4a3e4cd8 RCX: 00007f95dd6992c3
[1352.***] RDX: 000000004321fedc RSI: 0000000028121969 RDI: 00000000fee1dead
[1352.***] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
[1352.***] R10: 0000000000400968 R11: 0000000000000282 R12: 0000000000000000
[1352.***] R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
[1475.***] INFO: task halt:5187 blocked for more than 245 seconds.
...

--=-=-=
Content-Type: text/plain


After the last message here, the "echo", Call Trace, RIP and register
messages were repeated exactly as above.  At this point I did a hard
reboot.  A web search found something similar to the above output
("System hangs (bad RIP value) when disk used in pool is removed"), but
didn't otherwise seem to be related to the problem I'm having.

Do you still want me to check whether removing the iwlwifi driver makes
a differece?  And with the CDROM still detached, or does that not
matter?

Steve Berman

--=-=-=--
