Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210B4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA91520748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586294579;
	bh=GrYkIAts1kYPy4lWMwWZ1lizEaRk+chot1r7UHuADHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LeXzKMsJnWzzZ0nn7BrU2PsWXsZSiWAzI9gb0PQnfqxdSKEvGmplgaSGCHmGkTqbp
	 VpZAFawf4rvUxpbmb+5/wnPUvfB+rIr5hNI3KnpzjGa12nqS1rOosOq79XWB93SME2
	 +CPCyta8zjyb9pCvzSumoeqlWJOEpgB4VKqDo+IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDGVW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:22:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45533 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGVW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:22:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so5331729ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqAA90EFEqaZqtfJsahs6rAmiP9w+6pABhPEUrk2J0s=;
        b=cWtyAfRJ6HZ9whZ7T1OwTqUkHj67UHyQLHNktG1URy3jMW58GkW80jxJjlj8gB7GhE
         3F0b04BHhGAUviItNAlVtNpm1kMC4wyjt5JtQfw/V+AcyE9EB5lvlfGHC0oM8Tdjg/zB
         YwojkZl7/nVdBy5im39XCep/6nxy8E2TkGYTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqAA90EFEqaZqtfJsahs6rAmiP9w+6pABhPEUrk2J0s=;
        b=eQNlqbQSKmPICsgqEUA/QMd/rUf7BhAvTqFgLazIaEmoAEFYZJr9cUrAdPgTTyb13c
         thG81NqDQbAaoOWnnyPFOLSc3cHEsoULN6UXBQVs8I3ZznEcCQXdoYTfeomBS/WemYl+
         lG+gElcN6QHgUrtW5KZ+I9MecDwvlRw+8XWshGBZo0qSB8GXx7Q41nnC2qax/y6SO8bT
         QZmVwHhICIzkVSeShtwhsaH1On5YZiRYUhuXp8H/ucasZGkKYEG1dschr3nyjalQC/Xl
         l6w9D0bfPVqCQvpHZ9sPW1A1kfXw8USFr8URIzzntkGsEcNCaCk+d39uLJH80IiFbWFc
         PgLg==
X-Gm-Message-State: AGi0PuYfnMd4qs82NuePrvr8QVPKbwuuPrqBEcA0u4bcqLJzkzqJhzO7
        co6X0PVSoWWnREvBYceUGbk7pVVTsmk=
X-Google-Smtp-Source: APiQypKoQSJX6Q53O+ni/+YFBroxP19mMv3njV0m20IVoCFV3vLaO20ucf2WfeSa/oyKprezhEBJug==
X-Received: by 2002:a2e:8746:: with SMTP id q6mr2831167ljj.13.1586294572377;
        Tue, 07 Apr 2020 14:22:52 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id x23sm12529072ljd.23.2020.04.07.14.22.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 14:22:51 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q19so5341413ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:22:50 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr2888317ljp.204.1586294570185;
 Tue, 07 Apr 2020 14:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
 <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
 <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com> <699292.1586294051@warthog.procyon.org.uk>
In-Reply-To: <699292.1586294051@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 14:22:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwaNvyd1q=h0nUQio9byojpxufGkOiVfAh10woRs8KSA@mail.gmail.com>
Message-ID: <CAHk-=whwaNvyd1q=h0nUQio9byojpxufGkOiVfAh10woRs8KSA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     David Howells <dhowells@redhat.com>
Cc:     Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 2:14 PM David Howells <dhowells@redhat.com> wrote:
>
> It might be worth asking the compiler folks to give us an __attribute__ for
> that - even if they don't do anything with it immediately.  So we might have
> something like:
>
>         void free(const volatile void *ptr) __attribute__((free(1)));

Yeah, that sounds sane.

> There are some for allocation functions, some of which we use, though I'm not
> sure we do so as consistently as we should (should inline functions like
> kcalloc() have them, for example?).

I think that gcc supports a "malloc" attribute, but it's only used for
alias analysis optimizations, afaik (ie it says that the pointer the
function returns cannot alias anything else).

So we do have that "__malloc" thing, but I'm not sure how much it
actually matters.

And adding it to inline functions shouldn't be _wrong_, but it
shouldn't matter either, since I think the alias analysis would work
regardless.

I wonder how much of a code generation difference it makes. I suspect
not a lot, but maybe I'd be surprsied.

But yes, having the free attribute would be consistent (even if the
syntax for it might be as you suggest, kind of like the __printf()
attribute works). Even if it wasn't initially used for anything it
wouldn't hurt, and maybe some day it would improve warnings (and allow
the compiler to do the dead store elimination that started this whole
long set of threads in the first place..)

            Linus
