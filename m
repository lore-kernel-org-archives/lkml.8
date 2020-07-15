Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCEDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769BD206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="C2w+xDy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGOUyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOUya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:54:30 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E08C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:54:30 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w34so2982869qte.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IRr7BOcKGQDdx5/akVj041tdKlulMT6T+KrOEULXvD8=;
        b=C2w+xDy21/ZDkcBgzJYtmc7MfMmlRZBjahk+aQzS+n6EQ5yxvhrAJyUh0XuwPh+gs/
         QICD396IjoK2jOIdttqNsw9jZI6hvZu9znYenowYkJF2x40srsdQOTiy2PZprFV+wqzw
         MsB887YEfRqF2B+YQcc/vxlHUknWwkzg2tkeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IRr7BOcKGQDdx5/akVj041tdKlulMT6T+KrOEULXvD8=;
        b=gA+Xd7Y4SbS07FaH7jYfHMygfy87SH7qLdqSNZG44YyRiZj06tj6oIiceksY1ZKgaF
         QdSWECT3auVOkCTKAAMIOa+Qs0MYULkvsDnLsOQQ9xOPBoGf5VdDzCmN4v8+T8tQ4U0O
         nnJE5aCBDQCQK+aoUJ7/F0Faj5iTu4hM0zqEvUh8jRXQP2YFH4WjW5b5nXfHUWetaosg
         9yPmIQYWrlYO7E3Ncqu5cUIqTm4txNOBkkUGVeapISgZNM1jI2XeoSVDOsaV+F1Yjdlt
         kQb8ZwijmF1t1lI3oJar//ozUS49F3ZfPeV/3BilsGDEHYDcWrRZc5SZrpoGxNOXNUMH
         JMlA==
X-Gm-Message-State: AOAM531yTW6KfttYtEOTwVwlHiCFZe8P8L7ORB0CKCYQsrLUySotpFhy
        /TPpU2sUmtyF8IVHtAuTVlLdWw==
X-Google-Smtp-Source: ABdhPJxKvPkvDN60ehduEY+fmfz+lcdsimrPubxVbP0CVKzfApwTD1RVVolJZ1uVyaFZBZh4b/Egtg==
X-Received: by 2002:ac8:32fb:: with SMTP id a56mr1824876qtb.158.1594846469196;
        Wed, 15 Jul 2020 13:54:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n64sm3581471qke.77.2020.07.15.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:54:28 -0700 (PDT)
Date:   Wed, 15 Jul 2020 16:54:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
Message-ID: <20200715205428.GA201569@google.com>
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Jul 15, 2020 at 11:36:59AM -0700, Linus Torvalds wrote:
> On Wed, Jul 15, 2020 at 6:50 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > mremap(2) does not allow source and destination regions to overlap, but
> > shift_arg_pages() calls move_page_tables() directly and in this case the
> > source and destination overlap often. It
> 
> Actually, before we do this patch (which I think is a good idea), I'd
> like Naresh to test the attached patch.
> 
> And Kirill, Joel, mind looking it over too.
> 
> IT IS ENTIRELY UNTESTED.

Seems a clever idea and was something I wanted as well. Thanks. Some comments
below:

> But I hope the concept (and the code) is fairly obvious: it makes
> move_page_tables() try to align the range to be moved, if possible.
> 
> That *should* actually remove the warning that Naresh sees, for the
> simple reason that now the PMD moving case will *always* trigger when
> the stack movement is PMD-aligned, and you never see the "first do a
> few small pages, then do the PMD optimization" case.
> 
> And that should mean that we don't ever hit the "oh, we already have a
> target pmd" thing, because the "move the whole pmd" case will clear
> the ones it has already taken care of, and you never have that "oh,
> there's an empty pmd where the pages were moved away one by one".
> 
> And that means that for this case, it's _ok_ to overlap (as long as we
> copy downwards).
> 
> What do you think?

I might not have fully understand the code but I get the basic idea it is
aiming for. Basically you want to align the cases where the address space is
free from both sides so that you can trigger the PMD-moving optimization.

Regarding the ADDR_AFTER_NEXT checks, shouldn't you check for:

	if (ADDR_AFTER_NEXT(ALIGN(*old_addr + *len, PMD_SIZE), old))
		return;

and for the len calculation, I did not follow what you did, but I think you
meant something like this? Does the following reduce to what you did? At
least this is a bit more readable I think:

	*len += (ALIGN(*new_addr + *len, PMD_SIZE) - (*new_addr + *len));

	which reduces to:

	*len = ALIGN(*new_addr + *len, PMD_SIZE) - *new_addr;

Also you did "len +=", it should be "*len +=" in this function.

In try_to_align_start(), everything looks correct to me.

> Ok, so I could easily have screwed up the patch, even if it's
> conceptually fairly simple. The details are small, but they needed
> some care. The thing _looks_ fine to me, both on a source level and
> when looking at the generated code, and I made sure to try to use a
> lot of small helper functions and couple of helper macros to make each
> individual piece look clear and obvious.
> 
> But obviously a single "Oh, that test is the wrong way around", or a
> missing mask inversion, or whatever, could completely break the code.
> So no guarantees, but it looks fairly straightforward to me.
> 
> Naresh - this patch does *NOT* make sense to test together with
> Kirill's (or Joel's) patch that says "don't do the PMD optimization at
> all for overlapping cases". Those patches will hide the issue, and
> make the new code only work for mremap(), not for the initial stack
> setup that caused the original warning.
> 
> Joel - I think this patch makes sense _regardless_ of the special
> execve() usage case, in that it extends your "let's just copy things
> at a whole PMD level" logic to even the case where the beginning
> wasn't PMD-aligned (or the length wasn't sufficient).
> 
> Obviously it only triggers when the source and destination are
> mutually aligned, and if there are no other vma's around those
> first/last PMD entries. Which might mean that it almost never triggers
> in practice, but looking at the generated code, it sure looks like
> it's cheap enough to test.

Oh ok, we had some requirements in my old job about moving large address
spaces which were aligned so it triggered a lot in those. Also folks in the
ChromeOS team tell me it is helping them.

> Didn't you have some test-cases for your pmd optimized movement cases,
> at least for timing?

Yes, I had a simple mremap() test which was moving a 1GB map and measuring
performance. Once I get a chance I can try it out with this optimization and
trigger it with unaligned addresses as well.

thanks,

 - Joel

