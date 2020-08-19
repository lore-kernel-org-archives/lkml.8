Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD1FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658B8206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Np666du6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHSMT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgHSMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:19:18 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AA3C061342
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:19:18 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id l14so9315270wrp.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc
         :content-transfer-encoding;
        bh=FMJtX5sE/ijHGQQo6or6WwI3AI9STC6T6y3elNBDyxc=;
        b=Np666du64zIhPkn7EXB9gnv2v97Mppfik8nrGpDKJs0LAnPQslKRdttJpfNBAhdYL1
         vbStB2psYT9wXiZXZepWE36Y9bT5aHgjWtK4MUYil9prJTaYTHJ6OqbrliGWQ5oZ+Ks6
         Bli8xLd5MBrKCQL/tiuqE9RaEKlvM9Z+MzkDUhDJwW8OFTX1cDkJ0EY189plnYbI5jzA
         fY05yT4YXYvd1qFkJD4PFHpsy6V4F3zXkFt+udf//0kROgRTdVcH0ngJO3PltdCjBy8X
         DyeRqSbYuw3qb1Ife0RGlGHuXxh5sSrceCnGD5/0yMSTtFei5ndOXm8EWNUWFtc9bdyc
         WW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc:content-transfer-encoding;
        bh=FMJtX5sE/ijHGQQo6or6WwI3AI9STC6T6y3elNBDyxc=;
        b=g5r8ORf3eg00UxJ184/ZS9X5Z7kiuz4c6Nf37OzISkWgMyR1+b7GA7RxBxl5GBQiBP
         2QvWqIXtlAVtb14xMIqEiKkFj0KGK7NQCqHcoytummOrlWlqreXFrq848V8icQZ831BS
         6Fo3VcjLqXRoiKmUlj5umh/Jk4WkLB3Ym7wlrEOVocc4eL5T6nSvSlD8qvN/x+RLGRzo
         A+pULtzNN7kId6INdAvaA2zPU9xacjm66Ercu5F0/86Jr1vIFeYjoBmiGkBuil6OcP/3
         D5bcoMnEm5x+TAfzozG3wZcfYFx4bL9W513Ed9OpVglOyrTgtgLkxfEG4sgBKm3gTuhC
         JqDg==
X-Gm-Message-State: AOAM532e/1eTlM5U+7ZmymetVPqzp5WRVYpS50rWnHWcBjhnmXSmsi6D
        TBjaT2He/RPOXxo7Bj4YrrhvIrJA6Aqi
X-Google-Smtp-Source: ABdhPJxHgJd9QRuk6MhBzMzz27/J81xqSRcU//003VyQCqmSVuYjQcdOow7AlT4rjFquBw5LTG+BFRThYB1Q
X-Received: by 2002:adf:cf10:: with SMTP id o16mr22954517wrj.380.1597839555928;
 Wed, 19 Aug 2020 05:19:15 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:19:13 +0200
In-Reply-To: <CAKwvOdkJxmSXg+v1pG4+DkhoJzEE47smce6pB=Zhy6viY_++xw@mail.gmail.com>
Message-Id: <20200819121913.3374601-1-courbet@google.com>
Mime-Version: 1.0
References: <CAKwvOdkJxmSXg+v1pG4+DkhoJzEE47smce6pB=Zhy6viY_++xw@mail.gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
From:   Clement Courbet <courbet@google.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        "=?UTF-8?q?D=C3=A1vid=20Bolvansk=C3=BD?=" <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 9:58 PM Nick Desaulniers <ndesaulniers@google.com> =
wrote:
On Tue, Aug 18, 2020 at 12:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Aug 18, 2020 at 12:19 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And honestly, a compiler that uses 'bcmp' is just broken. WTH? It's
> > the year 2020, we don't use bcmp. It's that simple. Fix your damn
> > broken compiler and use memcmp. The argument that memcmp is more
> > expensive than bcmp is garbage legacy thinking from four decades ago.
> >
> > It's likely the other way around, where people have actually spent
> > time on memcmp, but not on bcmp.
> >
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Linus
>
> You'll have to ask Clement about that.=C2=A0 I'm not sure I ever saw the
> "faster bcmp than memcmp" implementation, but I was told "it exists"
> when I asked for a revert when all of our kernel builds went red.

If **is** possible to make bcmp much faster then memcmp. We have one
such implementation internally (it's scheduled to be released as part of
llvm-libc some time this year), but most libc implementations just alias to
memcmp.

Below is a graph showing the impact of releasing this compiler optimization
with our optimized bcmp on the google fleet (the cumulative memcmp+bcmp usa=
ge
of all programs running on google datacenters, including the kernel). Scale=
 and
dates have been redacted for obvious reasons, but note that the graph start=
s at
y=3D0, so you can compare the values relative to each other. Note how as me=
mcmp
is progressively being replaced by bcmp (more and more programs being
recompiled with the compiler patch), the cumulative usage of memory
comparison drops significantly.
=C2=A0
https://drive.google.com/file/d/1p8z1ilw2xaAJEnx_5eu-vflp3tEOv0qY/view?usp=
=3Dsharing

The reasons why bcmp can be faster are:
=C2=A0- typical libc implementations use the hardware to its full capacity,=
 e.g. for
bcmp we can use vector loads and compares, which can process up to 64 bytes
(avx512) in one instruction. It's harder to implement memcmp with these for
little-endian architectures as there is no vector bswap. Because the kernel
only uses GPRs I can see how that might not perfectly fit the kernel use ca=
se.
But the kernel really is a special case, the compiler is written for most
programs, not specifically for the kernel, and most programs should benefit=
 from
this optimization.
=C2=A0- bcmp() does not have to look at the bytes in order, e.g. it can loo=
k at the
first and last . This is useful when comparing buffers that have common
prefixes (as happens in mostly sorted containers, and we have data that sho=
ws
that this is a quite common instance).
=C2=A0

> Also, to Clement's credit, every patch I've ever seen from Clement is
> backed up by data; typically fleetwide profiles at Google.=C2=A0 "we spen=
d
> a lot of time in memcmp, particularly comparing the result against
> zero and no other value; hmm...how do we spend less time in
> memcmp...oh, well there's another library function with slightly
> different semantics we can call instead."=C2=A0 I don't think anyone woul=
d
> consider the optimization batshit crazy given the number of cycles
> saved across the fleet.=C2=A0 That an embedded project didn't provide an
> implementation, is a footnote that can be fixed in the embedded
> project, either by using -ffreestanding or -fno-builtin-bcmp, which is
> what this series proposes to do.
