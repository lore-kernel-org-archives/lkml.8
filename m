Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB73C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F65E22B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596477400;
	bh=UetAFMriMsn93gg8iRkrAwTlSrzNc6GUlIF5/D8oRvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K3UNvHm4AGmIHfjHK7L9BstUmX5ky8tRmDE6fgobrsNoGxrEzuEjm82EeW6HxV19q
	 sbUgHvqiWL1oJ/1c0d1+ySuUbMHlWm2qOEjR94P1DeUIZmxtCyTNGN4m9MMd/A2FaB
	 n72SA9lcfAUNkKLN3b4S9bC/SqgDAnFhjaXcnZIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHCR4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgHCR4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:56:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3583C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 10:56:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v4so30953794ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaqHXnSq/+5AnLVcTFKvIkD2/ChJW1rYkgWkgJWHkhI=;
        b=WXoyMu9jqOKiVA0G/0bqv7yP/KzZzxRDWYK3wgjj7eBXhilZN09q0E6NdqI8paPgVx
         uenlh/8wbbP3O5sR6fRguRO2u3Sq7Acew4GCwLZ0/hjwrVhjdTsWtWt3+p+X50qVweCe
         Rhb7IMFmmXicDz3094eg2kocoH8P86LJDwqKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaqHXnSq/+5AnLVcTFKvIkD2/ChJW1rYkgWkgJWHkhI=;
        b=PXagkWEfdFnXFzCB3CRZFhiaevnUw5X3q9v17X6ROBKyP4aaTXbGBMRW+RIi6+ArY9
         PQAYSRQovEaUY6LvzGDS9exMtGzmAMS2AdnwKhgRsHWJQxSNGCWWsgHwzDluw4tCIJHI
         g18vomSmP/t5KmifbOqlCdk7jqmQTcQMQFh5DBrY8LJFdlDpkqAO4u+oDby0VDtFRJJw
         jAq1RjCAGF85Kb968aiYgIigPPAPbdKhcgU6+VRKWBwOH0Eri6tnvrZwS+Cok8g5X2NI
         4PUuGXwRTLW/eso6mhSMZmNoPMsYwuQVAiE3D3LxrZiXCLHFKves0CnW6/vA7Q5MpTeH
         b41A==
X-Gm-Message-State: AOAM531R5gh3mooVqvOCH7c0BgxV38BvlBwaC4iIMEvBDyIr0mcJuu32
        goro56YYpgHpv8F/qDepb1gGXkwuY0s=
X-Google-Smtp-Source: ABdhPJxNLMjAt2vfojnlhqNvEsc/REf1aXXtLz5933sv9vesgTUN6zICEZM3C43iVswbAFS/9u5WTg==
X-Received: by 2002:a2e:7f1a:: with SMTP id a26mr7299654ljd.123.1596477396415;
        Mon, 03 Aug 2020 10:56:36 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u21sm3022342ljl.11.2020.08.03.10.56.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 10:56:34 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id k13so20967612lfo.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:56:34 -0700 (PDT)
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr9323974lfo.142.1596477394160;
 Mon, 03 Aug 2020 10:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <20200803131453.GL5174@dhcp22.suse.cz>
In-Reply-To: <20200803131453.GL5174@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 10:56:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU+W2OAHT220uRm+MtO9c44Tehe6a+eio1xyso5rNipQ@mail.gmail.com>
Message-ID: <CAHk-=wiU+W2OAHT220uRm+MtO9c44Tehe6a+eio1xyso5rNipQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Hugh Dickins <hughd@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 6:14 AM Michal Hocko <mhocko@suse.com> wrote:
>
> I hope I got it right and this is the latest version of your patches. Btw.
> do you still think that increasing PAGE_WAIT_TABLE_BITS is reasonable.

I suspect it's still very reasonable, but I'd love to have numbers for it.

> In the meantime I have learned that the customer suffering from the
> issue is very unlikely to reboot the machine anytime soon or even
> willing to test a non-trivial patch. We do not own any machine which
> exhibit this problem unfortunately. So it is quite unlikely I can
> help with testing.

Ok.

> Also does it make sense to put this into mmotm tree for a while to get a
> larger testing coverage?

Well, I did the 5.8 release yesterday, so I just put it in the tree
for the 5.9 merge window - I've been running it locally since I posted
it, and while Hugh couldn't prove it improved anything, his results
certainly also didn't say it was bad.

So anybody that tests my top-of-tree will be testing that thing now,
which is likely more than linux-next or mmotm gets (outside of build
testing and the robots).

Of course, I don't know how many people run my development tree,
particularly during the busy merge window, but hey, at worst it will
be in the next linux-next that way. At best, it's not just me, but a
number of other developers.

                   Linus
