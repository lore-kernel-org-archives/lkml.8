Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6247AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B3802065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5sjXUDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgGIHDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIHD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:03:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD44C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 00:03:29 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h18so524352qvl.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YrXb+PwDrzRj61WwzuMsF1SQ3qopodp/CgTQXPhCgl8=;
        b=V5sjXUDzQudR96ZAfOfACopDQJ9o/MmPoWTqGfULqp/vTddHWzEIZ1UIDkcu7IJ7VM
         mQOuzlm1NdLOSM6JCtegh0GVdCdLHA3wFuAnz/y+lp2jbtjaSIQ6mwHH8fvYsMwsSWge
         k2tJ6CRYjrGnffV9DUqfYnhPMUR3SXUfe1rqAI6WypoIX8AD5yCAdv0q5TLKMTHPs80n
         WtrwJv5yJHopgEx99pbPbRAgK78oHNV4ki2vJCYgBah1CuUBV1EpghGYBGhaGOXYvFyv
         R4h5DRlr67+Mc7BDiJKe88WWK80wx7sbEALbLjQ5u5dYt1eglbbC727RwjpdKAK+IkYW
         ++3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YrXb+PwDrzRj61WwzuMsF1SQ3qopodp/CgTQXPhCgl8=;
        b=YjrQDGc1j8RZdeUeWwe0UOA2JDy/PDYq6/yrErlUPMZyW2xDSJ54c36sKWOl3Yy43/
         9kJGLWHw99mCYxSfeOX709W6A9CmKPpZ9oWG8HqhSRgme78Vcf10GDrihGrzaYCcgpqv
         ENcXFFRBU/IW79hERdCCjaXONoNB0a7rprALxp/X4zb4Ke968tinJ1Dn0nMa1S8NLPfp
         cHpx8UpXoZjllQ0T5oRrv0lfBc8Can25D0Ia8Txbf3CVSmVBdeBD97JEu8zOEmqYLCqj
         z5ViekcjsjsxaeXmbg5Rumi1aPk4hOc2fce1lAxpHU7T3phT9oEWT2JfOLWK/1oPicPm
         p2eg==
X-Gm-Message-State: AOAM531O6GC9H4rfGJpdLqnFkWvFiTwAp0HMdQjzSBr2IkmMBOqoclMe
        ba3FIACX9cDPHWT1ZSpC3ijo7gePZQg+9jBO8w4=
X-Google-Smtp-Source: ABdhPJwnBP30L2pcgjXTXouFKiroyJmxdrQWyS+nPsnu928YAHeRkSL5ytc9qnPd6EF8LzPDkPxsKo3g9wyiowPIyXo=
X-Received: by 2002:ad4:4732:: with SMTP id l18mr58589404qvz.208.1594278208659;
 Thu, 09 Jul 2020 00:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz> <20200708071602.GB16543@js1304-desktop>
 <20200708074103.GD7271@dhcp22.suse.cz> <20200709064340.GB19160@dhcp22.suse.cz>
In-Reply-To: <20200709064340.GB19160@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 9 Jul 2020 16:03:27 +0900
Message-ID: <CAAmzW4OWNF_fST82YaJFUszQwy8dFEkXRFw8pDKNjHzsRZ5Lig@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA aware
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 9=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 3:43, Mi=
chal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 08-07-20 09:41:06, Michal Hocko wrote:
> > On Wed 08-07-20 16:16:02, Joonsoo Kim wrote:
> > > On Tue, Jul 07, 2020 at 01:22:31PM +0200, Vlastimil Babka wrote:
> > > > On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > > > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > >
> > > > > new_non_cma_page() in gup.c which try to allocate migration targe=
t page
> > > > > requires to allocate the new page that is not on the CMA area.
> > > > > new_non_cma_page() implements it by removing __GFP_MOVABLE flag. =
 This way
> > > > > works well for THP page or normal page but not for hugetlb page.
> > > > >
> > > > > hugetlb page allocation process consists of two steps.  First is =
dequeing
> > > > > from the pool.  Second is, if there is no available page on the q=
ueue,
> > > > > allocating from the page allocator.
> > > > >
> > > > > new_non_cma_page() can control allocation from the page allocator=
 by
> > > > > specifying correct gfp flag.  However, dequeing cannot be control=
led until
> > > > > now, so, new_non_cma_page() skips dequeing completely.  It is a s=
uboptimal
> > > > > since new_non_cma_page() cannot utilize hugetlb pages on the queu=
e so this
> > > > > patch tries to fix this situation.
> > > > >
> > > > > This patch makes the deque function on hugetlb CMA aware and skip=
 CMA
> > > > > pages if newly added skip_cma argument is passed as true.
> > > >
> > > > Hmm, can't you instead change dequeue_huge_page_node_exact() to tes=
t the PF_
> > > > flag and avoid adding bool skip_cma everywhere?
> > >
> > > Okay! Please check following patch.
> > > >
> > > > I think that's what Michal suggested [1] except he said "the code a=
lready does
> > > > by memalloc_nocma_{save,restore} API". It needs extending a bit tho=
ugh, AFAICS.
> > > > __gup_longterm_locked() indeed does the save/restore, but restore c=
omes before
> > > > check_and_migrate_cma_pages() and thus new_non_cma_page() is called=
, so an
> > > > adjustment is needed there, but that's all?
> > > >
> > > > Hm the adjustment should be also done because save/restore is done =
around
> > > > __get_user_pages_locked(), but check_and_migrate_cma_pages() also c=
alls
> > > > __get_user_pages_locked(), and that call not being between nocma sa=
ve and
> > > > restore is thus also a correctness issue?
> > >
> > > Simply, I call memalloc_nocma_{save,restore} in new_non_cma_page(). I=
t
> > > would not cause any problem.
> >
> > I believe a proper fix is the following. The scope is really defined fo=
r
> > FOLL_LONGTERM pins and pushing it inside check_and_migrate_cma_pages
> > will solve the problem as well but it imho makes more sense to do it in
> > the caller the same way we do for any others.
> >
> > Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pag=
es allocated from CMA region")
> >
> > I am not sure this is worth backporting to stable yet.
>
> Should I post it as a separate patch do you plan to include this into you=
r next version?

It's better to include it on my next version since this patch would
cause a conflict with
the next tree that includes my v3 of this patchset.

Thanks.
