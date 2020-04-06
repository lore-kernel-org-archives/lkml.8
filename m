Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32B7C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ACA2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6l9/PoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgDFDOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 23:14:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43868 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFDOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 23:14:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id v23so5350078ply.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KrMlUKTNeum7x5sltX8KMxycbNc+02GypLAIc2PxYRo=;
        b=n6l9/PoPu69WpXT2Mhp8EZHschCokwiFwYEsCQGtvfeKtWLCPJVr6oG1HquLiu02XI
         tN1ZBgOX7T4orHjVzbpZq1YbtwWWTGwb6eoHiHCefE7DIkPuZJrQwcn3vk5DrUxhLlms
         AB0x78zGlV7JWTZl0LGNj4BxRhgg0E4fNtV7+gKw/vW5Z/g9cBFxXsSnl6KSSfEcT/Tm
         8r7JKejY8sjcEDU2QAnkKKkPTg25kaFCjoc9mJGuRFzSiJ+JclKyEr/r7H6Zt/Ozh83g
         h0cBn5nMJXMfaPQfWPvMoXNeewVsI9Y0qS1MFHCZ1mbKj7ljW/DmFXJqIiyXejh54FR1
         0uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrMlUKTNeum7x5sltX8KMxycbNc+02GypLAIc2PxYRo=;
        b=Li1owDIE940moMFt6hbI8jV8ZP5gtZdF5SMUVbcZNfC7dPPUNgJ65XqGmf8gWY8FwG
         5tSprY8ad3L/6hPggaOmuHwHw/4EAP8J6WqYYgsU828uzIhKoZ82Do6Qtx/Fef2Fqf3B
         PDlSvFzmuCtvqGkza9N1mGphRqm0wPcbRX0IheFIq00htgBQ9f602XH/qo1JyCEBZRFy
         6Snvc+Bn0NRrlhEZGZb+nguD+tkZqBS/Y8xVjUXVWvFNvEhN/M73mf3oUp8CywMbItAV
         nI5ccQ3QdcVfuL4kUH3tuguH7aM2R1KihB2lSioJX/FYAkCcEb2VC4tFmjX2Y6jEPmaV
         JdzQ==
X-Gm-Message-State: AGi0PuacFYs4XsBxdnudY2jkahlBIcBcI3pStOnHbz67NfcpgWXVT4px
        y9FxWIZQzyzd5FyWSTUYI/9pdA==
X-Google-Smtp-Source: APiQypLMY5yAy/eXmZCMTUi5bSNDlJlbf2KuiYRL4mW6WB0Py/B804nld4ImPobYhV0WwKjXzw70xA==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr18913445pls.36.1586142886153;
        Sun, 05 Apr 2020 20:14:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id e184sm10357065pfh.219.2020.04.05.20.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 20:14:45 -0700 (PDT)
Date:   Sun, 5 Apr 2020 20:14:42 -0700
From:   Fangrui Song <maskray@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias =?utf-8?Q?M=C3=A4nnich?= <maennich@google.com>,
        Sandeep Patil <sspatil@google.com>
Subject: Re: [PATCH] kbuild: support 'LLVM' to switch the default tools to
 Clang/LLVM
Message-ID: <20200406031442.2yrjtjp476qzjbqs@google.com>
References: <20200403051709.22407-1-masahiroy@kernel.org>
 <CAKwvOdnaZ6qDVxaPY-GEH8pdUkzH6eqm16ok9_wzRSVRG-1kiQ@mail.gmail.com>
 <CAK7LNAQybfcYiosNU+ybd-Q7-Y2dbLqBVN2XA00wCRnFAoqdew@mail.gmail.com>
 <20200405235507.psjjhqa3cxw57xra@google.com>
 <CAK7LNAS_SQg2nhJ8HKBTq3+dziGpaJZ87fOBRS-ZMdUpKGhX9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNAS_SQg2nhJ8HKBTq3+dziGpaJZ87fOBRS-ZMdUpKGhX9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-06, Masahiro Yamada wrote:
>On Mon, Apr 6, 2020 at 8:55 AM 'Fangrui Song' via Clang Built Linux
><clang-built-linux@googlegroups.com> wrote:
>>
>> On 2020-04-06, Masahiro Yamada wrote:
>> >On Sat, Apr 4, 2020 at 3:24 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>> >>
>> >> On Thu, Apr 2, 2020 at 10:17 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>> >> >
>> >> > As Documentation/kbuild/llvm.rst implies, building the kernel with a
>> >> > full set of LLVM tools gets very verbose and unwieldy.
>> >> >
>> >> > Provide a single switch 'LLVM' to use Clang and LLVM tools instead of
>> >> > GCC and Binutils. You can pass LLVM=1 from the command line or as an
>> >> > environment variable. Then, Kbuild will use LLVM toolchains in your
>> >> > PATH environment.
>> >> >
>> >> > Please note LLVM=1 does not turn on the LLVM integrated assembler.
>> >> > You need to explicitly pass AS=clang to use it. When the upstream
>> >> > kernel is ready for the integrated assembler, I think we can make
>> >> > it default.
>> >>
>> >> Having this behavior change over time may be surprising.  I'd rather
>> >> that if you want to not use the integrated assembler, you explicitly
>> >> negate it, or just don't use the LLVM=1 syntax, ie. `make CC=clang
>> >> LD=ld.lld ...`.
>> >>
>> >> We could modify how `-no-integrated-as` is chosen when LLVM=1.
>> >>
>> >> make LLVM=1 LLVMIA=0 ... # add `-no-integrated-as`
>> >> # what the flag is doesn't really matter to me, something shorter might be nice.
>> >> make LLVM=1 # use all LLVM tools
>> >>
>> >> Since we got rid of $(AS), it would be appropriate to remove/change it
>> >> there, since no one really relies on AS=clang right now. (We do have 1
>> >> of our 60+ CI targets using it, but we can also change that trivially.
>> >> So I think we have a lot of freedom to change how `-no-integrated-as`
>> >> is set.
>> >>
>> >> This could even be independent of this patch.
>> >
>> >
>> >I also thought a boolean flag is preferred.
>> >
>> >AS=clang will not live long anyway, and
>> >I hesitated to break the compatibility
>> >for the short-term workaround.
>> >
>> >But, if this is not a big deal, I can
>> >replace AS=clang with LLVMIA=1.
>>
>> My mere complaint is that it may be difficult to infer the intention (integrated
>> assembler) from the abbreviation "IA" in "LLVMIA" :/
>>
>> Something with "AS" in the name may be easier for a user to understand,
>> e.g. CLANG_AS or LLVM_AS.
>
>I see 'llvm-as' in my PATH,
>but it is a different kind of tool, right?
>(converter from LLVM assembler *.ll to LLVM bit code *.bc)
>
>So, I thought "LLVM_AS" might be confusing.

You are right. llvm-as converts a textual form of LLVM IR (.ll) to
a binary form bitcode (.bc). LLVM_AS is confusing. CLANG_AS/CLANGAS might be
suitable.

   clang a.c '-###' => clang -cc1     # like gcc invokes cc1
   clang a.s '-###' => clang -cc1as   # this invokes the integrated assembler
