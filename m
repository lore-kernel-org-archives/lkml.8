Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904BE207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgEUXfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:35:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62995 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgEUXfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:35:20 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04LNYvGa068748;
        Fri, 22 May 2020 08:34:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Fri, 22 May 2020 08:34:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04LNYvHw068745
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 22 May 2020 08:34:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [5.7-rc5 x86 regression] ORC unwinder generates unreliable traces
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000c866c705a61a95d4@google.com>
 <9a337dfa-175f-e13b-1977-0f63d589f37c@I-love.SAKURA.ne.jp>
 <CACT4Y+bAg0jJSVSu-AwP2k5QMk3kgnwRn4xXb3C5Mx-CyMRwdA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <99be7df0-c0af-3985-aa7b-674990e319b2@i-love.sakura.ne.jp>
Date:   Fri, 22 May 2020 08:34:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bAg0jJSVSu-AwP2k5QMk3kgnwRn4xXb3C5Mx-CyMRwdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

syzbot is troubled by CONFIG_UNWINDER_ORC=y .

As of commit d2f8825ab78e4c18 ("Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost"),
sched_show_task() is defunctional (all threads' traces are marked as 'unreliable').

[   43.975229] sysrq: Show State
[   43.978609]   task                        PC stack   pid father
[   43.981856] systemd         S11664     1      0 0x00000000
[   43.984118] Call Trace:
[   43.985626]  ? __schedule+0x27d/0x770
[   43.987738]  ? schedule+0x5a/0xd0
[   43.989509]  ? schedule_hrtimeout_range_clock+0x11c/0x130
[   43.991702]  ? ep_poll+0x461/0x4f0
[   43.993384]  ? _raw_write_unlock_irq+0x1f/0x30
[   43.995343]  ? ep_poll+0x472/0x4f0
[   43.997053]  ? wait_woken+0xa0/0xa0
[   43.998763]  ? do_epoll_wait+0xcd/0xf0
[   44.000494]  ? __x64_sys_epoll_wait+0x15/0x20
[   44.002385]  ? do_syscall_64+0x45/0x1d0
[   44.004158]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3

Since v5.7-rc5 is bad and v5.7-rc4 is good, the culprit is commit c14cab2688d09b85
("Merge tag 'x86-urgent-2020-05-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
which contains

    Pull x86 fixes from Thomas Gleixner:
     "A set of fixes for x86:
(...snipped...)
       - A series of fixes for objtool and the ORC unwinder addressing
         variety of small issues:

in the log.

----------
Kernel 5.7.0-rc6-00069-gd2f8825ab78e on an x86_64

localhost login: [   43.975229][    C6] sysrq: Show State
[   43.978609][    C6]   task                        PC stack   pid father
[   43.981856][    C6] systemd         S11664     1      0 0x00000000
[   43.984118][    C6] Call Trace:
[   43.985626][    C6]  ? __schedule+0x27d/0x770
[   43.987738][    C6]  ? schedule+0x5a/0xd0
[   43.989509][    C6]  ? schedule_hrtimeout_range_clock+0x11c/0x130
[   43.991702][    C6]  ? ep_poll+0x461/0x4f0
[   43.993384][    C6]  ? _raw_write_unlock_irq+0x1f/0x30
[   43.995343][    C6]  ? ep_poll+0x472/0x4f0
[   43.997053][    C6]  ? wait_woken+0xa0/0xa0
[   43.998763][    C6]  ? do_epoll_wait+0xcd/0xf0
[   44.000494][    C6]  ? __x64_sys_epoll_wait+0x15/0x20
[   44.002385][    C6]  ? do_syscall_64+0x45/0x1d0
[   44.004158][    C6]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3

----------
Kernel 5.7.0-rc5 on an x86_64

localhost login: [   33.662344][    C6] sysrq: Show State
[   33.663434][    C6]   task                        PC stack   pid father
[   33.665144][    C6] systemd         S11968     1      0 0x00000000
[   33.666724][    C6] Call Trace:
[   33.667603][    C6]  ? __schedule+0x27d/0x770
[   33.668692][    C6]  ? schedule+0x5a/0xd0
[   33.669834][    C6]  ? schedule_hrtimeout_range_clock+0x11c/0x130
[   33.671397][    C6]  ? ep_poll+0x29e/0x4d0
[   33.672494][    C6]  ? _raw_write_unlock_irq+0x1f/0x30
[   33.673811][    C6]  ? ep_poll+0x45c/0x4d0
[   33.674839][    C6]  ? wait_woken+0xa0/0xa0
[   33.676000][    C6]  ? do_epoll_wait+0xcd/0xf0
[   33.677184][    C6]  ? __x64_sys_epoll_wait+0x15/0x20
[   33.678433][    C6]  ? do_syscall_64+0x45/0x1d0
[   33.679637][    C6]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3

----------
Kernel 5.7.0-rc4 on an x86_64

localhost login: [   35.448925][    C6] sysrq: Show State
[   35.450252][    C6]   task                        PC stack   pid father
[   35.452227][    C6] systemd         S11944     1      0 0x00000000
[   35.454001][    C6] Call Trace:
[   35.454983][    C6]  ? __schedule+0x27d/0x770
[   35.456288][    C6]  schedule+0x5a/0xd0
[   35.457393][    C6]  schedule_hrtimeout_range_clock+0x11c/0x130
[   35.459106][    C6]  ? ep_poll+0x40b/0x4c0
[   35.460306][    C6]  ? _raw_write_unlock_irq+0x1f/0x30
[   35.461840][    C6]  ep_poll+0x38f/0x4c0
[   35.463017][    C6]  ? wake_up_q+0x90/0x90
[   35.464230][    C6]  do_epoll_wait+0xcd/0xf0
[   35.465464][    C6]  __x64_sys_epoll_wait+0x15/0x20
[   35.466878][    C6]  do_syscall_64+0x45/0x1d0
[   35.468073][    C6]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[   35.469657][    C6] RIP: 0033:0x7f1f191b0e93
[   35.470910][    C6] Code: Bad RIP value.
[   35.472046][    C6] RSP: 002b:00007fffc4c25c88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
[   35.474303][    C6] RAX: ffffffffffffffda RBX: 00007fffc4c25c90 RCX: 00007f1f191b0e93
[   35.476852][    C6] RDX: 0000000000000035 RSI: 00007fffc4c25c90 RDI: 0000000000000004
[   35.479254][    C6] RBP: 00007fffc4c26000 R08: 9c23bff2734474f6 R09: 000055ec811556e0
[   35.481458][    C6] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
[   35.483643][    C6] R13: ffffffffffffffff R14: 0000000000000000 R15: 000055ec81fd23b0

----------

