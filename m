Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D361C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F0C20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bygEw+ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbgCPVlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:41:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42467 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbgCPVlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:41:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id t3so8594232plz.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9wf0Koz5Hqawzf6JsmYQiKszzPagSKBiZUUlt5oOYqk=;
        b=bygEw+utdMG3J5vWZUoZSaS7LmV6Z5HdtyZV/VdNtbOd9xdi8xc0AugHxl6FD6zUyE
         DYho48lurJEKOQsrXUCvVHgqwG5nzSQ9hCveGYqzxMmXyXHZZj4TSZj7imlQc1nxdiHm
         AetbRzqEN6m4JOEDas4VlK2MDkOXsuAz8ba+zYfeZwrZ08d7nqfZUL7MWZDs3SuIb6Fg
         hDEBTGIAwM7cIXBIUMAgMZeQtZQgPsr1VNX0Zbnn0UONxvqrcD7hzeT7XNNc1nrkrD6L
         XWgo9QJuNS7GdyhnuwxaexJq3QG/5dIbA2yuW1NwoXOE95YUbvsI1GJ3JTlDNV/gN9oV
         203Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9wf0Koz5Hqawzf6JsmYQiKszzPagSKBiZUUlt5oOYqk=;
        b=kUy3khUzDsc9x1e/i1XiL7y/z6n3Op9DPhvDLN5L3Vfun+ghVjmaJF9b20fEaxwxYK
         80E4HwPJJ2UOYKZQP8rV65pHqQsd7G2ryKCG/lmSC0suHcrdPDCDlerfwZd/VN69f0Rm
         2LsGY5Fd7J17qX8D9jnooZ7RJe0wjEWoT1jH+eXP5jGWh6zzvmp/8Pv5dxWlMkwNHo2O
         8/a3ulACbTGEubsSO3i1mxRD7k9fEkOa1ibzub1PRWGsvpFV60xqDQCdRETqTnpurONL
         pfMOKYhYpe7fxVrJuFoaySJ6vqTwU6BiwG30qJi1aoaSkfiS89l4AksZS+BRcnD17SNE
         L1Nw==
X-Gm-Message-State: ANhLgQ2vluv133GJDpPrGSaxIr5PlD2jj1cNoNqExfm7YHuzkC/o1ety
        flFOSQkaXnw3fMh02BpfF+0KoZDzQmxta1oDO9+WZQ==
X-Google-Smtp-Source: ADFU+vtTQK5TD1ku2W52cwb9IcN2NIxSX4pkJHwb1CiOr27o/QEwR2bJm0JvInszSDbMqcrpiTnEbBwxyDyJBxR5jGk=
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr1121105plo.179.1584394895359;
 Mon, 16 Mar 2020 14:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200214054706.33870-1-natechancellor@gmail.com>
 <87v9o965gg.fsf@intel.com> <158166913989.4660.10674824117292988120@skylake-alporthouse-com>
 <87o8u1wfqs.fsf@intel.com> <ff302c03-d012-a80d-b818-b7feababb86b@daenzer.net>
In-Reply-To: <ff302c03-d012-a80d-b818-b7feababb86b@daenzer.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Mar 2020 14:41:23 -0700
Message-ID: <CAKwvOdnaRG=7mib9vtWX4wkjQXHeUiioonTaZLStMVXfOOSUfw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Cast remain to unsigned long in eb_relocate_vma
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 7:36 AM Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
>
> On 2020-02-14 12:49 p.m., Jani Nikula wrote:
> > On Fri, 14 Feb 2020, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >> Quoting Jani Nikula (2020-02-14 06:36:15)
> >>> On Thu, 13 Feb 2020, Nathan Chancellor <natechancellor@gmail.com> wro=
te:
> >>>> A recent commit in clang added -Wtautological-compare to -Wall, whic=
h is
> >>>> enabled for i915 after -Wtautological-compare is disabled for the re=
st
> >>>> of the kernel so we see the following warning on x86_64:
> >>>>
> >>>>  ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1433:22: warning:
> >>>>  result of comparison of constant 576460752303423487 with expression=
 of
> >>>>  type 'unsigned int' is always false
> >>>>  [-Wtautological-constant-out-of-range-compare]
> >>>>          if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >>>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> >>>>  ../include/linux/compiler.h:78:42: note: expanded from macro 'unlik=
ely'
> >>>>  # define unlikely(x)    __builtin_expect(!!(x), 0)
> >>>>                                             ^
> >>>>  1 warning generated.
> >>>>
> >>>> It is not wrong in the case where ULONG_MAX > UINT_MAX but it does n=
ot
> >>>> account for the case where this file is built for 32-bit x86, where
> >>>> ULONG_MAX =3D=3D UINT_MAX and this check is still relevant.
> >>>>
> >>>> Cast remain to unsigned long, which keeps the generated code the sam=
e
> >>>> (verified with clang-11 on x86_64 and GCC 9.2.0 on x86 and x86_64) a=
nd
> >>>> the warning is silenced so we can catch more potential issues in the
> >>>> future.
> >>>>
> >>>> Link: https://github.com/ClangBuiltLinux/linux/issues/778
> >>>> Suggested-by: Michel D=C3=A4nzer <michel@daenzer.net>
> >>>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >>>
> >>> Works for me as a workaround,
> >>
> >> But the whole point was that the compiler could see that it was
> >> impossible and not emit the code. Doesn't this break that?
> >
> > It seems that goal and the warning are fundamentally incompatible.
>
> Not really:
>
>     if (sizeof(remain) >=3D sizeof(unsigned long) &&
>         unlikely(remain > N_RELOC(ULONG_MAX)))
>              return -EINVAL;
>
> In contrast to the cast, this doesn't generate any machine code on 64-bit=
:
>
> https://godbolt.org/z/GmUE4S
>
> but still generates the same code on 32-bit:
>
> https://godbolt.org/z/hAoz8L

Exactly.

This check is only a tautology when `sizeof(long) =3D=3D sizeof(int)` (ie.
ILP32 platforms, like 32b x86), notice how BOTH GCC AND Clang generate
exactly the same code: https://godbolt.org/z/6ShrDM

Both compilers eliminate the check when `-m32` is not set, and
generate the exact same check otherwise.  How about:
```
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index d3f4f28e9468..25b9d3f3ad57 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1415,8 +1415,10 @@ static int eb_relocate_vma(struct
i915_execbuffer *eb, struct eb_vma *ev)

        urelocs =3D u64_to_user_ptr(entry->relocs_ptr);
        remain =3D entry->relocation_count;
+#ifndef CONFIG_64BIT
        if (unlikely(remain > N_RELOC(ULONG_MAX)))
                return -EINVAL;
+#endif

        /*
         * We must check that the entire relocation array is safe
```

We now have 4 proposed solutions:
1. https://lore.kernel.org/lkml/20191123195321.41305-1-natechancellor@gmail=
.com/
2. https://lore.kernel.org/lkml/20200211050808.29463-1-natechancellor@gmail=
.com/
3. https://lore.kernel.org/lkml/20200214054706.33870-1-natechancellor@gmail=
.com/
4. my diff above
Let's please come to a resolution on this.
--=20
Thanks,
~Nick Desaulniers
