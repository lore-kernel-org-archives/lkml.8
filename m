Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8929C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 23:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BC0206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 23:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgHOXyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 19:54:21 -0400
Received: from netrider.rowland.org ([192.131.102.5]:42337 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726429AbgHOXyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 19:54:20 -0400
Received: (qmail 52558 invoked by uid 1000); 14 Aug 2020 22:07:39 -0400
Date:   Fri, 14 Aug 2020 22:07:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Protecting usb_set_interface() against device removal
Message-ID: <20200815020739.GB52242@rowland.harvard.edu>
References: <b0a7247c-bed3-934b-2c73-7f4b0adb5e75@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a7247c-bed3-934b-2c73-7f4b0adb5e75@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 04:07:03PM -0700, Guenter Roeck wrote:
> Hi all,
> 
> over time, there have been a number of reports of crashes in usb_ifnum_to_if(),
> called from usb_hcd_alloc_bandwidth, which is in turn called from usb_set_interface().
> Examples are [1] [2] [3]. A typical backtrace is:
> 
> <3>[ 3489.445468] intel_sst_acpi 808622A8:00: sst: Busy wait failed, cant send this msg
> <6>[ 3490.507273] usb 1-4: USB disconnect, device number 3
> <1>[ 3490.516670] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> <6>[ 3490.516680] PGD 0 P4D 0
> <4>[ 3490.516687] Oops: 0000 [#1] PREEMPT SMP PTI
> <4>[ 3490.516693] CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d29ca36db06 #1
> <4>[ 3490.516696] Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/2019
> <4>[ 3490.516706] RIP: 0010:usb_ifnum_to_if+0x29/0x40
> <4>[ 3490.516710] Code: ee 0f 1f 44 00 00 55 48 89 e5 48 8b 8f f8 03 00 00 48 85 c9 74 27 44 0f b6 41 04 4d 85 c0 74 1d 31 ff 48 8b 84 f9 98 00 00 00 <48> 8b 10 0f b6 52 02 39 f2 74 0a 48 ff c7 4c 39 c7 72 e5 31 c0 5d
> <4>[ 3490.516714] RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
> <4>[ 3490.516718] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
> <4>[ 3490.516721] RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
> <4>[ 3490.516724] RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
> <4>[ 3490.516727] R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
> <4>[ 3490.516731] R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
> <4>[ 3490.516735] FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000000000
> <4>[ 3490.516738] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[ 3490.516742] CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
> <4>[ 3490.516745] Call Trace:
> <4>[ 3490.516756] usb_hcd_alloc_bandwidth+0x1ee/0x30f
> <4>[ 3490.516762] usb_set_interface+0x1a3/0x2b7
> <4>[ 3490.516773] uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
> <4>[ 3490.516781] uvc_video_start_streaming+0x91/0xdd [uvcvideo]
> <4>[ 3490.516787] uvc_start_streaming+0x28/0x5d [uvcvideo]
> <4>[ 3490.516795] vb2_start_streaming+0x61/0x143 [videobuf2_common]
> <4>[ 3490.516801] vb2_core_streamon+0xf7/0x10f [videobuf2_common]
> <4>[ 3490.516807] uvc_queue_streamon+0x2e/0x41 [uvcvideo]
> <4>[ 3490.516814] uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
> <4>[ 3490.516820] __video_do_ioctl+0x33d/0x42a
> <4>[ 3490.516826] video_usercopy+0x34e/0x5ff
> <4>[ 3490.516831] ? video_ioctl2+0x16/0x16
> <4>[ 3490.516837] v4l2_ioctl+0x46/0x53
> <4>[ 3490.516843] do_vfs_ioctl+0x50a/0x76f
> <4>[ 3490.516848] ksys_ioctl+0x58/0x83
> <4>[ 3490.516853] __x64_sys_ioctl+0x1a/0x1e
> <4>[ 3490.516858] do_syscall_64+0x54/0xde
> 
> I have been able to reproduce the problem on a Chromebook by strategically placing
> msleep() calls into usb_set_interface() and usb_disable_device(). Ultimately, the
> problem boils down to lack of protection against device removal in usb_set_interface()
> [and/or possibly other callers of usb_ifnum_to_if()].
> 
> Sequence of events is roughly as follows:
> 
> - usb_set_interface() is called and proceeds to some point, possibly to
>   mutex_lock(hcd->bandwidth_mutex);
> - Device removal event is detected, and usb_disable_device() is called

At this point all interface drivers get unbound (their disconnect 
routines are called).

> - usb_disable_device() starts removing actconfig data. It has removed
>   and cleared dev->actconfig->interface[i], but not dev->actconfig
> - usb_set_interface() calls usb_hcd_alloc_bandwidth(), which calls
>   usb_ifnum_to_if()
> - In usb_ifnum_to_if(), dev->actconfig is not NULL, but
>   dev->actconfig->interface[i] is NULL
> - crash
> 
> Question is what we can do about this. Checking if dev->state != USB_STATE_NOTATTACHED
> in usb_ifnum_to_if() might be a possible approach, but strictly speaking it would
> still be racy since there is still no lock against device removal. I have not tried
> calling usb_lock_device() in usb_set_interface() - would that possibly be an option ?

As far as I know, protecting against these races is the responsibility 
of the USB interface drivers.  They must make sure that their disconnect 
routines block until all outstanding calls to usb_set_interface return 
(in fact, until all outstanding device accesses have finished).

For instance, in the log extract you showed, it's obvious that the 
uvc_start_streaming routine was running after the disconnect routine had 
returned, which looks like a bug in itself: Once the disconnect routine 
returns, the driver is not supposed to try to access the device at all 
because some other driver may now be bound to it.

We can't just call usb_lock_device from within usb_set_interface, 
because usb_set_interface is often called with that lock already held.

Alan Stern
