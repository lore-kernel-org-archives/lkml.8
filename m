Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E6C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D53D21927
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqPXuqQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBXV2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:28:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33824 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:28:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so4575526plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8BGinAzlZOhZ+617u+1B0XdFYhcPHGy2MPB2MaSFIV8=;
        b=EqPXuqQKGmG4j9on8S0Mxv9iBKtuHM0hbrqRuguBP/pGCrYWHh3SLhkegOKyJhVatu
         vJ0rapmcKWPkbojbh25KTjRHE+PWqo26hpzHlBLZKUiyFMd13Sz/UiYQ7L3Y4a/2a9qK
         2usToCRw5saVeYvjfTgOKBAAIbEf0n/28HwNfbqaQOXev8O/LfsJNPYMh27rw/H/5w9n
         b1Gz/qe2fKg7cetV/POL2YZhDfHX+evKEYIt/O1lHghPXgBMgXtUMbht7uRBskAeEgzN
         EAHpq5paVz747f55QMbNmoTRBNirAFN3NfE2bcmLzSNHdPiT+tHaPsztpI7ZwczVhQk7
         /LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8BGinAzlZOhZ+617u+1B0XdFYhcPHGy2MPB2MaSFIV8=;
        b=WTQQlwZJdpK/9Y5W/Si91Y8ZPPIG4FyYSUsDlLp+AG+7OW+z6E8doZpkW14NiQqNWv
         UPdSvjZ4grosHiT7nezcHYa/ewsPMhfwJUbaIUU3HPj2swr6+g/Sx69fNq2NuInnUSwg
         JfTwEHvwYmA+RmlwrV5MCyI5itvGa+4zT4g6NGLYjdTvG2ARVGB2X0y3gZ3OArc0fY4C
         FBuniwPojr9jJ3u3NZdrJwu32vbOolkq1dnh0gaGZh1PXzrVwJYrs+xDxVPBjs31592R
         7epf9nk3H9Tde0W5+jFmGf/mTYFRgHH0u6Tq3O0n5bDh5UvrtnFdAYwaXoMjoeVSHT1B
         u1kA==
X-Gm-Message-State: APjAAAUA5JA9Oean14j3JZVHvCVQoKjlePqFD12XfmsFomtHOqcBmjWc
        dCqtWtwRPAEO+E7LjJeP8+WnYw==
X-Google-Smtp-Source: APXvYqw5zI7KEt8xzuzQf+9IJsjMGPhubY3G9WIDxG92nZ+obDLokstq+UohGfgNB8yhPk1vtvnWCA==
X-Received: by 2002:a17:90b:289:: with SMTP id az9mr1183242pjb.23.1582579711848;
        Mon, 24 Feb 2020 13:28:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id x7sm14173473pfp.93.2020.02.24.13.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:28:31 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:28:28 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200224212828.xvxl3mklpvlrdtiw@google.com>
References: <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
 <CAKwvOd=nCAyXtng1N-fvNYa=-NGD0yu+Rm6io9F1gs0FieatwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOd=nCAyXtng1N-fvNYa=-NGD0yu+Rm6io9F1gs0FieatwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-24, Nick Desaulniers wrote:
>On Mon, Feb 24, 2020 at 5:28 AM Michael Matz <matz@suse.de> wrote:
>>
>> Hello,
>>
>> On Sat, 22 Feb 2020, Nick Desaulniers wrote:
>>
>> > > > > In GNU ld, it seems that .shstrtab .symtab and .strtab are special
>> > > > > cased. Neither the input section description *(.shstrtab) nor *(*)
>> > > > > discards .shstrtab . I feel that this is a weird case (probably even a bug)
>> > > > > that lld should not implement.
>> > > >
>> > > > Ok, forget what the tools do for a second: why is .shstrtab special and
>> > > > why would one want to keep it?
>> > > >
>> > > > Because one still wants to know what the section names of an object are
>> > > > or other tools need it or why?
>> > > >
>> > > > Thx.
>> > > >
>> > > > --
>> > > > Regards/Gruss,
>> > > >     Boris.
>> > > >
>> > > > https://people.kernel.org/tglx/notes-about-netiquette
>> > >
>> > > .shstrtab is required by the ELF specification. The e_shstrndx field in
>> > > the ELF header is the index of .shstrtab, and each section in the
>> > > section table is required to have an sh_name that points into the
>> > > .shstrtab.
>> >
>> > Yeah, I can see it both ways.  That `*` doesn't glob all remaining
>> > sections is surprising to me, but bfd seems to be "extra helpful" in
>> > not discarding sections that are required via ELF spec.
>>
>> In a way the /DISCARD/ assignment should be thought of as applying to
>> _input_ sections (as all such section references on the RHS), not
>> necessarily to output sections.  What this then means for sections that
>> are synthesized by the link editor is less clear.  Some of them are
>> generated regardless (as you noted, e.g. the symbol table and associated
>> string sections, including section name string table), some of them are
>> suppressed, and either lead to an followup error (e.g. with .gnu.hash), or
>> to invalid output (e.g. missing .dynsym for executables simply lead to
>> segfaults when running them).

Hi Michael, please see my other reply on this thread: https://lkml.org/lkml/2020/2/24/47

Synthesized sections can be matched as well. For example, SECTIONS { .pltfoo : { *(.plt) }} can rename the output section .plt to .pltfoo
It seems that in GNU ld, the synthesized section is associated with the
original object file, so it can be written as:

   SECTIONS { .pltfoo : { a.o(.plt) }}

In lld, you need a wildcard to match the synthesized section *(.plt)

.rela.dyn is another example.

>> That's the reason for the perceived inconsistency with behaviour on '*':
>> it's application to synthesized sections.  Arguably bfd should be fixed to
>> also not discard the other essential sections (or alternatively to give an
>> error when an essential section is discarded).  The lld behaviour of e.g.
>> discarding .shstrtab (or other synthesized sections necessary for valid
>> ELF output) doesn't make much sense either, though.

I think most input section descriptions *(*) are misuse. They really
should be INPUT_SECTION_FLAGS(SHF_ALLOC) *(*)

>Hi Michael, thank you for the precise feedback.  Do you have a list of
>"synthesized sections necessary for valid ELF output?" Also, could you
>point me to the documentation about `*` and its relation to
>"synthesized sections necessary for valid ELF output?"  This will help
>me file a precise bug against LLD.

https://sourceware.org/binutils/docs/ld/Output-Section-Discarding.html#Output-Section-Discarding

has a few words on this topic. A large part is implementation defined.
In GNU ld, the implementation is mostly in ld/ldlang.c and ld/ldexp.c
(very long).
