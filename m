Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B250EC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF712082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgDVOQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:16:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVOQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:16:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83D49ACF1;
        Wed, 22 Apr 2020 14:16:54 +0000 (UTC)
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
To:     Jakub Jelinek <jakub@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20200417085859.GU2424@tucnak> <20200417090909.GC7322@zn.tnic>
 <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <20200422114007.GC20730@hirez.programming.kicks-ass.net>
 <20200422134924.GB26846@zn.tnic> <20200422135531.GM2424@tucnak>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <20a91f2e-0f25-8dba-e441-3233cc1ef398@suse.cz>
Date:   Wed, 22 Apr 2020 16:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422135531.GM2424@tucnak>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 3:55 PM, Jakub Jelinek wrote:
> On Wed, Apr 22, 2020 at 03:49:24PM +0200, Borislav Petkov wrote:
>> On Wed, Apr 22, 2020 at 01:40:07PM +0200, Peter Zijlstra wrote:
>>> You haz a whitespace issue there.
>>
>> Fixed.
>>
>>> Also, can we get this in writing, signed in blood, from the various
>>> compiler teams ;-)
>>
>> Yah, I wouldn't want to go fix this again in gcc11 or so. That's why I
>> wanted the explicit marking but let's try this first - it is too simple
>> to pass over without having tested it.
> 
> If virtual blood is enough, AFAIK GCC has never tried to accept volatile
> inline asm (asm ("") is such; non-volatile asm such as int x; asm ("" : "=r" (x));
> could be e.g. dead code eliminated) in the statements between function call and
> return when deciding about what function can be tail-called or can use
> tail-recursion and there are no plans to change that.
> 
> 	Jakub
> 
> 
> 

One possible solution can be usage of a GCC pragma that will disable the tail-call optimization:

$ cat tail.c
int foo(int);

#pragma GCC push_options
#pragma GCC optimize("-fno-optimize-sibling-calls")
int baz(int a)
{
   int r = foo(a);
   return r;
}
#pragma GCC pop_options

I'm not sure if clang provides something similar (the -foptimize-sibling-calls option
is supported as well).

And as I talked to Boris, I would recommend to come up with a "configure" check
that a compiler does not optimize the key code sequence:

$ cat asm-detect.c
int foo(int a);
int bar(int a)
{
   int r = foo(a);
   asm ("");
   return r;
}

$ gcc -O2 -c asm-detect.c -S -o/dev/stdout | grep jmp
[no output]

Martin
