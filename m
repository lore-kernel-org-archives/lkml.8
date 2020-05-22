Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D5EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA89C205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPxzew+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgEVKwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgEVKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:52:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D2C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:52:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o14so12120881ljp.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvdyN6G4YtegRjCLgqlMGLFPk+ZDJ/sCDCmfREQfAYs=;
        b=MPxzew+BaJxir4dgUA9o3HVns9qarZ9K7auFqYfINS40vfUiTt5MGzXN89nhppJNYJ
         VXK84TbQdyf9b9ZMY/doS6mNQTxnNFkzKdaJLxwhbg4QtliRkgK1mFk4lbpnGkJee1rM
         z3KtLboDvdRLZmsjPO/CoqfBS0lfkYrih6HoozgVE4yNkryPhKUPZOYm2H+nzdVABzSW
         IHONB44yeoX5H69Mqcba1tKOVZvWspsLvgnJI6wtxjD+qMAhPF7s0x6pAVW2OY2KCds6
         jOZV7sBzFKh0dJE5AOR8RQAGZgIgCuJsnTwipnt2wXrlZK1qJDWEKO6jlr5Bp7r8O+fn
         hn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvdyN6G4YtegRjCLgqlMGLFPk+ZDJ/sCDCmfREQfAYs=;
        b=iE4eVPLFTddFXozdfOC54WK+HuKDMR3jYHmpEmb0DSdeH2CMMHpPoG5jPn1sGQ0V2t
         t5dwMMhfLcSfCS1MclHTXLdP4t+4n82jaaFPYN2C5fKqS+iYVNAWeE2X3LJpdX+J9yI3
         WyCeb6YfOnsd+XD3yIAKUwmTiYkVnri3bJiV0WGRlNEkhrmouwjXJCaor4lql05AP3S7
         WfW2aRkLzg9D2b0fKVY+MB0ykb+hlBmZm9Wwve/PE5tHSyM9Ez/MBjuMCn0TORtZdf5V
         XuH/OEQZtw5/pcnNd71CzvP0e2umUwNMyxzZdRp+XN1Cf/2CroRVS0+mM/r4El6JiTyH
         nDsA==
X-Gm-Message-State: AOAM533w/vRhlPlLvvHid/uLnPmVgls3IUKDAYsYlhOY8o8SFwFiKj4m
        DzgSyoJQTc99EsTepVXVhVZk4NPzWMeWX3sH6zVs/Q==
X-Google-Smtp-Source: ABdhPJwT+56RE7ncBbnOnI78vRnr+Lpx7mxffN+NN9N0wIt4TPXqlDIkjAKLXCvmPYBpHeZxbYfwhtbKQ3j+WtB0X6U=
X-Received: by 2002:a2e:7504:: with SMTP id q4mr4798745ljc.339.1590144762130;
 Fri, 22 May 2020 03:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <1590141746-23559-1-git-send-email-sumit.garg@linaro.org> <20200522103823.uwb6jpjwpzhhjwwt@holly.lan>
In-Reply-To: <20200522103823.uwb6jpjwpzhhjwwt@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 22 May 2020 16:22:30 +0530
Message-ID: <CAFA6WYPVY2Jz6YF_tpc80b2LqEnzMa60NaVjQEmBwQEOY3o+2g@mail.gmail.com>
Subject: Re: [PATCH] kdb: Make kdb_printf robust to run in NMI context
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 at 16:08, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, May 22, 2020 at 03:32:26PM +0530, Sumit Garg wrote:
> > While rounding up CPUs via NMIs, its possible that a rounded up CPU
> > maybe holding a console port lock leading to kgdb master CPU stuck in
> > a deadlock during invocation of console write operations. So in order
> > to avoid such a deadlock, invoke bust_spinlocks() prior to invocation
> > of console handlers.
> >
> > Also, add a check for console port to be enabled prior to invocation of
> > corresponding handler.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 924bc92..e32ece6 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -699,7 +699,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >                       }
> >               }
> >               for_each_console(c) {
> > +                     if (!(c->flags & CON_ENABLED))
> > +                             continue;
> > +                     bust_spinlocks(1);
> >                       c->write(c, cp, retlen - (cp - kdb_buffer));
> > +                     bust_spinlocks(0);
>
> I think it might actually be better to directly manipulate oops_in_progress
> here.
>

Okay will directly manipulate oops_in_progress here.

> bust_spinlocks(0) will call unblank_screen() and console_unblank() and
> I don't think calling these is worth the risk (and whilst kicking klogd
> is safe I think its also not required).

Makes sense.

-Sumit

>
>
> Daniel.
>
>
>
> >                       touch_nmi_watchdog();
> >               }
> >       }
> > @@ -761,7 +765,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >                       }
> >               }
> >               for_each_console(c) {
> > +                     if (!(c->flags & CON_ENABLED))
> > +                             continue;
> > +                     bust_spinlocks(1);
> >                       c->write(c, moreprompt, strlen(moreprompt));
> > +                     bust_spinlocks(0);
> >                       touch_nmi_watchdog();
> >               }
> >
> > --
> > 2.7.4
> >
