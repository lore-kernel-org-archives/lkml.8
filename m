Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB5C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076A12080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgGWN4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:56:16 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33963 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgGWN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:56:16 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MLhsE-1kGH533iF6-00HiXo for <linux-kernel@vger.kernel.org>; Thu, 23 Jul
 2020 15:56:14 +0200
Received: by mail-qk1-f169.google.com with SMTP id l23so5404326qkk.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:56:13 -0700 (PDT)
X-Gm-Message-State: AOAM533uzl1stOURGdWgrZ0h744lNTx5ZJdTFr+OPMn0IY4asqFSHvCG
        boj9eamTMAe2VtGFv1HF6aKmdeNuDGrZWmRsVpE=
X-Google-Smtp-Source: ABdhPJzZGTNJvW/D+pt2/+h0e7++KgU9TyH0Q1pJ2dvoN4jbBRN2PYLlVnONsRE9Ec1i1kB+bqO/UQt0wXPMaOi1ZCg=
X-Received: by 2002:a37:9004:: with SMTP id s4mr5176965qkd.286.1595512572758;
 Thu, 23 Jul 2020 06:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
 <20200720204925.3654302-12-ndesaulniers@google.com> <87365izj7i.fsf@nanos.tec.linutronix.de>
 <87zh7qy4i4.fsf@nanos.tec.linutronix.de> <CA+icZUVz0opOb0LihLvPvKM-t0Y=pcUWDyb+u-L_UVnnbPh1rQ@mail.gmail.com>
 <CAK8P3a3Ms1uvLcbhmbsU+-u11BCrXPaU5Dro=P9LjAG7CYm8ww@mail.gmail.com> <CA+icZUXzjcQ7ekTg8LvwcaBZFn_HeDjif+rKaFAKy=0gUrx=Xg@mail.gmail.com>
In-Reply-To: <CA+icZUXzjcQ7ekTg8LvwcaBZFn_HeDjif+rKaFAKy=0gUrx=Xg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jul 2020 15:55:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0gFG8z_qdY2gPm5p7kjpj8xq-APyazk390FpHUJiZ7Hw@mail.gmail.com>
Message-ID: <CAK8P3a0gFG8z_qdY2gPm5p7kjpj8xq-APyazk390FpHUJiZ7Hw@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] x86: support i386 with Clang
To:     Sedat Dilek <sedat.dilek@gmail.com>
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
X-Provags-ID: V03:K1:VHGxVsp49KImS4oIXoeddkMq1omTd8LisxdOxonGpXQwixTHgjB
 2DwqG0rHFy/FfXjIaG8rN6TzROgOHYzWD67fIjXNamE+UMrlNa16jk8dbF5+cbUgM38QWy0
 gRLMW6/PkBvXNyLqSNoHixU4aJ6d8DOHybYQjFF+3YM8nBPNADu6khV6fitQcB34uobX9Ma
 71pqg2Ml6aRdckGaAXnKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S/nrZhp5nrc=:JAI//IXL+69i5Z1SRHlN6e
 H7vI+ZBlkdYUHaJLXHPj9inLs9wMp/i3NdHxiJH5FHwFUioW/vPa4PWJdfvZYGofRkVKqsGPx
 T86s32aXaUnrrNxP2HPIbc8Cagp9+dx5YBGJrrQcJmT6vn+DtIHRmMEpXqgrX3/gDi2j5Zhq5
 n6ySIzi0vIyoDrWsvYUrQ64XZN0feWJ7tayeyAPDFZeyGSGRQ5ZDiejS/EmsNsRTF8imjKs8d
 pFQHv4lYXTMNlPDULTq6HAfTUAMWMc6/oYM7P/TT5QLUZ7AwHLiKZsyH6nBgseihrf+r0QPHT
 RYE1/gTsNhxmxRppNXejixh0KjDY1Gd7dQdilJ9tJokGpCvEDHYN1QUY7x3EM7jQNL88FXoMf
 LnUcJ3lktC4iMC6hPek8M78HJXagWH60jqFRCXUDEpffXXnrh+uHCZYOT2twLVWwhkpyueBMd
 ZqN+4I2Tjzi4wRVYOWLUP62gefusnOUoVKqDq3IZbtbts356PAn3swZ+MaaBbbkMeFWVbitFA
 jb2DJ1XZv9veWYXXVoSDAkRYgjt4FSZ4QdUjwmQNiKJoAUySzEDEVlTx6+fQis8EWmmW4nEuF
 fWybknsn2Cwm0/yjXNa5tXIV1GEgC7mg7MzpetSoe1fGjEj6z752VWVQ+xUr8VSvlXR68y1bA
 XomVUspZjQqli8b70atNe6LZ/Y/kZ3x4Yeofqd9MBRs58cQwkIyPqJv3A1j41jODQXOCZiWz8
 wP053n1llPoGSkppB/bnUakG0IvBg9VCfl44my0mwgebFXUl/jwPF7eYXCY5afxFa4B3BDmxM
 5e13or0WLQL+xJt9SDwei349gWUsBxtgnB9KjhcTIEMtZRftmNt6nTaE2mx/UZfcdI28dPcDL
 XSLENht8AzOWQC0KpRg9gjnjkRWSPyZ9FCfyQMVJq3E9dwwPfMrYZXe9Xe5Zh4UXNInLRV7jG
 HDBCBKTJ40yhvFY91ZyjwdDMzDybERP4cS9BTDlL++2px29rvN+/F
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 3:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> What happens when there is no CONFIG_64BIT line?
> There exist explicit checks for (and "inverse") of CONFIG_64BIT like
> "ifdef" and "ifndef" or any "defined(...)" and its opposite?
> I remember I have seen checks for it in x86 tree.

As long as you consistently pass ARCH=i386 when running 'make',
nothing bad happens, as ARCH=i386 just hides that option.

If you run "make ARCH=i386 defconfig" followed by "make olddefconfig"
(without ARCH=i386) on a non-i386 machine, the absence of that
CONFIG_64BIT line will lead to the kernel going back to a 64-bit
configuration.

    Arnd
