Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6921C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BCE20675
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQ3s5JsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgBYUhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:37:38 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:55576 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgBYUhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:37:38 -0500
Received: by mail-pj1-f52.google.com with SMTP id d5so229929pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 12:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1XIiBi4oFqFORFlQSNw7k0aiV4sK296qJvfGhGJwdw=;
        b=LQ3s5JsGiE5C/5QwAaBVAvmcQzFSZQV/cq37pLIqqZoS3kr5rWHIeVPeJi0QSbm7dU
         O7s4jzwksIiWqBJl3RfEfyT4PA4Nj/Vtkwy64hhxX4FdUhNGyRFAINXPapkhR1QhuKld
         l6+1XX+FTFlbm9z3wgR6d6GVBMsl7z+jf2myRX5SR6V7qPuYrz77DbG6ScEQXzWT0IAT
         ib4+WM9ZvKKuzoqe96C5ctW3XxDOjZn1POfDRcLHx9jYZF6z2LihbFkU44SdtUsDvdIl
         mVW632toRtCJCwzWCcBKjACtoXBm/Smx194+Sm3i8GOjCdsRkPNKzWG1A688jczm79dY
         Gj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1XIiBi4oFqFORFlQSNw7k0aiV4sK296qJvfGhGJwdw=;
        b=YvXNQm8Evyv2IlFtQUiS7515uJEf4vX1rmVjtR2ZLWye8RYosQJ74lH6zOzY25x+wX
         il9q8YO6tlCeZAB0gM+3cHp/3aSOyW+rCGGvGj9XzwMtNmb/kdsfnosyt9WnoxCDPHge
         1eks2lVm+0lgwbe8Y3+23sKuSASpbwkCu4LBU2OsxU4iVt85z0EPuZb9l98XSoJ3Oj3l
         /9cejRUSDKag9kvLLNojTZNriMza1c4sgVaqY1OE67l42wCDpbyky0ElRSTdtSF/LKPp
         sOCdMMKaa95b4nRfm0O8YzucJ/1muwdjvSPiu35WQT4ARHdvK2STDO8himdhi+onXcDt
         /0nA==
X-Gm-Message-State: APjAAAWolLf9ZiIma0cX/Z1uCDOs7vi8ghuxewhtYsPrXYy8aGXuWOqb
        qYXx0h1UxXX/3GsjCXbOaXRRNnkU4Uv6cWwzl/LmXg==
X-Google-Smtp-Source: APXvYqwA9l5PA1pH+Ecx/QO7gbcCcyQIT07mu96WcqOtKhnbLmxVjht2OHC1qkLLWoQLn5YC4KnOfLbelRCE2tYsDCc=
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr955101pjk.134.1582663057319;
 Tue, 25 Feb 2020 12:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20200109150218.16544-2-nivedita@alum.mit.edu> <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic> <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com> <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan> <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <202002242122.AA4D1B8@keescook> <20200225182951.GA1179890@rani.riverdale.lan> <202002251140.4F28F0A4F@keescook>
In-Reply-To: <202002251140.4F28F0A4F@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Feb 2020 12:37:26 -0800
Message-ID: <CAKwvOdnkr1W4LTm8XmTKGkSDUhSBRowLbKwJwyitDMAGLh9ywg@mail.gmail.com>
Subject: Re: --orphan-handling=warn
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:43 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Feb 25, 2020 at 01:29:51PM -0500, Arvind Sankar wrote:
> > On Mon, Feb 24, 2020 at 09:35:04PM -0800, Kees Cook wrote:
> > > Note that cheating and doing the 1-to-1 mapping by handy with a 40,000
> > > entry linker script ... made ld.lld take about 15 minutes to do the
> > > final link. :(
> >
> > Out of curiosity, how long does ld.bfd take on that linker script :)
>
> A single CPU at 100% for 15 minutes. :)

I can see the implementers of linker script handling thinking "surely
no one would ever have >10k entries." Then we invented things like
-ffunction-sections, -fdata-sections, (per basic block equivalents:
https://reviews.llvm.org/D68049) and then finally FGKASLR. "640k ought
to be enough for anybody" and such.
-- 
Thanks,
~Nick Desaulniers
