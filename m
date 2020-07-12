Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2557FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 20:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0401A206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 20:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594586728;
	bh=i6PAArwPhEAM8oTGixt5l7LJKpXsP4uO+gOJ3mXaXCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HkN1Hau6cQgifwPYEDursdjI/3/BSLMnUS9htr6ZgyV1zHdfOSGaScyZIQZX+AIvH
	 lQNzZegmRVSRspFqbI/5xoaYCUtfaxe0aJCvNNMC/iJtsxPCW8tKZzaWLnhl5WVBvY
	 yk4D2JHFbTp/tgHU8kFMW50DHL3GpFv/LoljR4U4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgGLUpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 16:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgGLUpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 16:45:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6528C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:45:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so6786329lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gl2ce7HaAsxftBSvHTYfVjHKxjss9sGSbVqe5rk7avY=;
        b=XdGOzuYCMQf2MS3+YU13NwZGxK6zk35LUeoeXKnD4wgMvpsZR4f1qJiIA3edqzxUOI
         APpAc1SkrdtdB1sVpR+nfZN5esJJgThGv9EAPSKom0yU+I4kNIz9avLhSfpeIbrUgO8N
         jtms4zy/hQnftZTRS7OTXFDNvfm8EZQlT9LGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gl2ce7HaAsxftBSvHTYfVjHKxjss9sGSbVqe5rk7avY=;
        b=iaa2ynjhj/TDAItfxYQnIh4uki3G1M7hx0ehecXJTRCBz9KhUQTkh6VnaNISZ8CoJQ
         Oc2DGYJCpU2c1oJbKfW3Dp4tNrStAsPQuJwVE+G4RDmZ8Q53So48GQLDhUa3Dr1/+a3y
         efjQbNGUcLnHqoZt0Iwts4GnxCMa7hVqiB/dq5L2e31aWTfceLOsEOu3bCftNkT1bhDR
         2sEFKD96IvLsRm9icnerEDWcIcw+RmpP62seVcw3xsXPIzq5y2TwDY1W+ChhuabFB12J
         vLoQ1uBI5ikIBJFN64z3gvE99zBc7rV6BcDZKn58q8G0TRBAq1hxCWMPIyT6G2wrAT3n
         Mb8Q==
X-Gm-Message-State: AOAM531UoHWiNj8g6YOd1krg2kic67i8wZsERkanrfromekmdi+AAEkL
        vExEuIDOBA32lxGp6c0HORtSTV76a2E=
X-Google-Smtp-Source: ABdhPJyob8tu58ZTCEDWp7PpHw3zMZWLpoxSZuA8RYPxU4slD5DF5hO2r3eo3ZNZ0R79gRP44r/EGg==
X-Received: by 2002:a19:ecc:: with SMTP id 195mr50836877lfo.71.1594586713192;
        Sun, 12 Jul 2020 13:45:13 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b16sm3630892ljp.124.2020.07.12.13.45.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 13:45:12 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id q4so13249132lji.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:45:12 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr51001288lfn.30.1594586313808;
 Sun, 12 Jul 2020 13:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <CA+G9fYudT63yZrkWG+mfKHTcn5mP+Ay6hraEQy3G_4jufztrrA@mail.gmail.com>
 <CAHk-=whPrCRZpXYKois-0t8MibxH9KVXn=+-O1YVvOA016fqhw@mail.gmail.com>
 <CA+G9fYusSSrc5G_pZV6Lc-LjjkzQcc3EsLMo+ejSzvyRcMgbqw@mail.gmail.com>
 <CAHk-=wj_Bqu5n3OJCnKiO_gs97fYEpdx6eSacEw2kv9YnnSv_w@mail.gmail.com> <20200712173052.GU12769@casper.infradead.org>
In-Reply-To: <20200712173052.GU12769@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Jul 2020 13:38:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU1LR_H4zV6McCKHKJ0unX1zXLTRXfjSEW2HTDjTce0A@mail.gmail.com>
Message-ID: <CAHk-=wiU1LR_H4zV6McCKHKJ0unX1zXLTRXfjSEW2HTDjTce0A@mail.gmail.com>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        William Kucharski <william.kucharski@oracle.com>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 10:31 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> But I don't see any other way to do it.  It's not like I can put THPs
> in the page cache before fixing the things that won't work.

I agree that sometimes there are bootstrapping issues. Incremental and
explanatory commits are still better than one big commit that
introduces a whole new feature and enables it.

But if at all possible, at least limit the scope of the new feature
first, enabling the simplest possible cases as they become possible so
that there's some incremental testing, and so that bisection can say
"ok, that baseline worked, but then when XYZ happened, things went
sideways".

And even when it's a new feature - if it needs cleanup patches to
other things first, please do that. In fact, please do that as a
completely independent series that goes into a previous kernel release
entirely, so that the cleanup and preparatory patches can be
independently verified by a lot of people who run that _previous_
kernel, so that the baseline of that cleanup phase is something as
stable as possible.

             Linus
