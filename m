Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16581C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF30420656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akahJck9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgGGHKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:10:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74452C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:10:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j80so37262640qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/hHqCcReYqoMkm+kcMIPuy9sGku7DzNx3v+nOmiNA0=;
        b=akahJck9O0W8nZzudJ883br+mnJCJwp7lNcLQUpfelics6uN8doWqCXumnjJtt8Tql
         S6IZdOk39pnZLWxVn2NspYp2DQab7+Rvqx+MY2iMrcdgEtciVpIDFoHoCw+RBv5RMof/
         GXSE97XA5C0TxkgOMFD7oCKeE0tqvui4gZVuHvQL48NKYIDhts8q69YVIS/W4DHvRFNv
         MRau+/dKBD/rBmzqY+OJPJnZbSPl8yC+XUBKmsa/EnatlvJICd9u25dx8AhqLQMXw2iR
         Q/o1Eo8Hrv5GonnlSPqN+S9xY/385khuSA7mxhC66tMiVpDhyvWf0LJcKhRQXRQOSWSR
         mbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/hHqCcReYqoMkm+kcMIPuy9sGku7DzNx3v+nOmiNA0=;
        b=DmJ+HWsnCEZLZQF/AWU1s+A5jHgyfLFwS3wU5n/wzUZZVDRnmUESdzNhvZwOODIO21
         qOG15XtjtbLy1jahwuWEWNyxV91UjvknMYsfVQFxHkgZiwCH2P7MMlLQRLwYQYTS/Tr5
         Wd+1BvPMGYnHT1ihOAmyj1e9yT02+H5weHD3D5206X2UiZZdMNzuT3tYUtgrylc0nYE9
         tnCbTLX/rNmwfhBmPAKsJjkG5u1BOM+LepraC+wZvgxY/GKdjSBjFef12xF0Ee50oB2y
         RJvlY4kpRVYn58gCsPEvufYao6jI9W+OO1BinZcBhPDea8cpocAMSjs3PkaZlpGb3F37
         wDew==
X-Gm-Message-State: AOAM532e3WBHHggyw7uYyKq4jeNNICbyH7EsOiX4tXzNrIgTM1VylBsR
        zv9Q2ajWVPw+H87HdsXOSUW5Jac9KlY2bakrxFatogbjyFx0zg==
X-Google-Smtp-Source: ABdhPJzR4oVOXTGfiC3Xoqs63X+hNJ3ABws6WTi8KsJIP6WWV48qZ6mPNAM8yUyr8npU6afrGxLfeKMxkzOTZVmxEow=
X-Received: by 2002:a37:7ec1:: with SMTP id z184mr49405486qkc.185.1594105838283;
 Tue, 07 Jul 2020 00:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002ef21705a9933cf3@google.com>
In-Reply-To: <0000000000002ef21705a9933cf3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Jul 2020 09:10:26 +0200
Message-ID: <CACT4Y+aiMBpJ+O0RPhs8mVUyn4O8cx6AZDwaFSuBaV+=XOrjLA@mail.gmail.com>
Subject: Re: KASAN: out-of-bounds Read in csd_lock_record
To:     syzbot <syzbot+98af0465c818c8b093e9@syzkaller.appspotmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 3:05 AM syzbot
<syzbot+98af0465c818c8b093e9@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    9e50b94b Add linux-next specific files for 20200703
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17667097100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
> dashboard link: https://syzkaller.appspot.com/bug?extid=98af0465c818c8b093e9
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16def937100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1324dc83100000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+98af0465c818c8b093e9@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: out-of-bounds in csd_lock_record+0xcb/0xe0 kernel/smp.c:118
> Read of size 8 at addr ffffc90001677830 by task syz-executor014/30713
>
> CPU: 0 PID: 30713 Comm: syz-executor014 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
>  csd_lock_record+0xcb/0xe0 kernel/smp.c:118
>  flush_smp_call_function_queue+0x285/0x730 kernel/smp.c:391
>  __sysvec_call_function_single+0x98/0x490 arch/x86/kernel/smp.c:248
>  asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
>  </IRQ>
>  __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
>  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
>  sysvec_call_function_single+0xe0/0x120 arch/x86/kernel/smp.c:243
>  asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:604
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
> RIP: 0010:qlink_free mm/kasan/quarantine.c:151 [inline]
> RIP: 0010:qlist_free_all+0xfc/0x140 mm/kasan/quarantine.c:167
> Code: 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 4c 8b 70 18 e9 40 ff ff ff e8 c3 27 c6 ff 48 83 3d eb 55 01 08 00 74 36 4c 89 ff 57 9d <0f> 1f 44 00 00 4d 85 e4 75 9e 49 c7 45 08 00 00 00 00 49 c7 45 00
> RSP: 0018:ffffc90005537ad8 EFLAGS: 00000282
> RAX: 0000000000000c29 RBX: ffff888090e0da80 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000282
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880a2fa9780
> R13: ffffc90005537b10 R14: ffff8880aa00fc00 R15: 0000000000000282
>  quarantine_reduce+0x17e/0x200 mm/kasan/quarantine.c:260
>  __kasan_kmalloc.constprop.0+0x9e/0xd0 mm/kasan/common.c:475
>  slab_post_alloc_hook mm/slab.h:535 [inline]
>  slab_alloc mm/slab.c:3316 [inline]
>  kmem_cache_alloc+0x148/0x550 mm/slab.c:3486
>  __d_alloc+0x2a/0x920 fs/dcache.c:1709
>  d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
>  alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
>  anon_inode_getfile fs/anon_inodes.c:91 [inline]
>  anon_inode_getfile+0xc8/0x1f0 fs/anon_inodes.c:74
>  anon_inode_getfd+0x4c/0xa0 fs/anon_inodes.c:136
>  bpf_map_new_fd kernel/bpf/syscall.c:686 [inline]
>  bpf_map_new_fd kernel/bpf/syscall.c:678 [inline]
>  map_create kernel/bpf/syscall.c:872 [inline]
>  __do_sys_bpf+0xe6d/0x4b10 kernel/bpf/syscall.c:4094
>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:367
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x447e79
> Code: Bad RIP value.
> RSP: 002b:00007f0e1d49fdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00000000006e39e8 RCX: 0000000000447e79
> RDX: 000000000000003c RSI: 0000000020000000 RDI: 0000000000000000
> RBP: 00000000006e39e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e39ec
> R13: 00007fff7cf05b0f R14: 00007f0e1d4a09c0 R15: 0000000000000000
>
>
> Memory state around the buggy address:
>  ffffc90001677700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90001677780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc90001677800: f1 f1 f1 f1 00 00 00 00 f3 f3 f3 f3 00 00 00 00
>                                      ^
>  ffffc90001677880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90001677900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

I think this is the same as:

#syz dup: KASAN: stack-out-of-bounds Read in csd_lock_record
