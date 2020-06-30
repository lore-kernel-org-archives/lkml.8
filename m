Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C946C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17FC4206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgF3TLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:11:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52685 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgF3TLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:11:51 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MauFB-1jDymc2bnf-00cU4W; Tue, 30 Jun 2020 21:11:49 +0200
Received: by mail-qv1-f49.google.com with SMTP id e3so3479829qvo.10;
        Tue, 30 Jun 2020 12:11:49 -0700 (PDT)
X-Gm-Message-State: AOAM532tWlQGGtiLhBMJs2XEsARZS2BVbCoeRzEIL1e5ypc4cfTz7vDu
        t/w4RhvExJnp4KMu8Mt/1P7ZURTpacmGBOKR3Fk=
X-Google-Smtp-Source: ABdhPJy8Dn8rL1I0U5RYNNkDb6apYhSxF/cek48EVCvK4tcGtsr9BI41NIYfCMTIzNjQg3sijIRh8LwqEplBMOYW8s8=
X-Received: by 2002:a05:6214:846:: with SMTP id dg6mr20327019qvb.210.1593544308407;
 Tue, 30 Jun 2020 12:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-3-will@kernel.org>
In-Reply-To: <20200630173734.14057-3-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jun 2020 21:11:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a136e2k-iGoJ4X51mnj0f0KSLJKOw6b=s4F2QHHeyAMEQ@mail.gmail.com>
Message-ID: <CAK8P3a136e2k-iGoJ4X51mnj0f0KSLJKOw6b=s4F2QHHeyAMEQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] compiler.h: Split {READ,WRITE}_ONCE definitions out
 into rwonce.h
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LnFDDIjRuXDckRiBaZGfmiG7HaTrrU39Wjww08d3sBPpTh0bBiC
 R18dhZQINNcBZ60ocsHkZQTFVn5tMd7QDCWiaBczDXRBCaIJYO2+OSoII+r0REMFq66/K1L
 JrRxCeJARV3JI27LVClu+VT9mpBekIzD1BccLbfV033oyigdtOGqzvrUfNDxQzH6vHslkIw
 lzDlRev00L4nSdR0SKE1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C8esC7patGM=:rsYR3CSmcrTZb51jltms7E
 po6GEFUweLiWLa6MnwKz6jP1OvSdinAWuRgL4RxGqEjTcIUqnIZtM9zZ8N5rlkYImj2FVoD1u
 DmCgeGWYe8RYHp8F2FOvsw44SD4KEEU2CuYPn1z7ob4JIC0iN5g3NPGAmdS6pbfgq9rPTCmfr
 G/ddu0SYVF1xX7fhdgkpxA1H8GpGJabJYFMXu/2NDCUk3LSaAjkkVuh5/L1kUgQmv8LiQoHqq
 2LfkIooHR3zbPRDj6VvPw5z748NrIo8ZIsnYlKql+I8FTl6FYhemIZ8sDbwz5LqWbRod/u3F5
 1IBJyjRgeC/7ISLQSSJZRX/yARVVmpMNPMyoPGUohK7Pnb3bFP6md/u7B/nXn2qyhht1NxC1w
 vE0vWzuFbRK9JzEAEIszGHDOX+QEMG8xDtPDAqyFpdSySWcgrJ9+NTCZoluVO7sO3ZibJTAwv
 /ymcT4QaME2TufvzqfhIDfSPjbniAZXLl6vvaOr0scExlP216N/eIU1bsZ7oxLppWcnZjzQ1d
 tD8BklSxYbvCyMjPl6WjHjA9cBNlYTVR6qyjQjVT4dQ1/0SFDLYXKzDglb9WPTw4vzRx9Iw97
 fZlVMA6tVeZm2ruZWTWpDlDUzrbWk4kKVtI/Lub0lUpE9T/3vfGKWlpRxPRIXZrY+HDJADtr9
 Tbb27S5WPrZJwTUTzEMLtrUz9gilecIsnLmYJI/L4SudOR1NnU2/AsdX0bB5spWf8HZ0SJCZc
 JlYtUxUKOk19jiVdO7wf+DXqGJ6VPrhajSLSZn4Vcvhfx+cDR8dlfCBU02D91pglFtBgNIkPX
 T3c54PQc87+m0oiZtyuWd4k7cPYZQrgc2yd7vllilybPnTROJ4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 7:37 PM Will Deacon <will@kernel.org> wrote:
>
> In preparation for allowing architectures to define their own
> implementation of the READ_ONCE() macro, move the generic
> {READ,WRITE}_ONCE() definitions out of the unwieldy 'linux/compiler.h'
> file and into a new 'rwonce.h' header under 'asm-generic'.
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/asm-generic/Kbuild   |  1 +
>  include/asm-generic/rwonce.h | 91 ++++++++++++++++++++++++++++++++++++
>  include/linux/compiler.h     | 83 +-------------------------------

Very nice, this has the added benefit of allowing us to stop including
asm/barrier.h once linux/compiler.h gets changed to not include
asm/rwonce.h.

The asm/barrier.h header has a circular dependency, pulling in
linux/compiler.h itself.

       Arnd
