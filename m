Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F40DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B30020722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589457671;
	bh=1R0oD1rKhcYN+Ed55aTvuPeewcTVpQPAYBSDRIGjIV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wax2s+5tgL5jGqvwxBcK/MwHD5SmQEQID/Z5T4fL/0dElLZc0YM7uBY2LgMiU6eXi
	 f2yzCCVzZwbVpoEhkkX8qtUuiFxdsQynPfq8osa19bUePmtEozvlrz/WUkllYLL5Ze
	 uYYQ8Ca12DSDYUIqRDhBaWiA0aqOZ9eSjtwG8ePg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgENMBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgENMBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:01:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203902065D;
        Thu, 14 May 2020 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589457669;
        bh=1R0oD1rKhcYN+Ed55aTvuPeewcTVpQPAYBSDRIGjIV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8ckis++g/UCCCD8zU/9atNzfBa4/gzp+fCSUbSHEC2YQKx1+PwiDi07W3Z1ScOH8
         nEzRCM9nY5lEOIg2No0tz9Tvnu6fMsZiHmZnMFteJ0r6JKQu5SBtZABcohnio91jkz
         chdf0eUnHWBwSxZS2b0lN02Z3edXoDJ5Baa4CJGg=
Date:   Thu, 14 May 2020 13:01:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514120104.GD4280@willie-the-truck>
References: <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net>
 <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
 <20200514112142.GV2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514112142.GV2978@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:21:42PM +0200, Peter Zijlstra wrote:
> On Wed, May 13, 2020 at 03:58:30PM +0200, Marco Elver wrote:
> > On Wed, 13 May 2020 at 15:24, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> > > > So far so good, except: both __no_sanitize_or_inline and
> > > > __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> > > > just doesn't avoid explicit kcsan_check calls, like those in
> > > > READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> > > > just because macros won't be redefined just for __no_sanitize
> > > > functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> > > > access is unchecked.
> > > >
> > > > This will have the expected result:
> > > > __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> > > >
> > > > This will not work as expected:
> > > > __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> > > > races are reported
> > > >
> > > > All this could be fixed if GCC devs would finally take my patch to
> > > > make -fsanitize=thread distinguish volatile [1], but then we have to
> > > > wait ~years for the new compilers to reach us. So please don't hold
> > > > your breath for this one any time soon.
> > > > [1] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html
> > >
> > > Right, but that does not address the much larger issue of the attribute
> > > vs inline tranwreck :/
> > 
> > Could you check if Clang is equally broken for you? I think GCC and
> > Clang have differing behaviour on this. No idea what it takes to fix
> > GCC though.
> 
> So I have some good and some maybe not so good news.
> 
> Given the patch below (on top of tglx's entry-v5-the-rest tag); I did
> find that I could actually build alternative.o for gcc-{8,9,10} and
> indeed clang-10. Any earlier gcc (I tried, 5,6,7) does not build:
> 
> ../arch/x86/include/asm/ptrace.h:126:28: error: inlining failed in call to always_inline ‘user_mode’: function attribute mismatch
> 
> I dumped the poke_int3_handler output using objdump, find the attached
> files.
> 
> It looks like clang-10 doesn't want to turn UBSAN off :/ The GCC files
> look OK, no funny calls in those.
> 
> (the config has KASAN/UBSAN on, it looks like KCSAN and KASAN are
> mutually exclusive)
> 
> ---
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 77c83833d91e..06d8db612efc 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -990,7 +990,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
>  	return 0;
>  }
>  
> -int noinstr poke_int3_handler(struct pt_regs *regs)
> +int noinstr __no_kcsan __no_sanitize_address __no_sanitize_undefined poke_int3_handler(struct pt_regs *regs)
>  {
>  	struct bp_patching_desc *desc;
>  	struct text_poke_loc *tp;
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 2cb42d8bdedc..5e83aada6553 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -15,6 +15,13 @@
>  /* all clang versions usable with the kernel support KASAN ABI version 5 */
>  #define KASAN_ABI_VERSION 5
>  
> +#if __has_feature(undefined_sanitizer)

Hmm, this might want to be __has_feature(undefined_behavior_sanitizer)
(and damn is that hard for a Brit to type out!)

Will
