Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5781C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865EF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jRAACe3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD3PXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:23:32 -0400
Received: from mail.efficios.com ([167.114.26.124]:52070 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3PXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:23:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6B42F28F3E3;
        Thu, 30 Apr 2020 11:23:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C6EyuYAfL3om; Thu, 30 Apr 2020 11:23:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1416428F3E2;
        Thu, 30 Apr 2020 11:23:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1416428F3E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588260210;
        bh=6Sx1GJXEO6S/nQiDfv+3DQvQUtNhB+yVzvi6csoiNEY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jRAACe3RQ281gdlMDgzhST7siwMevuUcoLIzXVXMVBTFcLrNAtH9wfkTnzyllk4w6
         Ul8pL49wWreSDvAZRwuf2AGrRWHMe8DFSYxPuT2P6T4wvtToTDCsNhX2dWY459F6Qg
         AV/EuPk95TfKTrP8Lr7i1WbBAIutJtHzTM+AWA8G0BTYsqb/q3jJ9tTdj9YCWL+6/M
         SREYBgSiCzoAvsOy23JDQMEU4A+ecPy9t1YKU3VkzJnE8mpE8gGcZQQ0RcTtOSRogl
         rBCr3aL7o7DhekukEHgIB9+YqaipJbzBuMNH4EqN+uHymmzEL8fDqAp7DhX5Hpuv4m
         oEsqr2XtjmlkQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YuHCX-Utpz_I; Thu, 30 Apr 2020 11:23:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 03D6728F271;
        Thu, 30 Apr 2020 11:23:30 -0400 (EDT)
Date:   Thu, 30 Apr 2020 11:23:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joerg Roedel <jroedel@suse.de>, rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Message-ID: <50145570.77817.1588260209983.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200430141120.GA8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home> <20200429105941.GQ30814@suse.de> <20200429082854.6e1796b5@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200430141120.GA8135@suse.de>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: XrnEl/HdUEdw3GQc1LVTNHxd8OdDzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 30, 2020, at 10:11 AM, Joerg Roedel jroedel@suse.de wrote:

> Hi,
> 
> On Wed, Apr 29, 2020 at 10:07:31AM -0400, Steven Rostedt wrote:
>> Talking with Mathieu about this on IRC, he pointed out that my code does
>> have a vzalloc() that is called:
>> 
>> in trace_pid_write()
>> 
>> 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
>> 
>> This is done when -P1,2 is on the trace-cmd command line.
> 
> Okay, tracked it down, some instrumentation in the page-fault and
> double-fault handler gave me the stack-traces. Here is what happens:
> 
> As already pointed out, it all happens because of page-faults on the
> vzalloc'ed pid bitmap. It starts with this stack-trace:
> 
> RIP: 0010:trace_event_ignore_this_pid+0x23/0x30
> Code: e9 c2 4b 6b 00 cc cc 48 8b 57 28 48 8b 8a b8 00 00 00 48 8b 82 c0 00 00 00
> 48 85 c0 74 11 48 8b 42 28 65 48 03 05 5d 9c e6 7e <0f> b6 40 7c c3 48 85 c9 75
> ea f3 c3 90 48 8b 4f 70 48 83 02 01 48
> RSP: 0018:ffffc90000673bd8 EFLAGS: 00010082
> RAX: ffffe8ffffd8c870 RBX: 0000000000000203 RCX: ffff88810734ca90
> RDX: ffff888451578000 RSI: ffffffff820f3d2a RDI: ffff888453594d68
> RBP: ffff888453594d68 R08: 000000000001845e R09: ffffffff81114ba0
> R10: 0000000000000000 R11: 000000000000000e R12: 4000000000000000
> R13: ffffffff820f3d2a R14: 000000000001845e R15: 4000000000000002
>  ? trace_event_raw_event_rcu_fqs+0xa0/0xa0
>  trace_event_raw_event_rcu_dyntick+0x89/0xa0
>  ? trace_event_raw_event_rcu_dyntick+0x89/0xa0
>  ? trace_event_raw_event_rcu_dyntick+0x89/0xa0
>  ? insn_get_prefixes.part.2+0x174/0x2d0
>  rcu_irq_enter+0xf0/0x1d0
>  rcu_irq_enter_irqson+0x21/0x50
>  switch_mm_irqs_off+0x43c/0x570
>  ? do_one_initcall+0x51/0x210
>  __text_poke+0x1a9/0x470
>  text_poke_bp_batch+0x73/0x180
>  text_poke_flush+0x43/0x50
>  arch_jump_label_transform_apply+0x16/0x30
>  __static_key_slow_dec_cpuslocked+0x42/0x50
>  static_key_slow_dec+0x1f/0x50
>  tracepoint_probe_unregister+0x1e2/0x220
>  trace_event_reg+0x6a/0x80
>  __ftrace_event_enable_disable+0x1ca/0x240
>  __ftrace_set_clr_event_nolock+0xe1/0x140
>  __ftrace_set_clr_event+0x3d/0x60
>  system_enable_write+0x76/0xa0
>  vfs_write+0xad/0x1a0
>  ? rcu_irq_exit+0xb8/0x170
>  ksys_write+0x48/0xb0
>  do_syscall_64+0x60/0x200
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x7f875b0ecdb0
> Code: Bad RIP value.
> RSP: 002b:00007ffc746be918 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f875b0ecdb0
> RDX: 0000000000000001 RSI: 00007ffc746be93f RDI: 0000000000000004
> RBP: 00007ffc746be9a0 R08: 636172742f6c6500 R09: 0000000002242ee0
> R10: 6f662f7365636e61 R11: 0000000000000246 R12: 000000000040a4b0
> R13: 00007ffc746bebd0 R14: 0000000000000000 R15: 0000000000000000
> 
> I havn't figured out how rcu_irq_enter() calls down into
> trace_event_raw_event_rcu_dyntick() and further into
> trace_event_ignore_this_pid(), but the stacktrace shows it does.
> 
> So trace_event_ignore_this_pid() faults on the vzalloc()'ed memory, calling
> into the page-fault handler. What happens there is:
> 
> RIP: 0010:trace_event_ignore_this_pid+0x23/0x30
> Code: e9 c2 4b 6b 00 cc cc 48 8b 57 28 48 8b 8a b8 00 00 00 48 8b 82 c0 00 00 00
> 48 85 c0 74 11 48 8b 42 28 65 48 03 05 5d 9c e6 7e <0f> b6 40 7c c3 48 85 c9 75
> ea f3 c3 90 48 8b 4f 70 48 83 02 01 48
> RSP: 0018:ffffc90000673a50 EFLAGS: 00010082
> RAX: ffffe8ffffd8c870 RBX: 0000000000000203 RCX: ffff88810734ca90
> RDX: ffff888451578000 RSI: ffffe8ffffd8c8ec RDI: ffff88844fd98478
> RBP: ffff88844fd98478 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffe8ffffd8c8ec
> R13: 0000000000000000 R14: ffffc90000673b28 R15: 0000000000000000
>  trace_event_raw_event_x86_exceptions+0x87/0xa0
>  ? trace_event_buffer_lock_reserve+0x6e/0x110
>  do_page_fault+0x45e/0x630
>  ? trace_hardirqs_off_thunk+0x1a/0x37
>  page_fault+0x43/0x50
> 
> The page-fault handler calls a tracing function which again ends up in
> trace_event_ignore_this_pid(), where it faults again. From here on the CPU is in
> a page-fault loop, which continues until the stack overflows (with
> CONFIG_VMAP_STACK).
> 
> Then there is no mapped stack anymore, so the page-fault results in a
> double-fault, which uses an IST stack. The double-fault handler does
> ist_enter(), which calls into rcu_nmi_enter(), which also has trace-events down
> its call-path. I have no stack-trace for this, but what likely happens
> now is that it page-faults again while on the IST stack and the
> page-fault loops until the #DF IST stack overflows. Then the next #DF
> happens and the stack pointer is reset to the top of the #DF IST stack,
> starting the loop over again. This loops forever, causing the hang.

I suspect it's called by:

include/linux/trace_event.h:trace_trigger_soft_disabled():

static inline bool
trace_trigger_soft_disabled(struct trace_event_file *file)
{
        unsigned long eflags = file->flags;

        if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
                if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
                        event_triggers_call(file, NULL, NULL);
                if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
                        return true;
                if (eflags & EVENT_FILE_FL_PID_FILTER)
                        return trace_event_ignore_this_pid(file);
        }
        return false;
}

Thanks,

Mathieu

> 
> Regards,
> 
> 	Joerg

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
