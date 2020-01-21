Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0E6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC6D20882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="J64FB2M6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAUJQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:16:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36260 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:16:40 -0500
Received: from zn.tnic (p200300EC2F0B0400A009400066D53C66.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:400:a009:4000:66d5:3c66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35D291EC0B7A;
        Tue, 21 Jan 2020 10:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579598199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ANXkNq5QvqcOwrIgPpsFYa4JWlL8ZcM65Bre6rHpQbs=;
        b=J64FB2M6EXfWriRaoAsTY1CSeMYYgdPGWM+OZUYjcNmFBa81Rcrx0MyBQafpYQzunZV8Kl
        5pXsYdJcL2VCJjYhHsEQRTW/IQkOFnMYdo+Nh/qSHUL0EQkmueKW0TCxX78uw82UE+GS0y
        A5PzeCM2IDJ3O9spe8T/6TvqEUUNBK4=
Date:   Tue, 21 Jan 2020 10:16:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Elver <elver@google.com>
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: fix a data race in cpa_inc_4k_install
Message-ID: <20200121091633.GF7808@zn.tnic>
References: <20200121041200.2260-1-cai@lca.pw>
 <20200121072744.GA7808@zn.tnic>
 <CANpmjNPFRCRg9wnFwyJpZVg8Urb9HAdZ++e3xbh1LXPjgAs4kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPFRCRg9wnFwyJpZVg8Urb9HAdZ++e3xbh1LXPjgAs4kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:19:18AM +0100, Marco Elver wrote:
> As I said in my email that you also copied to the message, this is
> just a stats counter. For the general case, I think we reached
> consensus that such accesses should intentionally remain data races:
>   https://lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/T/#u

Yap, I agree with Linus on the legibility aspect.

> Either you can use the data_race() macro, making this
> 'data_race(cpa_4k_install++)' -- this effectively documents the
> intentional data race --
> 
> or just blacklist the entire file by putting
>   KCSAN_SANITIZE_set_memory.o := n
> into the Makefile.
> 
> [ Note that there are 2 more ways to blacklist:
>   - __no_kcsan function attribute, for blacklisting entire functions.
>   - KCSAN_SANITIZE :=n in the Makefile, blacklisting all compilation
> units in the Makefile. ]

Do we have all those official methods how to make KCSAN happy,
documented somewhere?

> I leave it to you what makes more sense. I don't know if there are
> other data races lurking here, since cpa_4k_install is not the only
> stats counter.

In this particular case and if it were me, I'd prefer the __no_kcsan
function attribute because it is kept outside of the function body. But
I can't find __no_kcsan in current tip:

$ git grep __no_kcsan
.h:204:static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
include/linux/compiler.h:215:# define __no_kcsan_or_inline __no_sanitize_thread notrace __maybe_unused
include/linux/compiler.h:216:# define __no_sanitize_or_inline __no_kcsan_or_inline
include/linux/compiler.h:218:# define __no_kcsan_or_inline __always_inline
include/linux/compiler.h:225:static __no_kcsan_or_inline
include/linux/compiler.h:238:static __no_kcsan_or_inline

just this "glued together" thing __no_kcsan_or_inline.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
