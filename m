Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78841C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD3820775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1zFq+VA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgFZEt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFZEt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:49:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990DDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:49:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i3so6558917qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LFYDMUKQrW0T4SH1uN8ylIu3ETCULxHbKqmp1cm62qk=;
        b=k1zFq+VAzqOSlxMiA0G5gBJLoAJY6P0qFBiHQQzT5vjMoyOXdAFJUxM5VhxBJyZvOx
         W4Y3y2Q5SAZ8YE9RlGUvf4uDLfY/8CEk8IY6DffPP6QB4Hm1yBPL9FagGmMMxWvDSzaW
         9nd73O9fsMBqAyN1EJR2ueeWkocpwSTKIQdgslJSwA9eEobG0k+ijyiXtLnFLysBGqcJ
         0HrTpfvVAsJNV8QArBdBfPDO6krzFOnj6AeLLwDds4Thk7KMPmv3y+ViRLbN5QmiUitz
         FHiiHP/yVaSIFr/zWQCTVtdn2lbOrCN0QgpqHSfUgXiB2Ced8Bu0FL04rGKcVMyqF9Qy
         Mevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LFYDMUKQrW0T4SH1uN8ylIu3ETCULxHbKqmp1cm62qk=;
        b=r7Fxtpn96Kyerhcc7xQv7xaYp6ptyKPjL2QtDVBEXuwdxi3VP4b/Aq+1bhtkebi27Z
         hAi753WXO2BK7i6irg1Wg5xeJPKPTimvuROFF0qqodHBXov8yhB7aSAjYV+yAf5zX7eY
         WdLGz5h9x9SfyyGX1lcY9cp2ZsYiPenKg06i9pdIaVtJl88+ZcZCxXCc9P1qntE36zsi
         R7bW6ch94Ub/F25AfJrtDvCm42Pk3TEmjGK4y9kjsxjGr1R+MrT5PbRX++Kac0QHtVNM
         hq76LI7wIApw26vzpA6+U06IWJgnB79hbv++KvYuHKx052egjOX1dmzN9zciUgZOxnBX
         XRNQ==
X-Gm-Message-State: AOAM531JVEaSWHt/LQSzBF+58dnNof013FeJZsh5H7fTb7iLamVa4RvH
        FMmY8L4RhbOh4ghIvmiFJgY4ktLDRem0cQpVqHk=
X-Google-Smtp-Source: ABdhPJz8DxP+lZdaXieeYFvOpq4grToe+5JIrMlWyBrb0g7FKmjCCPPYfY2OO1oxh2fKCHaVWrzHFNkilBcUjzNVr/A=
X-Received: by 2002:aed:2359:: with SMTP id i25mr984146qtc.194.1593146966697;
 Thu, 25 Jun 2020 21:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com> <20200625115422.GE1320@dhcp22.suse.cz>
In-Reply-To: <20200625115422.GE1320@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 26 Jun 2020 13:49:15 +0900
Message-ID: <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com>
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

2020=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 8:54, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue 23-06-20 15:13:44, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > new_non_cma_page() in gup.c which try to allocate migration target page
> > requires to allocate the new page that is not on the CMA area.
> > new_non_cma_page() implements it by removing __GFP_MOVABLE flag. This w=
ay
> > works well for THP page or normal page but not for hugetlb page.
>
> Could you explain why? I mean why cannot you simply remove __GFP_MOVABLE
> flag when calling alloc_huge_page_nodemask and check for it in dequeue
> path?

If we remove __GFP_MOVABLE when calling alloc_huge_page_nodemask, we cannot
use the page in ZONE_MOVABLE on dequeing.

__GFP_MOVABLE is not only used for CMA selector but also used for zone sele=
ctor.
If we clear it, we cannot use the page in the ZONE_MOVABLE even if
it's not CMA pages.
For THP page or normal page allocation, there is no way to avoid this
weakness without
introducing another flag or argument. For me, introducing another flag
or argument for
these functions looks over-engineering so I don't change them and
leave them as they are
(removing __GFP_MOVABLE).

But, for alloc_huge_page_nodemask(), introducing a new argument
doesn't seem to be
a problem since it is not a general function but just a migration
target allocation function.

If you agree with this argument, I will add more description to the patch.

Thanks.
