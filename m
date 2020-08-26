Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD9C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D4E206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYKvrPyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHZFM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 01:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgHZFM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 01:12:56 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBF1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 22:12:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id k18so562591qtm.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yfilLBz5JZdi/avFWO9tv5bRcdRvux+Y1JNGa63+Zro=;
        b=hYKvrPyvirHQ+xAzWDhhq/Ve3fZvfDkw5fuDGO3+OfWWm1ofs9zDsoDjyMvL+nPnSD
         gs0YfdCzHTHaFwZTQP+iqBv82s7JY+1XrsnNfWmUyj4qJF40prRBc63skwRCZJbNHsuA
         Me92vZt7MTLa083lH4yQNIH/6bOKrvKscPPAXJvjmhYeTA1Xguf/YUQBzFyNDYoU+3Lj
         vzHg4aUmM3RX451EBuADsyD3WpYoPIXv+r/3t/HK1qvwno5cQ0DT0P3qnAHKQZf7utgB
         zkPp/qpPx/xiQe/xa8V8yerURt0qsvUun9nocWJKFvK84ZN0zm8AXmtk2s3USdvh6xQC
         VHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yfilLBz5JZdi/avFWO9tv5bRcdRvux+Y1JNGa63+Zro=;
        b=kOyprwa39/HBdd0xFkKvGfpmwwkwSn7s+RZgdoMOCCyA/hyJBnSy8Zo9TyyxUwc3L4
         L/PO3kzzPBFpdVLR3N3iFzqyPJYUH65NFs9hfQPCGrDT71LR4Hyedd/uPPwMTGgVkLD8
         wvlQtwCGwEN/ed5AMVC3yy+HCfbvn2Ft6jYlWA/f06ObH63SHk5sWz9TuXC83OzSQ7PA
         /Jmg5Te0u6LXxsuFgD7dgrR9/X3JUgZcKy5anh4Jnb0kdS+gJRyEZ6J0ymn9Y8BX/CUU
         cwsYB2rW9JR+4VU72hOjt70oulrfQPjAJe/fl4J6yADRZQMbW3vuWtfIXHZYtZc8YsrA
         Tieg==
X-Gm-Message-State: AOAM533IqWIFmlAbT2HFEy7PbWBlV7OUnUDs9wUfFbhyosmJzs//Q9hI
        9Be590RTN9XugbHDqahsNRies5tHz6UZCYQl3rXwOrvq
X-Google-Smtp-Source: ABdhPJxGUZBBfmxks+iAEFmtTgt/Wjzl0KmJDjKRrAC0gaBWPCGHEAsFKNWw7ZZqj5Ufn6gZsd0UcTpwmn2DeOsDsRE=
X-Received: by 2002:ac8:36b4:: with SMTP id a49mr9983461qtc.124.1598418774817;
 Tue, 25 Aug 2020 22:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com> <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz>
In-Reply-To: <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 26 Aug 2020 14:12:44 +0900
Message-ID: <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 8=EC=9B=94 25=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:43, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> On 8/25/20 6:59 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > memalloc_nocma_{save/restore} APIs can be used to skip page allocation
> > on CMA area, but, there is a missing case and the page on CMA area coul=
d
> > be allocated even if APIs are used. This patch handles this case to fix
> > the potential issue.
> >
> > Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
> > could have the pages on CMA area so we need to skip it if ALLOC_CMA isn=
't
> > specified.
> >
> > This patch implements this behaviour by checking allocated page from
> > the pcplist rather than skipping an allocation from the pcplist entirel=
y.
> > Skipping the pcplist entirely would result in a mismatch between waterm=
ark
> > check and actual page allocation.
>
> Are you sure? I think a mismatch exists already. Pages can be on the pcpl=
ist but
> they are not considered as free in the watermark check. So passing waterm=
ark
> check means there should be also pages on free lists. So skipping pcplist=
s would
> be safe, no?

You are right.

> > And, it requires to break current code
> > layering that order-0 page is always handled by the pcplist. I'd prefer
> > to avoid it so this patch uses different way to skip CMA page allocatio=
n
> > from the pcplist.
>
> Well it would be much simpler and won't affect most of allocations. Bette=
r than
> flushing pcplists IMHO.

Hmm...Still, I'd prefer my approach. There are two reasons. First,
layering problem
mentioned above. In rmqueue(), there is a code for MIGRATE_HIGHATOMIC.
As the name shows, it's for high order atomic allocation. But, after
skipping pcplist
allocation as you suggested, we could get there with order 0 request.
We can also
change this code, but, I'd hope to maintain current layering. Second,
a performance
reason. After the flag for nocma is up, a burst of nocma allocation
could come. After
flushing the pcplist one times, we can use the free page on the
pcplist as usual until
the context is changed.

How about my reasoning?

Thanks.
