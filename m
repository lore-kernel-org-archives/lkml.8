Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F71CC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69108206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axIVAF/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgCYIqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:46:12 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43947 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCYIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:46:11 -0400
Received: by mail-vs1-f65.google.com with SMTP id w185so983031vsw.10;
        Wed, 25 Mar 2020 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MIiTW9Ytzte99WeenMF81qYVzmN4cMx/ufBSjES47w=;
        b=axIVAF/4mMgKGhZXuDt1jyUjTzacbl6BR/h+EGepTJL/PFuu00A1jL60hNA3z5b38m
         AA4S7HclPVeTIXMyGSwKlF9vCw2wPFao97Ihc0tUox42sJvc0nSu+MVYuHHBDEn/kXIW
         Q3Ch6qyG5GcdhVoJtDe4RgY4cX2LK9SBSFQdVzRX3Y+PfiiTAch442igaE4txkyohKkd
         M1J5US+i+GctbjQ+PcHveWgqGnEUWKyQAgAL8GYAn/I9/ysnas+iAr0B5hVwXbA+LaOM
         c9kqO6bgqgDh9x5ten1lywbFRfm4g7y2KURfsrRQpgtGGiesI8fWZOyX5AJyiqNnH/hZ
         x+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MIiTW9Ytzte99WeenMF81qYVzmN4cMx/ufBSjES47w=;
        b=KLdIxqwn8c1D4vYey76jel9moX7koOpBnFNqBZDEOFE32V627p6ijfXUYqMSvM+RXb
         tHCO+E4iOcPHqmLFqLMWAnuPkjpHY1gaA+qIzw+dIAWqQDI1Fu+9zHNwVc9NDtYBjvMK
         RRzUw6KLA4HExegRgF661KidgGB7WBKKFR5k/q6pAKwQjgVEpJfKX3O/tt52JQyYJPPL
         ZuCIcO5+P+HlmtjjcJYgVqnyUOKu/1JqWAljx8VJApQnYRZhJTkBpTNfT31vSueJvsCW
         GvAjK9mWwi7zrAw0tN4GoWXEfnTvFbVyEnkLN2qlf6lrnzpGSsXt3R03JW+JZTmJgsaq
         ET5w==
X-Gm-Message-State: ANhLgQ3MMU+k/zJz6dujiq3Vh/gV8DZFNjaOqgUdXm6IMZ71DchclzSD
        fAaghHYLKxF08ETZisqWc9hkSLW/FfP8UXxDa20lVs6GGC4=
X-Google-Smtp-Source: ADFU+vvmv6G94nXegVPaUhLUoiuhutsXjS9fU+mu16KSFYz3lKT7gaXvljbjuXFSD4XbCFpgcdIUDOSanNELClOfLxk=
X-Received: by 2002:a67:c189:: with SMTP id h9mr1606233vsj.91.1585125968774;
 Wed, 25 Mar 2020 01:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000039420505a14e4951@google.com>
In-Reply-To: <00000000000039420505a14e4951@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Wed, 25 Mar 2020 16:45:57 +0800
Message-ID: <CADG63jANt9w4rFWKg6cw_S4jvB+Q-2hyOp9Mm0WD3oyQofY6UA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hfa384x_usbin_callback
To:     syzbot <syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        nishkadg.linux@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000004b5e2605a1a9e684"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004b5e2605a1a9e684
Content-Type: text/plain; charset="UTF-8"

#syz test: https://github.com/google/kasan.git e17994d1

On Sat, Mar 21, 2020 at 3:28 AM syzbot
<syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d74573e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fa561de00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d74573e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:381 [inline]
> BUG: KASAN: slab-out-of-bounds in skb_put_data include/linux/skbuff.h:2284 [inline]
> BUG: KASAN: slab-out-of-bounds in hfa384x_int_rxmonitor drivers/staging/wlan-ng/hfa384x_usb.c:3412 [inline]
> BUG: KASAN: slab-out-of-bounds in hfa384x_usbin_rx drivers/staging/wlan-ng/hfa384x_usb.c:3312 [inline]
> BUG: KASAN: slab-out-of-bounds in hfa384x_usbin_callback+0x1993/0x2360 drivers/staging/wlan-ng/hfa384x_usb.c:3026
> Read of size 19671 at addr ffff8881d226413c by task swapper/0/0
>
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xef/0x16e lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd3/0x314 mm/kasan/report.c:374
>  __kasan_report.cold+0x37/0x77 mm/kasan/report.c:506
>  kasan_report+0xe/0x20 mm/kasan/common.c:641
>  check_memory_region_inline mm/kasan/generic.c:185 [inline]
>  check_memory_region+0x152/0x1c0 mm/kasan/generic.c:192
>  memcpy+0x20/0x50 mm/kasan/common.c:127
>  memcpy include/linux/string.h:381 [inline]
>  skb_put_data include/linux/skbuff.h:2284 [inline]
>  hfa384x_int_rxmonitor drivers/staging/wlan-ng/hfa384x_usb.c:3412 [inline]
>  hfa384x_usbin_rx drivers/staging/wlan-ng/hfa384x_usb.c:3312 [inline]
>  hfa384x_usbin_callback+0x1993/0x2360 drivers/staging/wlan-ng/hfa384x_usb.c:3026
>  __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
>  usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
>  dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
>  call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
>  expire_timers kernel/time/timer.c:1449 [inline]
>  __run_timers kernel/time/timer.c:1773 [inline]
>  __run_timers kernel/time/timer.c:1740 [inline]
>  run_timer_softirq+0x5f9/0x1500 kernel/time/timer.c:1786
>  __do_softirq+0x21e/0x950 kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0x178/0x1a0 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
>  smp_apic_timer_interrupt+0x141/0x540 arch/x86/kernel/apic/apic.c:1146
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>  </IRQ>
> RIP: 0010:default_idle+0x28/0x300 arch/x86/kernel/process.c:696
> Code: cc cc 41 56 41 55 65 44 8b 2d 44 77 72 7a 41 54 55 53 0f 1f 44 00 00 e8 b6 62 b5 fb e9 07 00 00 00 0f 00 2d ea 0c 53 00 fb f4 <65> 44 8b 2d 20 77 72 7a 0f 1f 44 00 00 5b 5d 41 5c 41 5d 41 5e c3
> RSP: 0018:ffffffff87007d80 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: ffffffff8702cc40 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff8702d48c
> RBP: fffffbfff0e05988 R08: ffffffff8702cc40 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffff87e607c0 R15: 0000000000000000
>  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
>  do_idle+0x3e0/0x500 kernel/sched/idle.c:269
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:361
>  start_kernel+0xe16/0xe5a init/main.c:998
>  secondary_startup_64+0xb6/0xc0 arch/x86/kernel/head_64.S:242
>
> The buggy address belongs to the page:
> page:ffffea0007489800 refcount:32744 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
> flags: 0x200000000010000(head)
> raw: 0200000000010000 dead000000000100 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00007fe8ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8881d2268000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8881d2268080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff8881d2268100: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
>                    ^
>  ffff8881d2268180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8881d2268200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

--0000000000004b5e2605a1a9e684
Content-Type: application/octet-stream; 
	name="0002-staging-wlan-ng-fix-ODEBUG-bug-in-prism2sta_disconne.patch"
Content-Disposition: attachment; 
	filename="0002-staging-wlan-ng-fix-ODEBUG-bug-in-prism2sta_disconne.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8731i4t0>
X-Attachment-Id: f_k8731i4t0

RnJvbSA4NGEzMWJhMzI2ZjRiODAyYjIyYThkMjgyNTFiODgxYmY0YzcyOTBkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaXVqdW4gSHVhbmcgPGhxamFnYWluQGdtYWlsLmNvbT4KRGF0
ZTogV2VkLCAyNSBNYXIgMjAyMCAxNDo1NToyNSArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8zXSBz
dGFnaW5nOiB3bGFuLW5nOiBmaXggT0RFQlVHIGJ1ZyBpbgogcHJpc20yc3RhX2Rpc2Nvbm5lY3Rf
dXNiCgpXZSBzaG91bGQgY2FuY2VsIGh3LT51c2Jfd29yayBiZWZvcmUga2ZyZWUoaHcpLgoKUmVw
b3J0ZWQtYnk6IHN5emJvdCs2ZDJlN2Y2ZmE5MGUyN2JlOWQ2MkBzeXprYWxsZXIuYXBwc3BvdG1h
aWwuY29tClNpZ25lZC1vZmYtYnk6IFFpdWp1biBIdWFuZyA8aHFqYWdhaW5AZ21haWwuY29tPgot
LS0KIGRyaXZlcnMvc3RhZ2luZy93bGFuLW5nL3ByaXNtMnVzYi5jIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2xhbi1u
Zy9wcmlzbTJ1c2IuYyBiL2RyaXZlcnMvc3RhZ2luZy93bGFuLW5nL3ByaXNtMnVzYi5jCmluZGV4
IDM1MjU1NmYuLjQ2ODliMjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy93bGFuLW5nL3By
aXNtMnVzYi5jCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93bGFuLW5nL3ByaXNtMnVzYi5jCkBAIC0x
ODAsNiArMTgwLDcgQEAgc3RhdGljIHZvaWQgcHJpc20yc3RhX2Rpc2Nvbm5lY3RfdXNiKHN0cnVj
dCB1c2JfaW50ZXJmYWNlICppbnRlcmZhY2UpCiAKIAkJY2FuY2VsX3dvcmtfc3luYygmaHctPmxp
bmtfYmgpOwogCQljYW5jZWxfd29ya19zeW5jKCZody0+Y29tbXNxdWFsX2JoKTsKKwkJY2FuY2Vs
X3dvcmtfc3luYygmaHctPnVzYl93b3JrKTsKIAogCQkvKiBOb3cgd2UgY29tcGxldGUgYW55IG91
dHN0YW5kaW5nIGNvbW1hbmRzCiAJCSAqIGFuZCB0ZWxsIGV2ZXJ5b25lIHdobyBpcyB3YWl0aW5n
IGZvciB0aGVpcgotLSAKMS44LjMuMQoK
--0000000000004b5e2605a1a9e684--
