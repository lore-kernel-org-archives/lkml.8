Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C3AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D30E2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mifopRg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgFDWiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgFDWiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:38:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 15:38:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so1736109pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ORpTC9E5uWw4nJVLuPu5+95Od037mXPJYxD/DvOmRCg=;
        b=mifopRg5zwZSoWPB0rqPWzu76NS00gnxaStDOF9gaTZQ2HjwYDWPZXIuQvcAxJVBFL
         rfHaM4mLRn8BmJzFqZyCrXPFpf4viP1YWWiMuIxE4PgryIL9eY7DMSQuTUn+iHBTb9JY
         ZWXQDvrN6PvFEHp2vL4NEJXgdh53vIseRZfj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ORpTC9E5uWw4nJVLuPu5+95Od037mXPJYxD/DvOmRCg=;
        b=P8xpqtCfyOEjYnGXh/AaTGc/qZOGP9IQl1i12TozymuDDDTlowcP3hRdlgKEUJUfHn
         KK3hUNp+Co396gXHPSm9y5bCV23bE6xJHQ3tQl7aozAQzOcyphly2vkNZiSlnIt6goS0
         l+Tuc4H7B9NFkvIfYAhqughynAczaaGF9TSuSaRjCXyT7uerdnYgEaT7F3l4/cGhyHXs
         TJyH9wD+WmMZnBqpZCpXKGZH0pOaB5bLeqBMK/3x41ScN9vDHhVay6u4A9vN0svSf/vx
         vhOb3ca4IAG+hI6+S0kI41sP+8xFlLKHp/3ebQnO5KVELNqjrq0xHZo1Bqh+qG/8rErU
         11/Q==
X-Gm-Message-State: AOAM533bjiKsSaR8W0V9WHBA3A6RZ3YJyORKToMVMx9eaOihw/CgrYLs
        fo93JS2abRxtBK6jQoJfEqbOxQ==
X-Google-Smtp-Source: ABdhPJxoRyg7vN0rXVhDIZ+/Hr+4ozPGYOxwW0LAyLqSrArkNfAKIlCPsrx3rpTTcFtqmNba4cPDOw==
X-Received: by 2002:a17:90a:b781:: with SMTP id m1mr7817051pjr.14.1591310280580;
        Thu, 04 Jun 2020 15:38:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q201sm5334685pfq.40.2020.06.04.15.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 15:37:59 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:37:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 7/9] x86: Add support for function granular KASLR
Message-ID: <202006041525.CB0293F898@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
 <20200521165641.15940-8-kristen@linux.intel.com>
 <202005211301.4853672E2@keescook>
 <7d95c165766be97843f11d2695d1538f94ceb1d4.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d95c165766be97843f11d2695d1538f94ceb1d4.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:27:24AM -0700, Kristen Carlson Accardi wrote:
> On Thu, 2020-05-21 at 14:08 -0700, Kees Cook wrote:
> > On Thu, May 21, 2020 at 09:56:38AM -0700, Kristen Carlson Accardi
> > wrote:
> > > [...]
> > > +/*
> > > + * This is an array of pointers to sections headers for randomized
> > > sections
> > > + */
> > > +Elf64_Shdr **sections;
> > 
> > Given the creation of the Elf_Shdr etc macros in the header, should
> > all
> > of the Elf64 things in here be updated to use the size-agnostic
> > macros?
> > (Is anyone actually going to run a 32-bit kernel with fgkaslr some
> > day?)
> 
> I suppose it's not impossible, just ... not useful. I will make the
> update.

Yeah. I figure it might just look cleaner? Or, I guess, drop the other
macros? I guess I wasn't sure why those macros got touched and then
didn't get used.

> > > [...]
> > > +	/*
> > > +	 * we are going to need to regenerate the markers table, which is a
> > > +	 * table of offsets into the compressed stream every 256 symbols.
> > > +	 * this code copied almost directly from scripts/kallsyms.c
> > > +	 */
> > 
> > Can any of this kallsyms sorting code be reasonably reused instead
> > of copy/pasting? Or is this mostly novel in that it's taking the
> > output
> > of that earlier sort, which isn't the input format scripts/kallsyms.c
> > uses?
> 
> No - I cut out only code blocks from scripts/kallsyms.c, but there was
> no neat way to reuse entire functions without majorly refactoring a lot
> of stuff in scripts/kallsyms.c

Hmm. I wonder if there might be a way to carve out what you need into
lib/ and then #include it as a separate compilation unit? I'm always
worried about cut/pasted code getting out of sync.

> > > [...]
> > > +#include "../../../../lib/extable.c"
> > 
> > Now that the earlier linking glitches have been sorted out, I wonder if
> > it might be nicer to add this as a separate compilation unit, similar to
> > how early_serial_console.c is done? (Or, I guess, more specifically, why
> > can't this be in utils.c?)
> 
> The problem with putting this in utils.c was because there was an
> inline function (static) that I use that is defined in extable.c
> (ex_to_insn). If I move this to utils.c I'm not sure how to keep re-
> using this inline function without modifying it with a define like
> STATIC. I thought it was cleaner to just leave it alone and do it this
> way.

Hm, I see. I guess if this becomes fragile in the future, the special
inlines can be moved to lib/extable.h and then things can be carved out
into a separate compilation unit.

> > > [...]
> > > +		if (!strcmp(sname, ".text")) {
> > > +			text = s;
> > > +			continue;
> > > +		}
> > 
> > Check text is still NULL here?
> > 
> > Also, why the continue? This means the section isn't included in the
> > sections[] array? (Obviously things still work, but I don't
> > understand
> > why.)
> 
> I don't include .text in the sections[] array because sections[] is
> only for sections to be randomized, and we don't randomize .text.

Yeah, I got myself confused there originally. I actuallyed realized my
mistake on this later when I was explaining how FGKASLR worked in the
thread with tglx. :)

> > > +
> > > +		if (!strcmp(sname, ".data..percpu")) {
> > > +			/* get start addr for later */
> > > +			percpu = s;
> > 
> > Similar, check percpu is still NULL here?
> > 
> > Also, is a "continue" intended here? (This is kind of the reverse of
> > the "continue" question above.) I think you get the same result
> > during
> > the next "if", but I was expecting this block to look like the .text
> > test above.
> 
> You are right, I could have put a continue here and saved the next
> compare.

Cool; yeah, it was just a "wait, is that right?" when looking at it.

> > > diff --git a/arch/x86/boot/compressed/misc.c
> > > b/arch/x86/boot/compressed/misc.c
> > > index 9652d5c2afda..5f08922fd12a 100644
> > > --- a/arch/x86/boot/compressed/misc.c
> > > +++ b/arch/x86/boot/compressed/misc.c
> > > @@ -26,9 +26,6 @@
> > >   * it is not safe to place pointers in static structures.
> > >   */
> > >  
> > > -/* Macros used by the included decompressor code below. */
> > > -#define STATIC		static
> > 
> > Can you split the STATIC macro rearrangement out into a separate
> > patch?
> > I think it deserves a dedicated commit log to explain why it's
> > changing
> > the way it is (i.e. we end up with "STATIC" no longer meaning
> > "static"
> > in misc.c now
> 
> This change was made to fix the issue of having malloc_ptr be declared
> locally rather than globally - (that weird problem I was having that
> made it so I had to #include all the .c files until I figured out what
> the issue was. If I separate out the change, then I feel like the
> commit doesn't make sense out of this context. What if I put a big
> comment in misc.h?

I think it's fine to split it out with a commit log describing what it's
_about_ to fix, "without this, any other code using misc.h ..." and/or
"in the next patches we'll need this because ..."

> > > [...]
> > > +		(void)adjust_address(&extended);
> > 
> > I don't think "(void)" needed here?
> 
> I can delete it - it's not "needed", but was done to show an
> intentional discard of the return value from adjust_address.

The code style in the kernel seems to be to not include these (since
it's a call-site override) and instead use __must_check on the function
when the results MUST be checked. This way, all call-sites suddenly
light up when the attribute gets added and we don't end up with places
that might get masked, etc.

> The rest of your feedback incorporated into v3.

Awesome!

-- 
Kees Cook
