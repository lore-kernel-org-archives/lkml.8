Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9411C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BAD2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLMJe+V9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGJR3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGJR3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:29:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7007C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:29:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so6971790eje.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dhYqHDXmVB851MO24k0xJG8pSyIioIjacD8y0LsCCxY=;
        b=dLMJe+V9OFFRHOT42hrZZ1af8nQv7C6RUMqJRqQTx5tKDOZ8GvnlINDSvRebp84+iU
         m7IQVo5KdPxMFgtHzn8b+huKWXTMhwT9YtcAEAjYMQA2ytWBrN/gts3Imut/Hysm0f86
         FMd6HXbnlMjLcq1Pu1reAqpngO8kLHyS10S+JLt06MgNOdupDkW2kNYqn2dDOkMsZS+L
         1xrS2mpxHCeQFfcdO5nV9spuB/E4DmmcsY/a88MrBRyF2I3DZp8wL4+L3eTUP0ZTPTQL
         iL1nofMyqqy/pfiAZW6rku3LfcG4tO0SCqavMgENEzHFSwiClEjGVHkrJd1tF783H9dh
         ALZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dhYqHDXmVB851MO24k0xJG8pSyIioIjacD8y0LsCCxY=;
        b=W1pCKiUnUfOTRbH7QbgbRjDF0/hp7LwSRTaTw7cKSvQgoFJNclIs04awVaO1Nfg4+S
         xQ256KxJhfxjeXjZAUjxtlbwkjWZvTSRvx/KPDCExpysfXRjeWuBPukjOAeSbyf2Dxz8
         9zF5yE7N/cGPkOEhblIURWczr6lNFcEr/fZ/3YUQoNgGt6ImzddYI61R29/i4EOOL+Wh
         NuNx+SxSdeX1CAnh3MsRcEXbIz2l/McxX+dhg8nZgAQW2EbYv/qEeAobBDIrKgbuVOgo
         r7jAJ7fkSFyqbUh/1s+Ges1V/utrWX8LfuO4J5Expih1x2AbLpWUWunFsksB1rkvezVO
         Aotw==
X-Gm-Message-State: AOAM533Nw1sI47/8itP0d1xggCDmOFYS7bxzYqPtSSzC44wAJtYHksiL
        yNNldkc/baNT0R8YmLIcCiFwZfrszKs94Ay9KmIw4nuCcBk=
X-Google-Smtp-Source: ABdhPJyTnwMaj0fBe3xhHrqoUd5Au+DzxnbxORXfAamjJPmba1exXOGavNjGe0okwDqGFdHfQ8vRWv6iZ1kk1s3wtmM=
X-Received: by 2002:a17:906:c209:: with SMTP id d9mr38452213ejz.449.1594402186385;
 Fri, 10 Jul 2020 10:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org> <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com> <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
 <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
In-Reply-To: <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jul 2020 10:29:27 -0700
Message-ID: <CAHbLzko9DtqTpamdGAZRtRm9fq8E-FQR_79SHso7SeheUjzEzA@mail.gmail.com>
Subject: Re: a question of split_huge_page
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 2:35 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
> =E5=9C=A8 2020/7/10 =E4=B8=8B=E5=8D=881:28, Mika Penttil=C3=A4 =E5=86=99=
=E9=81=93:
> >
> >
> > On 10.7.2020 7.51, Alex Shi wrote:
> >>
> >> =E5=9C=A8 2020/7/10 =E4=B8=8A=E5=8D=8812:07, Kirill A. Shutemov =E5=86=
=99=E9=81=93:
> >>> On Thu, Jul 09, 2020 at 04:50:02PM +0100, Matthew Wilcox wrote:
> >>>> On Thu, Jul 09, 2020 at 11:11:11PM +0800, Alex Shi wrote:
> >>>>> Hi Kirill & Matthew,
> >>>>>
> >>>>> In the func call chain, from split_huge_page() to lru_add_page_tail=
(),
> >>>>> Seems tail pages are added to lru list at line 963, but in this sce=
nario
> >>>>> the head page has no lru bit and isn't set the bit later. Why we do=
 this?
> >>>>> or do I miss sth?
> >>>> I don't understand how we get to split_huge_page() with a page that'=
s
> >>>> not on an LRU list.  Both anonymous and page cache pages should be o=
n
> >>>> an LRU list.  What am I missing?>
> >>
> >> Thanks a lot for quick reply!
> >> What I am confusing is the call chain: __iommu_dma_alloc_pages()
> >> to split_huge_page(), in the func, splited page,
> >>      page =3D alloc_pages_node(nid, alloc_flags, order);
> >> And if the pages were added into lru, they maybe reclaimed and lost,
> >> that would be a panic bug. But in fact, this never happened for long t=
ime.
> >> Also I put a BUG() at the line, it's nevre triggered in ltp, and run_v=
mtests
> >
> >
> > In  __iommu_dma_alloc_pages, after split_huge_page(),  who is taking a
> > reference on tail pages? Seems tail pages are freed and the function
> > errornously returns them in pages[] array for use?
> >
>
> CC Joerg and iommu list,
>
> That's a good question. seems the split_huge_page was never triggered her=
e,
> since the func would check the PageLock first. and have page->mapping and=
 PageAnon
> check, any of them couldn't be matched for the alloced page.
>
> Hi Joerg,
> would you like look into this? do we still need the split_huge_page() her=
e?

I think this is the same problem which has been discussed a couple of
weeks ago. Please refer to:
https://lore.kernel.org/linux-mm/20200619001938.GA135965@carbon.dhcp.thefac=
ebook.com/

I think the conclusion is split_huge_page() can't be used in this path
at all. But we didn't reach a fix yet.

>
> Thanks
> Alex
>
> int split_huge_page_to_list(struct page *page, struct list_head *list)
> {
>         struct page *head =3D compound_head(page);
>         struct deferred_split *ds_queue =3D get_deferred_split_queue(head=
);
>         struct anon_vma *anon_vma =3D NULL;
>         struct address_space *mapping =3D NULL;
>         int count, mapcount, extra_pins, ret;
>         pgoff_t end;
>
>         VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
>         VM_BUG_ON_PAGE(!PageLocked(head), head);        <=3D=3D
> >
>
