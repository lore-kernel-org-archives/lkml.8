Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E769220719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="R/fRwhTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgHaPrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHaPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:47:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:47:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so1839pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+ohCLAP9UTjkHxmjO3qPfpY/4YDZFTwy+almICXOT8=;
        b=R/fRwhTSnvwlpKpg4R0D0Gjz6NKxAewmOSyRoNP+VCuasLvY1iO40/MCkny3gpHlPJ
         Klxx2s04pSanbVLVISoVPQ76rAihlR0szU4ljutWZbpOISNWBfrXJdeSbIpsUjaxEow7
         an5vv5ji70K1VQYcVKNRShwRi1MB5W3p5c0RvKaAVOGSCI+jOa0momEGkaaToagQdKZj
         TobfaVP7Dnzsu4TZNRAW8YeDbcV520edsAwB2ErJFes3D/78ckuGaQhjrUVm9L1LumoD
         N2XAnVoesXD0t+5i1NkovpOizN5X0UKgaBBd8RjIDITwRPJDcJOrnxwXC0bOq6PO9bWg
         +paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+ohCLAP9UTjkHxmjO3qPfpY/4YDZFTwy+almICXOT8=;
        b=qYFhw3SH7mUTzQFO7C3jveg8JFIhZ0en6oo6/WBpP+SXO2QlJPMEDIyBHPzK7c/K3z
         QnDt1Ohdn7GW7zQlgeA796EHhlKcmIsX09lrmjl839KB2BC+P7nLvIQXK+ZZt6/h3fzp
         GmdDG3J/KMhAhfqDPTs5aLT7GuNHzBgooMXuse2CaNhiuyQ6koAxF+oLxFpUZCEzfxu7
         6VJDLcqqDjM8mcmU1o85DmjK5GZ8SG12MjNRQkMlIr6hTtEJhbbVk/2MIPRXvbsj/KjB
         N4fEFilRzNHQKj5dRTY5RdyMVDaFojnrPM9a0RwL0aAeB61K5Fcy6BkKxUf3D23R7TbV
         kjmQ==
X-Gm-Message-State: AOAM532FuEexrihaPftC3XZZ5EOd0i2jTT9y5lovHHYjwkcmW+KHiqHx
        N5AUSi2OB3HA9oZUaQ2Wcw+Q+OqKjDLvYh0OAelZlw==
X-Google-Smtp-Source: ABdhPJxDLF1AzpYR4WifdFZ+pt7AtKjp50Lx5WnDnyxGh++DBh0SsrvV0Q18wplv+9kYGeE1Ubbi/0IpA6WXrdv+tBU=
X-Received: by 2002:a17:90a:bd0e:: with SMTP id y14mr18913pjr.13.1598888870990;
 Mon, 31 Aug 2020 08:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <159888672694.1411785.5987998076694782591.stgit@devnote2>
In-Reply-To: <159888672694.1411785.5987998076694782591.stgit@devnote2>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 31 Aug 2020 23:47:14 +0800
Message-ID: <CAMZfGtXqhyzsqm=9Y5VUVpRsTA4-EfAXsX=8TLOjuVkJkw-ngg@mail.gmail.com>
Subject: Re: [External] [BUGFIX PATCH] kprobes: Fix to check probe enabled
 before disarm_kprobe_ftrace()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:12 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Commit 0cb2f1372baa ("kprobes: Fix NULL pointer dereference at
> kprobe_ftrace_handler") fixed one bug but not completely fixed yet.
> If we run a kprobe_module.tc of ftracetest, kernel showed a warning
> as below.
>
>
> # ./ftracetest test.d/kprobe/kprobe_module.tc
> === Ftrace unit tests ===
> [1] Kprobe dynamic event - probing module
> ...
> [   22.400215] ------------[ cut here ]------------
> [   22.400962] Failed to disarm kprobe-ftrace at trace_printk_irq_work+0x0/0x7e [trace_printk] (-2)
> [   22.402139] WARNING: CPU: 7 PID: 200 at kernel/kprobes.c:1091 __disarm_kprobe_ftrace.isra.0+0x7e/0xa0
> [   22.403358] Modules linked in: trace_printk(-)
> [   22.404028] CPU: 7 PID: 200 Comm: rmmod Not tainted 5.9.0-rc2+ #66
> [   22.404870] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
> [   22.406139] RIP: 0010:__disarm_kprobe_ftrace.isra.0+0x7e/0xa0
> [   22.406947] Code: 30 8b 03 eb c9 80 3d e5 09 1f 01 00 75 dc 49 8b 34 24 89 c2 48 c7 c7 a0 c2 05 82 89 45 e4 c6 05 cc 09 1f 01 01 e8 a9 c7 f0 ff <0f> 0b 8b 45 e4 eb b9 89 c6 48 c7 c7 70 c2 05 82 89 45 e4 e8 91 c7
> [   22.409544] RSP: 0018:ffffc90000237df0 EFLAGS: 00010286
> [   22.410385] RAX: 0000000000000000 RBX: ffffffff83066024 RCX: 0000000000000000
> [   22.411434] RDX: 0000000000000001 RSI: ffffffff810de8d3 RDI: ffffffff810de8d3
> [   22.412687] RBP: ffffc90000237e10 R08: 0000000000000001 R09: 0000000000000001
> [   22.413762] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807c478640
> [   22.414852] R13: ffffffff8235ebc0 R14: ffffffffa00060c0 R15: 0000000000000000
> [   22.415941] FS:  00000000019d48c0(0000) GS:ffff88807d7c0000(0000) knlGS:0000000000000000
> [   22.417264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.418176] CR2: 00000000005bb7e3 CR3: 0000000078f7a000 CR4: 00000000000006a0
> [   22.419309] Call Trace:
> [   22.419990]  kill_kprobe+0x94/0x160
> [   22.420652]  kprobes_module_callback+0x64/0x230
> [   22.421470]  notifier_call_chain+0x4f/0x70
> [   22.422184]  blocking_notifier_call_chain+0x49/0x70
> [   22.422979]  __x64_sys_delete_module+0x1ac/0x240
> [   22.423733]  do_syscall_64+0x38/0x50
> [   22.424366]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   22.425176] RIP: 0033:0x4bb81d
> [   22.425741] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e0 ff ff ff f7 d8 64 89 01 48
> [   22.428726] RSP: 002b:00007ffc70fef008 EFLAGS: 00000246 ORIG_RAX: 00000000000000b0
> [   22.430169] RAX: ffffffffffffffda RBX: 00000000019d48a0 RCX: 00000000004bb81d
> [   22.431375] RDX: 0000000000000000 RSI: 0000000000000880 RDI: 00007ffc70fef028
> [   22.432543] RBP: 0000000000000880 R08: 00000000ffffffff R09: 00007ffc70fef320
> [   22.433692] R10: 0000000000656300 R11: 0000000000000246 R12: 00007ffc70fef028
> [   22.434635] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
> [   22.435682] irq event stamp: 1169
> [   22.436240] hardirqs last  enabled at (1179): [<ffffffff810df542>] console_unlock+0x422/0x580
> [   22.437466] hardirqs last disabled at (1188): [<ffffffff810df19b>] console_unlock+0x7b/0x580
> [   22.438608] softirqs last  enabled at (866): [<ffffffff81c0038e>] __do_softirq+0x38e/0x490
> [   22.439637] softirqs last disabled at (859): [<ffffffff81a00f42>] asm_call_on_stack+0x12/0x20
> [   22.440690] ---[ end trace 1e7ce7e1e4567276 ]---
> [   22.472832] trace_kprobe: This probe might be able to register after target module is loaded. Continue.
>
>
> This is because the kill_kprobe() calls disarm_kprobe_ftrace() even
> if the given probe is not enabled. In that case, ftrace_set_filter_ip()
> fails because the given probe point is not registered to ftrace.

Does the following patch solve this issue?  Thanks.

  kprobes: Fix kill kprobe which has been marked as gone
  https://lkml.org/lkml/2020/8/19/1496

>
> Fix to check the given (going) probe is enabled before invoking
> disarm_kprobe_ftrace().
>
> Fixes: 0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 287b263c9cb9..d43b48ecdb4f 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2159,9 +2159,10 @@ static void kill_kprobe(struct kprobe *p)
>
>         /*
>          * The module is going away. We should disarm the kprobe which
> -        * is using ftrace.
> +        * is using ftrace, because ftrace framework is still available at
> +        * MODULE_STATE_GOING notification.
>          */
> -       if (kprobe_ftrace(p))
> +       if (kprobe_ftrace(p) && !kprobe_disabled(p) && !kprobes_all_disarmed)
>                 disarm_kprobe_ftrace(p);
>  }
>
>


-- 
Yours,
Muchun
