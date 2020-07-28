Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FBBC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A711D2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="v9x4Nd39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgG1ClC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgG1ClC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:41:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD0BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:41:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so10133667pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n68pwSghXWgsDmyZS0HNGk1OCTBojCVhiofwdUm2ZsI=;
        b=v9x4Nd39BbkbtN6v46io1CQ2wm0Poht3rOk8BlWHRzuZE3iOfy4N3sUVJcYetkL2f9
         1A5RnpK/Qeo9Y+9zutxAJD1ljA23EYfHYf2PpQeqI5Zy9YhO8KSbA0J9t3CF+f2nl1FP
         zTYK78NYvesL1LJUnFBwp6pZhZqKtc+IgNss/kzGGTXyxR+Ki4TFu1heUnoRONe6U50H
         UuqDQykQ2NbjWUYy9xXEvMA8O3Dute3ClxWQ4oDf0JZiHgh+8QxOg1SW/x949Bnp0XW0
         bEO9+IY56jrhGDcaos0R8EXSlTaI4Pjf+tLEnnHXufqgAA+FwUeFDLeqLPdw4+d2uf7+
         D6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n68pwSghXWgsDmyZS0HNGk1OCTBojCVhiofwdUm2ZsI=;
        b=e2vw9jnDt6B+OE1trgmZ+8ujKj8Gcym5A69fMT7eeEg+IkrSQvp/R5X2Oru/IxNx/p
         07UVuKr5e+YM0nJOS/kwIu27PW4EOnIOzUavVx7O9LzsTiaIkrdHQT5Ixmz7M24dapxl
         vXv7wRCI33WlCIaBt0qUzqFjE5tzMd7C+X94gG2Zwra4TIfLiRf3ApdCOc7Y97z1t4sB
         f2N7cL8UbQ50z1ISFPBuisOT73w1uCB5sPRg9eEG5BG/K/aZ3/y85ypai+NPEQnEEnzs
         Er+K8UzvGEOPjKPETcm0xQNqQE0cr5rSDfE9RzYGMnzFDYaMWKWeXfvHf+5OofeAfoJk
         heBQ==
X-Gm-Message-State: AOAM5322kwG3pDycc3Zu/2wpTkTkTMkrVoMwlS7T+ySLsvEJgWxm5zGX
        y1xmPIgB4LThqx7JpyX834oAoOsKg8zoARoAfjdhwQ==
X-Google-Smtp-Source: ABdhPJwH31/0tgUHWrYoecZ9F4UMDVgg17KdG5paKg3PUsxhHrUgBsch7aZCeHqY0LLOKgvJcfc7idTEDPYOOUMs+vw=
X-Received: by 2002:a62:195:: with SMTP id 143mr22048348pfb.226.1595904061453;
 Mon, 27 Jul 2020 19:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200725080749.70470-1-songmuchun@bytedance.com> <20200727171953.443afb897bb88261facf5512@linux-foundation.org>
In-Reply-To: <20200727171953.443afb897bb88261facf5512@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 28 Jul 2020 10:40:22 +0800
Message-ID: <CAMZfGtUH4vzMG=KB7YkC73yKZ_t904oi7RifLBr0_FAL-ttPRA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] mm/hugetlb: add mempolicy check in the
 reservation routine
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mike.kravetz@oracle.com, Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>, mgorman@suse.de,
        Michel Lespinasse <walken@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jianchao Guo <guojianchao@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 8:19 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 25 Jul 2020 16:07:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > In the reservation routine, we only check whether the cpuset meets
> > the memory allocation requirements. But we ignore the mempolicy of
> > MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
> > memory allocation may fail due to mempolicy restrictions and receives
> > the SIGBUS signal. This can be reproduced by the follow steps.
> >
> >  1) Compile the test case.
> >     cd tools/testing/selftests/vm/
> >     gcc map_hugetlb.c -o map_hugetlb
> >
> >  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
> >     system. Each node will pre-allocate one huge page.
> >     echo 2 > /proc/sys/vm/nr_hugepages
> >
> >  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
> >     numactl --membind=0 ./map_hugetlb 4
> >
> > With this patch applied, the mmap will fail in the step 3) and throw
> > "mmap: Cannot allocate memory".
>
> This doesn't compile with CONFIG_NUMA=n - ther eis no implementation of
> get_task_policy().
>
> I think it needs more than a simple build fix - can we please rework
> the patch so that its impact (mainly code size) on non-NUMA machines is
> minimized?
>

OK. I will do that, thanks.


-- 
Yours,
Muchun
