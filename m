Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EBB20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgFHRck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:32:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgFHRck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:32:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0C724AD2C;
        Mon,  8 Jun 2020 17:32:42 +0000 (UTC)
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, ndesaulniers@google.com
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
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <87213fd1-950d-c2d5-4aa0-2f53ea3b505c@suse.cz>
Date:   Mon, 8 Jun 2020 19:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192353.GA180529@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 9:23 PM, Marco Elver wrote:
> 
> 
> On Wed, 03 Jun 2020, Borislav Petkov wrote:
> 
>> On Thu, May 14, 2020 at 12:05:38PM +0100, Will Deacon wrote:
>>> Talking off-list, Clang >= 7 is pretty reasonable wrt inlining decisions
>>> and the behaviour for __always_inline is:
>>>
>>>    * An __always_inline function inlined into a __no_sanitize function is
>>>      not instrumented
>>>    * An __always_inline function inlined into an instrumented function is
>>>      instrumented
>>>    * You can't mark a function as both __always_inline __no_sanitize, because
>>>      __no_sanitize functions are never inlined
>>>
>>> GCC, on the other hand, may still inline __no_sanitize functions and then
>>> subsequently instrument them.
>>
>> Yeah, about that: I've been looking for a way to trigger this so that
>> I can show preprocessed source to gcc people. So do you guys have a
>> .config or somesuch I can try?
> 
> For example take this:
> 
> 	int x;
> 
> 	static inline __attribute__((no_sanitize_thread)) void do_not_sanitize(void) {
> 	  x++;
> 	}
> 
> 	void sanitize_this(void) {
> 	  do_not_sanitize();
> 	}
> 
> Then
> 
> 	gcc-10 -O3 -fsanitize=thread -o example.o -c example.c
> 	objdump -D example.o

Hello.

Thank you for the example. It seems to me that Clang does not inline a no_sanitize_* function
into one which is instrumented. Is it a documented behavior ([1] doesn't mention that)?
If so, we can do the same in GCC.

Thanks,
Martin

[1] https://clang.llvm.org/docs/AttributeReference.html#no-sanitize

> 
> will show that do_not_sanitize() was inlined into sanitize_this() and is
> instrumented. (With Clang this doesn't happen.)
> 
> Hope this is enough.
> 
> Thanks,
> -- Marco
> 

