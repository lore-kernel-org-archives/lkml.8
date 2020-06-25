Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95EAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8086B206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbO+5/p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390849AbgFYQcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390007AbgFYQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:32:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8021AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:32:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so6591384eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9u1owb98wt1rgpllIsg8TqO/K5Zij7HRxC2lX5Y95rM=;
        b=FbO+5/p0HCLuFIg2S0AOrDg23Sy86SuXq4Dj+c6XGdH5TLqJ9GNhDQB6EJ80jsNha7
         WL3Tzu4KE4o1Ev8zhRwEwqIoE+Dq7+wIquVm+oeTyIdI4PyWXkJBcxwP5jKCi6fskgb+
         Y+oPtD8P6WEjFKuqMlBgw4CiF2HufhMBolAIY61YiGpfTDSDbN2DMApoB3yGNTymywy2
         laqUxXpD281N9g2NLNRw9I1hwyIgKzX9gZS6NjSwAQVoCH/tvO6h7KpVXzBHi8TxfvPb
         tGRHEXC1ey6mvARCYX6Eg2WhxqpYGV0xPozs9A9yxArEqxmFHGLMZuuUcgE5gRxO/4+m
         XSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9u1owb98wt1rgpllIsg8TqO/K5Zij7HRxC2lX5Y95rM=;
        b=hZUQD1D2H5BLCvGqQSOAg3hdrZyGg+OovA5hVtBEDaBQA+rIjZau8CnWWk7dHcC0PW
         p70Tn6pgHac7I7i4HDhFqlNjusAls0hVhOxUjo7D7Y8vUtPEGKH4CEV8Fk3LBCdZxaxv
         PYvrKsqx1E+ldp3BNTalBLroA+Mll4YTE+WjossIUWxfpF5XYd/FSkEF3Gp0uLw5ngrd
         VbgY4QMq/V2a70F9BolIvVzzO8bzp1UHqEXUI/JgC40V0+c5JEOIP7i+2qEKzQjVEv2Z
         qMx58xQua9+KWuTgLEUhHqO8f4HDQFICSMS0yFZHTwpPg8ClUko/pKZFmNkcrCyRM+ak
         aGsQ==
X-Gm-Message-State: AOAM533spPpsdhVwZ5swJ0gd1nfGCE0sm/2Lqyv/hP1Y/NY35CaVtCEa
        3cLL3S3ii5OGiZpSLToxYqf9XIcNK4ujK9dHyhg=
X-Google-Smtp-Source: ABdhPJxCQ59rjR5ytah0ieuIxKCiuojtjkelpJ5yQw9SkARvH/ShawMVo6l3ItgeCk3XW3XYiA8pvKX6fQdv0er+1CE=
X-Received: by 2002:a17:906:5496:: with SMTP id r22mr31614377ejo.449.1593102766231;
 Thu, 25 Jun 2020 09:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200624191417.16735-1-chris@chris-wilson.co.uk> <20200625114209.GA7703@casper.infradead.org>
In-Reply-To: <20200625114209.GA7703@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 25 Jun 2020 09:32:34 -0700
Message-ID: <CAHbLzkqBJWx89tTSPXjCzMG8=2OGQSmzPNjhqZv55surP8oFCQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 4:42 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jun 24, 2020 at 08:14:17PM +0100, Chris Wilson wrote:
> > A side effect of the LRU shrinker not being dma aware is that we will
> > often attempt to perform direct reclaim on the persistent group of dma
> > pages while continuing to use the dma HW (an issue as the HW may already
> > be actively waiting for the next user request), and even attempt to
> > reclaim a partially allocated dma object in order to satisfy pinning
> > the next user page for that object.
> >
> > It is to be expected that such pages are made available for reclaim at
> > the end of the dma operation [unpin_user_pages()], and for truly
> > longterm pins to be proactively recovered via device specific shrinkers
> > [i.e. stop the HW, allow the pages to be returned to the system, and
> > then compete again for the memory].
>
> Why are DMA pinned pages still on the LRU list at all?  I never got an
> answer to this that made sense to me.  By definition, a page which is
> pinned for DMA is being accessed, and needs to at the very least change
> position on the LRU list, so just take it off the list when DMA-pinned
> and put it back on the list when DMA-unpinned.

Sounds reasonable to me. In the earlier email I suggested skip isolate
dma pinned page in scan phase, but if they are long term pinned, it
seems preferred to put them on the unevictable lru IMHO.

>
> This overly complex lease stuff must have some reason for existing, but
> I still don't get it.
>
