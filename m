Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F3C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A5B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Tqwr6xPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgHTO4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHTO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:56:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:56:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so2429079ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ykyf/DFJPRk+LJhd4gWzpG3IAE+R8tPYL4KrwhMgRM=;
        b=Tqwr6xPEkCzFQinEVPAhvPL+AZv9nB9tisxcKkJmbGxIz2fQRURRo96xYFC2daX/K2
         aV6+c27jl18VUfd/iriJg+/oExn7ydoVTnDh/QhBX9vtaHaKlxmLdsZK1mfGewIuT7uQ
         LFxsQsIftezlmHizWiaN57J3ZQd4+Vo2oHUu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ykyf/DFJPRk+LJhd4gWzpG3IAE+R8tPYL4KrwhMgRM=;
        b=avjN2AID7Ihv2AANue7sLaw1c+OPq7QslfhXLka/nNTe7ywwRrzvMk4r1sNic20nMK
         Rw/+vHA9+41v5b6zzAF4xJilv4qry20ss9nK/g6SU7bpHyLq/YsiQjlnE1xGoKDLSEXZ
         SzXp5VXOEvbRM17dYmf/4RiRoN3dy79H1Kxn7y1ERveVOxqr4Lv5+6HDxdTnPzHPne2d
         qUH5KRxRQ/8QSMvjdRqHl4UufoUZ7CF5oulOUdNUZy7NZbUEtwPbdlABWljLiuviwTPo
         iHOXSjTsmVRKMst9DgWxDPcCwMmpOiOiK1tSJ63nzbra3PNOvFI0KKy5Wpgm9aljQ9eV
         46zw==
X-Gm-Message-State: AOAM530iDTTkT+vh2Jmk60NIsghbLXMltiWBlD8NQ97aKTigtyJDbzHR
        /rkPe+sPFbxfs1XwmgBpJ8Jw3g==
X-Google-Smtp-Source: ABdhPJwWNTMjuLtgomNg4RLsk7kkApyg5eAdXgForaqNIq9JLTBaq8slGS9ncLR37o9JdusAsoMrgw==
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr1707465lji.215.1597935365273;
        Thu, 20 Aug 2020 07:56:05 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f12sm498715ljn.14.2020.08.20.07.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 07:56:04 -0700 (PDT)
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com>
 <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
 <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com>
 <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
 <20200818202407.GA3143683@rani.riverdale.lan>
 <CAKwvOdnfh9nWwu1xV=WDbETGiabwDxXxQDRCAfpa-+kSZijb9w@mail.gmail.com>
 <CAKwvOdkA4SC==vGZ4e7xqFG3Zo=fnhU=FgnSazmWkkVWhkaSYw@mail.gmail.com>
 <20200818214146.GA3196105@rani.riverdale.lan>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <df6c1da4-b910-ecb8-0de2-6156dd651be6@rasmusvillemoes.dk>
Date:   Thu, 20 Aug 2020 16:56:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818214146.GA3196105@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2020 23.41, Arvind Sankar wrote:
> On Tue, Aug 18, 2020 at 01:58:51PM -0700, Nick Desaulniers wrote:
>> On Tue, Aug 18, 2020 at 1:27 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>>
>>> On Tue, Aug 18, 2020 at 1:24 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>>>>
>>>> On Tue, Aug 18, 2020 at 12:13:22PM -0700, Linus Torvalds wrote:
>>>>> On Tue, Aug 18, 2020 at 12:03 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>>>>>
>>>>>> I'm not saying "change the semantics", nor am I saying that playing
>>>>>> whack-a-mole *for a limited time* is unreasonable. But I would like to go back
>>>>>> to the compiler authors and get them to implement such a #pragma: "this
>>>>>> freestanding implementation *does* support *this specific library function*,
>>>>>> and you are free to call it."
>>>>>
>>>>> I'd much rather just see the library functions as builtins that always
>>>>> do the right thing (with the fallback being "just call the standard
>>>>> function").
>>>>>
>>>>> IOW, there's nothing wrong with -ffreestanding if you then also have
>>>>> __builtin_memcpy() etc, and they do the sane compiler optimizations
>>>>> for memcpy().
>>>>>
>>>>> What we want to avoid is the compiler making *assumptions* based on
>>>>> standard names, because we may implement some of those things
>>>>> differently.
>>>>>
>>>>
>>>> -ffreestanding as it stands today does have __builtin_memcpy and
>>>> friends. But you need to then use #define memcpy __builtin_memcpy etc,
>>>> which is messy and also doesn't fully express what you want. #pragma, or
>>>> even just allowing -fbuiltin-foo options would be useful.
>>
>> I do really like the idea of -fbuiltin-foo.  For example, you'd specify:
>>
>> -ffreestanding -fbuiltin-bcmp
>>
>> as an example. `-ffreestanding` would opt you out of ALL libcall
>> optimizations, `-fbuiltin-bcmp` would then opt you back in to
>> transforms that produce bcmp.  That way you're informing the compiler
>> more precisely about the environment you'd be targeting.  It feels
>> symmetric to existing `-fno-` flags (clang makes -f vs -fno- pretty
>> easy when there is such symmetry).  And it's already convention that
>> if you specify multiple conflicting compiler flags, then the latter
>> one specified "wins."  In that sense, turning back on specific
>> libcalls after disabling the rest looks more ergonomic to me.
>>
>> Maybe Eli or David have thoughts on why that may or may not be as
>> ergonomic or possible to implement as I imagine?
>>
> 
> Note that -fno-builtin-foo seems to mean slightly different things in
> clang and gcc. From experimentation, clang will neither optimize a call
> to foo, nor perform an optimization that introduces a call to foo. gcc
> will avoid optimizing calls to foo, but it can still generate new calls
> to foo while optimizing something else. Which means that
> -fno-builtin-{bcmp,stpcpy} only solves things for clang, not gcc. It's
> just that gcc doesn't seem to have implemented those optimizations.
> 

I think it's more than that. I've always read gcc's documentation

'-fno-builtin'
'-fno-builtin-FUNCTION'
     Don't recognize built-in functions that do not begin with
     '__builtin_' as prefix. ...

     GCC normally generates special code to handle certain built-in
     functions more efficiently; for instance, calls to 'alloca' may
     become single instructions which adjust the stack directly, and
     calls to 'memcpy' may become inline copy loops.
     ...

to mean exactly that observed above and nothing more, i.e. that
-fno-builtin-foo merely means that gcc stops treating a call of a
function named foo to mean a call to a function implementing the
standard function by that name (and hence allows it to e.g. replace a
memcpy(d, s, 1) by byte load+store). It does not mean to prevent
emitting calls to foo, and I don't think it ever will - it's a bit sad
that clang has chosen to interpret these options differently.

Thinking out load, it would be useful if both compilers grew

  -fassume-provided-std-foo

and

  -fno-assume-provided-std-foo

options to tell the compiler that a function named foo with standard
semantics can be assumed (or not) to be provided by the execution
environment; i.e. one half of what -f(no-)builtin-foo apparently does
for clang currently.

And yes, the positive -fbuiltin-foo would also be quite useful in order
to get the compiler to recognize a few important functions (memcpy,
memcmp) while using -ffreestanding (or just plain -fno-builtin) to tell
it to avoid assuming anything about most std functions - I've worked on
a VxWorks target where snprintf() didn't have the correct "return what
would be written" semantics but rather behaved like the kernel's
non-standard scnprintf(), and who knows what other odd quirks that libc had.

Rasmus
