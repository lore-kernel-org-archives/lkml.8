Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CDC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD865207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SYxd7JAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgIBMvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIBMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:51:45 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53201C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 05:51:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so6460013ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vb8nEfGlhVBFAznOemnS757d63JHXGeX/MUl+8OqStw=;
        b=SYxd7JAeBsojOK2HUAbQyxkhg1r2C33uBFoIFXIdeqIVKX1/oBdUHl9X47BM1Irz6D
         24JJGwShtYpRXBQHDq0ap5W78KaAZab4FGlK5TlftAOyS+INqj2HqACK+BewNBms9+hQ
         1KsBJbQYD8yb/ODXzfAkQfuclmUacIuGK8ecF1/h7gl83zPGuZQSgZBZoWkfoleS8Z/p
         yYgY+vxRSoj5p2o9I6xBA7+Eag6iQfUbh8pGhIs3gJoQ+wvK/x3mNY431ncbl+amubjR
         QDoq1oKdlhTDKI6qRQ5WztZ6wB0fRJP+w9S8Uy8WFrOugIyUV0VEvee4h3eN8VTLoWb+
         51vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vb8nEfGlhVBFAznOemnS757d63JHXGeX/MUl+8OqStw=;
        b=Z80eUBmVUAS77t9Zh9UtUlazKXNPp0k9NY+pEATEY6PHNrZfMoW6TX/8fPDccWeBXl
         mjnK6HQFqF6AfVfrWwuqpDugmoKUaJKboyC5S2Yz1G0Ql7Exsga+CZ2wx4oE+zSkx30i
         IqGG26fD1FTfRJvSqrEnOReYTibrIZR3nK2FIC7jp6shNmY9QCRsICYeDWtyaDtisuNz
         9pRA37XX0OZ0lt+UYUhKkHHsufi5aYZWz9sASPLf2mOmeFkUkMEQqS03nBYvCJoozik+
         SL9x+xb9hE9GgRVdM80FIvvVCgHLnL391CGxBsE9JJI97s6IqgUlj+eKZGlW2klgHcp6
         xREw==
X-Gm-Message-State: AOAM532qz856o2ZBTfryAc4RnxW155/i7eF2+kJ4zOlzqNeY3efulC7K
        3uuAFw8Jm8aWMzI8QGaylao5PBxcgJLtFc73kAObMw==
X-Google-Smtp-Source: ABdhPJxF8QWki8QRQ8ChcVSrdGNWI+JN5Pf5Gfm0KpWIWw9wgLSDXR87J9qd6Qzug5NPd3Wa1Di1x991eP/t+FZTUvU=
X-Received: by 2002:a17:907:2055:: with SMTP id pg21mr6481789ejb.501.1599051102784;
 Wed, 02 Sep 2020 05:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200127173453.2089565-1-guro@fb.com> <20200130020626.GA21973@in.ibm.com>
 <20200130024135.GA14994@xps.DHCP.thefacebook.com> <CA+CK2bCQcnTpzq2wGFa3D50PtKwBoWbDBm56S9y8c+j+pD+KSw@mail.gmail.com>
 <20200813000416.GA1592467@carbon.dhcp.thefacebook.com> <CA+CK2bDDToW=Q5RgeWkoN3_rUr3pyWGVb9MraTzM+DM3OZ+tdg@mail.gmail.com>
 <CA+CK2bBEHFuLLg79_h6bv4Vey+B0B2YXyBxTBa=Le12OKbNdwA@mail.gmail.com>
 <6469324e-afa2-18b4-81fb-9e96466c1bf3@suse.cz> <20200902112624.GC4617@dhcp22.suse.cz>
In-Reply-To: <20200902112624.GC4617@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Sep 2020 08:51:06 -0400
Message-ID: <CA+CK2bA43fZpdDc3WXOaQ_dtmy=wHV7eFQW8k++tbfGwERMrhg@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] The new cgroup slab memory controller
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Thread #1: memory hot-remove systemd service
> > > Loops indefinitely, because if there is something still to be migrated
> > > this loop never terminates. However, this loop can be terminated via
> > > signal from systemd after timeout.
> > > __offline_pages()
> > >       do {
> > >           pfn = scan_movable_pages(pfn, end_pfn);
> > >                   # Returns 0, meaning there is nothing available to
> > >                   # migrate, no page is PageLRU(page)
> > >           ...
> > >           ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> > >                                             NULL, check_pages_isolated_cb);
> > >                   # Returns -EBUSY, meaning there is at least one PFN that
> > >                   # still has to be migrated.
> > >       } while (ret);
>

Hi Micahl,

> This shouldn't really happen. What does prevent from this to proceed?
> Did you manage to catch the specific pfn and what is it used for?

I did.

> start_isolate_page_range and scan_movable_pages should fail if there is
> any memory that cannot be migrated permanently. This is something that
> we should focus on when debugging.

I was hitting this issue:
mm/memory_hotplug: drain per-cpu pages again during memory offline
https://lore.kernel.org/lkml/20200901124615.137200-1-pasha.tatashin@soleen.com

Once the pcp drain  race is fixed, this particular deadlock becomes irrelavent.

The lock ordering, however, cgroup_mutex ->  mem_hotplug_lock is bad,
and the first race condition that I was hitting and described above is
still present. For now I added a temporary workaround by using save to
file instead of piping the core during shutdown. I am glad the
mainline is fixed, but stables should also have some kind of fix for
this problem.

Pasha
