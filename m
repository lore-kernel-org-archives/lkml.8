Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0231BC352BE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6FB2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392263AbgDOAHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:07:42 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50807 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392246AbgDOAHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:07:15 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03F05vMk028406;
        Wed, 15 Apr 2020 09:05:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Wed, 15 Apr 2020 09:05:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03F05ul5028393
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 15 Apr 2020 09:05:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
 <f2b9ef2a-8449-72fc-4f87-8bf65d713800@i-love.sakura.ne.jp>
Message-ID: <6e3864f5-fdaf-874a-b326-1c79816d7141@i-love.sakura.ne.jp>
Date:   Wed, 15 Apr 2020 09:05:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f2b9ef2a-8449-72fc-4f87-8bf65d713800@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/14 17:02, Tetsuo Handa wrote:
>> Some kind of "not even root" flag, which might be per-process and not
>> possible to clear once set (so that your _normal_ system binaries
>> could still do the root-only stuff, but then you could start a fuzzing
>> process with that flag set, knowing that the fuzzing process - and
>> it's children - are not able to do things).
> 
> I don't think per-process flags will work. Not every action is taken inside
> process context who issued a syscall. Some action might be taken in interrupt
> context or in kthread context. Since we have no means to propagate per-process
> flags, we will need to give up more than we have to give up.

An example from https://syzkaller.appspot.com/bug?id=fc28634f4815322260d0735ad0ed14f767b558b6 (currently the third top crasher in "open" table).

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3668 at net/core/dev.c:8776 rollback_registered_many+0x1ed/0xec0 net/core/dev.c:8776
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 3668 Comm: kworker/1:6 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 panic+0x2aa/0x6e1 kernel/panic.c:221
 __warn.cold+0x2f/0x30 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:rollback_registered_many+0x1ed/0xec0 net/core/dev.c:8776
Code: 05 00 00 31 ff 44 89 fe e8 10 ac 78 fc 45 84 ff 0f 85 49 ff ff ff e8 d2 aa 78 fc 0f 1f 44 00 00 e8 c8 aa 78 fc e8 c3 aa 78 fc <0f> 0b 48 89 ef e8 59 2e 24 fd 31 ff 89 c5 89 c6 e8 de ab 78 fc 40
RSP: 0018:ffff8881d4b7f640 EFLAGS: 00010216
RAX: 0000000000040000 RBX: ffff8881d1620000 RCX: ffffc9000d3f6000
RDX: 0000000000003912 RSI: ffffffff84c6ad5d RDI: 0000000000000001
RBP: ffff8881d1620068 R08: ffff8881c74d9880 R09: fffffbfff0f876c5
R10: fffffbfff0f876c4 R11: ffffffff87c3b627 R12: ffff8881d4b7f788
R13: dffffc0000000000 R14: ffff8881d4b7f720 R15: 0000000000000000
 rollback_registered+0xf2/0x1c0 net/core/dev.c:8855
 unregister_netdevice_queue net/core/dev.c:9947 [inline]
 unregister_netdevice_queue+0x1d7/0x2b0 net/core/dev.c:9940
 unregister_netdevice include/linux/netdevice.h:2715 [inline]
 unregister_netdev+0x18/0x20 net/core/dev.c:9988
 r871xu_dev_remove+0xe2/0x215 drivers/staging/rtl8712/usb_intf.c:604
 usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:436
 __device_release_driver drivers/base/dd.c:1137 [inline]
 device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 usb_disable_device+0x23d/0x790 drivers/usb/core/message.c:1238
 usb_disconnect+0x293/0x900 drivers/usb/core/hub.c:2211
 hub_port_connect drivers/usb/core/hub.c:5046 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5335 [inline]
 port_event drivers/usb/core/hub.c:5481 [inline]
 hub_event+0x1a1d/0x4300 drivers/usb/core/hub.c:5563
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 process_scheduled_works kernel/workqueue.c:2328 [inline]
 worker_thread+0x7ab/0xe20 kernel/workqueue.c:2414
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

8767         list_for_each_entry_safe(dev, tmp, head, unreg_list) {
8768                 /* Some devices call without registering
8769                  * for initialization unwind. Remove those
8770                  * devices and proceed with the remaining.
8771                  */
8772                 if (dev->reg_state == NETREG_UNINITIALIZED) {
8773                         pr_debug("unregister_netdevice: device %s/%p never was registered\n",
8774                                  dev->name, dev);
8775 
8776                         WARN_ON(1);
8777                         list_del(&dev->unreg_list);
8778                         continue;
8779                 }
8780                 dev->dismantle = true;
8781                 BUG_ON(dev->reg_state != NETREG_REGISTERED);
8782         }

I can't judge whether this WARN_ON() makes sense outside of syzkaller.
But I'd like to suppress this WARN_ON() under testing by syzkaller so that
syzkaller can spend resource for seeking for different bugs (assuming that
suppressing this WARN_ON() is harmless). To suppress this WARN_ON(),
per-process flags (e.g. current->dont_hit_warn_on_at_rollback_registered_many )
cannot work because this is a Workqueue context. And user-visible global flags
(e.g. sysctl_dont_hit_warn_on_at_rollback_registered_many ) is too much.

An approach for TOMOYO to solve this kind of problem is to guard using
a kernel config option for fuzz testing.

  commit e80b18599a39a625 ("tomoyo: Add a kernel config option for fuzzing testing.")
  commit 4ad98ac46490d5f8 ("tomoyo: Don't emit WARNING: string while fuzzing testing.")

This is not something that should publish permanently user-visible flags.
