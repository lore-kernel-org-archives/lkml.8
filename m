Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22030C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047A120756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgETUwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:52:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgETUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:52:41 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MTREY-1jTuUF1FHQ-00Tlhw for <linux-kernel@vger.kernel.org>; Wed, 20 May
 2020 22:52:39 +0200
Received: by mail-qk1-f175.google.com with SMTP id f83so5017878qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:52:39 -0700 (PDT)
X-Gm-Message-State: AOAM531zZ8HmZ83F3zCGPOaRfnHBls5JMaTttEJWSImudsl78bWGt50a
        2xl9vC+uzQOblA85QCxA+LofBk28udQ4syCmx0k=
X-Google-Smtp-Source: ABdhPJwbCjpvdQ69jpw/vCRNJG1pz94dQq04t1slk369ddybTSxpRyrBSWLEnc3+a/1PYLuOZHitGEyzoYkmb2QoEpI=
X-Received: by 2002:a37:bc7:: with SMTP id 190mr6681765qkl.286.1590007958081;
 Wed, 20 May 2020 13:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
 <0c2abcd1-7da8-2559-1e93-4c3bdd38dec1@linaro.org> <CAK8P3a3fxs+14ZdCRmt_GwJGv3Aipm1r9sAHH6aVj2UrWBNuQQ@mail.gmail.com>
 <20200520154128.GA24483@arm.com> <20200520160810.GM1079@brightrain.aerifal.cx>
 <20200520170932.GO1079@brightrain.aerifal.cx>
In-Reply-To: <20200520170932.GO1079@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 May 2020 22:52:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2+_a+Qj8uvSToLKwf_pj14EouAFzEO6Un5uc8fT9Vr-w@mail.gmail.com>
Message-ID: <CAK8P3a2+_a+Qj8uvSToLKwf_pj14EouAFzEO6Un5uc8fT9Vr-w@mail.gmail.com>
Subject: Re: clock_gettime64 vdso bug on 32-bit arm, rpi-4
To:     Rich Felker <dalias@libc.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Jack Schmidt <jack.schmidt@uky.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, nd <nd@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5UGgv9NWEnc6ImpRaSBMXnVcIq18Y7ckb72GuQHkW/IycHgvBz1
 uxyjf/hAhRyIIMpPn4WUN+rnMn1ajianxdqkO/gs+JK7q6Vsxap5k1CLxgGe1Jz09u1KfgL
 KJWYchAJuJnoQVCBtB9ZidSAm1L+JgdAQHg6k6/lV16GjfVWJ3CPwTMjw/cpZ1GIbDu/X7T
 SiflyUM5L3CJpqB5pCkng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s8zDq3F/oHE=:LzFUjbGDp9pOgMAo0TFURo
 moA/HBS8fjgz2jmYsC5o2tPT0NoSxx+oFhKT4eiKgGiLdURR2KQKTPF5cZr7W2+0CLrIBn4ML
 TiYm1Y5+tIU+W9RDmFfOKu21AuwUJkI5iEk3OxpzDnJsEwRcTkk7uyqHOCu00xjAZyw+L3MZD
 6NBOB10tUXK/cw7SiyhLYeDeFbJITN8PRfUX8WycPqUjHOHaBzq0s9q5qbEVKKyNbkIPWFTi+
 pJ0nREmUHDuJFhtay7MZ6X2p9J2BsF9k0RjhwTbebMm1egYfu1/vKF4WpvL8ov9/8vQoDYL4i
 YPqm7htc0HHXMvnW0EkarEZWc27C9Akjv9yjJwQ9U2N0DG0mAg4332tOjLdXMMOHuzzfhfZVI
 LSsZ+zsY60puHuAUc743/IprrhjeSJUBWQhN+MD2mL482BY79qIq1LgX+hQSayrzW8MlRMSsy
 O5TkK2lqw/72lLqyY8/mdcrPJLoEFujWqus8O5lfba/jmdnEvA/4u2qLEcX+OqoNECFVexNKZ
 uyR7QMuc3wX9rj8vLe5Kxu2p7qUojKMtqVpAh6AaAxiwytFQMokx9BtWdEF4+Nmv5UUYP174O
 a0iPQCtaXJW6aoAKSu4A/M4S9es+94WL8MpS2gUwm1sk8zYKyoUtuUuVpBsixg5kDw3AeKrpO
 nAvGzNCoBtvpX3Djnm/3EdByeqhEm0tNOhpI19Z13P8ZFUvt9aMZMn/ZdbTdcF6OqAJEIunhs
 nypCLmruYIENrkDrxbjjo1Nnj1jQfreNNoK3AtFwHKi5ur3YKh0dY9Nl0KfO39dsOInCrF1ax
 8yuEZNj61XzStaDsUCxgtVr9KYNPsmpgncqWNUW78YDKppssDY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 7:09 PM Rich Felker <dalias@libc.org> wrote:
>
> On Wed, May 20, 2020 at 12:08:10PM -0400, Rich Felker wrote:
> > On Wed, May 20, 2020 at 04:41:29PM +0100, Szabolcs Nagy wrote:
> > > The 05/19/2020 22:31, Arnd Bergmann wrote:
> > > > On Tue, May 19, 2020 at 10:24 PM Adhemerval Zanella
> > > > <adhemerval.zanella@linaro.org> wrote:
> > > > > On 19/05/2020 16:54, Arnd Bergmann wrote:
> > > note: i could not reproduce it in qemu-system with these configs:
> > >
> > > qemu-system-aarch64 + arm64 kernel + compat vdso
> > > qemu-system-aarch64 + kvm accel (on cortex-a72) + 32bit arm kernel
> > > qemu-system-arm + cpu max + 32bit arm kernel
> > >
> > > so i think it's something specific to that user's setup
> > > (maybe rpi hw bug or gcc miscompiled the vdso or something
> > > with that particular linux, i built my own linux 5.6 because
> > > i did not know the exact kernel version where the bug was seen)
> > >
> > > i don't have access to rpi (or other cortex-a53 where i
> > > can install my own kernel) so this is as far as i got.
> >
> > If we have a binary of the kernel that's known to be failing on the
> > hardware, it would be useful to dump its vdso and examine the
> > disassembly to see if it was miscompiled.
>
> OK, OP posted it and I think we've solved this. See
> https://github.com/richfelker/musl-cross-make/issues/96#issuecomment-631604410

Thanks a lot everyone for figuring this out.

> And my analysis:
>
> <@dalias> see what i just found on the tracker
> <@dalias> patch_vdso/vdso_nullpatch_one in arch/arm/kernel/vdso.c patches out the time32 functions in this case
> <@dalias> but not the time64 one
> <@dalias> this looks like a real kernel bug that's not hw-specific except breaking on all hardware where the patching-out is needed
> <@dalias> we could possibly work around it by refusing to use the time64 vdso unless the time32 one is also present
> <@dalias> yep
> <@dalias> so i think we've solved this. the kernel thought it wasnt using vdso anymore because it patched it out
> <@dalias> but it forgot to patch out the time64 one
> <@dalias> so it stopped updating the data needed for vdso to work

As you mentioned in the issue tracker, the patching was meant as
an optimization and missing it for clock_gettime64 was a mistake but
should by itself not have caused incorrect data to be returned.

I would assume that there is another bug that leads to clock_gettime64
not entering the syscall fallback path as it should but instead returning
bogus data.

Here are some more things I found:

- From reading the linux-5.6 code that was tested, I see that a condition
  that leads to patching out the clock_gettime() vdso should also lead to
  clock_gettime64() falling back to the the syscall after
  __arch_get_hw_counter() returns an error, but for some reason that
  does not happen. Presumably the presence of the patching meant that
  this code path was never much exercised.
  A missing 45939ce292b4 ("ARM: 8957/1: VDSO: Match ARMv8 timer in
  cntvct_functional()") would explain the problem, if it happened on
  linux-5.6-rc7 or earlier. The fix was merged in the final v5.6 though.

- The patching may actually be counterproductive because it means that
   clock_gettime(CLOCK_*COARSE, ...) has to go through the system call
   when it could just return the time of the last timer tick regardless of the
   clocksource.

- We may get bitten by errata handling on 32-bit kernels running on 64-bit
  hardware that has errata workaround in arch/arm64 for compat mode
  but not in native arm kernels. ARM64_ERRATUM_1418040,
  ARM64_ERRATUM_858921 or SUN50I_ERRATUM_UNKNOWN1
  are examples of workaround that are not used on 32-bit kernels running
  on 64-bit hardware.

         Arnd
