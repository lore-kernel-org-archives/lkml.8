Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF90CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899B420692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvE9X5S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbgDMTXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgDMTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:23:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8BAC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:23:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e16so3962995pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lE32io1NRyqSa7MHqCZDRttxoRhAaBAKKn04pJslSA=;
        b=BvE9X5S9Y0cIXImu51NYc31tHh4aVt0KseCDiyJkR7OZzY2JlIRDMkyDZdTNOPuC4R
         9IYJkyCLyatQ9MCEd+g3PH5wq3a+NdnlcnQwJGnU5WCj0BtJz72G8SPSDblVjuOUBKvh
         yhtI9Co6zz/+w4Y2ZsWWLZBcNOjxZAl0nlqk8AeM04HBptMq3I/aR+OocaBYkQ8aIM1n
         jmagVkld4noTl+Up7eXZH2LGLT23dOn9qhWpW7udKYuYLNiClPgVQu0sh/zlvqTdjr7c
         AkUSLYive4wNiDPW4Iix+C1+FjWDB6jiNv3afz3djTNXVT9cjCdb3G9SfKdliIBkFdtZ
         CXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lE32io1NRyqSa7MHqCZDRttxoRhAaBAKKn04pJslSA=;
        b=rlI3Jezwpl5SOgyRH5JLm1lto+ymmrt6sBLR7Fh/ePG4+l+/kE++3hyoJa64SyKSjc
         4ZJ4bfZ6a3VPPapR6g3l8wNzEq1vB17fvSROV3QqFfDi/lcwbiEunVsKoZmviaa7NYoy
         Ulo3jdt/Mx6gGAb0wI91j1djBVxzGNzRpDFm2f42t9xoPVp0ozR6Saln9UOth5Ur31f2
         iP9OfMli+Xl7JnFaaHfWwuO7kHKP9Ff1B7NY+CcPIg59qxdvMcrdaR2ltOzd8R0W5nIX
         gRX2egAHZSCQl5/8efTWmOvYP6a977Dh8eeIrMWymxQl3eKdVZamMwqwaZrHCevlVyZr
         i6gQ==
X-Gm-Message-State: AGi0Pubt/dCn4zQ7sWTthQyFNG/U9Tz27lu53eUJl2gET7JoJDkQzxrR
        adz43Ug/LhpA2Jlr9AtAYnKHWv/ThyTdBCVVg6mk4Q==
X-Google-Smtp-Source: APiQypKO1KUFCBfb3oR8QeV6GdNn+LL1TlznBqs1HPMQVZ+C86o3a66gINbmsxoBZH/I8gA95LPPPkmkWiOv+MWhxzc=
X-Received: by 2002:a17:90a:266c:: with SMTP id l99mr13602789pje.186.1586805830250;
 Mon, 13 Apr 2020 12:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com> <20200410123301.GX25745@shell.armlinux.org.uk>
In-Reply-To: <20200410123301.GX25745@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 12:23:38 -0700
Message-ID: <CAKwvOd=-u3grX3O4CtBayJYhv=mmsxMrRTF=AMcKMbphN5Xkgg@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jian Cai <caij2003@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 5:33 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> For older CPUs, it doesn't matter what the latest ARM ARM says, the
> appropriate version of the ARM ARM is the one relevant for the CPU
> architecture.  This is a mistake frequently made, and it's been pointed
> out by Arm Ltd in the past (before ARMv6 even came on the scene) that
> keeping older revisions is necessary if you want to be interested in
> the older architectures.

As if it never existed *waves hands*.  Interesting.  Does ARM still
distribute these older reference manuals? Do you keep copies of the
older revisions?

>
> However, there's an additional complication here: DEC's license from
> Arm Ltd back in the days of StrongARM allowed them to make changes to
> the architecture - that was passed over to Intel when they bought that
> part of DEC.  Consequently, these "non-Arm vendor" cores contain
> extensions that are not part of the ARM ARM.  iWMMXT is one such
> example, which first appeared in the Intel PXA270 SoC (an ARMv5
> derived CPU).
>
> In fact, several of the features found in later versions of the ARM
> architecture came from DEC and Intel enhancements.
>
> If your compiler/assembler only implements what is in the latest ARM
> ARM, then it is not going to be suitable for these older CPUs and
> alternate vendor "ARM compatible" CPUs.

This is a neat piece of history, thanks for sharing.
-- 
Thanks,
~Nick Desaulniers
