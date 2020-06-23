Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD6CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EF02076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZnR5cxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgFWAFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbgFWAFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:05:14 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592CBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:05:13 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u17so14167931qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ci1H/D9yRBKgCOs8CwvIjI+cliPNnLJY+ZZdvthmHrE=;
        b=bZnR5cxj0yVhupPYbVTZrUAGY9nNkIrFLLNIPmuoAvUQ4OHK1sHDJWoL2/SJRkwpMI
         m7Prz2r4QOf6lv5YTO11dfUPOF7IdsLIzGE0bbPrwh0Jqu3SwX4PVrjDyEqr2hhiOwnd
         8ZhWv03Dhkn/QmOUGiO+wbhlnkTVoyz0ypeJQhxVs+38DxTgnv8VKRIqiXcRvjAjFL2B
         PY3M7tpF+3Cje3f8ltlW1ZoL/ABW7ca3n/B+EM/ouagHylGpp4Fnj9zLrVUfXu2HmB2c
         rMGukrOiBhktkdYYOtt74ENxCSvvGBtzzC/JD9jGDjulPVNC8e2L3Rw63kb/ditJ9R4B
         48CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ci1H/D9yRBKgCOs8CwvIjI+cliPNnLJY+ZZdvthmHrE=;
        b=GuXurFBbvig8TUYyZPJThtQX2KyHUX+dL8Mjcdevh8HTyCUiOWXfSlwRQZKGqx40Ht
         cRiU+sApvWMYHpI/dEaIGl6srWU6wusz6VfXVlO8H2vGTQpAsd0jhJUUvdMuMxaXcN6U
         Ygw6mqa+95OWm/UpuB5VexFxANU7T+/zEGsTF3IB8/opgSejUKm9Xp0Lf9mX+10RfdW4
         9mgou6fyBojI8eWXIodUTkRtJeoh4NuU7MYqW+xVi2w33xe8w9k4dgo5OJ11R/O0UIt+
         I1SlomNb0lUJ0RnAvfklsiA+0Pr46oU63ZEV6ptApaDpx/bkId9QKIpmEAveq8/k+AAd
         9QKw==
X-Gm-Message-State: AOAM532cdLE87N9Fh/ZHw4Ty7nYPaB+/P+UbqV0GuchclhCzp0vrnpz0
        XApd2XayW47snLUUmsFSMDw=
X-Google-Smtp-Source: ABdhPJxYjTLo2qfOd0wWwuZ+o+bwZ1DSHNPGSAzwRuX6m2CVu0k46bPOAgySdkGRIdv61Zccfg9lPw==
X-Received: by 2002:ac8:6602:: with SMTP id c2mr11641275qtp.243.1592870712468;
        Mon, 22 Jun 2020 17:05:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p80sm3965934qke.19.2020.06.22.17.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:05:11 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 22 Jun 2020 20:05:10 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <20200623000510.GA3542245@rani.riverdale.lan>
References: <20200622193146.2985288-1-keescook@chromium.org>
 <20200622193146.2985288-4-keescook@chromium.org>
 <20200622225615.GA3511702@rani.riverdale.lan>
 <202006221604.871B13DE3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006221604.871B13DE3@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:07:11PM -0700, Kees Cook wrote:
> On Mon, Jun 22, 2020 at 06:56:15PM -0400, Arvind Sankar wrote:
> > On Mon, Jun 22, 2020 at 12:31:44PM -0700, Kees Cook wrote:
> > > +
> > > +#define add_random_kstack_offset() do {					\
> > > +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> > > +				&randomize_kstack_offset)) {		\
> > > +		u32 offset = this_cpu_read(kstack_offset);		\
> > > +		u8 *ptr = __builtin_alloca(offset & 0x3FF);		\
> > > +		asm volatile("" : "=m"(*ptr));				\
> > > +	}								\
> > > +} while (0)
> > 
> > This feels a little fragile. ptr doesn't escape the block, so the
> > compiler is free to restore the stack immediately after this block. In
> > fact, given that all you've said is that the asm modifies *ptr, but
> > nothing uses that output, the compiler could eliminate the whole thing,
> > no?
> > 
> > https://godbolt.org/z/HT43F5
> > 
> > gcc restores the stack immediately, if no function calls come after it.
> > 
> > clang completely eliminates the code if no function calls come after.
> 
> nothing uses the stack in your example. And adding a barrier (which is
> what the "=m" is, doesn't change it.

Yeah, I realized that that was what's going on. And clang isn't actually
DCE'ing it, it's taking advantage of the red zone since my alloca was
small enough.

But I still don't see anything _stopping_ the compiler from optimizing
this better in the future. The "=m" is not a barrier: it just informs
the compiler that the asm produces an output value in *ptr (and no other
outputs). If nothing can consume that output, it doesn't stop the
compiler from freeing the allocation immediately after the asm instead
of at the end of the function.

I'm talking about something like
	asm volatile("" : : "r" (ptr) : "memory");
which tells the compiler that the asm may change memory arbitrarily.

Here, we don't use it really as a barrier, but to tell the compiler that
the asm may have stashed the value of ptr somewhere in memory, so it's
not free to reuse the space that it pointed to until the function
returns (unless it can prove that nothing accesses memory, not just that
nothing accesses ptr).
