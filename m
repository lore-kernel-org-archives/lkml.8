Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE01EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68F620786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9EnQDL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHYPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHYPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:22:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0868C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:22:04 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j7so11912771oij.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fUzRthWoB95qJoATouB2WhM9wBqkFWmCuiCwuyo/jvo=;
        b=j9EnQDL/9vRo7973OSxTeKsTHu3+YwVj4aspv8D6Td6creaRrVt2CPyO6KXxMod/U9
         UWieCgngo2TqcsJC0G5crciN6vc0p90gRKfsue2kYacgwnxjTIWTJw958ndfrBcGd4JN
         OhTIMaez9f1m1FhwhW5ZDcqzxE+i5+Wsb3bIfhHuzSNG7ux1XFbsXRziOMGKKTzVzhDq
         gu8UrQ8/WNXxbpYCWOzkLUjfcVUUDGIOr6z9MuywHOakNJ7ByzhlJF5/0Dmzuwwtz+qC
         7HINv95foLvXK/nz8ZWADrR/88N63yNYBXhxHAdiDt1IAN4rueXMXuLaJhLauQIXoeyP
         r0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fUzRthWoB95qJoATouB2WhM9wBqkFWmCuiCwuyo/jvo=;
        b=ZN6xg48YCkbgUXx/YV3WJ3YAHBKuyBDXYuVuB+MYyVwJkcKDR1Z8Ar/OkZgOSMZxGK
         hVRkUmJ34MHMA0WkWb5lny6F+ReG+aSuY8dVcOuMljC3hdb/tA7H2yU3MF7OKcb8KhQv
         qsoZM+oIomeWdH+Cz9Efr0rpHUVF+euopmu8pV8Om1lWJTO5tqGKFQzjBRj7kQwVljAg
         6kFIaYjjWPn/nnPk2L2709YwXFRHecBp5TqqZbpD+pAt/xYzbF7q8QPKl84wi7x3dv21
         PVDv5KkqeU8bnDIyzQDV1NRT9fnpZwZHBXb97vhPv5CTSEFlaC0tWKQ2B1rDtAkM2+FB
         8NDQ==
X-Gm-Message-State: AOAM531AP67VqOXlVs9ex7rz1hdiF2McrQjz2OXljhAtLsw1++l7OwDA
        Ihxy8Yn/jvGHPxandbmti1i+Ddutkh1CEJkShzU=
X-Google-Smtp-Source: ABdhPJyRL1jQB9bUpdzqLs0+LpskMkvmj/1Ujpo1vDfcFTYHuJCf8ZGwFip81Dv8lI3c0oHzKRfjLy0S94gCUgj5P0M=
X-Received: by 2002:a05:6808:311:: with SMTP id i17mr1403276oie.72.1598368924153;
 Tue, 25 Aug 2020 08:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200823011652.GA1910689@rani.riverdale.lan> <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <CANiq72kWaS=8rDQ81cCY3021=1J5yFfJk8FHBQEjhtssRFoVcQ@mail.gmail.com> <20200825151910.GA786059@rani.riverdale.lan>
In-Reply-To: <20200825151910.GA786059@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 25 Aug 2020 17:21:52 +0200
Message-ID: <CA+icZUUrsG-Y_3Rg3a6+5mXXoh_w=QYnCFAazKane9fwXAWynw@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Replace __force_order with memory clobber
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 5:19 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Aug 24, 2020 at 09:13:34PM +0200, Miguel Ojeda wrote:
> > Hi Arvind,
> >
> > On Sun, Aug 23, 2020 at 11:25 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > - Using a dummy input operand with an arbitrary constant address for the
> > >   read functions, instead of a global variable. This will prevent reads
> > >   from being reordered across writes, while allowing memory loads to be
> > >   cached/reordered across CRn reads, which should be safe.
> >
> > Assuming no surprises from compilers, this looks better than dealing
> > with different code for each compiler.
> >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
> >
> > A lore link to the other discussion would be nice here for context.
> >
>
> Ok.
>
> > > + * The compiler should not reorder volatile asm, however older versions of GCC
> > > + * had a bug (which was fixed in 8.1, 7.3 and 6.5) where they could sometimes
> >
> > I'd mention the state of GCC 5 here.
> >
>
> Ok.
>
> > > + * reorder volatile asm. The write functions are not a problem since they have
> > > + * memory clobbers preventing reordering. To prevent reads from being reordered
> > > + * with respect to writes, use a dummy memory operand.
> > >   */
> > > -extern unsigned long __force_order;
> > > +
> >
> > Spurious newline?
> >
>
> This was intentional, but I can remove it if people don't like the extra
> whitespace.
>
> I'll wait a few days for additional review comments before sending v2.
>
> Thanks.

Thanks for taking care and your patch.

I have tested this on top of Linux v5.9-rc2 with LLVM toolchain
v11.0.0-rc2 (ThinLTO).

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -
