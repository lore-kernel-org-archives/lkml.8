Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B739AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A03C2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597345384;
	bh=TkQlpBvBC4PTUDfHnLBR4jgz1pKbikv68jEDh4VXNVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YhAlnh4rawsSGl/+Qvu5SkJbo1uST6d1om/UHer7VP3BS5cOP2qUyO7h/jKzUKwHQ
	 EUQb2nP6vSC9/240yh4FDo3xjiQlCDgLotWL2R4zjWlyTJ7HOU7gUA+UKBWmhR3Nut
	 tZQVyv5dZUGCUIZjxBKn0RcPW4Vd2pcw8gDU1R1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMTDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:03:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B908C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:03:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so7359662ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exAlskjzIFOE1QMe0saylZOMoEP4iKWyM0PCmNmV2iE=;
        b=D+KqO8DxYbapI0GwZR2nNjGv6dp+d+eVYzQHwg5OMjCbe3Q6SGne/SURb84sC+W4Bf
         WlFabSyY/QeiyaXTbQEFykeACFf5RZkc3ed28jFSDCVYw1jr/QDpijkI6yyaYHoDWcFI
         MCFoMmJ6MPdGoGJ2OI3Xt9c/mIbtsjp3OvXv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exAlskjzIFOE1QMe0saylZOMoEP4iKWyM0PCmNmV2iE=;
        b=iI01lESinfGnj9jI9cX2VxX5CBrnuy2vWmDvW3HjcWcTCqCgfRXhNjqc3iVaNEIruA
         MFauCQ2ZjrLA7/uz6mV87MsxionuW6Xkz5q4ARuVWH/Qrxe5Xh2MNj1LjivMoY/4rovt
         HXK7dRdLWQKzoeWSU0C+wOGVCZYrGbqTk14SrqN+3egY6kuPJdGgblc9iLE2itj4x/Ys
         ZFS2vyG/ilGgS4IK9oled+EVwsOwbhcy7rpN6QsHwoho39fZ936ILhVAsa3A0abQ6ZzR
         QD9r3boet/0NkQCcKdaYjq9FrfAD18KkJ4wcAsZBGtjzMb3Hq9Nk0KYjHnf4cGut0V2y
         9YrA==
X-Gm-Message-State: AOAM532Z+ogQBOPybtN6ODeQpz708gF+SbYclWe0GYkjOdoi2RNRaQQK
        oFG04ZarWmfEN7W655ZxDSIxxOZnjVE=
X-Google-Smtp-Source: ABdhPJxs9rOexXsLTxldXxEPZhBanPJia1/22fHhHNOpjzca1aFmXnl96hh+o2lbIpaqPkq/FpxTKA==
X-Received: by 2002:a2e:9595:: with SMTP id w21mr2793567ljh.334.1597345379648;
        Thu, 13 Aug 2020 12:02:59 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c21sm1354603lfh.38.2020.08.13.12.02.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 12:02:58 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id w25so7342674ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:02:58 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr2566294lji.314.1597345377681;
 Thu, 13 Aug 2020 12:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Aug 2020 12:02:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
Message-ID: <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(), use rcu_read_lock()
To:     Hugh Dickins <hughd@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 8:17 PM Hugh Dickins <hughd@google.com> wrote:
>
> Since commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
> improved unlock_page(), it has become more noticeable how cow_user_page()
> in a kernel with CONFIG_DMA_API_DEBUG=y can create and suffer from heavy
> contention on DMA debug's radix_lock in debug_dma_assert_idle().

Ooh.

Yeah, that's ridiculously expensive, and serializes things for no good reason.

Your patch looks obviously correct to me (Christoph?), but it also
makes me go "why are we doing this in the first place"?

Because it looks to me like
 (a) the debug check is wrong
 (b) this is left-over from early debugging

In particular, I don't see why we couldn't do a COW on a page that is
under writeback at the same time. We're not changing the page that is
doing DMA.

In fact, the whole "COW with DMA" makes me feel like the real bug may
have been due that whole "ambiguous COW" thing, which was fixed in
17839856fd58 ("gup: document and work around "COW can break either
way" issue")

That debug thing goes back almost 7 years, and I don't think it has
caught anything in those seven years, but I could be wrong.

The commit that adds it does talk about a bug, but that code was
removed entirely eventually. And google shows no hits for
debug_dma_assert_idle() since - until your email.

So my gut feel is that we should remove the check entirely, although
your patch does seem like a big improvement.

Christoph?

(And Dan too, of course, in case he happens to be relaxing in front of
the computer away from a newborn baby ;)

               Linus
