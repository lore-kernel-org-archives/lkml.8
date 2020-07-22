Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F49C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1784A20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQOOnqg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgGVSH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgGVSH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:07:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ABCC0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:07:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n2so2349939edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdyJ3zCjPfmLPOxt0EpbJoGI3z0Dst2ftnMjMBs721s=;
        b=VQOOnqg73U7x3eQrsDW5P6NHQpsRTrBV6mDqQ35Y7KbR5dxMVHVEhlOpBKgbC4YauI
         hKoPoQogS3yVaVz+cHKlmtCp41T1+KI57s1dNmREFvPgWO9LQa1Md2XUbvuoYp7xcDOD
         uJkxpr/ugST6O4YCQmPPrAz4f1LYvrnmu4TBkKKzuhd7zdw95+t6HeiJXKW9A6c8pPUy
         XRNlbkclQcCrxbPIAZrisC31UWn7W4GKg1hOvR+OFZqdAhucXRldSHGUkEO+NbUB9S9S
         XaVu2nmp3aY/+8g9/c/Kskh84nH4FtiosOyHuJCZKQY+DsufHyQlBrv/tBuyO6TpzdFa
         UM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdyJ3zCjPfmLPOxt0EpbJoGI3z0Dst2ftnMjMBs721s=;
        b=A5kAOvdfkgcJKOs61/NYQlsOPSr4mO0+Vz9Seo9mVqmIy/FOtF+nrjMpuzDqln06qA
         nHn4CGO7JNmBsgiYNrNm+cwjOv8dIfZ00dDg7jU1bp7sUBp104QhOdqNFiE0+pKv1sFp
         hZUk4luo9eLCsytass0Tyi013WSYhXu9vGIKOirQ0O+f69ErgiZXF2/BJENDshg5WKzh
         iygzkKUTyNKGze5XIA9M8UKCRg8nWYe2GKqXXr5WL1mOg9folQT5062mB4ZBIzp30akZ
         2HlATfjWr++CDUWY8GCdxcQxD6a0f8tcwxswwTcmKgeTHnhOBipmUKSVOW9N0RBL+tFr
         Nw0w==
X-Gm-Message-State: AOAM531qj4KaOed6yOFReNmYi+ZMzR4DQNDKCElM1ZXJ/i1xa6Asp2Kr
        UMjK835vq0Zd5OwC+UJsk9OpTxRl5oguthGweCS1pw==
X-Google-Smtp-Source: ABdhPJwcnL9bpNsR0ioOLFXQ9M3j8q0lz48Fhhhje9z+wnEe4/R/foPMYkXV+6IoYiAKnIEt8CMey3jrAzyf6UdUmaI=
X-Received: by 2002:a05:6402:542:: with SMTP id i2mr682149edx.318.1595441245286;
 Wed, 22 Jul 2020 11:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com> <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com> <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com> <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com> <20200626112931.GF4817@hirez.programming.kicks-ass.net>
 <CABCJKucSM7gqWmUtiBPbr208wB0pc25afJXc6yBQzJDZf4LSWA@mail.gmail.com>
 <20200717133645.7816c0b6@oasis.local.home> <CABCJKuda0AFCZ-1J2NTLc-M0xax007a9u-fzOoxmU2z60jvzbA@mail.gmail.com>
 <20200717140545.6f008208@oasis.local.home> <CABCJKucDrS9wNZLjtmN5qMbZBTHLvB1Z7WqTwT3b11-K4kNcyg@mail.gmail.com>
 <20200722135829.7ca6fbc5@oasis.local.home>
In-Reply-To: <20200722135829.7ca6fbc5@oasis.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 22 Jul 2020 11:07:13 -0700
Message-ID: <CABCJKucn5o+PgMnKwHOGRnhTdVk9Dnd2QZwy54wXYwQYNUNjBw@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:58 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 20 Jul 2020 09:52:37 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > > Does x86 have a way to differentiate between the two that record mcount
> > > can check?
> >
> > I'm not sure if looking at the relocation alone is sufficient on x86,
> > we might also have to decode the instruction, which is what objtool
> > does. Did you have any thoughts on Peter's patch, or my initial
> > suggestion, which adds a __nomcount attribute to affected functions?
>
> There's a lot of code in this thread. Can you give me the message-id of
> Peter's patch in question.

Sure, I was referring to the objtool patch in this message:

https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/

Sami
