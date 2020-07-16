Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98120C43457
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC2B2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgGPNGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:06:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgGPNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:06:21 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MwQGj-1koIlq14Rp-00sR1K for <linux-kernel@vger.kernel.org>; Thu, 16 Jul
 2020 15:06:19 +0200
Received: by mail-qv1-f42.google.com with SMTP id p7so2639156qvl.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:06:19 -0700 (PDT)
X-Gm-Message-State: AOAM533u8poQ9nQGDrVokh3JhVyiwbZStt251J/Ycrd8vQuLYkV9d78Y
        EUrVoreBJDSH3b3LFueyKj7+ffQLpFucCQECrgM=
X-Google-Smtp-Source: ABdhPJxNeCsNSf0Q6nH5Bu1+2ccIGi3fJ3q5Aaw5a35m7D7la4pI0jBb24AUhcQ+TrmiFxWfKsLX5fT0btz4Ib/UIvg=
X-Received: by 2002:ad4:4c09:: with SMTP id bz9mr3944948qvb.210.1594904778075;
 Thu, 16 Jul 2020 06:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost> <20200712193944.GA81641@localhost>
In-Reply-To: <20200712193944.GA81641@localhost>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Jul 2020 15:06:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a20UQvQO0U=p1kBEUvRdwm8VFBa31aCe7C70hwTzcu_yw@mail.gmail.com>
Message-ID: <CAK8P3a20UQvQO0U=p1kBEUvRdwm8VFBa31aCe7C70hwTzcu_yw@mail.gmail.com>
Subject: Re: Linux kernel in-tree Rust support
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Adrian Bunk <bunk@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AEcPFNHArkNcZZ0+ETR/vEnUCCOZxPeq7Rlim5BeET1reyAB6aV
 kn0pu/q2ZptSBdJ7iU/G1Bk5LWLe14MkG5V9s08nSThzyBiDAssBvXcU4zQN5aHLlzoJsRF
 NGPtP5/z2VeyWdmYMnnxywY6HbDJIAybpjlKeGsb+baTeYCaGWyKTWpFjUFnXBwVO39j4a0
 P9zjM8XBJVI1jlpC4EZdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ArF/SCQ3AgM=:m4+RoHOJemSVIw7aAMkQeG
 vB13xxXqcH7urL0nkWEh/60qYAVYLqK1zUVl20mNfjiMid4YlCFbFSKFGa7xLU4ASIpiZR72g
 JNP8AoD6231oGB8zLkgcETzv803mNP36Rwgh7nQGtvO0jq3wSOv3xVZQ2LmeryEDzf0le/V0y
 rpl0BAwyvc0vB6OT+pMo0FPYL2wgR7qZqZ4p81ju7QEju189a1OayhTs2MUhVlt71OqPf1TSy
 LB8Q5h/l79bYPOtwXkouNCigb8MswLAtAIiiO/3hnDzbttdYsTisIt3Mz5pl2CAwMGKPgiI0m
 Qb2myXNO8E+csgO0NGePJQ6kfvGd5G/ko9P7MUGRN9xSybGTVcsSXLxKVXq1hMlyLDSQDK3HB
 +OY1CSQh879JQOD/+hTuDlUSn5FAJ7Xnyd/Vbg2HwnFeea3cOSkp929x88TwHoyrCXBakxb98
 /aY1cxBiQvCjbd9ZEL7vQSSFD44WTuFa6qH/Mb1jIWmjT5Hftd0rtPY4By9gDXA46vuYrJq5f
 nFLxkGxMbgJPpPhlDFDlW0Tu66VVeLTo+wK4ivsozwdw+PnNLiQ84dXIcmdmxcJv02UQ33nWj
 5A6BY8TJ3CEyNm4xRohobM2X7im/20vVI+d85i6J3Hk7VcJjNeTFvZ8zjE6OIIpoc7mWCpVt+
 cs3muzdFHBKGkNeR1d01/Utm6UBgMzhjYnMpKjyeAqKnbiiVSohXQhkf+uosCwC1hxwdmIKrW
 Vkyy0uFjcoz4tePUy8LD72c3jhbm8WeX7Znk6a31yTWkx9U0g2t8a1XC+fkj+Blc3/ARsPY/V
 qm+6w601s44fAAs4a360SlsIr5+A3lGRdVLVtEJByKFGr0n90uQTcSNwSHOXSrswzNTFXqt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 9:39 PM Josh Triplett <josh@joshtriplett.org> wrote:
> On Sun, Jul 12, 2020 at 03:31:51PM +0300, Adrian Bunk wrote:
> >
> > As an example:
> > Ubuntu LTS releases upgrade to a new Rust version every 1-2 months.
> > Ubuntu 16.04 started with Rust 1.7.0 and is now at Rust 1.41.0.
> >
> > It would not sound good to me if security updates of distribution
> > kernels might additionally end up using a different version of the
> > Rust compiler - the toolchain for the kernel should be stable.
> >
> > Would Rust usage in the kernel require distributions to ship
> > a "Rust for Firefox" and a "Rust for the kernel"?
>
> Rust has hard stability guarantees when upgrading from one stable
> version to the next. If code compiles with a given stable version of
> Rust, it'll compile with a newer stable version of Rust. Given that, a
> stable distribution will just need a single sufficiently up-to-date Rust
> that meets the minimum version requirements of both Firefox and Linux.
>
> (That would not apply if the kernel used nightly Rust, since
> nightly-only features are allowed to change before becoming stable;
> that's one reason why we should use stable Rust, and try to get Firefox
> to stick to stable Rust.)

I would expect we'd want a fairly tight coupling between kernel
releases and minimum rust releases at first. Whatever is the latest
stable rust version during the kernel's merge window might be
assumed to be the minimum version for the life of that kernel, but
an LTS release would not suddenly start relying on features
from a newer compiler (thought it might warn about known bugs).

This might mean that linux-next requires a beta version of rust, if
the release is expected before the merge window and it contains
an important change. Staying with fairly recent versions of clang
certainly helped in getting clang and the kernel to co-evolve and
get to the point we are now in using it as an alternative to gcc.

While Linux used to build with 12 year old compilers (4.1 until
2018), we now require a 6 year old gcc (4.9) or 1 year old
clang/llvm. I don't know whether these will fully converge over
time but it seems sensible that the minimum rust frontend version
we require for a new kernel release would eventually also fall
in that range, requiring a compiler that is no more than a few
years old, but not requiring the latest stable release.

      Arnd
