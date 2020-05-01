Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9150EC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 05:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D18820731
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 05:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XB7dR5aK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgEAFRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 01:17:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727922AbgEAFRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 01:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588310236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GSWin1sVu+RpjdOrQAPHPFQk2idbIftWleHLnOyDrQE=;
        b=XB7dR5aKgo8r4ddX3aPRknTQLj9xPjFbeJ7+ou2e4kyEHl0p7e99EiwKNz+FDA4+NZY1N+
        CXgrPSG1W/yZzGz0WkEIqeBt+eK8mDUn6qE9CuV+ZjKp89WvXvKlGcpGL8eM3n+TcRkAXE
        El6rrndEp5KwboIliZcQTGL+3vBDgyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-K88sYPXGMUaNtOBjygk2fQ-1; Fri, 01 May 2020 01:17:12 -0400
X-MC-Unique: K88sYPXGMUaNtOBjygk2fQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C831895A2C;
        Fri,  1 May 2020 05:17:11 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEF7C600E5;
        Fri,  1 May 2020 05:17:08 +0000 (UTC)
Date:   Fri, 1 May 2020 00:17:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH] x86/ftrace: Have ftrace trampolines turn read-only
 at the end of system boot up
Message-ID: <20200501051706.4wkrqwovybt2p6hr@treble>
References: <20200430202147.4dc6e2de@oasis.local.home>
 <20200501044733.eqf6hc6erucsd43x@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501044733.eqf6hc6erucsd43x@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:47:33PM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 30, 2020 at 08:21:47PM -0400, Steven Rostedt wrote:
> > The cause is the "ftrace=function" would register the function tracer
> > and create a trampoline, and it will set it as executable and
> > read-only. Then the "trace_options=func_stack_trace" would then update
> > the same trampoline to include the stack tracer version of the function
> > tracer. But since the trampoline already exists, it updates it with
> > text_poke_bp(). The problem is that text_poke_bp() called while
> > system_state == SYSTEM_BOOTING, it will simply do a memcpy() and not
> > the page mapping, as it would think that the text is still read-write.
> > But in this case it is not, and we take a fault and crash.
> > 
> > Instead, lets keep the ftrace trampolines read-write during boot up,
> > and then when the kernel executable text is set to read-only, the
> > ftrace trampolines get set to read-only as well.
> 
> Would it be easier to just call a new __text_poke_bp() which skips the
> SYSTEM_BOOTING check, since you know the trampoline will always be
> read-only?
> 
> Like:

early_trace_init() is called after mm_init(), so I thought it might
work, but I guess not:

[    0.206271] Starting tracer 'function'
[    0.232032] BUG: kernel NULL pointer dereference, address: 0000000000000050
[    0.232035] #PF: supervisor read access in kernel mode
[    0.232036] #PF: error_code(0x0000) - not-present page
[    0.232037] PGD 0 P4D 0 
[    0.232040] Oops: 0000 [#1] PREEMPT SMP PTI
[    0.232042] CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-rc2-next-20200424+ #127
[    0.232043] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
[    0.232047] RIP: 0010:walk_to_pmd+0x11/0x140
[    0.232048] Code: 78 c1 32 82 e8 a0 68 ff ff 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 48 89 f0 48 c1 e8 24 25 f8 0f 00 00 <48> 03 47 50 0f 84 12 01 00 00 41 54 49 89 fc 55 48 89 c5 53 48 8b
[    0.232050] RSP: 0000:ffffffff82603c68 EFLAGS: 00010046
[    0.232051] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    0.232052] RDX: ffffffff82603cc8 RSI: 0000000000000000 RDI: 0000000000000000
[    0.232053] RBP: 8000000000000063 R08: 0000000000000001 R09: fff0000000000fff
[    0.232054] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82603cc8
[    0.232055] R13: 0000000000000000 R14: 0000000000000066 R15: fffffffffffffeff
[    0.232056] FS:  0000000000000000(0000) GS:ffff88813b600000(0000) knlGS:0000000000000000
[    0.232057] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.232058] CR2: 0000000000000050 CR3: 0000000002612001 CR4: 00000000000606b0
[    0.232061] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.232062] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.232063] Call Trace:
[    0.232066]  __get_locked_pte+0x19/0x100
[    0.232069]  ? 0xffffffffa0000065
[    0.232071]  __text_poke+0x14d/0x640
[    0.232073]  ? 0xffffffffa0000065
[    0.232076]  text_poke_bp_batch+0x8b/0x1c0
[    0.232078]  ? 0xffffffffa0000065
[    0.232080]  __text_poke_bp+0x3a/0x60
[    0.232083]  arch_ftrace_update_trampoline+0xac/0x300
[    0.232087]  __register_ftrace_function+0x7c/0xc0
[    0.232089]  ftrace_startup+0x1e/0xf0
[    0.232091]  register_ftrace_function+0x24/0x70
[    0.232093]  func_set_flag+0x6f/0x90
[    0.232096]  __set_tracer_option.isra.0+0x24/0x50
[    0.232098]  trace_set_options+0x149/0x160
[    0.232102]  apply_trace_boot_options+0x44/0x6d
[    0.232105]  register_tracer+0x1d8/0x1e9
[    0.232107]  early_trace_init+0x266/0x378
[    0.232109]  start_kernel+0x337/0x614
[    0.232112]  ? x86_family+0x5/0x20
[    0.232114]  secondary_startup_64+0xa4/0xb0
[    0.232119] Modules linked in:
[    0.232120] CR2: 0000000000000050
[    0.232126] random: get_random_bytes called from print_oops_end_marker+0x26/0x40 with crng_init=0
[    0.232128] ---[ end trace 71e23a89b9b5224f ]---
[    0.232130] RIP: 0010:walk_to_pmd+0x11/0x140
[    0.232131] Code: 78 c1 32 82 e8 a0 68 ff ff 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 48 89 f0 48 c1 e8 24 25 f8 0f 00 00 <48> 03 47 50 0f 84 12 01 00 00 41 54 49 89 fc 55 48 89 c5 53 48 8b
[    0.232133] RSP: 0000:ffffffff82603c68 EFLAGS: 00010046
[    0.232134] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    0.232135] RDX: ffffffff82603cc8 RSI: 0000000000000000 RDI: 0000000000000000
[    0.232136] RBP: 8000000000000063 R08: 0000000000000001 R09: fff0000000000fff
[    0.232137] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82603cc8
[    0.232138] R13: 0000000000000000 R14: 0000000000000066 R15: fffffffffffffeff
[    0.232139] FS:  0000000000000000(0000) GS:ffff88813b600000(0000) knlGS:0000000000000000
[    0.232140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.232141] CR2: 0000000000000050 CR3: 0000000002612001 CR4: 00000000000606b0
[    0.232142] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.232143] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.232144] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.232184] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

