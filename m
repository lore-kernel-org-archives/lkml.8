Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A21EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1542820842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scrg/E/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgCCS0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:26:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44982 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbgCCS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:26:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id v22so3972282otq.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msDgQhZ5H5d7Z5XDGyHG8ivEHwE79NzJQffSR6gfnVw=;
        b=scrg/E/r4c9odOkKlng5jOcGHM+Ad9q690rs8jrQJTerjIitzWPgjXwcDRIew1IbUe
         /20ZlF5E4Za4PGoKPShH7oeyhZ3PoPH0KTu9bC/kVU1rsTClkOln1Rlt/Irge0u5exMy
         pqz9XPb5csJ8adG/zSbuv9NEwyzEiwTnVaec6hEKm6v92swGIERJ9vuG++7JdIixV/FR
         sxYMcXwz2qj1jD0HIDzkiG5nEZ88vxRZvUH8ZXthf9gCyWRHyhPWoseBNnFpGRLnhwzq
         srW62wxYi+ztzgtFIFXmoVFP8nPq4M6llnGPiNIsK/j+Bdoim4DgJ3rZReXtcu8nfDCh
         Dv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msDgQhZ5H5d7Z5XDGyHG8ivEHwE79NzJQffSR6gfnVw=;
        b=CuGSY0trYwR9/NVm/Zu6z3ybs8zXn7r2wOZS2HMbIb0S6z5Y5fnj+nJJ2rqdGKSO3z
         cFMLf7RA5lTxfQ8tJOPfmX4qEVqIGXPkjzohWmbYe8lECV44UILLokQLQlQYwr0kV84S
         drqQ1gQZnDiGnuIbUChWgIfRCmIhAf3AH8M55sMx7gGE7NOWjN6KZ3OkbTlpqXR7/Jeu
         j+QwHZfvzXLMfQyDwATYoX9EjDmiEQ4LuwmsfF2VN/WMF1IteTelKaZCj+ABK294iHI7
         r4mbs6LVcGA91NgMjMqKQcq0DVfn+/1Wcw4VA7C3RCXbWI9czh/qjUnA8m2FHo/fyoht
         4z7g==
X-Gm-Message-State: ANhLgQ1gp0T+Li3MpdNLoCEFHU5X5mWVYFB3NA2IJ4uvWLQZmpvrtfYX
        Y2O8PZJGtQNPUz0sY9MIkJW4v6XdcJzgAC+qOL41EQ==
X-Google-Smtp-Source: ADFU+vu5QnFNOffnUvHf/zodH2789PosTULYvzhXYv1CoMwwemSXbdfFgImF8Kxb+UpATKSXS6zwAiqzvehihFJWF9E=
X-Received: by 2002:a05:6830:16c8:: with SMTP id l8mr4278190otr.2.1583259993700;
 Tue, 03 Mar 2020 10:26:33 -0800 (PST)
MIME-Version: 1.0
References: <1583256049-15497-1-git-send-email-cai@lca.pw> <CANpmjNPJc_45+h_yJWwmw=YUuWduD6pPX2vdfPVekPvnnHd+_Q@mail.gmail.com>
In-Reply-To: <CANpmjNPJc_45+h_yJWwmw=YUuWduD6pPX2vdfPVekPvnnHd+_Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 3 Mar 2020 19:26:22 +0100
Message-ID: <CANpmjNOtweO7o7wxM6yX3_XKETWcLVqmKsQq5ZkXybfAY4_H5g@mail.gmail.com>
Subject: Re: [PATCH -next] signal: annotate data races in sys_rt_sigaction
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, catalin.marinas@arm.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 18:53, Marco Elver <elver@google.com> wrote:
>
> On Tue, 3 Mar 2020 at 18:21, Qian Cai <cai@lca.pw> wrote:
> >
> > Kmemleak could scan task stacks while plain writes happens to those
> > stack variables which could results in data races. For example, in
> > sys_rt_sigaction and do_sigaction(), it could have plain writes in
> > a 32-byte size. Since the kmemleak does not care about the actual values
> > of a non-pointer and all do_sigaction() call sites only copy to stack
> > variables, annotate them as intentional data races using the
> > data_race() macro. The data races were reported by KCSAN,
> >
> >  BUG: KCSAN: data-race in _copy_from_user / scan_block
> >
> >  read to 0xffffb3074e61fe58 of 8 bytes by task 356 on cpu 19:
> >   scan_block+0x6e/0x1a0
> >   scan_block at mm/kmemleak.c:1251
> >   kmemleak_scan+0xbea/0xd20
> >   kmemleak_scan at mm/kmemleak.c:1482
> >   kmemleak_scan_thread+0xcc/0xfa
> >   kthread+0x1cd/0x1f0
> >   ret_from_fork+0x3a/0x50
>
> I think we should move the annotations to kmemleak instead of signal.c.
>
> Because putting a "data_race()" on the accesses in signal.c just
> because of Kmemleak feels wrong because then we might miss other more
> serious issues. Kmemleak isn't normally enabled in a non-debug kernel.
>
> I wonder if it'd be a better idea to just disable KCSAN on scan_block
> with __no_kcsan? If Kmemleak only does reads, then __no_kcsan will do
> the right thing here, because the reads are hidden completely from
> KCSAN. With "data_race()" you would still have to mark both accesses
> in signal.c and kmemleak (this is by design, so that we document all
> intentionally data-racy accesses).
>
> An alternative would be to just exempt kmemleak from KCSAN with
> "KCSAN_SANITIZE_kmemleak.o := n". Given Kmemleak is a debugging tool
> and it's expected to race with all kinds of accesses, maybe that's the
> best option.

I saw there are already some data_race() annotations in Kmemleak.
Given there are probably more things waiting to be found in Kmemleak,
KCSAN_SANITIZE_kmemleak.o := n might just be the best option. I think
this is fair, because we really do not want to annotate anything
outside Kmemleak just because Kmemleak scans everything. The existing
annotations should probably be reverted in that case.

Thanks,
-- Marco


> Thanks,
> -- Marco
>
> >  write to 0xffffb3074e61fe58 of 32 bytes by task 30208 on cpu 2:
> >   _copy_from_user+0xb2/0xe0
> >   copy_user_generic at arch/x86/include/asm/uaccess_64.h:37
> >   (inlined by) raw_copy_from_user at arch/x86/include/asm/uaccess_64.h:71
> >   (inlined by) _copy_from_user at lib/usercopy.c:15
> >   __x64_sys_rt_sigaction+0x83/0x140
> >   __do_sys_rt_sigaction at kernel/signal.c:4245
> >   (inlined by) __se_sys_rt_sigaction at kernel/signal.c:4233
> >   (inlined by) __x64_sys_rt_sigaction at kernel/signal.c:4233
> >   do_syscall_64+0x91/0xb05
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  kernel/signal.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 5b2396350dd1..bf39078c8be1 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3964,14 +3964,15 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
> >
> >         spin_lock_irq(&p->sighand->siglock);
> >         if (oact)
> > -               *oact = *k;
> > +               /* Kmemleak could scan the task stack. */
> > +               data_race(*oact = *k);
> >
> >         sigaction_compat_abi(act, oact);
> >
> >         if (act) {
> >                 sigdelsetmask(&act->sa.sa_mask,
> >                               sigmask(SIGKILL) | sigmask(SIGSTOP));
> > -               *k = *act;
> > +               data_race(*k = *act);
> >                 /*
> >                  * POSIX 3.3.1.3:
> >                  *  "Setting a signal action to SIG_IGN for a signal that is
> > @@ -4242,7 +4243,9 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
> >         if (sigsetsize != sizeof(sigset_t))
> >                 return -EINVAL;
> >
> > -       if (act && copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
> > +       if (act &&
> > +           /* Kmemleak could scan the task stack. */
> > +           data_race(copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa))))
> >                 return -EFAULT;
> >
> >         ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
> > --
> > 1.8.3.1
> >
