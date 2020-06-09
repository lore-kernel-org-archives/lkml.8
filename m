Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4544C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36092078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgFILzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:55:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:55612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgFILzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:55:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5588EAAD0;
        Tue,  9 Jun 2020 11:55:42 +0000 (UTC)
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Marco Elver <elver@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
 <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck> <20200603185220.GA20613@zn.tnic>
 <20200603192353.GA180529@google.com>
 <87213fd1-950d-c2d5-4aa0-2f53ea3b505c@suse.cz>
 <CANpmjNNRz5OVKb6PE7K6GjfoGbht_ZhyPkNG9aD+KjNDzK7hGg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <cf282ae4-892a-a341-07ce-8ea5db6463b7@suse.cz>
Date:   Tue, 9 Jun 2020 13:55:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNNRz5OVKb6PE7K6GjfoGbht_ZhyPkNG9aD+KjNDzK7hGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 9:56 PM, Marco Elver wrote:
> On Mon, 8 Jun 2020 at 19:32, Martin Liška <mliska@suse.cz> wrote:
>>
>> On 6/3/20 9:23 PM, Marco Elver wrote:
>>>
>>>
>>> On Wed, 03 Jun 2020, Borislav Petkov wrote:
>>>
>>>> On Thu, May 14, 2020 at 12:05:38PM +0100, Will Deacon wrote:
>>>>> Talking off-list, Clang >= 7 is pretty reasonable wrt inlining decisions
>>>>> and the behaviour for __always_inline is:
>>>>>
>>>>>     * An __always_inline function inlined into a __no_sanitize function is
>>>>>       not instrumented
>>>>>     * An __always_inline function inlined into an instrumented function is
>>>>>       instrumented
>>>>>     * You can't mark a function as both __always_inline __no_sanitize, because
>>>>>       __no_sanitize functions are never inlined
>>>>>
>>>>> GCC, on the other hand, may still inline __no_sanitize functions and then
>>>>> subsequently instrument them.
>>>>
>>>> Yeah, about that: I've been looking for a way to trigger this so that
>>>> I can show preprocessed source to gcc people. So do you guys have a
>>>> .config or somesuch I can try?
>>>
>>> For example take this:
>>>
>>>        int x;
>>>
>>>        static inline __attribute__((no_sanitize_thread)) void do_not_sanitize(void) {
>>>          x++;
>>>        }
>>>
>>>        void sanitize_this(void) {
>>>          do_not_sanitize();
>>>        }
>>>
>>> Then
>>>
>>>        gcc-10 -O3 -fsanitize=thread -o example.o -c example.c
>>>        objdump -D example.o
>>
>> Hello.
>>
>> Thank you for the example. It seems to me that Clang does not inline a no_sanitize_* function
>> into one which is instrumented. Is it a documented behavior ([1] doesn't mention that)?
>> If so, we can do the same in GCC.
> 
> It is not explicitly mentioned in [1]. But the contract of
> "no_sanitize" is "that a particular instrumentation or set of
> instrumentations should not be applied". That contract is broken if a
> function is instrumented, however that may happen. It sadly does
> happen with GCC when a function is inlined. Presumably because the
> sanitizer passes for TSAN/ASAN/MSAN run after the optimizer -- this
> definitely can't change. Also because it currently gives us the
> property that __always_inline functions are instrumented according to
> the function they are inlined into (a property we want).
> 
> The easy fix to no_sanitize seems to be to do what Clang does, and
> never inline no_sanitize functions (with or without "inline"
> attribute).  always_inline functions should remain unchanged
> (specifying no_sanitize on an always_inline function is an error).

Hello.

Works for me and I've just sent patch for that:
https://gcc.gnu.org/pipermail/gcc-patches/2020-June/547618.html

> 
> Note this applies to all sanitizers (TSAN/ASAN/MSAN) and their
> no_sanitize attribute that GCC has.

Sure.

> 
> The list of requirements were also summarized in more detail here:
> https://lore.kernel.org/lkml/CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com/
> 
> Hope that makes sense. (I also need to send a v2 for param
> tsan-distinguish-volatile, but haven't gotten around to it yet --
> hopefully soon.

The patch is approved now.

  And then we also need a param
> tsan-instrument-func-entry-exit, which LLVM has for TSAN. One step at
> a time though.)

Yes, please send a patch for it.

Martin

> 
> Thanks,
> -- Marco
> 
> 
>> Thanks,
>> Martin
>>
>> [1] https://clang.llvm.org/docs/AttributeReference.html#no-sanitize
>>
>>>
>>> will show that do_not_sanitize() was inlined into sanitize_this() and is
>>> instrumented. (With Clang this doesn't happen.)
>>>
>>> Hope this is enough.
>>>
>>> Thanks,
>>> -- Marco
>>>
>>

