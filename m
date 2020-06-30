Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183A1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD57420775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2/CKotS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgF3GaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbgF3GaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:30:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E4FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:30:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so14752941qth.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M+zspVXwnwUugMmyg5Fs3M9A6bC6GD++C9bM08ArZgg=;
        b=f2/CKotSjqcsnXiEcvEANGrGuhkmMjbqSVhnnN0h6sFpMhuHMPMh5qlekepWmX8PaP
         sJ54X8bMgjoIcA1iBpqYifYP/KEb+1N1QFF2Fv737NYGBR2pH6e3Z/oKsnWlDWz1hSwh
         ZyeibuRav446yaRj7Gmlqiz/aTHdpEKt7dLSn3xDlqYiLsdDI26229eunGtgoSCsj7Uy
         CpcPA6vNGjK95pgUBBWTqDpJXUV835DKBy3Qvz/Z+tnNgdmJxKvq/mogXxgHnhkNMNp2
         036doAGMPNMZbBmQTBVsX35UUIb7kukEdzk4ho7IJ6O2URXsaX99oAnopgUnK4E2sP1i
         66lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M+zspVXwnwUugMmyg5Fs3M9A6bC6GD++C9bM08ArZgg=;
        b=PltNZNmexQ0JwSxcId2skDKY8V7pHoRGYWpPtNkpSamo3HQwiXgye2VIHB5N2F2cIg
         3NssncuMeVXZZwSKvbpjyjfvdJ1rh5/yrQPkE93VivznRU9fTuMd8RSpThyOEbNp+oP7
         5E701cMx5V0feafNMqNS4ZMzPzK+DTmaFUIIAhER9PNsCB0Esw2QYy9lNueFVXHG4gwb
         EkwqHMDJQi5wQk3CaBmu5Nb0pjT9YkvMQP/ijJB7MOLuWGm+libkLUOsHezhFtXA0fyL
         CcGoppvh56ysWZYrc5y/Cw1YrC9dTHvmoVizuyLq3pH3BFTOn5Lc5tYTL8ct9ZqfBbu6
         G2Pg==
X-Gm-Message-State: AOAM531qeQ7tPp8nRgWCXpw1rWamfZRDjDQ8qSIKdNBYXqsuND+Y7w9Q
        75JThnnebn3GeVfv10kE+3SEH5JWIMHk2Mm6cZc=
X-Google-Smtp-Source: ABdhPJytcCX9uk4lRHAQ9+sawDM4yk/IJQ6L6CiGTHW7F7hHyMnhniT/t40xGLm7iZ6SFMd/cjKJUYt23tDU9UpehAc=
X-Received: by 2002:ac8:4f49:: with SMTP id i9mr19435424qtw.65.1593498619002;
 Mon, 29 Jun 2020 23:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com> <20200625115422.GE1320@dhcp22.suse.cz>
 <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com>
 <20200626072324.GT1320@dhcp22.suse.cz> <CAAmzW4NLVwvqtoUb+JJ+WV=7_n800vA+YYC0LyrDS6iQ7wxcdg@mail.gmail.com>
 <20200629075510.GA32461@dhcp22.suse.cz>
In-Reply-To: <20200629075510.GA32461@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 30 Jun 2020 15:30:04 +0900
Message-ID: <CAAmzW4PFEEs0FGe+XMHzRdXr0LpdF3TZZG2L3E+opRyZWDZ48A@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mm/hugetlb: make hugetlb migration callback CMA aware
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:55, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon 29-06-20 15:27:25, Joonsoo Kim wrote:
> [...]
> > Solution that Introduces a new
> > argument doesn't cause this problem while avoiding CMA regions.
>
> My primary argument is that there is no real reason to treat hugetlb
> dequeing somehow differently. So if we simply exclude __GFP_MOVABLE for
> _any_ other allocation then this certainly has some drawbacks on the
> usable memory for the migration target and it can lead to allocation
> failures (especially on movable_node setups where the amount of movable
> memory might be really high) and therefore longterm gup failures. And
> yes those failures might be premature. But my point is that the behavior
> would be _consistent_. So a user wouldn't see random failures for some
> types of pages while a success for others.

Hmm... I don't agree with your argument. Excluding __GFP_MOVABLE is
a *work-around* way to exclude CMA regions. Implementation for dequeuing
in this patch is a right way to exclude CMA regions. Why do we use a work-a=
round
for this case? To be consistent is important but it's only meaningful
if it is correct.
It should not disrupt to make a better code. And, dequeing is already a spe=
cial
process that is only available for hugetlb. I think that using
different (correct)
implementations there doesn't break any consistency.

> Let's have a look at this patch. It is simply working that around the
> restriction for a very limited types of pages - only hugetlb pages
> which have reserves in non-cma movable pools. I would claim that many
> setups will simply not have many (if any) spare hugetlb pages in the
> pool except for temporary time periods when a workload is (re)starting
> because this would be effectively a wasted memory.

This can not be a stopper to make the correct code.

> The patch is adding a special case flag to claim what the code already
> does by memalloc_nocma_{save,restore} API so the information is already
> there. Sorry I didn't bring this up earlier but I have completely forgot
> about its existence. With that one in place I do agree that dequeing
> needs a fixup but that should be something like the following instead.

Thanks for letting me know. I don't know it until now. It looks like it's
better to use this API rather than introducing a new argument.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 57ece74e3aae..c1595b1d36f3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1092,10 +1092,14 @@ static struct page *dequeue_huge_page_nodemask(st=
ruct hstate *h, gfp_t gfp_mask,
>  /* Movability of hugepages depends on migration support. */
>  static inline gfp_t htlb_alloc_mask(struct hstate *h)
>  {
> +       gfp_t gfp;
> +
>         if (hugepage_movable_supported(h))
> -               return GFP_HIGHUSER_MOVABLE;
> +               gfp =3D GFP_HIGHUSER_MOVABLE;
>         else
> -               return GFP_HIGHUSER;
> +               gfp =3D GFP_HIGHUSER;
> +
> +       return current_gfp_context(gfp);
>  }
>
>  static struct page *dequeue_huge_page_vma(struct hstate *h,
>
> If we even fix this general issue for other allocations and allow a
> better CMA exclusion then it would be implemented consistently for
> everybody.

Yes, I have reviewed the memalloc_nocma_{} APIs and found the better way
for CMA exclusion. I will do it after this patch is finished.

> Does this make more sense to you are we still not on the same page wrt
> to the actual problem?

Yes, but we have different opinions about it. As said above, I will make
a patch for better CMA exclusion after this patchset. It will make
code consistent.
I'd really appreciate it if you wait until then.

Thanks.
