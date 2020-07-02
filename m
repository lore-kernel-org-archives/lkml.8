Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1177C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F862088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGBKJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:09:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgGBKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:09:00 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MW9zm-1jKVqS3CQM-00XYGX; Thu, 02 Jul 2020 12:08:58 +0200
Received: by mail-qk1-f180.google.com with SMTP id 80so25055449qko.7;
        Thu, 02 Jul 2020 03:08:58 -0700 (PDT)
X-Gm-Message-State: AOAM531PkRDYUMsbMGZyVS7rRI1yUby9/+mxlfVN/Tpre4DVwxWWZpaK
        BJ2BXm+ESDFTHm29CjFdKBGv57qrQhJ1UAd3e1I=
X-Google-Smtp-Source: ABdhPJx5SOJMuDfQwJVKZB5+m6bRsdErAkrfs1PX1uiM9LM3hcJxJy3YrlJL+419fren+MgMc2n134OOOUrPQ10mHDg=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr22857877qko.138.1593684537553;
 Thu, 02 Jul 2020 03:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-5-will@kernel.org>
 <20200702093239.GA15391@C02TD0UTHF1T.local> <20200702094833.GA16248@willie-the-truck>
In-Reply-To: <20200702094833.GA16248@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jul 2020 12:08:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07G1dLC+RUBDkzDbCRCP_gwZAaVK+k1UxvXT+7Kj=o+g@mail.gmail.com>
Message-ID: <CAK8P3a07G1dLC+RUBDkzDbCRCP_gwZAaVK+k1UxvXT+7Kj=o+g@mail.gmail.com>
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
X-Provags-ID: V03:K1:mak3dDZGE897vFH26+b5q7gq+C9l0V+pMqglMWHu/Q3+hoWWsQL
 xPZsW2vJLjdnX0ffEaN+PZA5LvLOVs3+tb35xMqpgv7Uu57I/nY/ocnByKIJ0KVUghpM9sn
 iqdQHunTum1PIsvRdRJtHU5arZEvkrIIet19DkYGTwksXPgcyoa4jr67S9xe6Ak0a1e66vS
 Trp6IMhJR7WwpddXYowLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7+KeRQCHiCM=:yeMFSuZ4NMCzmVlkyLf4eP
 V1i9z4kDSFbhrvkjg3nEvwolq9WxGBAMZBOmhWxv2zS/uhU1r+w7YsTvSbx8R9A93vzHmPiWp
 PD1DyGCHL3oQZ6gpaTgLMRJ2bi2e6LQqi5ryq+mTA1jOY0+Br6P5MdIeYdJfm8dQg1H65MTXQ
 ehwy5QEtN/FWWd/ILZfki1w7i8APiy8x7zZSi7x2bFqKy/C+2aN0ALldLuntBKWAGWZef3UcX
 Y3W4EKHp5lUurDgRi6HtR6MsnfMykmovV+PHa0t1WBot0SEhFgVjdCG/RpIpChW+nQYf2QJZf
 g4tVY5uG0AvU3dOicuCBZlDlN++6Ct49N81rFX+nojmEbUTf6Jz00j/qs4T90b7hGPavxve9P
 WpmURyeuMqZW4o0sa2r+ImUQG7Vh/z2ivJneyKUgShBIPO5sbGnUtWUjR4b0zq6+r51TezSw3
 qTQT0Cn30sPcQcLjISuoY6Vl4do7qNoI8nEShFwj3liWRJuETYrWQpzVuIJTshsN1jviKFkZ9
 uo3jl0yZKMsr9YknI2LAnlA0SPgGRUiGamDMtePsFy3KPtdXN9oNnap9IR7x2ixmhgzcz+ibj
 BBmPfO5vAhh0yFqCcxOBKfMsubG1FWUrXod1cHEnmnwwT0gM3IzaXFmB96uP0J7LYl7FRMha0
 XIqyUqhfmpcDL3ijIGWqBzuHZNnKiotti3pG0Bh1jzNhnBvq5bHdS6TfPYR0D7/Vk2W0h6Sug
 Ya4RpMI4FiakX2NWROb+I8Po4vnwhEfsOOvsRA90DSlMDH5i1l7EiiOf0sderst9S7EDwzqrb
 KHeGoOVEiNQa5gBB3+WeFZm4nQWoWnf3qiXrbUKgxrW/3Oad7I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 11:48 AM Will Deacon <will@kernel.org> wrote:
> On Thu, Jul 02, 2020 at 10:32:39AM +0100, Mark Rutland wrote:
> > On Tue, Jun 30, 2020 at 06:37:20PM +0100, Will Deacon wrote:
> > > -#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
> > > +#define __smp_load_acquire(p)                                              \
> > > +({                                                                 \
> > > +   __unqual_scalar_typeof(*p) ___p1 =                              \
> > > +           (*(volatile typeof(___p1) *)(p));                       \
> > > +   compiletime_assert_atomic_type(*p);                             \
> > > +   ___p1;                                                          \
> > > +})
> >
> > Sorry if I'm being thick, but doesn't this need a barrier after the
> > volatile access to provide the acquire semantic?
> >
> > IIUC prior to this commit alpha would have used the asm-generic
> > __smp_load_acquire, i.e.
> >
> > | #ifndef __smp_load_acquire
> > | #define __smp_load_acquire(p)                                           \
> > | ({                                                                      \
> > |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
> > |         compiletime_assert_atomic_type(*p);                             \
> > |         __smp_mb();                                                     \
> > |         (typeof(*p))___p1;                                              \
> > | })
> > | #endif

I also have a question that I didn't dare ask when the same
code came up before (I guess it's also what's in the kernel today):

With the cast to 'typeof(*p)' at the end, doesn't that mean we
lose the effect of __unqual_scalar_typeof() again, so any "volatile"
pointer passed into __READ_ONCE_SCALAR() or
__smp_load_acquire() still leads to a volatile load of the original
variable, plus another volatile access to ___p1 after
spilling it to the stack as a non-volatile variable?

I hope I'm missing something obvious here.

        Arnd
