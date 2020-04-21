Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32127C38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0B720782
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D03DyicL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDUA5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDUA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:57:31 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:57:31 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id n2so6466983ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW4BJ/J55m3HaZ+kiB//1SIpbvqAaKHy1tFHJFq2SiM=;
        b=D03DyicLsmL7+LboQbto/RvqJdcNMceBockZHXbCh4HJ4FleYdk3xz7sbXwHKRJi0I
         6OZ68M6amU9yMGt/fqFqLo8fJG3UBMgXIjlsR+JsyeCuDw9AyGwwy/iricPLdwi6raPE
         AZHAxxf13BfNp+uDD1UR3cRtN+X5bxFlO8y1REXdAKqEjkGqGguiddonn+es480cbD9E
         /W+MNg+57UOxpsFCDqJFk0EGNBQh/HbYxgZNPw2+rdwRRzYx+FPitwmgnFLgSdaDBMiD
         I2j5HXnAMWLGSvQEHVVsU5LxrAmh55QSv7st2Wb/puf548qlNZhaVsOL5IMfRdtJXGIT
         cyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW4BJ/J55m3HaZ+kiB//1SIpbvqAaKHy1tFHJFq2SiM=;
        b=f8ZZ21FZMAMnL1Efa1aPIaJ3EF+S26U+K5rmeMoei0n+vC5r/5XmxwlCUs7y4gi7q3
         xu0V7RsmdB7USUUWX7UriP0CLQdtuq7UMbY84MW5biEVAG8jQcIIXruVvvYgVIw/P4kf
         umBkB9fL8yKIvyiucOSX9HjMzEa43OpsFLHzz3stWFjAJ2HB+7baqIlAxvVH7uo87ro+
         YCbT164cx/EbY+1r2kkQCFjiCT+LV5DA/deIaEtjhFR/qLqHegZ8Ru4HJf6lYxGcT+BV
         MdOGNwIfXGL01ABqcYMzOPZItvfzcjnB55wLhER99EEoSog1AOOJFIZAeLzWa2SQzQX+
         VBzw==
X-Gm-Message-State: AGi0PuaQH6F6Y5zuDl5k5NMkOTG1Sd0lK+coIC8mpi0FBgJxy4JSnbFS
        gpK8R/kKIZ1HJxKcl9WWR/HncS6O2OvUIMjG1/H2Lg==
X-Google-Smtp-Source: APiQypLcvwWkQu+wlro68EBwT6VA4fjZAr+tishlnTGUIlsyIObtEHZhuupqrFQcjgQt7gKck/YiDH22XdWZaMRpPW8=
X-Received: by 2002:a5b:b92:: with SMTP id l18mr12132485ybq.7.1587430650440;
 Mon, 20 Apr 2020 17:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200415004353.130248-1-walken@google.com> <20200415004353.130248-9-walken@google.com>
 <20200420192806.GE5820@bombadil.infradead.org>
In-Reply-To: <20200420192806.GE5820@bombadil.infradead.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 20 Apr 2020 17:57:16 -0700
Message-ID: <CANN689EDVibi-EO9+S01qLW7gSpzj3i7g9g=GiH5vGGKgFz2Qg@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:28 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 14, 2020 at 05:43:51PM -0700, Michel Lespinasse wrote:
> > @@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
>                                             ^^^^^^^^
> >       .pgd            = swapper_pg_dir,
> >       .mm_users       = ATOMIC_INIT(2),
> >       .mm_count       = ATOMIC_INIT(1),
> > -     .mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
> > +     .mmap_sem       = MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
>                                                 ^^^^^^^
>
> Shome mishtake, shirley?
>
> I don't see that this particular patch buys us much.  The name 'mmap_sem'
> is still used, and I appreciate we abstract away the type of the lock,
> but wouldn't this be better?
>
> -       .mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
> +       MMAP_LOCK_INITIALIZER(tboot_mm),

Hmmm, that's significantly different from other initializers we have,
which may be a downside ? But other than that, it does seem completely
workable to me. Do you have a strong preference ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
