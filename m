Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE40C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D488420828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tg0va+Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCIIVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:21:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33061 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgCIIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:21:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id d22so6395915qtn.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AmaLlbiWLt+TX3UuGAGFHaSPjHO8BCUcdCcLxJEM2c=;
        b=Tg0va+TymUv3GuTlS5e8oTEcJ/tf/03YU7zol790GrSBcP/5EfHlkOnIoQW1hyhIPu
         U6FEs++MrAOhNxvIO3kxcPKXxEcy0zbEoeeIF5iJWX8MUcBDclZZQrO+vCtQhxQjf1I8
         ggJzC7m82pJXP2Q9R1U+y38cXbqsoNJ+0vItXtbX3Dw1WH5zEJppSRFL6zV3Y0BlufBR
         TsjszgdS2Cac/z7cGXIzpXnbhRmhEccumSr42Gdonnc0lxxMqkQ2SKjEQweyQr8laEly
         ZHtJBb5xYI2cpD42MnBhpaxRBGHNS+rW4DYCYR3taQn7UyvULvnRVpdKcji5wXmdiuK0
         TsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AmaLlbiWLt+TX3UuGAGFHaSPjHO8BCUcdCcLxJEM2c=;
        b=fCi3tmP2r3L1PcZJS+MYL03Xihg7ZpoXhA1LetVC4lspljhYhkvjedPkQ1Qq0F8Q4+
         WBaQiQCgVtTf4lnGjd+30XWc9xkwoa4Zjf+y7pINcb4vokwSQ6Y55OiQ2mQVJM/USiGZ
         mRqA0bvK94P6bHUjrrGJJqLbpdfYHHVEjUSDVDBmT8rKl23eqWtUA2oc4cImm1hmuAFV
         UXpPGZ+wg2wSlAc12VBlKbE3ao0mVne1OjSa+WzHikIIFnbLhJKwWex0r4RqCpOdddxg
         6YKa07YFuBjQ0nJRNjMSofGL5TntH6V5ntyCPx/ZFFB7FmYARSbWhmyCFc9pDgOtaP6Z
         ha4w==
X-Gm-Message-State: ANhLgQ3bdMgRDC+q6TRwd3Nm1PAZcpPaFIHEKm15uoDyVwcgmwkvzCUv
        co7RDXN3YnFXWDMojvNFFTCe1VgUNYckKsg/thgtjQ==
X-Google-Smtp-Source: ADFU+vvJ7/CtdWJbDQ9hp55oWelT68zYReFpKzLUyahx7UcTfYYh9fk3xqX0+EF8UXLLo4wOG3DoZPAZMiZg2ogIeOU=
X-Received: by 2002:aed:2591:: with SMTP id x17mr1765941qtc.380.1583742069992;
 Mon, 09 Mar 2020 01:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com> <CAG48ez02bt7V4+n68MNK3bmHpXxDnNmLZn8LpZ8r2w63ZhrkiQ@mail.gmail.com>
In-Reply-To: <CAG48ez02bt7V4+n68MNK3bmHpXxDnNmLZn8LpZ8r2w63ZhrkiQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Mar 2020 09:20:58 +0100
Message-ID: <CACT4Y+YokrJkh0ew-86=zsLLTr9Qnaom5gJeUX9TSMW7tDj=Eg@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     Jann Horn <jannh@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        kernel list <linux-kernel@vger.kernel.org>,
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

On Sun, Mar 8, 2020 at 7:35 PM 'Jann Horn' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Sun, Mar 8, 2020 at 5:40 PM syzbot
> <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
> > HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16cfeac3e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com
> >
> > general protection fault, probably for non-canonical address 0x1ffffffff1255a6b: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:arch_local_irq_disable arch/x86/include/asm/paravirt.h:757 [inline]
> > RIP: 0010:syscall_return_slowpath+0xeb/0x4a0 arch/x86/entry/common.c:277
> > Code: 00 10 0f 85 de 00 00 00 e8 b2 a3 76 00 48 c7 c0 58 d3 2a 89 48 c1 e8 03 80 3c 18 00 74 0c 48 c7 c7 58 d3 2a 89 e8 05 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > RSP: 0018:ffffc900020a7ed0 EFLAGS: 00010246
> > RAX: 1ffffffff1255a6b RBX: dffffc0000000000 RCX: ffff88808c512380
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffffc900020a7f10 R08: ffffffff810075bb R09: fffffbfff14d9182
> > R10: fffffbfff14d9182 R11: 0000000000000000 R12: 1ffff110118a2470
> > R13: 0000000000004000 R14: ffff88808c512380 R15: ffff88808c512380
> > FS:  000000000154f940(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000076c000 CR3: 00000000a6b05000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:304
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > #PF: supervisor write access in kernel mode
> > #PF: error_code(0x0002) - not-present page
> > PGD 8fecc067 P4D 8fecc067 PUD 97953067 PMD 0
> > Oops: 0002 [#2] PREEMPT SMP KASAN
> > CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
>
> Ugh, why does it build with -Werror...

Now I am realizing I don't know what's the proper way to turn off
warnings entirely...

We turn off this CONFIG_ERROR_ON_WARNING historically:
https://github.com/google/syzkaller/blob/2e9971bbbfb4df6ba0118353163a7703f3dbd6ec/dashboard/config/bits-syzbot.config#L17
and I thought that's enough. But now I realize it's not even a thing.
I see it referenced in some ChromeOS threads and there are some
discussions re upstreaming, but apparently it never existed upstream.

make has W=n, but it seems that it can only be used to produce more
warnings. We don't pass W=3 specifically and there is no W=0.

Should we always build with CFLAGS=-w? Is it guaranteed to work? Or is
there a better way?
