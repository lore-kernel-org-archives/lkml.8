Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EBCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968B3207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgGBLja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:39:30 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgGBLj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:39:29 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MyJx6-1isHMh3GRg-00ykb7; Thu, 02 Jul 2020 13:39:27 +0200
Received: by mail-qk1-f176.google.com with SMTP id e13so25256271qkg.5;
        Thu, 02 Jul 2020 04:39:27 -0700 (PDT)
X-Gm-Message-State: AOAM532z0IHA9N1mAsG65XlCWqo+0pwbShicaHgYkplIDL+zOJ4B9Fdd
        Gx0V0WAJRgyl1kE6Xf/FAxj82S5DvTjR08HdYBs=
X-Google-Smtp-Source: ABdhPJxZnj5versBmr7lWdCxrevvSnrtGz16SQp4OMCvU87jKF+QYKva7czF6a7gzq//AqJiVHDYLYMn/4Cgp3bsm/o=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr30820571qke.352.1593689966522;
 Thu, 02 Jul 2020 04:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-5-will@kernel.org>
 <20200702093239.GA15391@C02TD0UTHF1T.local> <20200702094833.GA16248@willie-the-truck>
 <CAK8P3a07G1dLC+RUBDkzDbCRCP_gwZAaVK+k1UxvXT+7Kj=o+g@mail.gmail.com> <20200702111832.GC16418@willie-the-truck>
In-Reply-To: <20200702111832.GC16418@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jul 2020 13:39:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3VrEkDf8t1CCsY+g7rtXkqBsiPOr97b1yRbz8NpjdfFA@mail.gmail.com>
Message-ID: <CAK8P3a3VrEkDf8t1CCsY+g7rtXkqBsiPOr97b1yRbz8NpjdfFA@mail.gmail.com>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered implementation
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z8zyvq6vDbeYzAhJCb6eVc2WB9OLAma8FkNnVfzP5LIPHoG/zM3
 H+stHIIcLhAOQVdPGVb+yvmXZS6bZvAlPlPGAb7K3XN/Yf/9tiD+LfyrHyrF2jie4hgS9KZ
 irhd23yNkSatHVfb8y2fRt4J+qOAfrpIFB+YlKB8CPwZ0m5soww1dXiL+e4/fBrJvO0u51V
 FIQm29ysC2PM1GqgInKpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MVQPFMqFHCg=:Mc/Fzv3M0wGaJGNRmiZWUe
 KhM7kbvbSIBkOSpRLKpn2mQuHZQiboCZGmj68hm2SMimxXdnYI3wYcK7GopZhk+JR3aBa1wbc
 b1yaKMwUqylhcFZNngxpMvDzlTF1PvFIjy1TTaAhiTRUB9+xeBPFgbS05UWQRwSmi2JAp+DOb
 w9PpjmmcLdJhOqQzTTiFB20BJKu26jnzomBTvGHtCKhc9ykIackRn29iZzaFfpnZvSRmnkvtQ
 nRB1TJtCrCSzEq2cuZ3HgSGJM0VJ7lBsDmQcm5XEh8rI8t/0TOOtezYCP2qeHZMi2E7wldego
 58hv1Ra6Ath2DLPfjcT9qJbkmo/521T0VPquIdh/1enx7hnlCBxsv8gxG2QnI8BYnZ3fTUTbQ
 qR3eaMFvTbbNBLDZTj2gNWGUbSrcyEqWPBu76Rmq+UU/d+W1zne8vnaUNyNjsJuIZAAqqnG2b
 UU8wfrD4HFvkfBctfr/Fi7vwMMXIF3BMSoOp78QP8Qj4tJwVoeCI1Sd1EBvtrBR2wQPmOrS68
 eREemZPiU1odDD2L1M3yLfpnjayDnchDXD/nZlp6QVeA6t0OqPfXZm0BQaUv98iolzQP8HxjA
 9XW1RGsmMsY/mMjUh2fyz5dymegWy+bpNe76EEzhw7+laAeDZEGO3I15Mx6eE0MRiuUjwffdQ
 5It73uUIRMFuiNK89mNjqT2VH+pSxQ4tl28Zqogpjw/CBt72jxVvhtO+89/7RLoZEz1l6X7Gy
 hdJ0rZ5ohsb3nY2vodf3TGVAKZyMGgO9S+QpihT/Ypet1XCDCqkCdn6XMwIkInXyR4v4dvNJm
 Y3SqJsvXjFHzffKoa+nDO8VFyuSx0FcmDugZDFctFRy2lf2Cw4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 1:18 PM Will Deacon <will@kernel.org> wrote:
> On Thu, Jul 02, 2020 at 12:08:41PM +0200, Arnd Bergmann wrote:
> > On Thu, Jul 2, 2020 at 11:48 AM Will Deacon <will@kernel.org> wrote:
> > > On Thu, Jul 02, 2020 at 10:32:39AM +0100, Mark Rutland wrote:

> Not sure I follow you here, but I can confirm that what you're worried
> about doesn't happen for the usual case of a pointer-to-volatile scalar.
>
> For example, ignoring dependency ordering:
>
> unsigned long foo(volatile unsigned long *p)
> {
>         return smp_load_acquire(p) + 1;
> }
>
> Ends up looking like:
>
>         unsigned long ___p1 = *(const volatile unsigned long *)p;
>         smp_mb();
>         (volatile unsigned long)___p1;
>
> My understanding is that casting a non-pointer type to volatile doesn't
> do anything, so we're good.

Right, I mixed up the correct

        (typeof(*p))___p;

with the incorrect

       *typeof(p)&___p;

which would dereference a volatile pointer and cause the
problem.

The code is all fine then.

    Arnd
