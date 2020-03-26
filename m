Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BBFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F5C206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BphgvEck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgCZUMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:12:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45955 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgCZUMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:12:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id l22so6712186oii.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q+Ax8x2vU+R+U6VbmPmYqkXtNPWfs1Jy/4mzvcdEYZg=;
        b=BphgvEckoK0ht7HlgFAnRZJk+fpNqINscW4e//FspZihcDb25k/h5kIlBffKJljiQS
         peela2MsUVMmRX7nnOcsdPdSygsxdUXaYK2jgEQUcY70x+NLHAF91LcLtSvgFx1pYMVJ
         ISXXyg7ZH8KnI/1rK5mc3eN597BYC7CEeNp6ssy3f91JILcdK3ytTmtPW7QM51hedGWS
         UC1qAymWlYlSDx2YgYJM5ISOrEaMlrp1RhnCao+KrOsOcsTexWQ4UFDeWEaL4ioawW3X
         oAUUW87wFw8TdFXqWfIXbfgAUo3rz0TWin5N6BmLHTqumXF/VuUskIM0KbJTi+kZuXzJ
         OC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q+Ax8x2vU+R+U6VbmPmYqkXtNPWfs1Jy/4mzvcdEYZg=;
        b=WV61emn44IG4vi8ByVdBo+dwwUHkVYfwstkWeWCt0FqrpAXWvksq9KkA+LFGzWIRht
         0IsaE58I/X5JvCYSwC2AiKJ91ZSPXbN1SU147nGuaQqwrJ2FOkM2+dj4fVQVRt5qZqoF
         38YIfYz0ljBpszGpfbXQLwCHUly3Q9sJO4D4TxnpbswYtMbR8HPDyAcCQviVtAijv51B
         Con8qAB9rg9od8wi6qUs0cU7w6qX2EMmI+EIHRavgR6kb+wLlTOI31h4B+O9yj3LKNRr
         /20THaPhhsTXbTD4MNN/fo1mUQ3KOKG5/EKBaikKIZ8fzHFiSgbDTuo3XGd+Ay4QK7Fw
         CykA==
X-Gm-Message-State: ANhLgQ2X+09+oIVKNnO3xLWZX81zEcKj77QLLUZEMa7nVSDJjX8uS1C7
        gydOqztKBZJf6co91yWgHZU=
X-Google-Smtp-Source: ADFU+vtPiVQu2F9SE5eGhZSoLiCecLF2dP70MsPljd+2jH7CppiNm5fY/jDEoS7okH0q+UO2gRUPPw==
X-Received: by 2002:aca:af97:: with SMTP id y145mr1534969oie.24.1585253521437;
        Thu, 26 Mar 2020 13:12:01 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id f45sm880530otf.30.2020.03.26.13.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 13:12:00 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:11:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] drm/i915: Cast remain to unsigned long in eb_relocate_vma
Message-ID: <20200326201158.GA30083@ubuntu-m2-xlarge-x86>
References: <20200214054706.33870-1-natechancellor@gmail.com>
 <87v9o965gg.fsf@intel.com>
 <158166913989.4660.10674824117292988120@skylake-alporthouse-com>
 <87o8u1wfqs.fsf@intel.com>
 <ff302c03-d012-a80d-b818-b7feababb86b@daenzer.net>
 <CAKwvOdnaRG=7mib9vtWX4wkjQXHeUiioonTaZLStMVXfOOSUfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnaRG=7mib9vtWX4wkjQXHeUiioonTaZLStMVXfOOSUfw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:41:23PM -0700, Nick Desaulniers wrote:
> On Fri, Feb 14, 2020 at 7:36 AM Michel Dänzer <michel@daenzer.net> wrote:
> >
> > On 2020-02-14 12:49 p.m., Jani Nikula wrote:
> > > On Fri, 14 Feb 2020, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > >> Quoting Jani Nikula (2020-02-14 06:36:15)
> > >>> On Thu, 13 Feb 2020, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >>>> A recent commit in clang added -Wtautological-compare to -Wall, which is
> > >>>> enabled for i915 after -Wtautological-compare is disabled for the rest
> > >>>> of the kernel so we see the following warning on x86_64:
> > >>>>
> > >>>>  ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1433:22: warning:
> > >>>>  result of comparison of constant 576460752303423487 with expression of
> > >>>>  type 'unsigned int' is always false
> > >>>>  [-Wtautological-constant-out-of-range-compare]
> > >>>>          if (unlikely(remain > N_RELOC(ULONG_MAX)))
> > >>>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> > >>>>  ../include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
> > >>>>  # define unlikely(x)    __builtin_expect(!!(x), 0)
> > >>>>                                             ^
> > >>>>  1 warning generated.
> > >>>>
> > >>>> It is not wrong in the case where ULONG_MAX > UINT_MAX but it does not
> > >>>> account for the case where this file is built for 32-bit x86, where
> > >>>> ULONG_MAX == UINT_MAX and this check is still relevant.
> > >>>>
> > >>>> Cast remain to unsigned long, which keeps the generated code the same
> > >>>> (verified with clang-11 on x86_64 and GCC 9.2.0 on x86 and x86_64) and
> > >>>> the warning is silenced so we can catch more potential issues in the
> > >>>> future.
> > >>>>
> > >>>> Link: https://github.com/ClangBuiltLinux/linux/issues/778
> > >>>> Suggested-by: Michel Dänzer <michel@daenzer.net>
> > >>>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >>>
> > >>> Works for me as a workaround,
> > >>
> > >> But the whole point was that the compiler could see that it was
> > >> impossible and not emit the code. Doesn't this break that?
> > >
> > > It seems that goal and the warning are fundamentally incompatible.
> >
> > Not really:
> >
> >     if (sizeof(remain) >= sizeof(unsigned long) &&
> >         unlikely(remain > N_RELOC(ULONG_MAX)))
> >              return -EINVAL;
> >
> > In contrast to the cast, this doesn't generate any machine code on 64-bit:
> >
> > https://godbolt.org/z/GmUE4S
> >
> > but still generates the same code on 32-bit:
> >
> > https://godbolt.org/z/hAoz8L
> 
> Exactly.
> 
> This check is only a tautology when `sizeof(long) == sizeof(int)` (ie.
> ILP32 platforms, like 32b x86), notice how BOTH GCC AND Clang generate
> exactly the same code: https://godbolt.org/z/6ShrDM
> 
> Both compilers eliminate the check when `-m32` is not set, and
> generate the exact same check otherwise.  How about:
> ```
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index d3f4f28e9468..25b9d3f3ad57 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -1415,8 +1415,10 @@ static int eb_relocate_vma(struct
> i915_execbuffer *eb, struct eb_vma *ev)
> 
>         urelocs = u64_to_user_ptr(entry->relocs_ptr);
>         remain = entry->relocation_count;
> +#ifndef CONFIG_64BIT
>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
>                 return -EINVAL;
> +#endif
> 
>         /*
>          * We must check that the entire relocation array is safe
> ```
> 
> We now have 4 proposed solutions:
> 1. https://lore.kernel.org/lkml/20191123195321.41305-1-natechancellor@gmail.com/
> 2. https://lore.kernel.org/lkml/20200211050808.29463-1-natechancellor@gmail.com/
> 3. https://lore.kernel.org/lkml/20200214054706.33870-1-natechancellor@gmail.com/
> 4. my diff above
> Let's please come to a resolution on this.

This is the only warning on an x86_64 defconfig build. Apologies if we
are being too persistent or nagging but we need guidance from the i915
maintainers on which solution they would prefer so it can be picked up.
I understand you all are busy and I appreciate the work you all do but
I do not want this to fall between the cracks because it is annoying to
constantly see this warning.

Cheers,
Nathan
