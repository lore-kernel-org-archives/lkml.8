Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E6AC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682BE20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk9tdMof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBCJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:33:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40703 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgBCJdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:33:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id t204so13524979qke.7;
        Mon, 03 Feb 2020 01:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkGN6qsWghM+p2dDSYrxQbmlOgHej/HNGErV2JjkL1g=;
        b=Vk9tdMofkccLKIPF5AuhKUGc4oqo1gl/eBcjiMD6qGaoopsctmMfPqGIPh3xpDx07o
         DD4ajwcsmM1AfJ+a9IupgvOpkNRX0BCTru4Vs3Nw37BpuT1FEqPj+2w5AveqGxPRedCX
         2LvGibxTjN85gOz7b+1ydRLUZljheFPjgoQlNy7mxW6hKHr6/VKyoZeV8CIYW/GWDJGG
         gKMPSE7/s3O0yWsKeIyo288xg7mzftxNl34WlIcpMRrqWPEItMzSjIyg69R1WB/zPRRZ
         PrY4AzvDLHZM0hygI70JuFseo55uttuQSkeZnViNeNukJYfwDryahQIoYZ05/j2RoF9k
         wWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkGN6qsWghM+p2dDSYrxQbmlOgHej/HNGErV2JjkL1g=;
        b=hyInXoz76oSzBUn8YKU7Lnka2/j/hBBSSw5fpdWNQmGNKwPHKDSXzelSxk9Arf/Uqo
         bemtHNqpCWjzXUQuI9wdijYzQXDU4g19R5tro2CDpOSfh49OByr+M9cJGjN2dfHU0sjo
         L/7AnfT0KFLzzVTJntpj4aYn+vdWdjlE1R6akaDshUYpH3JFk02VufkyT3eGNck70zVX
         pUyIniVwWHgSOaruCL7ZH+6wmdMZX04i7C8iMMPf4O19NYTN2AXnZ9F8/qO9AiVcgi6G
         hDmrwCzAm6RpvIOuxxOCAVZylHVH2CkFHh4lmYm/4QSpYyj2znnCX053EzBtdK7W/+a2
         cLSA==
X-Gm-Message-State: APjAAAWXaXc+VbToU9w5/gFGZ4PKBVdkFtBSWDwhFg+temkA0diw0eJ4
        3EAiI2IDVDD4DKBIdV4Me337Ze+Iw0f5Xntxp6+63+E/
X-Google-Smtp-Source: APXvYqzPm3cXYnQBn5BKE+ina4sYTGNEcdnnPZZ07bsBXVkmgPlB0D2m0mb90CFAuLfMhZe0J/NALsm1NkFygK57O+I=
X-Received: by 2002:a37:a642:: with SMTP id p63mr23402113qke.85.1580722416801;
 Mon, 03 Feb 2020 01:33:36 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200131073925eucas1p25bde5452aaa821435367dbfa9904a476@eucas1p2.samsung.com>
 <20200107220640.834-1-yichengli@chromium.org> <5bbca1db-d99b-9adc-b623-8f5ae1b1bb86@samsung.com>
In-Reply-To: <5bbca1db-d99b-9adc-b623-8f5ae1b1bb86@samsung.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 3 Feb 2020 10:33:25 +0100
Message-ID: <CAFqH_5307FZ2njAhAUJ011usvfiuBZ9cd10yNRLVPuMZNHWD4w@mail.gmail.com>
Subject: Re: [PATCH v5] platform: cros_ec: Query EC protocol version if EC
 transitions between RO/RW
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Missatge de Marek Szyprowski <m.szyprowski@samsung.com> del dia dv.,
31 de gen. 2020 a les 8:41:
>
> Hi
>
> On 07.01.2020 23:06, Yicheng Li wrote:
> > RO and RW of EC may have different EC protocol version. If EC transitions
> > between RO and RW, but AP does not reboot (this is true for fingerprint
> > microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> > still uses the protocol version queried before transition, which can
> > cause problems. In the case of fingerprint microcontroller, this causes
> > AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> > interrupt handler, which in turn prevents RO to clear the interrupt
> > line to AP, in an infinite loop.
> >
> > Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> > might have been a transition between RO and RW, so re-query the protocol.
> >
> > Change-Id: I49a51cc10d22a4ab9e75204a4c0c8819d5b3d282
> > Signed-off-by: Yicheng Li <yichengli@chromium.org>
>
> This patch landed recently in linux-next as commit
> 241a69ae8ea8e2defec751fe55dac1287aa044b8. Sadly, it causes following
> kernel oops on any key press on Samsung Exynos-based Chromebooks (Snow,
> Peach-Pit and Peach-Pi):
>

Many thanks for report the issue, we will take a look ASAP and revert
this commit meanwhile.

Thanks,
 Enric

> ------------[ cut here ]------------
> kernel BUG at drivers/platform/chrome/cros_ec_proto.c:727!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 97 Comm: irq/158-chromeo Not tainted
> 5.5.0-rc1-00013-g241a69ae8ea8 #228
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> PC is at cros_ec_get_host_event+0x34/0x54
> LR is at cros_ec_ready_event+0x14/0x44
> pc : [<c07a2d5c>]    lr : [<c07a12b4>]    psr: 60000013
> sp : ed7c5ec8  ip : eda65f40  fp : c019bc54
> r10: eda80380  r9 : eda65c00  r8 : 00000000
> r7 : 00000000  r6 : 00000000  r5 : eda65e40  r4 : eda65f40
> r3 : 00000000  r2 : eda65e40  r1 : 00000000  r0 : eda65e40
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6c44006a  DAC: 00000051
> Process irq/158-chromeo (pid: 97, stack limit = 0xe6616d77)
> Stack: (0xed7c5ec8 to 0xed7c6000)
> 5ec0:                   fffffffe eda65e40 00000000 c0151080 eda65ec8
> 00000000
> 5ee0: eda65e40 ffffffff c019c24c c0151354 00000000 0000000d a0000013
> c1007648
> 5f00: eda65e40 0000000d 00000000 c0151384 00000000 eda65e40 0000000d
> c07a185c
> 5f20: 00014000 6c161f27 eda65e40 eda65c00 00000001 c07a18a8 eda80380
> c019bc70
> 5f40: ed7c4000 eda803a4 00000001 c019c2b8 c10bbbae c1007648 00000040
> 00000000
> 5f60: c019bdd4 6c161f27 ed7c4000 eda82280 eda80440 00000000 eda80380
> c019c174
> 5f80: ee8d7c50 eda822b8 00000000 c014f7d4 eda80440 c014f6a4 00000000
> 00000000
> 5fa0: 00000000 00000000 00000000 c01010b4 00000000 00000000 00000000
> 00000000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000
> 00000000
> [<c07a2d5c>] (cros_ec_get_host_event) from [<eda65e40>] (0xeda65e40)
> Code: e3530004 1a000002 e59000d5 e12fff1e (e7f001f2)
> ---[ end trace 9dd28f4b1a9d14be ]---
> BUG: sleeping function called from invalid context at
> ./include/linux/percpu-rwsem.h:38
> in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 97, name:
> irq/158-chromeo
> INFO: lockdep is turned off.
> irq event stamp: 156
> hardirqs last  enabled at (155): [<c0af608c>]
> _raw_spin_unlock_irqrestore+0x68/0x70
> hardirqs last disabled at (156): [<c0101b40>] __und_svc+0x60/0x74
> softirqs last  enabled at (0): [<c0123530>] copy_process+0x378/0x1994
> softirqs last disabled at (0): [<00000000>] 0x0
> CPU: 1 PID: 97 Comm: irq/158-chromeo Tainted: G      D
> 5.5.0-rc1-00013-g241a69ae8ea8 #228
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c0111618>] (unwind_backtrace) from [<c010d39c>] (show_stack+0x10/0x14)
> [<c010d39c>] (show_stack) from [<c0ad21bc>] (dump_stack+0xb4/0xe0)
> [<c0ad21bc>] (dump_stack) from [<c01570c8>] (___might_sleep+0x28c/0x2e0)
> [<c01570c8>] (___might_sleep) from [<c013b550>] (exit_signals+0x38/0x3e4)
> [<c013b550>] (exit_signals) from [<c012bcd8>] (do_exit+0xcc/0xc20)
> [<c012bcd8>] (do_exit) from [<c010d5cc>] (die+0x22c/0x2f0)
> [<c010d5cc>] (die) from [<c010d890>] (do_undefinstr+0xbc/0x270)
> [<c010d890>] (do_undefinstr) from [<c0101b5c>] (__und_svc_finish+0x0/0x44)
> Exception stack(0xed7c5e78 to 0xed7c5ec0)
> 5e60: eda65e40 00000000
> 5e80: eda65e40 00000000 eda65f40 eda65e40 00000000 00000000 00000000
> eda65c00
> 5ea0: eda80380 c019bc54 eda65f40 ed7c5ec8 c07a12b4 c07a2d5c 60000013
> ffffffff
> [<c0101b5c>] (__und_svc_finish) from [<c07a2d5c>]
> (cros_ec_get_host_event+0x34/0x54)
> [<c07a2d5c>] (cros_ec_get_host_event) from [<eda65e40>] (0xeda65e40)
> genirq: exiting task "irq/158-chromeo" (97) is an active IRQ thread (irq
> 158)
> irq 158: nobody cared (try booting with the "irqpoll" option)
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W
> 5.5.0-rc1-00013-g241a69ae8ea8 #228
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c0111618>] (unwind_backtrace) from [<c010d39c>] (show_stack+0x10/0x14)
> [<c010d39c>] (show_stack) from [<c0ad21bc>] (dump_stack+0xb4/0xe0)
> [<c0ad21bc>] (dump_stack) from [<c019e6c8>] (__report_bad_irq+0x28/0xc0)
> [<c019e6c8>] (__report_bad_irq) from [<c019eb90>]
> (note_interrupt+0x264/0x2b4)
> [<c019eb90>] (note_interrupt) from [<c019b33c>]
> (handle_irq_event_percpu+0x5c/0x7c)
> [<c019b33c>] (handle_irq_event_percpu) from [<c019b394>]
> (handle_irq_event+0x38/0x5c)
> [<c019b394>] (handle_irq_event) from [<c019f770>]
> (handle_level_irq+0xcc/0x150)
> [<c019f770>] (handle_level_irq) from [<c0199ff8>]
> (generic_handle_irq+0x24/0x34)
> [<c0199ff8>] (generic_handle_irq) from [<c04ccab8>]
> (exynos_irq_eint0_15+0x44/0x98)
> [<c04ccab8>] (exynos_irq_eint0_15) from [<c0199ff8>]
> (generic_handle_irq+0x24/0x34)
> [<c0199ff8>] (generic_handle_irq) from [<c04c1a40>]
> (combiner_handle_cascade_irq+0x8c/0xdc)
> [<c04c1a40>] (combiner_handle_cascade_irq) from [<c0199ff8>]
> (generic_handle_irq+0x24/0x34)
> [<c0199ff8>] (generic_handle_irq) from [<c019a618>]
> (__handle_domain_irq+0x7c/0xec)
> [<c019a618>] (__handle_domain_irq) from [<c04c1ecc>]
> (gic_handle_irq+0x58/0x9c)
> [<c04c1ecc>] (gic_handle_irq) from [<c0101a70>] (__irq_svc+0x70/0xb0)
> Exception stack(0xc1001ed0 to 0xc1001f18)
> 1ec0:                                     c075ce14 00000000 2e00e000
> 00000000
> 1ee0: 00000000 00000000 00000001 c10bca20 00000001 00000000 c1086398
> eefb1e70
> 1f00: 05355555 c1001f20 c075ce14 c075ce18 60000013 ffffffff
> [<c0101a70>] (__irq_svc) from [<c075ce18>] (cpuidle_enter_state+0x318/0x5ac)
> [<c075ce18>] (cpuidle_enter_state) from [<c075d0fc>]
> (cpuidle_enter+0x3c/0x54)
> [<c075d0fc>] (cpuidle_enter) from [<c0161950>] (do_idle+0x228/0x2b8)
> [<c0161950>] (do_idle) from [<c0161d94>] (cpu_startup_entry+0x18/0x1c)
> [<c0161d94>] (cpu_startup_entry) from [<c0f00ee0>]
> (start_kernel+0x4a8/0x4d8)
> handlers:
> [<99982b69>] ec_irq_handler threaded [<8fcfc375>] ec_irq_thread
> Disabling IRQ #158
>
> Reverting it make built-in keyboard to operate properly again.
>
> > ---
> >   drivers/platform/chrome/cros_ec.c           | 24 +++++++++++++++++++++
> >   include/linux/platform_data/cros_ec_proto.h |  3 +++
> >   2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> > index 9b2d07422e17..38ec1fb409a5 100644
> > --- a/drivers/platform/chrome/cros_ec.c
> > +++ b/drivers/platform/chrome/cros_ec.c
> > @@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >       return ret;
> >   }
> >
> > +static int cros_ec_ready_event(struct notifier_block *nb,
> > +     unsigned long queued_during_suspend, void *_notify)
> > +{
> > +     struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
> > +                                                  notifier_ready);
> > +     u32 host_event = cros_ec_get_host_event(ec_dev);
> > +
> > +     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
> > +             mutex_lock(&ec_dev->lock);
> > +             cros_ec_query_all(ec_dev);
> > +             mutex_unlock(&ec_dev->lock);
> > +             return NOTIFY_OK;
> > +     }
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> >   /**
> >    * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
> >    * @ec_dev: Device to register.
> > @@ -201,6 +218,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >               dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
> >                       err);
> >
> > +     /* Register the notifier for EC_HOST_EVENT_INTERFACE_READY event. */
> > +     ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
> > +     err = blocking_notifier_chain_register(&ec_dev->event_notifier,
> > +                                            &ec_dev->notifier_ready);
> > +     if (err)
> > +             return err;
> > +
> >       dev_info(dev, "Chrome EC device registered\n");
> >
> >       return 0;
> > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > index 0d4e4aaed37a..a1c545c464e7 100644
> > --- a/include/linux/platform_data/cros_ec_proto.h
> > +++ b/include/linux/platform_data/cros_ec_proto.h
> > @@ -121,6 +121,8 @@ struct cros_ec_command {
> >    * @event_data: Raw payload transferred with the MKBP event.
> >    * @event_size: Size in bytes of the event data.
> >    * @host_event_wake_mask: Mask of host events that cause wake from suspend.
> > + * @notifier_ready: The notifier_block to let the kernel re-query EC
> > + *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
> >    * @ec: The platform_device used by the mfd driver to interface with the
> >    *      main EC.
> >    * @pd: The platform_device used by the mfd driver to interface with the
> > @@ -161,6 +163,7 @@ struct cros_ec_device {
> >       int event_size;
> >       u32 host_event_wake_mask;
> >       u32 last_resume_result;
> > +     struct notifier_block notifier_ready;
> >
> >       /* The platform devices used by the mfd driver */
> >       struct platform_device *ec;
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
