Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D690C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1C8206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMBcQjit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbgDMTNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387844AbgDMTNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:13:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC7C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:13:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so2658355pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4xDgyHrAaR0PWbatqOjb+dKS38cBqBXlUQRBaSrOKM=;
        b=CMBcQjitoOG06iIIgLKAPgFwxrg5zXJDxXPJRusMXuO9B0GZ4OpjMQaa5jWoaY2msq
         uA3VahVaBdEEeMMW+PI/eGalMkCV/zgyKHFZRKqlIONh6egDY8lCuDqDLqcGhzKAzEtY
         fYiiE5TrBqn9QDIaLxcZ5ghSFUVvkpWEZlVwr3ZBaRQpLP8n0uWgInFneJeXT6ApvsPE
         Mt7hpptRMeZAosXxs93ejIPW1jmpsXUSegSQEeyJe641fs5PgvcP7GqRz3PZz/GPT/JD
         jnLf5fkQ1LdYHVmmq2s0d2cJz3HAAL6KUsdpumwLu1S2Am3NaOdFiRqRjJXWU0NIViPj
         gN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4xDgyHrAaR0PWbatqOjb+dKS38cBqBXlUQRBaSrOKM=;
        b=p5Z5xxGSBEZxvq/sXHwPc1JfkH/OEMe+hsL2dJYR6stC9pFNb5npcuCRIGuBuazRHg
         vpVgUwwu1a1T1m9yxhJX5KLdq5MIz04rwy4d0t+vPDQwwO33q3LtlL/aaEzJ+W9+vlQC
         mKCdvzyFWjaXuEA7i3wOqj98qH+V24bnbApke4A+Pl07JFrX50QJOedP7OKdp/9ENBpi
         qX8eF0o34IRJoIoSA9JdYz/GwzTdXCEB6MizJDx1zDYQun6l8eofT7dzJTUK0wvANjd+
         LmcKmewCtzGYyzuKeBtL/Y0VtnOe8cQraVkyym471fUuaXXUFHQ/Fm+7lkABPbsjU/fb
         lnqQ==
X-Gm-Message-State: AGi0PubEjjP2EUa9H/d79ju+BloIvESkIeOIZGU/44PrSv76bXL3G82x
        b1Sg1l8MIj1k1j5bRpqekG/xoFS85BnlLKX7UeLdMw==
X-Google-Smtp-Source: APiQypKkEaqtqmfGTNSuJ/lapu/UAciLB7FdMsJYfXNGEoBlYcPaDtMLRZq5RKC1uPgVqO4lI/7/zwbmIiceA1AbyZ4=
X-Received: by 2002:a65:6704:: with SMTP id u4mr18940889pgf.263.1586805189832;
 Mon, 13 Apr 2020 12:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200324220830.110002-1-ndesaulniers@google.com>
 <20200403231611.81444-1-ndesaulniers@google.com> <20200404160100.GB26298@redhat.com>
 <20200404170604.GN23230@ZenIV.linux.org.uk>
In-Reply-To: <20200404170604.GN23230@ZenIV.linux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 12:12:58 -0700
Message-ID: <CAKwvOdng5_KtX9CNxrTdtsdfNKsfY_4q=Rw_zMp-wGL+64skmg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: signal: move save_altstack_ex out of generic headers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 10:06 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Apr 04, 2020 at 06:01:00PM +0200, Oleg Nesterov wrote:
> > On 04/03, Nick Desaulniers wrote:
> > >
> > > --- a/arch/x86/kernel/signal.c
> > > +++ b/arch/x86/kernel/signal.c
> > > @@ -416,6 +416,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> > >     return 0;
> > >  Efault:
> > >     user_access_end();
> > > +   reset_altstack();
> > >     return -EFAULT;
> > >  }
> > >  #else /* !CONFIG_X86_32 */
> > > @@ -507,6 +508,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> > >
> > >  Efault:
> > >     user_access_end();
> > > +   reset_altstack();
> > >     return -EFAULT;
> > >  }
> >
> > I must have missed something, but this looks just wrong.
> >
> > reset_altstack() should be called when __setup_rt_frame() (and
> > unsafe_save_altstack() in particular) succeeds, not when it fails.
> >
> > Nevermind, Al has already suggested to use signal_delivered()...
>
> FWIW, I propose to do is the patch below (against the current mainline);
> objections?
>
> Don't do sas_ss_reset() until we are certain that sigframe won't be abandoned
>
> Currently we handle SS_AUTODISARM as soon as we have stored the
> altstack settings into sigframe - that's the point when we have
> set the things up for eventual sigreturn to restore the old settings.
> And if we manage to set the sigframe up (we are not done with that
> yet), everything's fine.  However, in case of failure we end up
> with sigframe-to-be abandoned and SIGSEGV force-delivered.  And
> in that case we end up with inconsistent rules - late failures
> have altstack reset, early ones do not.
>
> It's trivial to get consistent behaviour - just handle SS_AUTODISARM
> once we have set the sigframe up and are committed to entering
> the handler, i.e. in signal_delivered().
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
I'll follow up on our KASAN implementation turning two consecutive
longs into memset, which is odd.  Some of the recent changes to
unsafe_put_user to pass a label are triggering new
error: inline assembly requires more registers than available
in arch/x86/ia32/ia32_signal.c for me, but they're unrelated to this patch.

> ---
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 0480ba4db592..f614967374f5 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -461,8 +461,6 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
>                         &__uss->ss_sp, label); \
>         unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
>         unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
> -       if (t->sas_ss_flags & SS_AUTODISARM) \
> -               sas_ss_reset(t); \
>  } while (0);
>
>  /*
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 05bacd2ab135..28fe9cc134f7 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -450,8 +450,6 @@ int __save_altstack(stack_t __user *, unsigned long);
>         unsafe_put_user((void __user *)t->sas_ss_sp, &__uss->ss_sp, label); \
>         unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
>         unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
> -       if (t->sas_ss_flags & SS_AUTODISARM) \
> -               sas_ss_reset(t); \
>  } while (0);
>
>  #ifdef CONFIG_PROC_FS
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e58a6c619824..4cfe0b9af588 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2769,6 +2769,8 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
>         if (!(ksig->ka.sa.sa_flags & SA_NODEFER))
>                 sigaddset(&blocked, ksig->sig);
>         set_current_blocked(&blocked);
> +       if (current->sas_ss_flags & SS_AUTODISARM)
> +               sas_ss_reset(current);
>         tracehook_signal_handler(stepping);
>  }
>
> @@ -4070,11 +4072,7 @@ int __save_altstack(stack_t __user *uss, unsigned long sp)
>         int err = __put_user((void __user *)t->sas_ss_sp, &uss->ss_sp) |
>                 __put_user(t->sas_ss_flags, &uss->ss_flags) |
>                 __put_user(t->sas_ss_size, &uss->ss_size);
> -       if (err)
> -               return err;
> -       if (t->sas_ss_flags & SS_AUTODISARM)
> -               sas_ss_reset(t);
> -       return 0;
> +       return err;
>  }
>
>  #ifdef CONFIG_COMPAT
> @@ -4129,11 +4127,7 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
>                          &uss->ss_sp) |
>                 __put_user(t->sas_ss_flags, &uss->ss_flags) |
>                 __put_user(t->sas_ss_size, &uss->ss_size);
> -       if (err)
> -               return err;
> -       if (t->sas_ss_flags & SS_AUTODISARM)
> -               sas_ss_reset(t);
> -       return 0;
> +       return err;
>  }
>  #endif
>


-- 
Thanks,
~Nick Desaulniers
