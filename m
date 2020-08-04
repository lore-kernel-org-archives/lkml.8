Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB1AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330F522B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2HNFSUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHDTXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHDTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:23:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C10C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 12:23:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so12884727pfx.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XcApH6pXVneHRDaMD0s65HFZFtwHnxoogMRpFUr7Ml0=;
        b=C2HNFSUjfYWVZYVW7UAHQ4O0Q29zM909ktJpPrg4zhTWwCUMe+JpgFmQV+G/Jz0G5z
         k4afVF1pIAixkJ7iqyBemSCI/Aq97hImIQsHe+gpD+qWat4NoUK0Q53GJszvl61fwDvv
         u65u06aZpsk4cyucbj84tOzS9hk7NML1Cduaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XcApH6pXVneHRDaMD0s65HFZFtwHnxoogMRpFUr7Ml0=;
        b=i2ZR1AwirZWi4y8M9FlKav7sv+kUz/ZIHFbBKkGfWf3S/mQh2irQCDcyOPHVi6+ttH
         b2sl+zxI6J8xni0Li2dQeIheZ3NafnizxAz0+tywWg+swtjl8VVydpLCc/uuvBapM+mv
         fji0vU6I2qc5PbMtjAkyWIMRn045hWjerUxHjQch2TAU0EVoLGJTNsO/JHiD/Q1FcCal
         xUZcsuu1BGv2BONCh54wc22F/fSKxC9ZKn/3CwdG2sbp8n/yAaOVtFWe1ot5JLQw9PKD
         8hxuHZY/u94zRGpfA3rl3pFZYZK4Imv/F+N8xRnUjL9HHNUt5nrOYHkJcHvybWyi/eBV
         awDA==
X-Gm-Message-State: AOAM532NdjPYLIjvUssOp5pUOpSeK1Lxt5v5OHnL96wNo4yLUYbvY33g
        sWwI+2DtJnpQBSvA+hcIT6FQdA==
X-Google-Smtp-Source: ABdhPJwVlxCeJApv9PkXGBGRX4MLzc5+zjpyf7Tyt+iMHLj2zdr6j7GOdMtPTyCjZ/qZfOnDwGB4Kg==
X-Received: by 2002:a63:6e4f:: with SMTP id j76mr4032173pgc.449.1596568985356;
        Tue, 04 Aug 2020 12:23:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id in12sm3416507pjb.29.2020.08.04.12.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 12:23:04 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:23:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC] saturate check_*_overflow() output?
Message-ID: <202008041137.02D231B@keescook>
References: <202008031118.36756FAD04@keescook>
 <f177a821-74a3-e868-81d3-55accfb5b161@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f177a821-74a3-e868-81d3-55accfb5b161@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:11:45AM +0200, Rasmus Villemoes wrote:
> On 03/08/2020 20.29, Kees Cook wrote:
> > Hi,
> > 
> > I wonder if we should explicitly saturate the output of the overflow
> > helpers as a side-effect of overflow detection? 
> 
> Please no.

I'm entirely on the fence about this, so I'm fine with that answer. (And
I see your PS about why -- thanks!)

> 
> (That way the output
> > is never available with a "bad" value, if the caller fails to check the
> > result or forgets that *d was written...) since right now, *d will hold
> > the wrapped value.
> 
> Exactly. I designed the fallback ones so they would have the same
> semantics as when using gcc's __builtin_* - though with the "all
> operands have same type" restriction, since it would be completely
> unwieldy to handle stuff like (s8) + (u64) -> (s32) in macros.

Right -- a totally sane requirement. :)

> 
> > Also, if we enable arithmetic overflow detection sanitizers, we're going
> > to trip over the fallback implementation (since it'll wrap and then do
> > the overflow test in the macro).
> 
> Huh? The fallback code only ever uses unsigned arithmetic, precisely to
> avoid triggering such warnings. Or are you saying there are some
> sanitizers out there which also warn for, say, (~0u) + 1u? Yes,
> detecting overflow/underflow for a (s32)-(s32)->(s32) without relying on
> -fwrapv is a bit messy, but it's done and AFAIK works just fine even
> with UBSAN enabled.

GCC only has a signed overflow sanitizer. Clang has signed and unsigned.
Dealing with -fwrapv is yet another exercise.

And I can solve this differently, too, with a static inline helper that does
basic mul and carries a no-sanitize attribute.

> What we might do, to deal with the "caller fails to check the result",
> is to add a
> 
> static inline bool __must_check must_check_overflow(bool b) { return
> unlikely(b); }
> 
> and wrap all the final "did it overflow" results in that one - perhaps
> also for the __builtin_* cases, I don't know if those are automatically
> equipped with that attribute. [I also don't know if gcc propagates
> likely/unlikely out to the caller, but it shouldn't hurt to have it
> there and might improve code gen if it does.]

(What is the formal name for the ({ ...; return_value; }) C construct?)

Will that work as a macro return value? If so, that's extremely useful.

> PS: Another reason not to saturate is that there are two extreme values,
> and choosing between them makes the code very messy (especially when
> using the __builtins). 5u-10u should saturate to 0u, not UINT_MAX, and
> even for for underflowing a signed computation like INT_MIN + (-7); it
> makes no sense for that to saturate to INT_MAX.

Ah, gotcha.

-- 
Kees Cook
