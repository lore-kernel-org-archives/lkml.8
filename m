Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2556206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+p4rL6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgEVKeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgEVKeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:34:13 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B0C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:34:12 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id i9so2069206ool.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ktmTy4SBF1rMKSXisJeFl7NM4HKoH9GRsdYqKi4Yhk=;
        b=r+p4rL6dIfZka9/kOM/z/qvR8koTdip9r+Ida4SrydWrQbMAl/U17vCfvc9dV+1HKP
         nPSQgCHjHTfLBNCNuq2OQjost52ETQWbL27CpfyFIPkKXg/V4Ssrg7u8Fs37ksLv5L5d
         N29orFGlaibmiszJnkHCqKo1DuLTdJ2bTAU/dyIUvVKqQVM26qB9BhRVHedyu19dWnKa
         G7GkPigV/ud9N8tv64tgALtAIgYuWSRQhpVfPFDy946hqW4gWjLrQdtJk4hmi8ZDEM3C
         kzvV41BvVGYvSZSIKg/porkInfmkPxxvkokGw29B9JWPwWp/Or9Wq1oOIBVDEVq75GuP
         G30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ktmTy4SBF1rMKSXisJeFl7NM4HKoH9GRsdYqKi4Yhk=;
        b=UFNMoSwysHPTMbj/3xzo2Vced0xOqgRa6vfPhLsO01HSuJ51MPfrLWqs78zDdwjW8n
         qoJa1FVWJScmwpQqPQfP1PwrFors3XBNSq9aT3NCgaruZxGS4VfiPopyXAFmP/m5dHPU
         oeZKvfARf8mdNqImzu3nXE88jDLl6wXe3uej7J0ge+QmSgAa0MspkKVWxDMp2g+YGQzG
         w905M/BfdwLheyIG3ndPkH7932SfRdRIfdj373Nw0Fze6M2Y85hV39rTKVMy7plDv3Pm
         PV2XpuHs5fTyfVpzzyFu/CK8tgo4Fzg0TOmbWj5SG5CIbSVSjd46pDoEYZuWgBKAiPY1
         +Jlw==
X-Gm-Message-State: AOAM532AKEG33Dxr5cyMjn15FREhMSavvecU7yFxAR9ucyl9bPprmL0K
        ie4fvoWeK3LW0w+KdroNzfu3tafBEc8qnhMdIOES5Q==
X-Google-Smtp-Source: ABdhPJwrhxKMFtD7P+RI0CQDAjknGBuZPr69lWCEuIfEcpoVvW6AvyTUoQvMfPMIjwqV4k4JmQ36BgVFa7vwpTZEZ2E=
X-Received: by 2002:a4a:e836:: with SMTP id d22mr2501899ood.54.1590143652013;
 Fri, 22 May 2020 03:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-4-elver@google.com>
 <20200522102630.GC28750@zn.tnic>
In-Reply-To: <20200522102630.GC28750@zn.tnic>
From:   Marco Elver <elver@google.com>
Date:   Fri, 22 May 2020 12:34:00 +0200
Message-ID: <CANpmjNM=aHuTWFk45j8BwRFoTQxc-ovghjfwQr5m4K3kVP8r0w@mail.gmail.com>
Subject: Re: [PATCH -tip v3 03/11] kcsan: Support distinguishing volatile accesses
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 at 12:26, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 21, 2020 at 04:20:39PM +0200, Marco Elver wrote:
> > diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
> > index 20337a7ecf54..75d2942b9437 100644
> > --- a/scripts/Makefile.kcsan
> > +++ b/scripts/Makefile.kcsan
> > @@ -9,7 +9,10 @@ else
> >  cc-param =3D --param -$(1)
> >  endif
> >
> > +# Keep most options here optional, to allow enabling more compilers if=
 absence
> > +# of some options does not break KCSAN nor causes false positive repor=
ts.
> >  CFLAGS_KCSAN :=3D -fsanitize=3Dthread \
> > -     $(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=
=3D0) -fno-optimize-sibling-calls)
> > +     $(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=
=3D0) -fno-optimize-sibling-calls) \
> > +     $(call cc-param,tsan-distinguish-volatile=3D1)
>
> gcc 9 doesn't like this:
>
> cc1: error: invalid --param name =E2=80=98-tsan-distinguish-volatile=E2=
=80=99
> make[1]: *** [scripts/Makefile.build:100: scripts/mod/devicetable-offsets=
.s] Error 1
> make[1]: *** Waiting for unfinished jobs....
> cc1: error: invalid --param name =E2=80=98-tsan-distinguish-volatile=E2=
=80=99
> make[1]: *** [scripts/Makefile.build:267: scripts/mod/empty.o] Error 1
> make: *** [Makefile:1141: prepare0] Error 2
> make: *** Waiting for unfinished jobs....
>
> git grep "tsan-distinguish-volatile" in gcc's git doesn't give anything.
>
> Hmm.

Yeah, my patch for GCC is still pending. But we probably need more
fixes for GCC, before we can re-enable it.

We restrict supported compilers later in the series:
https://lore.kernel.org/lkml/20200521142047.169334-7-elver@google.com/

More background is also in the cover letter:
https://lore.kernel.org/lkml/20200521142047.169334-1-elver@google.com/

Thanks,
-- Marco
