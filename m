Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF00AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2D1205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529211;
	bh=75sLDgS74qU0RUSowE4Y/141LDn4H61PM0ZxcV/8jpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZnxSXGa1GaphCjUMQEvsz+8rWbiPhPMcwm7WPSbTtHSyP95a7SXXN21y/OBZlY8sG
	 dGoCRiDztaBiN6Qmu+p026hOUPwkCqylj2DXjjLuhKat7s7YHZm1HfsUCgcFZHfAVa
	 AVxXZEmK1hRqOj1X2oj9zlB2RxP2rIMItfi46kUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgHOWGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgHOVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C438C06134A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:59:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so11762144ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5V/+PBSBblwToTAxIaWCU/QUA1O6ispz0B5966qT9o=;
        b=GViAih0/p9oLbkxsH0zRUETk2BWc6utJvJ2zieuBFpItMZ5Q/d+XoOIJE3UmtmDW9d
         PfB7oAxIVJBUbDF/z38G7nHCI1AuDI/Wa5eZncLuwEofl1Tgh5gbUZms7q6RUinORQm5
         atVm6Nom3LD276TzkMMR7WITDnfy6UtyUb83E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5V/+PBSBblwToTAxIaWCU/QUA1O6ispz0B5966qT9o=;
        b=AwPukdKC1ppzjZpojv7SSk88WNEQGgy1xru4W7SQuKiOZSUqqh6leMJWoRGt8frPxM
         gQZH1cogGS3li7GC9HhwYC7KGqbGcz6GKpEKJ1diwP3OERuV3PoLGQLth1eYMJtl9Iov
         dfYwVDtuLcF0uYrNDwqN2adfnBOI75VzH5sXCbdMYCd1ul9fyKrK6/7QfceT/8QmUy2+
         V7phEqzvdIURCkZc3J0GFJ3evF35PvfSScNVt38Q71+p+ScnkBj6nP4JzJ9oDg+ZTBMh
         HDtY4S56VZ8lGNjGdfFBDA9ItiB2ZUjJkkVYu6SA9DZXO0ZXyH8SZNtKjYNYW7R0avMv
         fl0w==
X-Gm-Message-State: AOAM5308VubFkMatdYr3dZcvJekZTK3mYkrPlnB1a5d0pzAy7PAnySjG
        L9gIEZDtgqg6V9LP/cE/7PtLSqQ1ia8bSg==
X-Google-Smtp-Source: ABdhPJwjDPqkG3kG5xYG2PRhv/OE0UngTipyQDD2/ehogRv9G97VfCOD+Ki3yDSpbncqfoGbPzc8iQ==
X-Received: by 2002:a2e:3019:: with SMTP id w25mr2283575ljw.291.1597453162455;
        Fri, 14 Aug 2020 17:59:22 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id v9sm2057310ljd.125.2020.08.14.17.59.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 17:59:21 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id i80so5669680lfi.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:59:21 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr2382329lfp.10.1597453160630;
 Fri, 14 Aug 2020 17:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
 <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
 <20200814054241.GA719@lst.de> <CAHk-=wifNX6U28sjPay+1ZJ5BmxRG8Bac7W1sP_Ft1yTqLj+GA@mail.gmail.com>
 <alpine.LSU.2.11.2008141642260.18762@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008141642260.18762@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 17:59:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw3QcceKCdYS2ktCPQ96m8Ysyek+w4ny0ygvy7z-_2rw@mail.gmail.com>
Message-ID: <CAHk-=whw3QcceKCdYS2ktCPQ96m8Ysyek+w4ny0ygvy7z-_2rw@mail.gmail.com>
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

On Fri, Aug 14, 2020 at 5:26 PM Hugh Dickins <hughd@google.com> wrote:
>
> We used to rely on page count there, and on trylock_page() only; but
> there was at least one user whose app went wrong when occasionally we
> COWed the page, just because something else momentarily took a reference
> to it, or locked it.  Around 2006, bug report from 2004: I did look up
> the history a week ago, but was interrupted before taking notes.

I actually think you may be talking about the exact problem that that
debug patch from Dan was originally created for:

  0abdd7a81b7e dma-debug: introduce debug_dma_assert_idle()
  77873803363c net_dma: mark broken

and your memory sounds exactly like that net_dma case (and the timing
matches roughly too - the NET_DMA code was merged in 2006, but I think
people had been playing trial games with it before that).

IOW, net_dma was horribly broken, and just couldn't deal with COW
because it did things wrong.

The thing is, doing extra COW's really shouldn't matter in _any_
half-way correct situation. There's a few cases:

 - user space writing to it, so we COW.

   This is the "simple" case that is obvious and we've always done the
same thing. User space will get the new copy, and there's no possible
situation when that can be wrong.

 - get_user_pages() for reading.

   This is the one we actually used to get wrong, and when another
user *didn't* cow, the data that was read might not match what the
original get_uiser_pages() case expected.

    But in this case, the bug only happened when we didn't cow
aggressively enough.

 - get_user_pages() for writing

   This is another 'simple" case, because it does the COW at
get_user_pages() time and gets it's own copy (which is also installed
in the thread that does the GUP, of course, so a subsequent fork an
danother write can obviously cause *further* COW action).

But in no case should an extra COW matter. Except if somebody uses
get_user_pages() to write to the page, and the COW "hides" that write
by giving a new copy to whoever expected to see it, but that's exactly
the case that Dan's patch was supposed to notice.

And since it never triggered outside of that invalid net_dma case, I
don't think any other case really ever existed.

Yes, I can well imagine that some people loved the concept of that TCP
receive copy offload, but it really was broken, and was removed
entirely by Dan in commit 7bced397510a ("net_dma: simple removal") a
year after being marked broken (the author date makes it look like
it's just a couple of weeks after being marked broken, but the commit
date for that removal is September 2014).

So I don't think that the trylock and checking page counts is a
correctness issue.

It had better not be, because anybody that writes to a shared-cow page
 without breaking COW is simply broken.

No, I really think that the real worry about doing more aggressive
copying is that it doesn't steal back the KSM page or the swap cache
page, so it will leave those pages around, and while they should then
be really easy for the VM to reclaim, I really worry that we have a
couple of decades of VM reclaim tuning with that swap cache reuse
behavior (KSM, not so much).

And while it works fine on my machine, I currently have 40GB or RAM
free, because honestly, the stuff I do doesn't need all that much
memory, and I ridiculously overspecced my new machine RAM'wise. So
nothing I will do would show any problems.

                Linus
