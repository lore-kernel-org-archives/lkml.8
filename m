Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC593C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8FF206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCn5psV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgEKTwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgEKTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:52:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7851C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:52:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so8413930pjw.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4J+O5ij9f6iPCsIeld+kaqMUMJVlz/CC6sojBFpIW5A=;
        b=JCn5psV/bUZ7uw45aQpXpO6oHjBJs3tJlx1OkzrSR75S3XPNwlnqhhoGNq5sn8Svb5
         gl6KdMmeXeHiITKglSOoPSyFrNImQOvVhPtnpanPwRMRF+/4C/Ux3SZi928JlRWtTvZN
         /4chmP+QOBe08BzvgBPm4u7MtbqYCRgtzCm3DXn/kCARAeVFpxI7VYryGAYtt1iMTQLB
         4yveBDwWX+5J+FAkZ6w+b1nBDRaY3VhRvn9OjqUyKSC21H+FOkFrIT+uZyew73OTguRD
         lX+bLlKubVSDY/476N6VLLrlG5J6a1O+TC8i+sWoyFH42y2EjfhRUXM/Im60CFp6yFUp
         rmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4J+O5ij9f6iPCsIeld+kaqMUMJVlz/CC6sojBFpIW5A=;
        b=dXCL61kPGq+jSwC03ZVJrf8YFgyPrRZ7pLVWAWVBOEhffJjBrkOd+wGlYNsL7bqXZa
         YgU8/5nUzgEdH0OmNZt9Dvmh+oGyyJAi6I6+eJ8HiUi+4EBi0rbXalmBjdBt6+v3azo6
         vYEg2qYzjuAxxgJYeO5LEfICoEH7c8JXTg+wBLDaBsvCpXpEsnaJjmoFmCw+Yb32pMpP
         wEosmvzk3F838GMXJW/kIyt9XtThrAiz1XyIo07HGfblobzIAemWBRvFd0k0gndM6Lmk
         5rhhrhBFSC7e5IrZrOoDi7FZtEVbkntWFSd4g6GkSBkFGaL2Cq+SonGmmVMk2eM6y+ss
         W4yA==
X-Gm-Message-State: AGi0PubaGN1D/aHmbbHqb2oEDXrQqfrfImqDZOz6xOGNETF8lsnS4eds
        /zvcwrwWAgItBRfxMKij/20GFbAJ8uqCX145dsrknA==
X-Google-Smtp-Source: APiQypJy3WgI4dEUsqoRxHE0DJN9k48AtN3jB2Wkzk2RWU8PnhP5is3d9qXfSbNEs4wsTKX2SdLqykMKyZjTfBlgcRE=
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr25045831pjb.101.1589226763110;
 Mon, 11 May 2020 12:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
 <CAHk-=wif=_ZomkWJAmQRCUAMHQ72V3NEQ-OteiPE56K7KoSjbQ@mail.gmail.com> <CAHk-=whhCBvjXtRiFM2JEZ4XyBmuPprvdo5tpPVBqUhkRszxiQ@mail.gmail.com>
In-Reply-To: <CAHk-=whhCBvjXtRiFM2JEZ4XyBmuPprvdo5tpPVBqUhkRszxiQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 May 2020 12:52:31 -0700
Message-ID: <CAKwvOdn06jCe_FhKiF_wSQavytVVD++RXD-bHbMdqnEA-wO-9w@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 11:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, May 11, 2020 at 11:12 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Would using "__builtin_choose_expr()" be able to avoid this whole issue?
>
> We actually have a fair amount of "pick expression based on size", so
> with a few helper macros we could make the code look better than the
> case statements too.
>
> Something (ENTIRELY UNTESTED!) like the attached patch, perhaps?
>
> NOTE! I only converted one single use to that "pick_size_xyz()" model.
> If this actually works for clang too, we could do the others.
>
> I guess I should just test it, since I have that clang tree.

Interesting approach.  Researching __builtin_choose_expr, it looks
like it was cited as prior art for C11's _Generic keyword.
http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1404.htm

I'm kind of tempted now to play with _Generic and see if that makes a
difference, though I'm not hopeful.  Without checking, I don't know if
that will produce warnings with `-std=gnu89`.

...

I'm playing around with _Generic now to see if that's a possible
solution, but it looks like it can't be used for selecting inline asm
constraint strings.  But maybe there's another way to use _Generic
here.  TODO: more testing.

I don't quite understand the use of GNU C statement expressions in
pick_type_statement, though I'm guessing the return value is important
somewhere.  Maybe just looking at the preprocessed source would make
it clearer.

> "why do we cast to unsigned long and then to char,
> when we just checked that the size of the type is 1"?

Deja vu.  I don't remember who I discussed that with, maybe Arnd, but
that was something else I had asked at some point.  I must have
forgotten to look into it more before sending the patch.  Can likely
drop that at least.

--
Thanks,
~Nick Desaulniers
