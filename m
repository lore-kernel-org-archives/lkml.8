Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D9EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EF6206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmlhj+CD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGXNWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:22:16 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C4C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:22:15 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r13so106870ilt.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tFbmzkA+BL4QIkFszn1H7XqsMIWLAyiLJStY3Llb7xc=;
        b=Wmlhj+CDR1XscUT+kL48FtFi8+2SDiECk+XC19tJmlMhpQBJuBwIL6g1yy+hAPLCiW
         YjiTr6ll2TpnFMbjUoiSfctTzyYDeEk2amokIe2677ubZy7CAFxYtsBi2Cg7GbsCIsrM
         7KWZu/vMOftHv8LtSjtqssihogNDt8KooP6EzVWWlm7AliAGScXk20rlXP0x625f9ZWu
         TURXaD8+tOgFwoP30bjHtbQmB2HVzheHgprBFAM7gnTWDvWJDU2RJpOpvm5d+RXx50nq
         59yFZABkgFnXxPtFkq9YKOOzkbZs/V5Gc+UeaqqFIjyFC3M/n54ArYnSqN+NoRLBmrnz
         xtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tFbmzkA+BL4QIkFszn1H7XqsMIWLAyiLJStY3Llb7xc=;
        b=AzA8jZyhLm5u7a3UsZ2WU3GLlOAcg/BIDKwtNrfYwGrOuXXECdjrF2h9tmYo3COfiN
         v45Q3J5HjMtggQDKj8oQiQgWI2NINBZcT5VLpwmKHvpUXcoyfHTWpiYoFTqdrowQxEXN
         m5oBAcWi2JSn+feIQan/ZfNUUH8I2M3CZ7afUrdVN4rPGK88StI9fhzWGx0IKl9Ph1Zq
         zQncvswFKgIAh055BOi7BzBNA5bUd4+hS0+vZIOeFsinCNpu0l+039ulzi1asrSOrEqR
         bxbYbv8ubfUDDeACAXvtbKPPGQKHvKIp+8ZJexLDSPZnW79cTv0x5pTKWBI0kuaMkVgo
         xUEA==
X-Gm-Message-State: AOAM530i+YN6bc+RyCQYodq4G+iymrHFnwX0Fp5eFh0S1MPvvwR96nDQ
        O29tU0dATT6kwbq/IDCvSYe7alp4VMfEWFjnHFg=
X-Google-Smtp-Source: ABdhPJyP87MutTHgoKl+LBFySajFTl18Qn1uIRc+YznVfmbonJUmd06UpVQUKtRANbLPzeeGzU6e0QH0YxI0j4HNRuQ=
X-Received: by 2002:a92:8b11:: with SMTP id i17mr9875109ild.212.1595596934936;
 Fri, 24 Jul 2020 06:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
 <20200720204925.3654302-12-ndesaulniers@google.com> <87365izj7i.fsf@nanos.tec.linutronix.de>
 <87zh7qy4i4.fsf@nanos.tec.linutronix.de> <CA+icZUVz0opOb0LihLvPvKM-t0Y=pcUWDyb+u-L_UVnnbPh1rQ@mail.gmail.com>
 <CAK8P3a3Ms1uvLcbhmbsU+-u11BCrXPaU5Dro=P9LjAG7CYm8ww@mail.gmail.com>
 <CA+icZUXzjcQ7ekTg8LvwcaBZFn_HeDjif+rKaFAKy=0gUrx=Xg@mail.gmail.com> <CAK8P3a0gFG8z_qdY2gPm5p7kjpj8xq-APyazk390FpHUJiZ7Hw@mail.gmail.com>
In-Reply-To: <CAK8P3a0gFG8z_qdY2gPm5p7kjpj8xq-APyazk390FpHUJiZ7Hw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 24 Jul 2020 15:22:03 +0200
Message-ID: <CA+icZUVGnfO1w6CpHh5cbZ9-ozMo6LhoyKxCq9mBpVF1jCZi-Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] x86: support i386 with Clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 3:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 23, 2020 at 3:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > What happens when there is no CONFIG_64BIT line?
> > There exist explicit checks for (and "inverse") of CONFIG_64BIT like
> > "ifdef" and "ifndef" or any "defined(...)" and its opposite?
> > I remember I have seen checks for it in x86 tree.
>
> As long as you consistently pass ARCH=i386 when running 'make',
> nothing bad happens, as ARCH=i386 just hides that option.
>
> If you run "make ARCH=i386 defconfig" followed by "make olddefconfig"
> (without ARCH=i386) on a non-i386 machine, the absence of that
> CONFIG_64BIT line will lead to the kernel going back to a 64-bit
> configuration.
>

Again thank you for your feedback.

Unsure if people are aware of the different behaviours and results.

That's why I keep the same make line with and without "defconfig".

Unfortunately, I had no opportunity to test the patchset :-(.

For testing I had done:
$ MAKE_OPTS="..."
$ ARCH=x86 make V=1 -j3 $MAKE_OPTS i386_defconfig (whereas V=1 and -j3
can be dropped of course)
$ ARCH=x86 make V=1 -j3 $MAKE_OPTS

Side-note:
How wonderful my patch "x86/defconfigs: Remove CONFIG_CRYPTO_AES_586
from i386_defconfig" landed in <tip.git#x86/build>.

- Sedat -

[1] https://git.kernel.org/tip/tip/c/6526b12de07588253a52577f42ec99fc7ca26a1f
