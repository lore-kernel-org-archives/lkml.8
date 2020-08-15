Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CA4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 00:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0416D2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 00:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tixNdcgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHOA0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 20:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHOA0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 20:26:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C21C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:26:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c4so8915473otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=56XdHRbo9k+Mqiix3oE2+ajX+BG6DMvqPZZGvyF8s0g=;
        b=tixNdcgK+4b42rbbV1u0RJNtmfxWXYFPXMmEtuiTZoiPVRNhfK63NLNQNItaKKt0qU
         irDv56YmHRUkovanDxgxt9TpyrJ5gDu0dGMI4NpuLAkysQ9jaeJYN5e/oeWpzpU6TWjZ
         4hwkVXbKR07KaB16uuzIspvIAimunf7B1eBOfHICpX2UFs+cKR1A3pcch50aSd8d4ucU
         obkFk/4BOnRLaQUep841rCZ/dsBjIAazO49rnZoxnVe26X/NHcdVXAB2hBJ/dD9ZrNSV
         7gL2TYIZpzckSVxb3pGJiNhJJpRLTgukoByesVlSN4fV8ZctLVz2Ymz2dLqufO5Q/MAx
         Qeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=56XdHRbo9k+Mqiix3oE2+ajX+BG6DMvqPZZGvyF8s0g=;
        b=gB/VEbdkhKhIpvEBnIGks9Lltpx8kzSUrJJNe4OUU9Z/brm1B9NRqDTvoogLhvvWWT
         6pdfQ2SLVqiloe6kF49AJnrBv9nVi1svkvh9MUsf4POU2GuOYHCKZU/S1gapXD7KIFdC
         0BApJNYSYhbdHhWpELH5Q/WneAnxc1naKEeVg9ibryRvzweDdsSqMQSbLZ60Zat1/LFV
         +JaQPuvSH7E5EdUArpU705lhaWXadc+42IkPLON2aJsLYCx8ROIN3R2OtlHIErviJKsO
         Ve7dkBNHM0QukWCy6x4pY6bCmkC00rI/Yr3OZ3SEjor0IFAvCfx6OX+Hmxech7p2Xhy4
         9rKQ==
X-Gm-Message-State: AOAM533I/ILusoJoDlSYrq/1ONT3pA/gffd7GiabAorvlOcBTSZsIQLY
        +qdfteHkdJJzQjZTbVkuzT0LKw==
X-Google-Smtp-Source: ABdhPJz1ULd9mf33Zk0GkTOi/uDvlRsoh0xCiJzx5JrH5jIYaNNXpeR1yTqNoUjKIOV3Iujqr8p++A==
X-Received: by 2002:a05:6830:11:: with SMTP id c17mr3709955otp.287.1597451212070;
        Fri, 14 Aug 2020 17:26:52 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z17sm1982367oop.15.2020.08.14.17.26.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 14 Aug 2020 17:26:50 -0700 (PDT)
Date:   Fri, 14 Aug 2020 17:26:28 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(), use
 rcu_read_lock()
In-Reply-To: <CAHk-=wifNX6U28sjPay+1ZJ5BmxRG8Bac7W1sP_Ft1yTqLj+GA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2008141642260.18762@eggly.anvils>
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils> <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com> <20200814054241.GA719@lst.de> <CAHk-=wifNX6U28sjPay+1ZJ5BmxRG8Bac7W1sP_Ft1yTqLj+GA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020, Linus Torvalds wrote:
> On Thu, Aug 13, 2020 at 10:42 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The whole thing predates my involvement with the code, but I defintively
> > think the patch from Hugh is a major improvement.  But I would also
> > have no problem with just removing it entirely.
> 
> I decided to just do both, since neither you nor Dan seemed to really object.
> 
> I applied Hugh's RCU read locking patch as a clear improvement, and
> then I did a second patch that just removed this function entirely.
> That sounds a bit odd, perhaps, but in case people decide to resurrect
> the debugging code, I didn't want us to lose sight of Hugh's
> improvement just because I then decided that we might as well go one
> step further and just remove it entirely.

That's ideal, thanks - exactly the sequence I was hoping for.

(Another shortcoming in debug_dma_assert_idle(), that I hadn't wanted
to distract us by mentioning, is that it assumed that the mapping is
contained within one small page, whereas I believe one or more of the
DMA mapping functions take a size_t argument, that could in theory span
small pages - I guess more plausible inside a compound page; yet it
looked like only an initial entry would be put into the radix-tree.)

> 
> And the only real reason I care is that this whole COW and page lock
> thing has showed up lately, and I like removing code.
> 
> I'm _very_ tempted to just apply my COW simplification patch that gets
> rid of all the complex try-to-share cases entirely (and would also
> obviate the whole forced-cow patch). I suspect it would effectively
> remove almost all of the [un[lock_page() bottlenecks entirely, but
> that code has decades of history and I suspect it's a bit too drastic
> wrt KSM and the swap cache pages.

Yes, you're right to hold back.

I'd been looking there too (but backed off while speeding up the
fork was causing the "Hugh load" to "fail": it's the exit that now
wants speeding up, to please that test).  I think it could well avoid
getting into page locking when mapcount is quickly seen to be high
(> 1? > 2? > bigger? I never did the logic), but the page locking
becomes important when mapcount looks low, yet swap might be involved.

We used to rely on page count there, and on trylock_page() only; but
there was at least one user whose app went wrong when occasionally we
COWed the page, just because something else momentarily took a reference
to it, or locked it.  Around 2006, bug report from 2004: I did look up
the history a week ago, but was interrupted before taking notes.

> 
> It would be lovely if the main source of page locking would really be
> about just IO, but the page lock has also become the thing that
> serializes almost everything related to page state. Which is why you
> find it in contexts that are really not IO-related at all (not just
> COW - page migration is the other one that has shown up a lot under
> "heavy CPU loads" without really necessarily any IO component to it).
> 
>                          Linus
