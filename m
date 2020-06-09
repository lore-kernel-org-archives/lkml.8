Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DCFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1573F206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbgFIUXm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgFIUXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:23:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49BC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 13:23:41 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jikmZ-0000v8-FR; Tue, 09 Jun 2020 22:23:39 +0200
Date:   Tue, 9 Jun 2020 22:23:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200609202339.cgy57twm2zdtjhje@linutronix.de>
References: <87bln7ves7.fsf@gmx.net>
 <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
 <87v9l65d2y.fsf@gmx.net>
 <20200513220428.4nksinis2qs5dtmh@linutronix.de>
 <87mu6aurfn.fsf@gmx.net>
 <20200522164012.ynyvrjompv42jtmx@linutronix.de>
 <87y2owwo2o.fsf@rub.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87y2owwo2o.fsf@rub.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-09 12:06:23 [+0200], Stephen Berman wrote:
> I recompiled kernel 5.6.4 with the printk() call you suggested, then
> booted the kernel with "ignore_loglevel initcall_debug" (but leaving the
> CDROM and wifi intact for now).  After working as I normally do, I
> called `shutdown -h now', again as usual.  After the "Bringing down the
> loopback interface" message there were these two messages:
> 
> reboot: __do_sys_reboot(317)CMD: 89abcdef
> reboot: __do_sys_reboot(317)CMD: 4321fedc
> 
> Then nothing more for two minutes, then, as previously:
> 
> sr 5:0:0:0: tag#10 timing out command, waited 120 seconds.
> 
> Then I did a hard reboot.
> 
> This morning I detached the cables to the CDROM (but left the disk in
> the box) and again booted 5.6.4 with "ignore_loglevel initcall_debug".
> After working for a bit, I called `shutdown -h now', and now there were
> quite a few more messages, but again the machine did not power off.
> Here is the ouput, which I transcribed carefully, hopefully without
> error (I omitted the fractional parts of the timestamps and some of the
> usb1-portX messages):

If it helps you could delay printks on shutdown (via
/proc/sys/kernel/printk_delay) and record a video clip. I could make
storage available for an upload.


| *   Bringing down the loopback interface...
| [1123.***] reboot: __do_sys_reboot(317)CMD: 89abcdef
| [1123.***] reboot: __do_sys_reboot(317)CMD: 4321fedc
This happens quicker than I expected. Initially I assumed that you are
not there yet and userland is still poking at your cdrom. Accordin
…
| [1124.***] sd 4:0:0:0: shutdown
| [1124.***] sd 4:0:0:0: shutdown [sda] Synchronizing SCSI cache
| [1124.***] sd 4:0:0:0: shutdown [sda] Stopping disk

After this, there shouldn't be any outstanding disk requests.
…
| [1125.***] ahci 0000:00:17.0: shutdown

This disables the ahci controller which means disk/cdrom requests won't
be answered by the hardware.
…
| [1125.***] ACPI: Preparing to enter system sleep state S5
| [1352.***] INFO: task halt:5187 blocked for more than 122 seconds.
| [1352.***]                  Not tainted 5.6.4 #4
| [1352.***] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message
| [1352.***] halt            D13856  5187   5186 0x00004000
| [1352.***] Call Trace:
| [1352.***]  ? __schedule+0x272/0x5b0
| [1352.***]  schedule+0x45/0xb0
| [1352.***]  schedule_timeout+0x204/0x2f0
| [1352.***]  ? acpi_os_release_object+0x5/0x10
| [1352.***]  ? acpi_ut_update_object_reference+0x14e/0x1d2
| [1352.***]  wait_for_completion+0xa3/0x100
| [1352.***]  ? wake_up_q+0x90/0x90
| [1352.***]  flush_workqueue+0x130/0x420

I have no idea where this flush_workqueue() is coming from. The command
  scripts/decode_stacktrace.sh vmlinux $(pwd)/ kernel_power_off+0x3d/0x70

should reveal that.
The cdrom is polled by the kernel every two seconds. I *think* the
kernel is blocked for some reason and then the cdrom polled. This can't
complete and you see the srX warning. The window is quite small but not
impossible. 
I managed to fabricate this case but after 
|[  137.581613] sr 3:0:0:0: tag#1 timing out command, waited 120s

The system shutdowns. So you are facing something different. I am
surprised that the workqueue stall detector did not yell here. The patch
at the bottom should get rid of the sr warnings.


| [1352.***]  kernel_power_off+0x3d/0x70
| [1352.***]  __do_sys_reboot+0x140/0x220
…

> After the last message here, the "echo", Call Trace, RIP and register
> messages were repeated exactly as above.  At this point I did a hard
> reboot.  A web search found something similar to the above output
> ("System hangs (bad RIP value) when disk used in pool is removed"), but
> didn't otherwise seem to be related to the problem I'm having.
> 
> Do you still want me to check whether removing the iwlwifi driver makes
> a differece?  And with the CDROM still detached, or does that not
> matter?

I assumed the wifi driver shuts the AHCI port for some reason. But
according to this log it does not happen, the ahci port is shutdown
properly. The patch at the bottom should get rid of the sr warning. Then
could you please try the other patch so we see which workqueue is
blocked? I am curious to see why the system is blocked.

> Steve Berman

Sebastian

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 9 Jun 2020 22:13:46 +0200
Subject: [PATCH] SCSI: Disable CD-ROM poll on shutdown

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/scsi/sr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index d2fe3fa470f95..2484e594af283 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -85,6 +85,13 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt);
 static int sr_done(struct scsi_cmnd *);
 static int sr_runtime_suspend(struct device *dev);
 
+static void sr_shutdown(struct device *dev)
+{
+	struct scsi_cd *cd = dev_get_drvdata(dev);
+
+	disk_block_events(cd->disk);
+}
+
 static const struct dev_pm_ops sr_pm_ops = {
 	.runtime_suspend	= sr_runtime_suspend,
 };
@@ -95,6 +102,7 @@ static struct scsi_driver sr_template = {
 		.owner		= THIS_MODULE,
 		.probe		= sr_probe,
 		.remove		= sr_remove,
+		.shutdown	= sr_shutdown,
 		.pm		= &sr_pm_ops,
 	},
 	.init_command		= sr_init_command,
-- 
2.27.0

