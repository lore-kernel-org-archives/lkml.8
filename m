Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D897FC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C381A2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgD3OLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:11:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:39344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgD3OL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:11:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6350AAD31;
        Thu, 30 Apr 2020 14:11:24 +0000 (UTC)
Date:   Thu, 30 Apr 2020 16:11:21 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200430141120.GA8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429100731.201312a9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 29, 2020 at 10:07:31AM -0400, Steven Rostedt wrote:
> Talking with Mathieu about this on IRC, he pointed out that my code does
> have a vzalloc() that is called:
> 
> in trace_pid_write()
> 
> 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
> 
> This is done when -P1,2 is on the trace-cmd command line.

Okay, tracked it down, some instrumentation in the page-fault and
double-fault handler gave me the stack-traces. Here is what happens:

As already pointed out, it all happens because of page-faults on the
vzalloc'ed pid bitmap. It starts with this stack-trace:

 RIP: 0010:trace_event_ignore_this_pid+0x23/0x30
 Code: e9 c2 4b 6b 00 cc cc 48 8b 57 28 48 8b 8a b8 00 00 00 48 8b 82 c0 00 00 00 48 85 c0 74 11 48 8b 42 28 65 48 03 05 5d 9c e6 7e <0f> b6 40 7c c3 48 85 c9 75 ea f3 c3 90 48 8b 4f 70 48 83 02 01 48
 RSP: 0018:ffffc90000673bd8 EFLAGS: 00010082
 RAX: ffffe8ffffd8c870 RBX: 0000000000000203 RCX: ffff88810734ca90
 RDX: ffff888451578000 RSI: ffffffff820f3d2a RDI: ffff888453594d68
 RBP: ffff888453594d68 R08: 000000000001845e R09: ffffffff81114ba0
 R10: 0000000000000000 R11: 000000000000000e R12: 4000000000000000
 R13: ffffffff820f3d2a R14: 000000000001845e R15: 4000000000000002
  ? trace_event_raw_event_rcu_fqs+0xa0/0xa0
  trace_event_raw_event_rcu_dyntick+0x89/0xa0
  ? trace_event_raw_event_rcu_dyntick+0x89/0xa0
  ? trace_event_raw_event_rcu_dyntick+0x89/0xa0
  ? insn_get_prefixes.part.2+0x174/0x2d0
  rcu_irq_enter+0xf0/0x1d0
  rcu_irq_enter_irqson+0x21/0x50
  switch_mm_irqs_off+0x43c/0x570
  ? do_one_initcall+0x51/0x210
  __text_poke+0x1a9/0x470
  text_poke_bp_batch+0x73/0x180
  text_poke_flush+0x43/0x50
  arch_jump_label_transform_apply+0x16/0x30
  __static_key_slow_dec_cpuslocked+0x42/0x50
  static_key_slow_dec+0x1f/0x50
  tracepoint_probe_unregister+0x1e2/0x220
  trace_event_reg+0x6a/0x80
  __ftrace_event_enable_disable+0x1ca/0x240
  __ftrace_set_clr_event_nolock+0xe1/0x140
  __ftrace_set_clr_event+0x3d/0x60
  system_enable_write+0x76/0xa0
  vfs_write+0xad/0x1a0
  ? rcu_irq_exit+0xb8/0x170
  ksys_write+0x48/0xb0
  do_syscall_64+0x60/0x200
  entry_SYSCALL_64_after_hwframe+0x49/0xb3
 RIP: 0033:0x7f875b0ecdb0
 Code: Bad RIP value.
 RSP: 002b:00007ffc746be918 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f875b0ecdb0
 RDX: 0000000000000001 RSI: 00007ffc746be93f RDI: 0000000000000004
 RBP: 00007ffc746be9a0 R08: 636172742f6c6500 R09: 0000000002242ee0
 R10: 6f662f7365636e61 R11: 0000000000000246 R12: 000000000040a4b0
 R13: 00007ffc746bebd0 R14: 0000000000000000 R15: 0000000000000000

I havn't figured out how rcu_irq_enter() calls down into
trace_event_raw_event_rcu_dyntick() and further into
trace_event_ignore_this_pid(), but the stacktrace shows it does.

So trace_event_ignore_this_pid() faults on the vzalloc()'ed memory, calling
into the page-fault handler. What happens there is:

 RIP: 0010:trace_event_ignore_this_pid+0x23/0x30
 Code: e9 c2 4b 6b 00 cc cc 48 8b 57 28 48 8b 8a b8 00 00 00 48 8b 82 c0 00 00 00 48 85 c0 74 11 48 8b 42 28 65 48 03 05 5d 9c e6 7e <0f> b6 40 7c c3 48 85 c9 75 ea f3 c3 90 48 8b 4f 70 48 83 02 01 48
 RSP: 0018:ffffc90000673a50 EFLAGS: 00010082
 RAX: ffffe8ffffd8c870 RBX: 0000000000000203 RCX: ffff88810734ca90
 RDX: ffff888451578000 RSI: ffffe8ffffd8c8ec RDI: ffff88844fd98478
 RBP: ffff88844fd98478 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffffe8ffffd8c8ec
 R13: 0000000000000000 R14: ffffc90000673b28 R15: 0000000000000000
  trace_event_raw_event_x86_exceptions+0x87/0xa0
  ? trace_event_buffer_lock_reserve+0x6e/0x110
  do_page_fault+0x45e/0x630
  ? trace_hardirqs_off_thunk+0x1a/0x37
  page_fault+0x43/0x50

The page-fault handler calls a tracing function which again ends up in
trace_event_ignore_this_pid(), where it faults again. From here on the CPU is in
a page-fault loop, which continues until the stack overflows (with
CONFIG_VMAP_STACK).

Then there is no mapped stack anymore, so the page-fault results in a
double-fault, which uses an IST stack. The double-fault handler does
ist_enter(), which calls into rcu_nmi_enter(), which also has trace-events down
its call-path. I have no stack-trace for this, but what likely happens
now is that it page-faults again while on the IST stack and the
page-fault loops until the #DF IST stack overflows. Then the next #DF
happens and the stack pointer is reset to the top of the #DF IST stack,
starting the loop over again. This loops forever, causing the hang.

Regards,

	Joerg

