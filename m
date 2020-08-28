Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B936C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390F920872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="oTCOBXxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgH1CeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgH1CeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:34:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33093C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 19:34:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w186so4727525pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 19:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wq4bW80PYQOUvc+r7HK1lpXC6FPGn4j7cEEATFFs/9U=;
        b=oTCOBXxK+fBohpDAkvRznZQumncoBJKZyRDUp5HFU+2ZRiPwLX6uWoA9NjpXlRv9Uj
         icW2nB2LIYQ3BBJJ5jc0w7AyYINngxONh8FoCPrv8LE173SZAToDmWc4rLiQ6SMAWZkG
         V9U0nE2JGZmvxGpYfNpVz8bUrpq79nkE0RWb6j8X8UbgpE4mUlI7eV5Qt2A7HlcdNAE5
         bqrR58QdJQi+3SKs2tTAraud3ZnTNgEeD5z/SW2yRbzo5PmThtJJQq3gtKXn3Qim7R3K
         qMwKqM00zkG0/U+F4JcjD4I9lY0EvI7MsjALkGdm2syGd6euU7+d0cfNOlGm3F9JZq63
         oMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wq4bW80PYQOUvc+r7HK1lpXC6FPGn4j7cEEATFFs/9U=;
        b=S3dv41007LS3gOjSfsLIZpEFknx3uT3+ykwmo70useusKhxuj8aW2NvbW+wytZoA+Z
         bxvXtYmho/A3ySNBPC0P73VkNlFl2lQ49gdt35JkAPma4uHYnoxc1OUwOXVdwkxiF4ie
         SAOppdeSQR9CUZJS8/Jn6bTOWVnIXkl2bInfBMTh4vtDjivPqBeVdDFPVkggaRWZNYvT
         D6Bh/rMJdMIVi72RwtkTbj/cRSwdDOshIFOKzQhkyiyqTz4Gp5fsq1qb4eAjx3O5Skpl
         I6HxozOYux0Jl3/inOn55fFDs76bFk68SjAJsrm0+JY2hqGxWRnfr4pF8MDmh5tPst3Z
         sTig==
X-Gm-Message-State: AOAM532G/GwrmqpqebFgMscCJpyHu/MCQZ5ZNzK1eCmZp3mNg3Ua8l68
        NWLlaFtnDRiYd1/YpfQGItKJAgYKA+nfgp1eDmaDSTFp1/w2OX8H
X-Google-Smtp-Source: ABdhPJxJQPdfEzCXFS9OWhsPamjtFq0jc35saCUnIZCNBxX9HEpqYBDHd3D3HTIPSLCWBE7TfpMBNcTzLVi0eqdnFrc=
X-Received: by 2002:a17:902:221:: with SMTP id 30mr19150363plc.222.1598582056522;
 Thu, 27 Aug 2020 19:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200822095328.61306-1-songmuchun@bytedance.com>
 <20200824135924.b485e000d358cee817c4f05c@linux-foundation.org>
 <79800508-54c9-4cda-02de-29b1a6912e75@oracle.com> <CAMZfGtXh+FP0O92ccj532Y=K4m2S==eSK8LjYEM+p6cttV0p8Q@mail.gmail.com>
 <231ec1f1-fe7a-c48a-2427-1311360d4b9b@oracle.com> <CAMZfGtWj5_Uh2KFAy4DGc0vzrNm4+Nge7rOBDAFQhh2aN7wOqA@mail.gmail.com>
 <afaa721e-f86c-9b49-acd1-54c9017fb269@oracle.com>
In-Reply-To: <afaa721e-f86c-9b49-acd1-54c9017fb269@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 28 Aug 2020 10:33:40 +0800
Message-ID: <CAMZfGtU9U5dv5oOCopnsFN7XErY52nA47b0jreUqZ2C6VBmC7w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/hugetlb: Fix a race between hugetlb
 sysctl handlers
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 5:51 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/25/20 7:47 PM, Muchun Song wrote:
> >
> > CPU0:                                     CPU1:
> >                                           proc_sys_write
> > hugetlb_sysctl_handler                      proc_sys_call_handler
> > hugetlb_sysctl_handler_common                 hugetlb_sysctl_handler
> >   table->data = &tmp;                           hugetlb_sysctl_handler_common
> >                                                   table->data = &tmp;
> >     proc_doulongvec_minmax
> >       do_proc_doulongvec_minmax             sysctl_head_finish
> >         __do_proc_doulongvec_minmax
> >           i = table->data;
> >           *i = val;     // corrupt CPU1 stack
>
> Thanks Muchun!
> Can you please add this to the commit message.

OK, I will do that. Thanks.

>
> Also, when looking closer at the patch I do not think setting table->maxlen
> is necessary in these routines.  maxlen is set when the hugetlb ctl_table
> entries are defined and initialized.  This is not something you introduced.
> The unnecessary assignments are in the existing code.  However, there is no
> need to carry them forward.

Yeah, I agree with you. I will remove the unnecessary assignment of
table->maxlen.

>
> --
> Mike Kravetz



-- 
Yours,
Muchun
