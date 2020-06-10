Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79788C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C5A20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rhC0j4t2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgFJM2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgFJM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:28:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E6C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:28:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q14so1507177qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+g/QNFEcpPiOwSyTtWV6UhK4FMdUVFtGGz85G+f+/28=;
        b=rhC0j4t2YEoK08PnkL2fihhmC5XXVkrYeI4vb3VnKbwE+l9tdbbSmO2UgkqGtnyPlM
         A0GI3PJZEbPKn/4mia3nw1st3f5LEAUJ/4yoKbxTGeg/DRiLE/NmVjmolN4gSsplKLU7
         amPaMjgFwZua3VOnt2Zy7xqvx+XlxhC82VvOKuAPgQ2RbNfnBlItygDqkAdoOT/xWXU9
         Wk0yiDW1EFJ5x7iRkIj1gIZaK8JS1Fvrk9alFm1NrVleNsjzwxK9ULdORw3y+dXJeW5H
         jXzsHtnjfTHJmigC5tqVrgpSEfYqVtdxngTj/gbhYCrOPI1k3ODgCD4pfaNPsIwqt4xX
         7gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+g/QNFEcpPiOwSyTtWV6UhK4FMdUVFtGGz85G+f+/28=;
        b=kyNvwyxbRAwfS7SxJ8IOcvvdsVIgTUNEPkQEJiVORRxXYwHmqFk68xQeUhX3tw1bwU
         cy2s4YLlwsRCox43cEeiurwloxJSbwo/mHujjWVa+Y69YnIHguKFRvkIy9ASivJmQtt4
         4MkHSDc2EAP44B4sgW56HKpQDLJsvzZtGQd5e6FtgEQ0pFd7zcd/b4OH67CDiegZw12g
         h7pnQR5+q5cZGSwg/8pkRyG4qPUYXL5a6YwIzqI5pGNpz6dfdnn25tVQ9tx9VRlALEkc
         NYwSKeuXe3Pn93KVSNtahn9sEFKfxggqILC/UNgeoqeipHH/zZGqnpr9N7ibTl0eumWq
         l7kg==
X-Gm-Message-State: AOAM532AwOc2qifeWI5DPMKcDjIbXgaVb5XZ0i4DkR+FNmMHQYiP0rBU
        eaM5lZr+jMldth8alESiUOV8iGxxuPzYRw==
X-Google-Smtp-Source: ABdhPJwLAeGPv59jZfZ3qqXM7MmZExkYgusex/dA6RWdkGRe+zbe7XyTijd5FwfQuIcBFIcoyaZGiw==
X-Received: by 2002:ac8:fa7:: with SMTP id b36mr2997242qtk.100.1591792100186;
        Wed, 10 Jun 2020 05:28:20 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h64sm11681352qkf.46.2020.06.10.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 05:28:19 -0700 (PDT)
Date:   Wed, 10 Jun 2020 08:28:17 -0400
From:   Qian Cai <cai@lca.pw>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
Message-ID: <20200610122817.GC954@lca.pw>
References: <20200610052154.5180-1-cai@lca.pw>
 <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
 <CAG_fn=X-da3V0OC-Bzd2rmkNuZ_bVpH_n7Sp5P_hSGXD4ryyBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X-da3V0OC-Bzd2rmkNuZ_bVpH_n7Sp5P_hSGXD4ryyBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:02:04PM +0200, Alexander Potapenko wrote:
> On Wed, Jun 10, 2020 at 7:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
> > >
> > > kernel_init_free_pages() will use memset() on s390 to clear all pages
> > > from kmalloc_order() which will override KASAN redzones because a
> > > redzone was setup from the end of the allocation size to the end of the
> > > last page. Silence it by not reporting it there. An example of the
> > > report is,
> >
> > Interesting. The reason why we did not hit it on x86_64 is because
> > clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
> > thus is not instrumented. Arm64 probably does the same. However, on
> > s390 clear_page is defined to memset.
> 
> Can we define it to __memset() instead?
> __memset() is supposed to be ignored by KASAN, e.g. KASAN runtime uses
> it in the places where we don't care about bugs.

I suppose that could work if s390 maintains perfer this way.
