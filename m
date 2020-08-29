Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A9BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 01:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8680B20838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 01:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgH2BYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:24:16 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57315 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726236AbgH2BYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 21:24:16 -0400
Received: (qmail 487363 invoked by uid 1000); 28 Aug 2020 21:24:15 -0400
Date:   Fri, 28 Aug 2020 21:24:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, bigeasy@linutronix.de,
        felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        joe@perches.com, johan@kernel.org, kai.heng.feng@canonical.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael.j.wysocki@intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in usb_bulk_msg
Message-ID: <20200829012415.GB486691@rowland.harvard.edu>
References: <000000000000d3c499057536ce86@google.com>
 <000000000000c69c7805adef8597@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c69c7805adef8597@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:52:16AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1052a669900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> dashboard link: https://syzkaller.appspot.com/bug?extid=7a7613e5ba9ae7bd15f9
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c328e900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eff41900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com
> 
> INFO: task syz-executor790:9958 blocked for more than 143 seconds.
>       Not tainted 5.9.0-rc2-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor790 state:D stack:28240 pid: 9958 ppid:  6854 flags:0x00004004
> Call Trace:
>  context_switch kernel/sched/core.c:3778 [inline]
>  __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
>  schedule+0xd0/0x2a0 kernel/sched/core.c:4602
>  schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
>  do_wait_for_common kernel/sched/completion.c:85 [inline]
>  __wait_for_common kernel/sched/completion.c:106 [inline]
>  wait_for_common kernel/sched/completion.c:117 [inline]
>  wait_for_completion_timeout+0x15e/0x270 kernel/sched/completion.c:157
>  usb_start_wait_urb+0x144/0x2b0 drivers/usb/core/message.c:63
>  usb_bulk_msg+0x226/0x550 drivers/usb/core/message.c:254
>  do_proc_bulk+0x39b/0x710 drivers/usb/core/devio.c:1231
>  proc_bulk drivers/usb/core/devio.c:1268 [inline]
>  usbdev_do_ioctl drivers/usb/core/devio.c:2542 [inline]
>  usbdev_ioctl+0x586/0x3360 drivers/usb/core/devio.c:2708

I'm confused about this bug report.

Here's the syz reproducer from the link listed above:

# 
https://syzkaller.appspot.com/bug?id=bf172344c5f1d3487a4feff67c3dd30e08d5b635
# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
#{"threaded":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"netdev":true,"close_fds":true}
r0 = syz_open_dev$usbfs(&(0x7f0000000040)='/dev/bus/usb/00#/00#\x00', 
0x4000000000000071, 0x28081)
r1 = socket$inet6(0xa, 0x2, 0x0)
r2 = dup(r1)
ioctl$PERF_EVENT_IOC_ENABLE(r2, 0x8912, 0x400200)
socketpair$unix(0x1, 0x0, 0x0, &(0x7f0000000000))
ioctl$USBDEVFS_CONTROL(r0, 0x8108551b, &(0x7f0000001140)={0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0})
ioctl$USBDEVFS_CLEAR_HALT(r0, 0xc0185502, &(0x7f0000000000)={0x1, 0x1})

As far as I can see, the only USB ioctls used in this test are 
USBDEVFS_CONTROL and USBDEVFS_CLEAR_HALT.  Neither of those calls 
do_proc_bulk() or usb_bulk_msg(), so how did those routines end up in 
the stack trace?

In fact, do_proc_bulk() is called only for USBDEVFS_BULK.  But the test 
doesn't use that ioctl!

What's going on?  Am I missing part of the test?

Alan Stern

