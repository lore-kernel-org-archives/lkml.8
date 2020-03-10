Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01168C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2752253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrQ08Fjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCJIKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:10:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41801 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCJIKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:10:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id b5so11873647qkh.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJQTicPUFjhr+DDZ8+QEOkZoD9wdXKac2RmPzis94hE=;
        b=NrQ08Fjtx6yKdu8tXkSwOifMXLW9KWyU/GNFA3m9Ffgj+fXf0MyZIgchM8Be8edKYG
         n8zxnvFBg3c5sU73BvfvOKCZumyW9o9415AzwevPFYekpRd5VfHpfzp/TTkoxkiT5rW4
         83f9IjUu8efheol+WBc9NQfXWV7+xhPR1s0OBbW87nAemNG30ImJ5U0lC9kVH1nNDF+4
         NE8DDrgomDWNwws5HdWLrXcJGEnARUCbmPBCWuTj0fijxeDikEBrIDftrTpy4a8nJIGT
         1uq1wX6/lneiHv70HJLaXx6KeFJp6+MnWU7L17ISnRvUEqK+IGlpMzGRAmVngk3tKpVh
         hOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJQTicPUFjhr+DDZ8+QEOkZoD9wdXKac2RmPzis94hE=;
        b=KyupSN4ENGTGiPmpWHnchS+Dh1zjEZksYMx/fdl0UBgPRQ9N4CUbJwv0KCLAhuPHEp
         M4Vj4UA48OwbqSjUhCIU2S6PLTdEb3hh4RTBMEKJ/DcHCf9x+aKvMnVX9LC9Q7pIjz3A
         3bhRHxLwRoxoIN+A211HLfe2SoiUUAHi+Tb/FcEEYIDf6ibDH7GHxSkwq7rYQD0GAjTB
         vrFjURZxymr3CipLTv2uRYONqhtvMfGElSzhKwAFWtUWwDH2a6MJaxYguEOSWt4UTK6Z
         qtBOhd1eLycqBpq2WErPFbTd5fnQR0GwGMw31IruYFuSJn2F/3kbTDSN8s2B1/UPqyZL
         c9Bg==
X-Gm-Message-State: ANhLgQ16nwuqf9dg5cWagoyJpYrhIHVkXl5TFxKWKejIG2znsdXuZlM1
        2zZbaC6nImjQ60V3SFmbrKRQRmQ3jlXz144Qf82x3A==
X-Google-Smtp-Source: ADFU+vvi6CBzxP6zzgPxTEyaQMIyks15tlwCLn39ID1gouztcCFOAUZs/DXbpTxltw97l11wA2qTAV9UHEIAHQZNoUw=
X-Received: by 2002:a37:664d:: with SMTP id a74mr18012335qkc.256.1583827832572;
 Tue, 10 Mar 2020 01:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com> <CAG48ez02bt7V4+n68MNK3bmHpXxDnNmLZn8LpZ8r2w63ZhrkiQ@mail.gmail.com>
 <CACT4Y+YokrJkh0ew-86=zsLLTr9Qnaom5gJeUX9TSMW7tDj=Eg@mail.gmail.com> <20200310061525.GA30283@ubuntu-m2-xlarge-x86>
In-Reply-To: <20200310061525.GA30283@ubuntu-m2-xlarge-x86>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Mar 2020 09:10:17 +0100
Message-ID: <CACT4Y+bx9w+Q5yJxykTbe8JDUt5ChLFRh5zGn78hHM8gqVZx7g@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>,
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

On Tue, Mar 10, 2020 at 7:15 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Mar 09, 2020 at 09:20:58AM +0100, Dmitry Vyukov wrote:
> > On Sun, Mar 8, 2020 at 7:35 PM 'Jann Horn' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Sun, Mar 8, 2020 at 5:40 PM syzbot
> > > <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
> > > > HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16cfeac3e00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
> > > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com
> > > >
> > > > general protection fault, probably for non-canonical address 0x1ffffffff1255a6b: 0000 [#1] PREEMPT SMP KASAN
> > > > CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > RIP: 0010:arch_local_irq_disable arch/x86/include/asm/paravirt.h:757 [inline]
> > > > RIP: 0010:syscall_return_slowpath+0xeb/0x4a0 arch/x86/entry/common.c:277
> > > > Code: 00 10 0f 85 de 00 00 00 e8 b2 a3 76 00 48 c7 c0 58 d3 2a 89 48 c1 e8 03 80 3c 18 00 74 0c 48 c7 c7 58 d3 2a 89 e8 05 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > RSP: 0018:ffffc900020a7ed0 EFLAGS: 00010246
> > > > RAX: 1ffffffff1255a6b RBX: dffffc0000000000 RCX: ffff88808c512380
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > RBP: ffffc900020a7f10 R08: ffffffff810075bb R09: fffffbfff14d9182
> > > > R10: fffffbfff14d9182 R11: 0000000000000000 R12: 1ffff110118a2470
> > > > R13: 0000000000004000 R14: ffff88808c512380 R15: ffff88808c512380
> > > > FS:  000000000154f940(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 000000000076c000 CR3: 00000000a6b05000 CR4: 00000000001406f0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:304
> > > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > > #PF: supervisor write access in kernel mode
> > > > #PF: error_code(0x0002) - not-present page
> > > > PGD 8fecc067 P4D 8fecc067 PUD 97953067 PMD 0
> > > > Oops: 0002 [#2] PREEMPT SMP KASAN
> > > > CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
> > >
> > > Ugh, why does it build with -Werror...
>
> There are certain warnings that are specifically treated like errors:
>
> In the main Makefile:
>
> KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
>
> > Now I am realizing I don't know what's the proper way to turn off
> > warnings entirely...
> >
> > We turn off this CONFIG_ERROR_ON_WARNING historically:
> > https://github.com/google/syzkaller/blob/2e9971bbbfb4df6ba0118353163a7703f3dbd6ec/dashboard/config/bits-syzbot.config#L17
> > and I thought that's enough. But now I realize it's not even a thing.
> > I see it referenced in some ChromeOS threads and there are some
> > discussions re upstreaming, but apparently it never existed upstream.
> >
> > make has W=n, but it seems that it can only be used to produce more
> > warnings. We don't pass W=3 specifically and there is no W=0.
> >
> > Should we always build with CFLAGS=-w? Is it guaranteed to work? Or is
> > there a better way?
>
> Would passing -Wno-werror via KCFLAGS work? Otherwise, passing
> -Wno-error=<specific warning> should work.
>
> Cheers,
> Nathan

Filed https://github.com/google/syzkaller/issues/1635 so that this is not lost.
