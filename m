Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6986BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB9F2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkdAW6/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbgCCSId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:08:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45554 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbgCCRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:53:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so3890045oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QskSzXkk1uR/gTFKte9PcDDhEgJX8WglHuzZL1T1G4=;
        b=EkdAW6/gbfcyTLcI6cTuLSxNcHGev64LQOUj5OAjNQw2Xj0vLIPKWYamrckOeGPLtq
         MhahHQt+YRF0QGMJZcGPkOWZV/8U8AknEZxlXU2VZ+FrViArmUtKhGfIaEUbH7F/gF4T
         04hPqBSpVHKtoGKcQNVvvSuZKE0Vy3OUl+JOHQR+tULqSkdsfOHK69X+FeNXTap9cvFf
         C/YFZiDDbNYtWupxyhH4d0URwyaCyd8kqZvCe5TE6eQtT1l4uTTY9eodjkNdGJDN0ujX
         +t9dGG48tMSUkTYHDv2NOPSrqgFzqNTMcYapNtcIFzhp5ASA9hiX7gzvkquAyM5Bko1n
         AiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QskSzXkk1uR/gTFKte9PcDDhEgJX8WglHuzZL1T1G4=;
        b=JcpaGQzNZmnUUPRlps+OUZUQKD1OBC7HItzS7cQ4ayD53zVz1mD42rlItGZsHEaHrW
         bEY4zhYeJhViPCsqQw8K3gLz9bxLn7ypD3QE2UsekVCC++gLXG/BTysMvHDVogTiNoHd
         AiGc+apYT19BZhzydzrpk8E8WxJKcClrClCEc6grbjq6cQPus//IJuC3OwCDszQjRb17
         qNi5EP0AuS0Kgmc8vf8ens2+tmgwDHVV1ygloxliVcbFiOS4J4fdmJQr+vH+VAwAzBzW
         PL3qfY2P4aY+Eu1uxBlvbFs35MXZz2SIPlcAZcOWWtuwWEIKEf7XFiHisY8Rp8tF93+K
         oMtQ==
X-Gm-Message-State: ANhLgQ1lSQlDoCYOZkYRZRqPYfckyze/LAI01AGPT3VdRXlqkBIkX/Cf
        rSjrX6qZfADG6Ef0kY3eF7cMfE0eDxniiZP3QWtwr4ZcOUY=
X-Google-Smtp-Source: ADFU+vvAz3SFLobt0buMef4VTMqh/gw3M2ubbyrfIoKOqQ/M5Ky/Ct5gh8DK1xfIa99e1pRyzln7JMroMoIwcBdJCwY=
X-Received: by 2002:aca:4cd8:: with SMTP id z207mr3096082oia.155.1583258011709;
 Tue, 03 Mar 2020 09:53:31 -0800 (PST)
MIME-Version: 1.0
References: <1583256049-15497-1-git-send-email-cai@lca.pw>
In-Reply-To: <1583256049-15497-1-git-send-email-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 3 Mar 2020 18:53:20 +0100
Message-ID: <CANpmjNPJc_45+h_yJWwmw=YUuWduD6pPX2vdfPVekPvnnHd+_Q@mail.gmail.com>
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

On Tue, 3 Mar 2020 at 18:21, Qian Cai <cai@lca.pw> wrote:
>
> Kmemleak could scan task stacks while plain writes happens to those
> stack variables which could results in data races. For example, in
> sys_rt_sigaction and do_sigaction(), it could have plain writes in
> a 32-byte size. Since the kmemleak does not care about the actual values
> of a non-pointer and all do_sigaction() call sites only copy to stack
> variables, annotate them as intentional data races using the
> data_race() macro. The data races were reported by KCSAN,
>
>  BUG: KCSAN: data-race in _copy_from_user / scan_block
>
>  read to 0xffffb3074e61fe58 of 8 bytes by task 356 on cpu 19:
>   scan_block+0x6e/0x1a0
>   scan_block at mm/kmemleak.c:1251
>   kmemleak_scan+0xbea/0xd20
>   kmemleak_scan at mm/kmemleak.c:1482
>   kmemleak_scan_thread+0xcc/0xfa
>   kthread+0x1cd/0x1f0
>   ret_from_fork+0x3a/0x50

I think we should move the annotations to kmemleak instead of signal.c.

Because putting a "data_race()" on the accesses in signal.c just
because of Kmemleak feels wrong because then we might miss other more
serious issues. Kmemleak isn't normally enabled in a non-debug kernel.

I wonder if it'd be a better idea to just disable KCSAN on scan_block
with __no_kcsan? If Kmemleak only does reads, then __no_kcsan will do
the right thing here, because the reads are hidden completely from
KCSAN. With "data_race()" you would still have to mark both accesses
in signal.c and kmemleak (this is by design, so that we document all
intentionally data-racy accesses).

An alternative would be to just exempt kmemleak from KCSAN with
"KCSAN_SANITIZE_kmemleak.o := n". Given Kmemleak is a debugging tool
and it's expected to race with all kinds of accesses, maybe that's the
best option.

Thanks,
-- Marco

>  write to 0xffffb3074e61fe58 of 32 bytes by task 30208 on cpu 2:
>   _copy_from_user+0xb2/0xe0
>   copy_user_generic at arch/x86/include/asm/uaccess_64.h:37
>   (inlined by) raw_copy_from_user at arch/x86/include/asm/uaccess_64.h:71
>   (inlined by) _copy_from_user at lib/usercopy.c:15
>   __x64_sys_rt_sigaction+0x83/0x140
>   __do_sys_rt_sigaction at kernel/signal.c:4245
>   (inlined by) __se_sys_rt_sigaction at kernel/signal.c:4233
>   (inlined by) __x64_sys_rt_sigaction at kernel/signal.c:4233
>   do_syscall_64+0x91/0xb05
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/signal.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 5b2396350dd1..bf39078c8be1 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3964,14 +3964,15 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
>
>         spin_lock_irq(&p->sighand->siglock);
>         if (oact)
> -               *oact = *k;
> +               /* Kmemleak could scan the task stack. */
> +               data_race(*oact = *k);
>
>         sigaction_compat_abi(act, oact);
>
>         if (act) {
>                 sigdelsetmask(&act->sa.sa_mask,
>                               sigmask(SIGKILL) | sigmask(SIGSTOP));
> -               *k = *act;
> +               data_race(*k = *act);
>                 /*
>                  * POSIX 3.3.1.3:
>                  *  "Setting a signal action to SIG_IGN for a signal that is
> @@ -4242,7 +4243,9 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
>         if (sigsetsize != sizeof(sigset_t))
>                 return -EINVAL;
>
> -       if (act && copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
> +       if (act &&
> +           /* Kmemleak could scan the task stack. */
> +           data_race(copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa))))
>                 return -EFAULT;
>
>         ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
> --
> 1.8.3.1
>
