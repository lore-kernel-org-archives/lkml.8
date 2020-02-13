Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6817C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A2A2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mu7RaWQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBMWnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:43:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46944 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:43:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id b35so3743324pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1uz4onwD02FQH4e/dvdb1FjZu1rFnkl+4ltvHCVnzHQ=;
        b=Mu7RaWQT57rbjsEgWQeug20f4GIX77GFzc3qAC7n2UMwytWFBLui8a1qKbHPGKy1kO
         9qHZUeD/Ig7Ke5Azt9yZuWIB3ilP30QdJLPVilNqofkViyiWVw9yHK13NFR7WQruhaev
         K9iZutEjIZ9rx6lvKFO6X2nTrfMLXqseES2VUtMF39yTdsb2GbDCvpgsBONkdsB8nnA5
         MUo5zjOT/BmVDI9DZ/Hr6pq80Tpe5d2g9iwzD+aJyP/o8jZWLS7JhIi11/cydPIK6Nly
         ZZyDKTNDANgpYqFoT7sqnemXJg3T6yPh2tbZSI2Aim3r5vYBVqiLMFEqe5+3ngmFACR/
         q5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1uz4onwD02FQH4e/dvdb1FjZu1rFnkl+4ltvHCVnzHQ=;
        b=nsupD/H3c8KDzFNUZpq+mhtA0v2qMnF0cVgeuonwQK/bcbZnxV+MmujUesBOLrPo2V
         NM1OmGV+FHvqy7z51+cLMfK9TPZ+HsiKl43kySUkTVfEyqpziAKvQlcoIrlbtEdGwOKj
         YvQX1fiiSdq4I4omELVxnv53GcQyIl0mozrSDGXDwywQRgMzWxO2EQvufEoIGVFYkIBm
         QaTzBI1YC0PVs1SgRlNUBV0dSh7GfaEMPmxu9mrQQkUinBOdJWulEx8h8uVUPqjlrwaI
         iZzFG1fyX2YvxivmItKOrQWac/WQmPjf8i4Aztj/xkVeZJGa04XnvaXG5LP9GQJWrqKE
         zHpA==
X-Gm-Message-State: APjAAAX0xFvWqJbk317xG5UfiZOjVlIu2WS36S5mw4P2fYALpglkokzD
        Fsunwd1aexnVdBY10aNhAWJGFtpVOhxFqvvtBspJtg==
X-Google-Smtp-Source: APXvYqz+I/Aj0lLNkEM0HAfbgend/2rNUCga5zdKKKJWLstIs2KmGzFR4k/LVIzrSDVahxXfq6sw1G//SGyOO9dV1IY=
X-Received: by 2002:a63:64c5:: with SMTP id y188mr195696pgb.10.1581633812546;
 Thu, 13 Feb 2020 14:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20200211050808.29463-1-natechancellor@gmail.com>
 <20200211061338.23666-1-natechancellor@gmail.com> <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net>
 <20200211203935.GA16176@ubuntu-m2-xlarge-x86> <f3a6346b-2abf-0b6a-3d84-66e12f700b2b@daenzer.net>
 <20200212170734.GA16396@ubuntu-m2-xlarge-x86> <d81a2cfe-79b6-51d4-023e-0960c0593856@daenzer.net>
In-Reply-To: <d81a2cfe-79b6-51d4-023e-0960c0593856@daenzer.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Feb 2020 14:43:21 -0800
Message-ID: <CAKwvOdm4eS19-D3pEkKsyZw7VjJP9Jeh5gMZaszwgjrJe63yUg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Disable -Wtautological-constant-out-of-range-compare
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 9:17 AM Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
>
> On 2020-02-12 6:07 p.m., Nathan Chancellor wrote:
> > On Wed, Feb 12, 2020 at 09:52:52AM +0100, Michel D=C3=A4nzer wrote:
> >> On 2020-02-11 9:39 p.m., Nathan Chancellor wrote:
> >>> On Tue, Feb 11, 2020 at 10:41:48AM +0100, Michel D=C3=A4nzer wrote:
> >>>> On 2020-02-11 7:13 a.m., Nathan Chancellor wrote:
> >>>>> A recent commit in clang added -Wtautological-compare to -Wall, whi=
ch is
> >>>>> enabled for i915 so we see the following warning:
> >>>>>
> >>>>> ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> >>>>> result of comparison of constant 576460752303423487 with expression=
 of
> >>>>> type 'unsigned int' is always false
> >>>>> [-Wtautological-constant-out-of-range-compare]
> >>>>>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >>>>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> >>>>>
> >>>>> This warning only happens on x86_64 but that check is relevant for
> >>>>> 32-bit x86 so we cannot remove it.
> >>>>
> >>>> That's suprising. AFAICT N_RELOC(ULONG_MAX) works out to the same va=
lue
> >>>> in both cases, and remain is a 32-bit value in both cases. How can i=
t be
> >>>> larger than N_RELOC(ULONG_MAX) on 32-bit (but not on 64-bit)?
> >>>>
> >>>
> >>> Hi Michel,
> >>>
> >>> Can't this condition be true when UINT_MAX =3D=3D ULONG_MAX?
> >>
> >> Oh, right, I think I was wrongly thinking long had 64 bits even on 32-=
bit.
> >>
> >>
> >> Anyway, this suggests a possible better solution:
> >>
> >> #if UINT_MAX =3D=3D ULONG_MAX
> >>      if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >>              return -EINVAL;
> >> #endif
> >>
> >>
> >> Or if that can't be used for some reason, something like
> >>
> >>      if (unlikely((unsigned long)remain > N_RELOC(ULONG_MAX)))
> >>              return -EINVAL;
> >>
> >> should silence the warning.
> >
> > I do like this one better than the former.
>
> FWIW, one downside of this one compared to all alternatives (presumably)
> is that it might end up generating actual code even on 64-bit, which
> always ends up skipping the return.

The warning is pointing out that the conditional is always false,
which is correct on 64b.  The check is only active for 32b.
https://godbolt.org/z/oQrgT_
The cast silences the warning for 64b.  (Note that GCC and Clang also
generate precisely the same instruction sequences in my example, just
GCC doesn't warn on such tautologies).
--=20
Thanks,
~Nick Desaulniers
