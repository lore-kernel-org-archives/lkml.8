Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71D2C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15092070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585040579;
	bh=AV8QW3nn8jQRBiIc5doTLtBK64ufkGXmNsE1oozecH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y7CFFfwRgjZ3QEObOuNpk3i6SEuAj8lAbhP2zFQoOixFlPQtWnrmugCAQ88p08xjf
	 ImFI516VwWw+wwiDqVx59F527xUKtWLjwKnGjFX6i+HYTLw3g/htcwaPtJXVBJt7ea
	 O1KZQKk1J/d5ig7JCRAvpYN63tY2CPd8VM4t1N+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCXJC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:02:58 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42291 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:02:58 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 02O92cga016626
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 18:02:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 02O92cga016626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585040559;
        bh=rPKfr4YNri5mx4ExgQkvbpN9SAEjUcUEL+qitgoFUcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ER/h59XV0NCJgbtMZfZf38kal9Kv1jeZrtlxjOclcBuU+oj+c9pD84KQeBtEm1LT8
         i36Mw6/lIMASnqnPr/pghVd0/iIzuOsb+CRw5HdwlqHSywTY7KDmH9iAaL3XaeSoXp
         Kg5ZWe7Plk2ec+hfQUe9izZDvEb4nT6oIA8ZU1zJ5aa7ME0sANz6FxZs3fgD9RxBEa
         /PF/hGO6PY+gOuYDkc4Xqh5cPHB4nPGo9X+x0ielI6rnvi4lSnkEPrHSXULuqJiSk8
         a63L/zQg1kyOumKJuWfLczVsB/6FBxFBhOWSLgUVBY8rqXOE8zqXAyWzFMA/Th5nII
         y5t2QcsTfzUOA==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id b5so228363vsb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 02:02:39 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2HmVyc8KuvB4CLU8nlcTuHWmFk105qZa9YEqyj6aBhoIcZY4Tq
        H131O4cCDSrObfFkzarr6iD8npPGECxABoagubo=
X-Google-Smtp-Source: ADFU+vvqs6PBhqXewmwnxlxjj5zsg8ttldEyMw2RD9XfHl65dh4ywaC09wcCdauuSa9M9zpFJfWdwUFSzOJ+4UpFdVw=
X-Received: by 2002:a67:8745:: with SMTP id j66mr17591587vsd.181.1585040558389;
 Tue, 24 Mar 2020 02:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200113161310.GA191743@rani.riverdale.lan> <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan> <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic> <20200323204454.GA2611336@zx2c4.com> <202003231350.7D35351@keescook>
In-Reply-To: <202003231350.7D35351@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 Mar 2020 18:02:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
Message-ID: <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
To:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.



On Tue, Mar 24, 2020 at 5:51 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Mar 23, 2020 at 02:44:54PM -0600, Jason A. Donenfeld wrote:
> > On Mon, Mar 16, 2020 at 05:02:59PM +0100, Borislav Petkov wrote:
> > > Long overdue patch, see below.
> > >
> > > Plan is to queue it after 5.7-rc1.
> > >
> > > ---
> > > From: Borislav Petkov <bp@suse.de>
> > > Date: Mon, 16 Mar 2020 16:28:36 +0100
> > > Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23
> > >
> > > The currently minimum-supported binutils version 2.21 has the problem of
> > > promoting symbols which are defined outside of a section into absolute.
> > > According to Arvind:
> > >
> > >   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
> > >           Invalid absolute R_X86_64_32S relocation: _etext
> > >   and after fixing that one, with
> > >           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> > >
> > > Those two versions of binutils have a bug when it comes to handling
> > > symbols defined outside of a section and binutils 2.23 has the proper
> > > fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html
> > >
> > > Therefore, up to the fixed version directly, skipping the broken ones.
> > >
> > > Currently shipping distros already have the fixed binutils version so
> > > there should be no breakage resulting from this.
> > >
> > > For more details about the whole thing, see the thread in Link.
> >
> > That sounds very good to me. Then we'll be able to use ADX instructions
> > without ifdefs.
> >
> > Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Can you send these now and we can land in 5.7 with the doc change?
>
> -Kees


Kees,

I folded this patch into the following series (16 patches):
https://lore.kernel.org/patchwork/project/lkml/list/?series=435391

This patch (14/16) is a prerequisite for 15/16.



Borislav,

When I forwarded this patch, I fixed up one more line.
(changes.rst duplicates the same information...)

Please see this. I hope this should be OK.
https://lore.kernel.org/patchwork/patch/1214519/



> --
> Kees Cook



--
Best Regards
Masahiro Yamada
