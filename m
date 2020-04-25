Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7D5C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 11:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303EA20767
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 11:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDYLKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:10:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgDYLKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 07:10:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3D3BAC24;
        Sat, 25 Apr 2020 11:09:56 +0000 (UTC)
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
To:     Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>, boris.ostrovsky@oracle.com
References: <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic> <20200423161126.GD26021@zn.tnic>
 <20200425014657.GA2191784@rani.riverdale.lan>
 <20200425085759.GA24294@zn.tnic>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <1fbcc917-420a-10a6-26a6-047b0b1c4783@suse.com>
Date:   Sat, 25 Apr 2020 13:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200425085759.GA24294@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.20 10:57, Borislav Petkov wrote:
> On Fri, Apr 24, 2020 at 09:46:57PM -0400, Arvind Sankar wrote:
>> The comment above boot_init_stack_canary's definition should be updated
>> to note that it needs to be called from a function that, in addition to
>> not returning, either has stackprotector disabled or avoids ending in a
>> tail call.
> 
> How's that?
> 
> diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
> index 91e29b6a86a5..237a54f60d6b 100644
> --- a/arch/x86/include/asm/stackprotector.h
> +++ b/arch/x86/include/asm/stackprotector.h
> @@ -55,8 +55,12 @@
>   /*
>    * Initialize the stackprotector canary value.
>    *
> - * NOTE: this must only be called from functions that never return,
> - * and it must always be inlined.
> + * NOTE: this must only be called from functions that never return, it must
> + * always be inlined and it should be called from a compilation unit for
> + * which stack protector is disabled.
> + *
> + * Alternatively, the caller should not end with a function call which gets
> + * tail-call optimized as that would lead to checking a modified canary value.
>    */
>   static __always_inline void boot_init_stack_canary(void)
>   {
> 
>> There are also other calls that likely need to be fixed as well -- in
>> init/main.c, arch/x86/xen/smp_pv.c, and there is a powerpc version of
>> start_secondary in arch/powerpc/kernel/smp.c which may also be affected.
> 
> Yes, there was an attempt to fix former:
> 
> https://lkml.kernel.org/r/20200413123535.10884-1-frederic.pierret@qubes-os.org
> 
> I probably should point the folks to this thread. CCed.
> 
> Boris O, Jürgen, I'm guessing I should fix cpu_bringup_and_idle() too,
> see:
> 
> https://lkml.kernel.org/r/20200423161126.GD26021@zn.tnic
> 
> or do you prefer a separate patch?

I'm fine with you including it in your patch.


Juergen
