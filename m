Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5342C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7665620838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JBsprV2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgBXWvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:51:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43739 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgBXWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:51:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so5859613pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csKoX99wXjSZzk96rey5IsInzo47PM9NCitxp5N6Ioc=;
        b=JBsprV2ZLAIyNTLRN+r6ILxG8+TbFtBYW2Vas2aSlSWdE92/TbkPGBwaSn9lgcXnaU
         KKaMu4qqae+0B7r8DPvRbAhIfMCBpOjzAKBQ6wjUh1PWZYrO/xpKnMNDzxLYUguC0Fyz
         EExngqXog17tgU8cnxBvI8nwuajadec7oLXYPm6en77KfXyBMHMGlQeSTXpWJSnF+/Iy
         elhxf95xO0dwWyaKPW7hA9072YpdMImNRS9v+IYGPQtEw2NNASBTO3owiQ0tUywCJF+c
         X/X6mHoZKiqrXZ+NIfIXc7C4yUnBRn2dfeQbpOOzOSrhTuRFn3xd0Md7KXuM/OZA/SU8
         lxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csKoX99wXjSZzk96rey5IsInzo47PM9NCitxp5N6Ioc=;
        b=pK0tX0ELacNQcuA9YAxk5YlLtHw1DL1Bq1PWPU02/GNBzHBw0sg3dEtpW+DuPdUJ6k
         La5UAdQ7jegmUu4qPXCllZ31EEplNbRpR/k7SWFW9b9elx/iIUf8LhYigPFdP7FEVFw9
         U+eoYYjFmzYlVa1rWDUkVgjIRYLlK3ylN/BjN7CjQ6ipiO4sCtcN5pGAjwqB8EVrlG2g
         QF3eLf2hjEICDsHGkTBQFpuDsxR2nGFMCLW7nMvGARmWDBTxG7Gitr2ufDdkoOm3XArV
         xfjpf/VS2fPCOwoNoP6yLcJ7VdK7fo0PItMge/Y44elWbEsCcNJNDtWYBzHC+BmIlhWK
         e5tw==
X-Gm-Message-State: APjAAAXQV+Au21sS38WaEn4SRbXFW2LE8WxUozxiTRfIBksI44ZDETWX
        Imipo2IkDpC/N5IJxFelJz62+A==
X-Google-Smtp-Source: APXvYqy30Y4eINEZzf48bWfoPPoDQmMp3g9BGrT5+XvpBLXDuVzIoWWVIgoXIN+Mc1djqEODK/MtaQ==
X-Received: by 2002:a62:1456:: with SMTP id 83mr54643458pfu.186.1582584662629;
        Mon, 24 Feb 2020 14:51:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id z4sm13622592pfn.42.2020.02.24.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:51:02 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:50:59 -0800
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20200224225059.2scjklfi4g7wwdkp@google.com>
References: <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
 <CAKwvOd=nCAyXtng1N-fvNYa=-NGD0yu+Rm6io9F1gs0FieatwA@mail.gmail.com>
 <20200224212828.xvxl3mklpvlrdtiw@google.com>
 <20200224214845.GC409112@rani.riverdale.lan>
 <20200224221703.eqql5hrx4ccngwa5@google.com>
 <20200224224343.GA572699@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200224224343.GA572699@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-24, Arvind Sankar wrote:
>On Mon, Feb 24, 2020 at 02:17:03PM -0800, Fangrui Song wrote:
>> On 2020-02-24, Arvind Sankar wrote:
>> >On Mon, Feb 24, 2020 at 01:28:28PM -0800, Fangrui Song wrote:
>> >> Hi Michael, please see my other reply on this thread: https://lkml.org/lkml/2020/2/24/47
>> >>
>> >> Synthesized sections can be matched as well. For example, SECTIONS { .pltfoo : { *(.plt) }} can rename the output section .plt to .pltfoo
>> >> It seems that in GNU ld, the synthesized section is associated with the
>> >> original object file, so it can be written as:
>> >>
>> >>    SECTIONS { .pltfoo : { a.o(.plt) }}
>> >>
>> >> In lld, you need a wildcard to match the synthesized section *(.plt)
>> >>
>> >> .rela.dyn is another example.
>> >>
>> >
>> >With the BFD toolchain, file matching doesn't actually seem to work at
>> >least for .rela.dyn. I've tried playing around with it in the past and
>> >if you try to use file-matching to capture relocations from a particular
>> >input file, it just doesn't work sensibly.
>>
>> I think most things are working in GNU ld...
>>
>> /* a.x */
>> SECTIONS {
>>    .rela.pltfoo : { a.o(.rela.plt) }  /* *(.rela.plt) with lld */
>>    .rela.dynfoo : { a.o(.rela.data) } /* *(.rela.dyn) with lld */
>> }
>
>The file matching doesn't do anything sensible. If you split your .data
>section out into b.s, and update the linker script so it filters for
>b.o(.rela.data), .rela.dynfoo doesn't get created, instead the default
>.rela.dyn will contains the .data section relocation. If you keep the
>filter as a.o(.rela.data), you get .rela.dynfoo, even though a.o doesn't
>actually contain any .rela.data section any more.

I raised the examples to support my viewpoint "synthesized sections can
be matched, as well as input sections."

If there is really a need (rare, not recommended) to rename output
sections only consisting of synthesized sections (e.g. .plt .rela.dyn),
for linker portability, it is better using a wildcard for the input
filename pattern.

As another example, SECTIONS { /DISCARD/ : { *(.rela.*) } } discards synthesized .rela.*

>>
>> % cat <<e > a.s
>>   .globl foo
>>   foo:
>>     call bar
>>   .data
>>   .quad quz
>> e
>> % as a.s -o a.o
>> % ld.bfd -T a.x a.o -shared -o a.so
