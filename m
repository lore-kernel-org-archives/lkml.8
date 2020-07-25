Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F78C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7432070E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595645205;
	bh=FtHO5ojDDjQc1/Jaxt8M/AoP751VgF64LWfsvcXYbC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Arz7q1QpMvO90ynET6ctn/bgIu9iMfQYhUrltqe1PaUJhsGXN4+zxbMm749ySDYDt
	 KO2OMReTbhODgizHHcaFqTlxOAa7BiVwUJ86zPZlvMFRWVMt53vzTfY2Hpkv/kAk+V
	 SCbWOQRMyzfsZHnQ2Sy4GM6Xuc8JfHg8WJh+4axc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGYCqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGYCqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:46:43 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC4CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 19:46:42 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m15so5529862lfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 19:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUH5ZgL4Gg4QInigyESctID6C5txQBv0Qt+FjLQ+12A=;
        b=ONZI0YOu712KSSeXlHyibd4cF3kZNWrnZe/Yi28TYAyIvPqB54JMYVXkA3HbAaQVF2
         J7A37WO2j+ixBZhGoYa4mPAShO8cYECzOO0V4F8bWdfJQC9O86WhkI3TDn2MECGVjSRW
         c7hVgQMtcFVTbw8mMW8Ewe6ruwHlgcdB7FA6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUH5ZgL4Gg4QInigyESctID6C5txQBv0Qt+FjLQ+12A=;
        b=jBvNJLmGbSBeo+JtJvbX1X0nGRaPh2eUDIFyfNOYQ6vHD7StXf/7yjUDA+vrMNFUh7
         6HzviIuRrAKPYpyU9Gju48Rq2aYj47RUYbkUrt9e89jXh2Q0NMk4cowTtq6BUsDKy4XE
         MDMKCCwFUh3yYijedIQ8Efue8wxwjRqKu217Vp9I5FOJ4nSEhj/5j+I5Ia33/S90hiIc
         1bk1QOYiyWBtb6tDgUo6gq2TT0ZlhLIxsMa5tR/aeEVlzBKhzDbNqghiD20NCFtesgaa
         fZLbQKd1Sjffy7SWmRUBBGxz4VeHLWCuOZYg1r0m+4yW7anZra7nM6qqbbv4nDiVFcKU
         7STw==
X-Gm-Message-State: AOAM531KHzsdwTuaPgH4TWF7nKvbHws7w+ubwYNq+zO/uiymVUEmBxgO
        m+dZw5Oz/FWLBYpXx+7kFlH0L+Vktqs=
X-Google-Smtp-Source: ABdhPJzmEHFilLcg3g+k9YR/izg0kz1BFkA8RKNHBlbVFpmm2Y4wfVDV0h8WbH4OjBxyK9rcAZyjiw==
X-Received: by 2002:a19:7001:: with SMTP id h1mr6574402lfc.40.1595645200208;
        Fri, 24 Jul 2020 19:46:40 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j2sm653606lji.115.2020.07.24.19.46.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 19:46:38 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id s9so11808083ljm.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 19:46:38 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr5814202ljj.312.1595645198300;
 Fri, 24 Jul 2020 19:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <alpine.LSU.2.11.2007241848300.8192@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2007241848300.8192@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 19:46:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1qMgNLMcSuA7EFffaqFVDUzNooMSoaon2094qbwCakQ@mail.gmail.com>
Message-ID: <CAHk-=wj1qMgNLMcSuA7EFffaqFVDUzNooMSoaon2094qbwCakQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 7:08 PM Hugh Dickins <hughd@google.com> wrote:
>
> But whatever, what happens on the next run, with these latest patches,
> will be more important; and I'll follow this next run with a run on
> the baseline without them, to compare results.

So the loads you are running are known to have sensitivity to this
particular area, and are why you've done your patches to the page wait
bit code?

Because yes, I think that last version in particular might make a big
difference with the "let people continue even if they only saw the
wakeup event, and never actually tested and saw the bit clear".

Of course, there's a possibility that "big difference" ends up being a
negative one. I think it will make the page wait queues shorter (which
is good for that latency and lockup thing), but waking things up more
aggressively _may_ also end up adding more CPU load, if they then all
decide to retry the operation for whatever reason.

And hey, it's also possible that it makes no difference at all,
because your load mainly tests the exclusive "lock_page()" case, which
won't have changed.

And that's all assuming they don't show some instability, of course.
But the code actually seems fairly simple now, and the basic
synchronization hasn't changed, just a behavioral optimization.

Famous last words.

               Linus
