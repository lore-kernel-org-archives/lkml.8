Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDE5207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbGgkqHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgGaGui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731365AbgGaGuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:50:37 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6721DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 23:50:37 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dd12so8659872qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WngGGnonvpFH+7HxvPSvcZRCNtYHz0yk1OEZnIMEESY=;
        b=IbGgkqHgIiEw/hTzDLLcAGVf9zgHEnHz00uKm4YLRY7/mON834YzH3vnQFLCtcJBot
         lxpku1E+EEWqG9nxOM+O6FxT7gnkEOeqAPEKpB3mmPuK6NNNPh/Fvq8d2+h6H3G+St1Q
         Yr6lGSvAJFBp2Ii61lPHEJt7rSQhGdj/4oYewHFCdWcivd8xGGG9JI70WEs4F9cNWRVx
         nwBavGGvc8chVB6X/IH6kbljGafQPt4oQOkBCZxh0wQbPqPZWQkZySuPioLPv6uL2BpV
         Z7xg+vIoUi0VfIDNdyI5g5phpnyD3XwhsiIdKFBmEPXohQ9lx6uNCEBgeBJLzyxs5buJ
         M0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WngGGnonvpFH+7HxvPSvcZRCNtYHz0yk1OEZnIMEESY=;
        b=T1gaeHo0s/5rhaltHHBpp/fuYKmogtfFqaK0hi/mKTrtLfwsx/RjfdyuQTCMUnPwp5
         cXErfvSWOiCikeXZ+vDYBpIhbQDoSmJYsjzB9hXKMAOnfeqsKwPul86bJ5GKOcXyO8Z+
         XKVhsYsqbmm5jxeqZJ2Iwg1+eHZLp85j9D2XHybYOycxoH4zbQ6/X17W0103QkuiTZuQ
         Wl0859xSjww+7BglYQTtAyKZ0vPN0BMKG8gVqPUL+jPRkDhcvjB4EcIeLnH1yBDBoaKF
         ztHbErZ1PgMGHTpUeXhQGSWkGoyfvw+ZHdmm+VXK3fxD/fpulE+p5lb1/XmnxYDTbspb
         Xk0A==
X-Gm-Message-State: AOAM531excrZGOI+6lS4ox8nZsW4bLlgJSvIgyd2OnPg+c5BiO+CREUV
        X2WYRVhVC14o/rt+DhHISJNokb2+zYeGtkVrYctQFA==
X-Google-Smtp-Source: ABdhPJxC6S0iBdEspvZgSadQkuzvLg58Lw0HSz7+nwhiEF8Iu7xIVUpU61rNUgtC8NBEDJSoO+ypuqgUXskBdmR7AcA=
X-Received: by 2002:a0c:c60b:: with SMTP id v11mr2756513qvi.122.1596178236176;
 Thu, 30 Jul 2020 23:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000060adcb05abb71eb6@google.com>
In-Reply-To: <00000000000060adcb05abb71eb6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 31 Jul 2020 08:50:24 +0200
Message-ID: <CACT4Y+ZnHF_b6hKQ_npjJ2fW7atZ7sP8WeGh-TDhu9UB0dcnPQ@mail.gmail.com>
Subject: Re: upstream boot error: BUG: soft lockup in __do_softirq
To:     syzbot <syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 8:44 AM syzbot
<syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    92ed3019 Linux 5.8-rc7
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10e84cdf100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b45e47f6d958ae82
> dashboard link: https://syzkaller.appspot.com/bug?extid=8472ea265fe32cc3bf78
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com

This is a qemu-kvm instance killing the host kernel somehow, the host
kernel itself running qemu's is full of rcu stalls. I think this is
not a bug in the tested kernel.
We change rcu stall timeout to 120 seconds from the default 21s, but
this happens only after boot using sysctls. I did not find any way to
change the rcu timeout via cmdline/config (would be useful).

> hrtimer: interrupt took 42698779 ns
> random: crng init done
> watchdog: BUG: soft lockup - CPU#3 stuck for 21s! [grep:4749]
> Modules linked in:
> hardirqs last  enabled at (2780): [<ffffffff88200204>] __do_softirq+0x204/0xa60 kernel/softirq.c:276
> hardirqs last disabled at (2781): [<ffffffff87e5b2ed>] idtentry_enter_cond_rcu+0x1d/0x50 arch/x86/entry/common.c:649
> softirqs last  enabled at (2760): [<ffffffff88200748>] __do_softirq+0x748/0xa60 kernel/softirq.c:319
> softirqs last disabled at (2779): [<ffffffff88000f0f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
> CPU: 3 PID: 4749 Comm: grep Not tainted 5.8.0-rc7-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__do_softirq+0x22f/0xa60 kernel/softirq.c:278
> Code: c7 c0 98 e0 b4 89 48 c1 e8 03 42 80 3c 30 00 0f 85 70 07 00 00 48 83 3d 76 de 94 01 00 0f 84 4a 06 00 00 fb 66 0f 1f 44 00 00 <48> c7 44 24 08 c0 90 a0 89 b8 ff ff ff ff 0f bc 04 24 83 c0 01 89
> RSP: 0000:ffffc90000598f70 EFLAGS: 00000286
> RAX: 1ffffffff1369c13 RBX: ffff8880294683c0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88200204
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff88000c3a
> R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  00007fe02dd23700(0000) GS:ffff88802d100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000f5d1e8 CR3: 000000001efc6000 CR4: 0000000000340ee0
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  </IRQ>
>  invoke_softirq kernel/softirq.c:387 [inline]
>  __irq_exit_rcu kernel/softirq.c:417 [inline]
>  irq_exit_rcu+0x229/0x270 kernel/softirq.c:429
>  sysvec_apic_timer_interrupt+0x54/0x120 arch/x86/kernel/apic/apic.c:1091
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
> Code: ba 63 03 00 00 e8 f5 bf 00 00 0f 1f 44 00 00 48 89 5c 24 e0 48 89 6c 24 e8 48 89 fb 4c 89 64 24 f0 4c 89 6c 24 f8 48 83 ec 38 <0f> b6 47 04 83 e0 0f 83 f8 06 0f 85 3e 01 00 00 31 d2 66 83 7b 06
> RSP: 002b:00007ffd13103ee0 EFLAGS: 00010202
> RAX: 00000000000003b7 RBX: 00007fe02d584588 RCX: 0000000000000000
> RDX: 00007fe02d57d94c RSI: 0000000000000edc RDI: 00007fe02d584588
> RBP: 00007fe02dd2aef8 R08: 00000000004282a7 R09: 0000000000000004
> R10: 00007ffd13103f70 R11: 00007ffd13103f70 R12: 0000000000000004
> R13: 0000000010a0a9c4 R14: 0000000000000002 R15: 00007ffd131040f8
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000060adcb05abb71eb6%40google.com.
