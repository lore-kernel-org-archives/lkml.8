Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B93C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D26520774
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRVONKp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgFJDLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFJDLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:11:50 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B9C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:11:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id e2so409019qvw.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PCGE0i5jShj8XCDSt3k7yuWmEi5dY5Ug2+/GmDjxlYg=;
        b=fRVONKp+S7uG//pRPspo5Nrf6ifu8rHa/DU2rAa4lAHzRZGIe/nDBoa8miLk7F6Icc
         VEVIk+U45HDrEklck8Ov0E4Y5iQEzvA8bfRjmMvRusZWQnJjJmcoAKUa78MkOm0XoTwY
         QVrUP8RIVEyXgf4KrBLCirjjMlJJgCmDHwKfI35ATFvI3Xz4VbUbYepbO5Lzjjv4nXao
         oMFd38agVxpYwuoMJKajIs81MFDfLavTEx3UJ2sV8TOL0EexI7p5jqzMpgFC4het1G8e
         3/bQpoAQG10F6WnkKbpwi1Mc3+Y49jUaFNFElZdQ8PE8EKwvFQuBjnMOM4iRb99bFLL8
         GGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PCGE0i5jShj8XCDSt3k7yuWmEi5dY5Ug2+/GmDjxlYg=;
        b=m01cdefD8HZpz5xF6ZfvyPnMa5bxGSD//B7k4EIj+ItOnW4E5fa9flpAWzvcustBF3
         d0BorbG3izzqEnFcfMLerTHLtvN+RVS5rA6wrOP89SKCTXM/y/OwInPOodG3FKJHaSOR
         QgCN3P5Ye+tpWJWIvLyVCPwMrxEMyphcIAOOxEw81hTIR/gIRpAG5DgQV6qnMUmS3BUp
         4tNbJB/amhE/bcDsXyIyx8e+scpX67WMy+OARQtm0yQLjphR1ruFlKuHsYeF79notfJ+
         vy3VW7CSHkYqD9jnPGYZ/vmhdb7uWN0ibxoI9IgHfNIvC5aH+U+Xg5qj+6LsesnDtKUr
         cC6w==
X-Gm-Message-State: AOAM530Dgoweh+RNgaz6rxePD5/rVhacf4uB8uaNv2bFSC6ak5FpIyT6
        2eWgY3ZtXqQTm7+5ZXkZjZOLzlmXc0uBwUyoHwM=
X-Google-Smtp-Source: ABdhPJxhrkEWfhv5QuiXBId0hcpxjE7i5N03/xqjKk6WQVwWEDDrUdbOkfB47BYSeQXEPEaokNih1g1UoY3KjvI9flo=
X-Received: by 2002:ad4:4d04:: with SMTP id l4mr1277779qvl.88.1591758709588;
 Tue, 09 Jun 2020 20:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-6-git-send-email-iamjoonsoo.kim@lge.com> <20200609134309.GG22623@dhcp22.suse.cz>
In-Reply-To: <20200609134309.GG22623@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 10 Jun 2020 12:11:35 +0900
Message-ID: <CAAmzW4N-O9+Y9xmi6WfB5_1voBQJZzPetpksdqcBx51kkY6njw@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] mm/hugetlb: unify hugetlb migration callback function
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

2020=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:43, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 27-05-20 15:44:56, Joonsoo Kim wrote:
> [...]
> > -/* page migration callback function */
> >  struct page *alloc_huge_page_nodemask(struct hstate *h,
> >                               struct alloc_control *ac)
> >  {
> >       ac->gfp_mask |=3D htlb_alloc_mask(h);
> > +     if (ac->nid =3D=3D NUMA_NO_NODE)
> > +             ac->gfp_mask &=3D ~__GFP_THISNODE;
>
> Is this really needed? alloc_huge_page_node is currently only called
> from numa migration code and the target node should be always defined.

Thanks! When I read the code, I was not sure that the target node is always
defined so I left this code. However, if it's true, this code isn't
needed at all.
I will consider your suggestion in the next version.

Thanks.
