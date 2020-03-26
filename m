Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF0C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FC420719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg2luxP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCZCXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:23:05 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46729 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZCXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:23:05 -0400
Received: by mail-ua1-f65.google.com with SMTP id y17so1569823uap.13;
        Wed, 25 Mar 2020 19:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qau2pFs0NqgRfFqs7QCcgxC2r7nkLQxYL4T+aMhiaYU=;
        b=mg2luxP+a2Y+eVzA7uP1Uwvt5k97nJSkHM+e+t6rYbyfhU+jqS871GE55wXFlNPUN6
         lNUzWCuorypaYonOiXbThyFPLl1ZGkCGM6UP/gOvC790HmZj/Ov4nO5GUPJfZHm85vkq
         5msBrXgVcaZ3CghzqOgmZPQyWT7b41yeMrmLjBaajRy5hwaG8W/LXj/HuVVJCULnTR+U
         3FdK3OTEvA2HC/W2iro++7u8nMndaxnloGa6gyBhtSEp37wYaGIVDqbZ13zamH2P0Bal
         5Xb35NJS0zEW0UYNMt3MZy+sY91Rey3LtDCRTKjBoBFE8nWwh1GfiVj8RzMkg0IG2hBl
         kh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qau2pFs0NqgRfFqs7QCcgxC2r7nkLQxYL4T+aMhiaYU=;
        b=epLII390vFwWwbIulRgEHjiJGMoABb7GFg6aHjSNl7BsAYQWsHxrl7RiCam6K2erxD
         Or+D+gLhdroI0nPT78RDFSDgIwZZ2aW0V5BAFb463yw/KD9FJMO0+j35QdC/hBSynpvj
         anASEErzZll2i7hmK+TQcijVAMr/qOxqTe9067sY23/oHsgmS5FVxl0+pimOxZlyc/0r
         6FzX5WkZtDRWsv8wglHItNepRiIRupNIFIUk5jkg45pup3grV+AqH17UEqqwzgTH7U5E
         BzLnynwTSl5vAu20kQMtXHLgU12aC+UCJjd1heLHgI0+KiW7dHurcwfj73RQdGwlc23n
         1gRQ==
X-Gm-Message-State: ANhLgQ2ZTaab++SBWIJULUY3UTygUL9y/S1rT3rQ1UmhaX3QQxqEd42P
        eIXv+4CWKTO6jUh+knV6eUS9s37wwulWLaNaBnM=
X-Google-Smtp-Source: ADFU+vucyMIQyKFGl57OWLYnUNSf8Y3e9MmsBqUTQEMInAQj/n9qPwg0AMhlZX0+6+RmkCXjj5i3qfr/Bc8la2N04ww=
X-Received: by 2002:a9f:28c5:: with SMTP id d63mr4856648uad.25.1585189381919;
 Wed, 25 Mar 2020 19:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <CADG63jANt9w4rFWKg6cw_S4jvB+Q-2hyOp9Mm0WD3oyQofY6UA@mail.gmail.com>
 <20200325131309.12792-1-hdanton@sina.com>
In-Reply-To: <20200325131309.12792-1-hdanton@sina.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Thu, 26 Mar 2020 10:22:48 +0800
Message-ID: <CADG63jA_7L87d4Bm6JDBD7AoYi5MCBJEUDd4SvW43Afg385d+Q@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hfa384x_usbin_callback
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        nishkadg.linux@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="00000000000002f33805a1b8aa72"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000002f33805a1b8aa72
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 25, 2020 at 9:13 PM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Wed, 25 Mar 2020 01:58:03 -0700
> > syzbot has tested the proposed patch but the reproducer still triggered crash:
> > KASAN: use-after-free Read in hfa384x_usbin_callback
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in memcpy include/linux/string.h:381 [inline]
> > BUG: KASAN: use-after-free in skb_put_data include/linux/skbuff.h:2284 [inline]
> > BUG: KASAN: use-after-free in hfa384x_int_rxmonitor drivers/staging/wlan-ng/hfa384x_usb.c:3412 [inline]
> > BUG: KASAN: use-after-free in hfa384x_usbin_rx drivers/staging/wlan-ng/hfa384x_usb.c:3312 [inline]
> > BUG: KASAN: use-after-free in hfa384x_usbin_callback+0x1993/0x2360 drivers/staging/wlan-ng/hfa384x_usb.c:3026
> > Read of size 19671 at addr ffff8881cda7b33c by task kworker/1:2/95
> >
> > CPU: 1 PID: 95 Comm: kworker/1:2 Not tainted 5.6.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0xef/0x16e lib/dump_stack.c:118
> >  print_address_description.constprop.0.cold+0xd3/0x314 mm/kasan/report.c:374
> >  __kasan_report.cold+0x37/0x77 mm/kasan/report.c:506
> >  kasan_report+0xe/0x20 mm/kasan/common.c:641
> >  check_memory_region_inline mm/kasan/generic.c:185 [inline]
> >  check_memory_region+0x152/0x1c0 mm/kasan/generic.c:192
> >  memcpy+0x20/0x50 mm/kasan/common.c:127
> >  memcpy include/linux/string.h:381 [inline]
> >  skb_put_data include/linux/skbuff.h:2284 [inline]
> >  hfa384x_int_rxmonitor drivers/staging/wlan-ng/hfa384x_usb.c:3412 [inline]
> >  hfa384x_usbin_rx drivers/staging/wlan-ng/hfa384x_usb.c:3312 [inline]
> >  hfa384x_usbin_callback+0x1993/0x2360 drivers/staging/wlan-ng/hfa384x_usb.c:3026
> >  __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
> >  usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
> >  dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
> >  call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
> >  expire_timers kernel/time/timer.c:1449 [inline]
> >  __run_timers kernel/time/timer.c:1773 [inline]
> >  __run_timers kernel/time/timer.c:1740 [inline]
> >  run_timer_softirq+0x5f9/0x1500 kernel/time/timer.c:1786
> >  __do_softirq+0x21e/0x950 kernel/softirq.c:292
> >  invoke_softirq kernel/softirq.c:373 [inline]
> >  irq_exit+0x178/0x1a0 kernel/softirq.c:413
> >  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
> >  smp_apic_timer_interrupt+0x141/0x540 arch/x86/kernel/apic/apic.c:1146
> >  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> >  </IRQ>
> > RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:85 [inline]
> > RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
> > RIP: 0010:_raw_spin_unlock_irqrestore+0x3b/0x40 kernel/locking/spinlock.c:191
> > Code: e8 2a e8 96 fb 48 89 ef e8 f2 c9 97 fb f6 c7 02 75 11 53 9d e8 16 50 b5 fb 65 ff 0d f7 bd 72 7a 5b 5d c3 e8 07 4e b5 fb 53 9d <eb> ed 0f 1f 00 55 48 89 fd 65 ff 05 dd bd 72 7a 45 31 c9 41 b8 01
> > RSP: 0018:ffff8881d56b6f40 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> > RAX: 0000000000000007 RBX: 0000000000000293 RCX: 0000000000000006
> > RDX: 0000000000000000 RSI: ffff8881d56a88f0 RDI: ffff8881d56a884c
> > RBP: ffff8881c0c64b80 R08: ffff8881d56a8000 R09: fffffbfff1266e8f
> > R10: fffffbfff1266e8e R11: ffffffff89337477 R12: 0000000000000000
> > R13: ffff8881c0c64bb8 R14: ffff8881c0c64b80 R15: ffff8881c0c64bb8
> >  hfa384x_usbctlx_submit+0x1cb/0x260 drivers/staging/wlan-ng/hfa384x_usb.c:3834
> >  hfa384x_docmd drivers/staging/wlan-ng/hfa384x_usb.c:1233 [inline]
> >  hfa384x_cmd_initialize+0x290/0x4f0 drivers/staging/wlan-ng/hfa384x_usb.c:846
> >  hfa384x_drvr_start+0x1f1/0x480 drivers/staging/wlan-ng/hfa384x_usb.c:2380
> >  prism2sta_ifstate+0x24e/0x510 drivers/staging/wlan-ng/prism2sta.c:471
> >  prism2sta_probe_usb.cold+0x1c8/0x49e drivers/staging/wlan-ng/prism2usb.c:112
> >  usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
> >  really_probe+0x290/0xac0 drivers/base/dd.c:551
> >  driver_probe_device+0x223/0x350 drivers/base/dd.c:724
> >  __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
> >  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
> >  __device_attach+0x217/0x390 drivers/base/dd.c:897
> >  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
> >  device_add+0x1459/0x1bf0 drivers/base/core.c:2500
> >  usb_set_configuration+0xe47/0x17d0 drivers/usb/core/message.c:2023
> >  usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:241
> >  usb_probe_device+0xd9/0x230 drivers/usb/core/driver.c:272
> >  really_probe+0x290/0xac0 drivers/base/dd.c:551
> >  driver_probe_device+0x223/0x350 drivers/base/dd.c:724
> >  __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
> >  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
> >  __device_attach+0x217/0x390 drivers/base/dd.c:897
> >  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
> >  device_add+0x1459/0x1bf0 drivers/base/core.c:2500
> >  usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2548
> >  hub_port_connect drivers/usb/core/hub.c:5195 [inline]
> >  hub_port_connect_change drivers/usb/core/hub.c:5335 [inline]
> >  port_event drivers/usb/core/hub.c:5481 [inline]
> >  hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5563
> >  process_one_work+0x94b/0x1620 kernel/workqueue.c:2264
> >  worker_thread+0x96/0xe20 kernel/workqueue.c:2410
> >  kthread+0x318/0x420 kernel/kthread.c:255
> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > The buggy address belongs to the page:
> > page:ffffea0007369e00 refcount:32737 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
> > flags: 0x200000000010000(head)
> > raw: 0200000000010000 dead000000000100 dead000000000122 0000000000000000
> > raw: 0000000000000000 0000000000000000 00007fe1ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff8881cda7ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffff8881cda7ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >ffff8881cda80000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                    ^
> >  ffff8881cda80080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8881cda80100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> >
> >
> > Tested on:
> >
> > commit:         e17994d1 usb: core: kcov: collect coverage from usb comple..
> > git tree:       https://github.com/google/kasan.git
> > console output: https://syzkaller.appspot.com/x/log.txt?x=139ea05be00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d52b19e00000
>
> Add a line of debug info.
>
> --- a/drivers/staging/wlan-ng/hfa384x_usb.c
> +++ b/drivers/staging/wlan-ng/hfa384x_usb.c
> @@ -3374,6 +3374,11 @@ static void hfa384x_int_rxmonitor(struct
>                          skblen - sizeof(struct p80211_caphdr));
>         }
>
> +       if (datalen > WLAN_DATA_MAXLEN) {
> +               pr_debug("%s datalen %u > WLAN_DATA_MAXLEN %u\n", __func__,
> +                                               datalen, WLAN_DATA_MAXLEN);
> +               return;
> +       }
>         skb = dev_alloc_skb(skblen);
>         if (!skb)
>                 return;

Great!

>

--00000000000002f33805a1b8aa72
Content-Type: application/octet-stream; 
	name="0002-staging-wlan-ng-fix-use-after-free-Read-in-hfa384x_u.patch"
Content-Disposition: attachment; 
	filename="0002-staging-wlan-ng-fix-use-after-free-Read-in-hfa384x_u.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k884thc40>
X-Attachment-Id: f_k884thc40

RnJvbSAzMGY1ZjIxODJkNTYyYjYwYzM1ZGY2NDgzYzkyYzFiZjYyZWQwZWM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaXVqdW4gSHVhbmcgPGhxamFnYWluQGdtYWlsLmNvbT4KRGF0
ZTogVGh1LCAyNiBNYXIgMjAyMCAxMDoxNDoxMiArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBz
dGFnaW5nOiB3bGFuLW5nOiBmaXggdXNlLWFmdGVyLWZyZWUgUmVhZCBpbgogaGZhMzg0eF91c2Jp
bl9jYWxsYmFjawoKQmVjYXVzZSB0aGUgc2l6ZSBvZiByeGZybS0+ZGF0YSBpcyBXTEFOX0RBVEFf
TUFYTEVOKDIzMTIpLHNvIHNrYmxlbgpjYW4ndCBiZSBtb3JlIHRoYW4gdGhhdC4KClNpZ25lZC1v
ZmYtYnk6IFFpdWp1biBIdWFuZyA8aHFqYWdhaW5AZ21haWwuY29tPgotLS0KIGRyaXZlcnMvc3Rh
Z2luZy93bGFuLW5nL2hmYTM4NHhfdXNiLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCiBtb2RlIGNoYW5nZSAxMDA2NDQgPT4gMTAwNzU1IGRyaXZlcnMvc3RhZ2luZy93
bGFuLW5nL2hmYTM4NHhfdXNiLmMKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2xhbi1u
Zy9oZmEzODR4X3VzYi5jIGIvZHJpdmVycy9zdGFnaW5nL3dsYW4tbmcvaGZhMzg0eF91c2IuYwpv
bGQgbW9kZSAxMDA2NDQKbmV3IG1vZGUgMTAwNzU1CmluZGV4IGI3MTc1NmFiMDM5NC4uN2ZlNjRm
Y2QzODVkCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy93bGFuLW5nL2hmYTM4NHhfdXNiLmMKKysrIGIv
ZHJpdmVycy9zdGFnaW5nL3dsYW4tbmcvaGZhMzg0eF91c2IuYwpAQCAtMzM3Miw2ICszMzcyLDgg
QEAgc3RhdGljIHZvaWQgaGZhMzg0eF9pbnRfcnhtb25pdG9yKHN0cnVjdCB3bGFuZGV2aWNlICp3
bGFuZGV2LAogCSAgICAgV0xBTl9IRFJfQTRfTEVOICsgV0xBTl9EQVRBX01BWExFTiArIFdMQU5f
Q1JDX0xFTikpIHsKIAkJcHJfZGVidWcoIm92ZXJsZW4gZnJtOiBsZW49JXpkXG4iLAogCQkJIHNr
YmxlbiAtIHNpemVvZihzdHJ1Y3QgcDgwMjExX2NhcGhkcikpOworCisJCXJldHVybjsKIAl9CiAK
IAlza2IgPSBkZXZfYWxsb2Nfc2tiKHNrYmxlbik7Ci0tIAoyLjE3LjEKCg==
--00000000000002f33805a1b8aa72--
