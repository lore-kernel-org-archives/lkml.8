Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7909C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 19:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0602084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 19:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6jx1oze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgAKTkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 14:40:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45036 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbgAKTkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 14:40:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so4810583wrm.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 11:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Xzzq+Fpy+MF3TzUUfFGW7XA26xcIbXvajvYyQ3QD5rk=;
        b=L6jx1ozed0id6SV+YZo+wCrpUcnnXkusA7x5OHiD+en03py9JrOR+B6LreAA/hKUz+
         EVTjOBkXPq4rtyH2nfd/kybHa2RSlUpJ4w9jh29NNrR8KyPCcsg9qzKDkeSKIf2de3Ao
         ZcAiYiF7Ti5a7KsSzMZoCPOFZqR76jBE2JmA3tHYobtTkGP7UWVn1AMkLTPG50FUoTBJ
         c/ELjsbGzBjybwLydYUOKqIpgOM7xWZuzpVvKQRzvb5wUInvfXP2nqwqOehZGEYWm9ba
         lRN6GwNHA4PXgmahG+ZQsAfWnMjR7yLXFuF3rO8feN/tGmeR6UJ2OMQGmwdVh3rFO0S+
         9NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Xzzq+Fpy+MF3TzUUfFGW7XA26xcIbXvajvYyQ3QD5rk=;
        b=rSSZGbx62soSOl58iHVkgPAkv1GYqgAHqDndtzACPhf03XI7YqUcd/4bQFSTIMlFvM
         NzlFCISJBPCLxES79AmcZxiu594UxPyyhoHmhzUjwDjEizTPAs+o1MCSwGH0X1QkA6uy
         uwGhoZaNbQwEDfpsrTVP+xayAarYd4+MNSrDVf9bR1TDo5HFUIEeZfR+rxQ7tef+sz9G
         EgpVcEI8UPsaCa9VlDwtAUqIrqyK4Np50NUX4K4BLCfjmyTgDqzP2DoGHQNMb+u2nuGw
         RyXt9wUtD8Vu/lGeO8Zum8IGRwGSEwEq7pFVpHPmhHdowD5lL0pBs6P3Da8AdBjx4E++
         35gA==
X-Gm-Message-State: APjAAAU1mzkHdNfV4J1qV1BqHvNZjhqNr1ul5HO+FdvX3HZxiHWquNf0
        eKREbgKAxqdSSrCyYrjwwMJKUYwQXUjqHUXvR/NaD8ZbqPA=
X-Google-Smtp-Source: APXvYqzayriqJ7UjnHGHkvHgDHFp9cOQu2Vm0X0NtYd0/FK+1/QLMocE2zac+c6qEOdAod9xpLXzUr7wo9PKBBXbano=
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr10179756wrm.241.1578771612670;
 Sat, 11 Jan 2020 11:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic> <202001101255.3F360ED562@keescook> <CAEQFVGa4fksPRtiLtBckSgbJY_JSHr07hoy5+5w-pAYym16YVg@mail.gmail.com>
In-Reply-To: <CAEQFVGa4fksPRtiLtBckSgbJY_JSHr07hoy5+5w-pAYym16YVg@mail.gmail.com>
From:   Mauro Rossi <issor.oruam@gmail.com>
Date:   Sat, 11 Jan 2020 20:40:01 +0100
Message-ID: <CAEQFVGbWKf2ksMrMmtymewArSF=ztNgeuieEQ3wvKrX1r759Aw@mail.gmail.com>
Subject: Fwd: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Message resent as plain text to linux-kernel@vger.kernel.org
because of rejection of previous message

---------- Forwarded message ---------
From: Mauro Rossi <issor.oruam@gmail.com>
Date: Sat, Jan 11, 2020 at 8:36 PM
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and
__end_of_kernel_reserve to S_REL
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>, Arvind Sankar
<nivedita@alum.mit.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo
Molnar <mingo@redhat.com>, H. Peter Anvin <hpa@zytor.com>,
<x86@kernel.org>, Linux Kernel Mailing List
<linux-kernel@vger.kernel.org>, Thomas Lendacky
<Thomas.Lendacky@amd.com>


Hello Kees,

On Fri, Jan 10, 2020 at 9:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 10, 2020 at 09:38:28PM +0100, Borislav Petkov wrote:
> > On Fri, Jan 10, 2020 at 03:23:49PM -0500, Arvind Sankar wrote:
> > > Pre-2.23 binutils makes symbols defined outside sections absolute, so
> > > these two symbols break the build on old linkers.
> >
> > -ENOTENOUGHINFO
> >
> > Which old linkers, how exactly do they break the build, etc etc?
> >
> > Please give exact reproduction steps.
>
> Mauro (now CCed) ran into this too, but on 32-bit builds only with older
> binutils. I hadn't set up an environment to try to reproduce it yet, but
> it seems like this patch would fix it. Mauro can you test this? Does it
> fix it for you too?
>
> https://lore.kernel.org/lkml/20200110202349.1881840-1-nivedita@alum.mit.edu/
>
> -Kees


The patch solves the issue with Android build of 32bit kernel,
I don't see 'Invalid absolute R_386_32 relocation' errors anymore.

Thanks a lot!

Mauro
