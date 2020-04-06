Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07484C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86A924876
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAkqWlSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgDFPfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:35:18 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37979 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgDFPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:35:18 -0400
Received: by mail-yb1-f194.google.com with SMTP id 204so65146ybw.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MduM/9HJVy6bkh8pxzs1OTdZ7KT0AQSI+WZ1X2yWzE=;
        b=nAkqWlSXVzfD2OyrsJv+DJCzxxvRXhc2u3dO5RWOKYsugkUEH3VVSUI1BilNYk9C31
         WRP9tVM7eYAvgL4lTtuvt7yJmwSsHFVBG+n6Img5X2LgDmDxIHTtoNkagE+qRKFDL7Jb
         o+zyIsJpA2SZeW5NOfkMTrCIHulQ6XoCM+SeJE+AG32lUgPjKxVD74Sq5lv3dqlkAv8v
         ecG7O17JF8MUs+UxoEq16pqhCUws/LIaFZKpipYOngeFqnCpAnAn5OWwmw7oFMU6Qef/
         UUjov5qUBTajxiSQQ7XCNObeYX+liBiTRAnw04gUAUy28YW9E7btXfKk42fFXhwtIt3H
         FpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MduM/9HJVy6bkh8pxzs1OTdZ7KT0AQSI+WZ1X2yWzE=;
        b=udb5kP5iIHNBY4c8ivBsP/cL743JgXOgMomKcRd7CBq+MMrSL2U7/TBGEiz267npCf
         30V64SXz8l1FjJu0ONiOTH5u8JralqB3PV0QM7XzixbreQKefTIxFe4Nxlu83bMRsIYU
         6lOonP4EaFsxUB1JHqAQcPouJbJLFbiBQDNpqYYuetF5rRKH7pkjrMDbfcjzEDDhpYiW
         zwKYwwvzZoOQ9pEYnTzW1wbS2Dznf7bUOgcLdhgOCecbYUzc+OiKcVY1ElV3t1v+eqBF
         rvet+oduzjho7fBRBaSkMviuRiTpck6fCznd4kq5Nlvc/HodLPxCLpI5iKMWJPz+sjpx
         pTFA==
X-Gm-Message-State: AGi0Pub68XQWps9Bx9AIRIwuI9nMqMQ9ubS7t2UMYrjAW7hHU13ATkUx
        hxeihPH98fMBRVzO0JZVQ6vP/9/GyEUPBVoIZJx0RTFZPk8=
X-Google-Smtp-Source: APiQypK4wWH0C6H6p51kRfIEovjLl5GRkWHPGwq1kBpRoJFoPHWOoWfvf1XDtP7x6tZMrnw9T7I5tse3rXnBcHoVtQ8=
X-Received: by 2002:a25:d382:: with SMTP id e124mr33930648ybf.162.1586187316742;
 Mon, 06 Apr 2020 08:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200327225102.25061-1-walken@google.com> <20200327225102.25061-7-walken@google.com>
 <20200401134234.GR20696@hirez.programming.kicks-ass.net>
In-Reply-To: <20200401134234.GR20696@hirez.programming.kicks-ass.net>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 6 Apr 2020 08:35:03 -0700
Message-ID: <CANN689H1VjW4aC8HuLEtb8YrVyAJ0t6OVM6w2_o1+P2=9Mt6Gw@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] mmap locking API: convert nested write lock sites
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 6:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 27, 2020 at 03:50:58PM -0700, Michel Lespinasse wrote:
>
> > @@ -26,6 +31,12 @@ static inline void mmap_write_unlock(struct mm_struct *mm)
> >       up_write(&mm->mmap_sem);
> >  }
> >
> > +/* Pairs with mmap_write_lock_nested() */
> > +static inline void mmap_write_unlock_nested(struct mm_struct *mm)
> > +{
> > +     up_write(&mm->mmap_sem);
> > +}
> > +
> >  static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
> >  {
> >       downgrade_write(&mm->mmap_sem);
>
> Why does unlock_nested() make sense ?

I thought it would make things more explicit to match the nested lock
with the corresponding unlock site; however this information is not
used at the moment (i.e. the nested unlock is implemented identically
to the regular unlock).

Having the matching sites explicitly identified may help when
implementing lock instrumentation, or when changing the lock type
(another patchset I am working on needs to pass an explicit lock range
to the nested lock and unlock sites).

I'll admit this is not a super strong argument, and can be deferred to
when an actual need shows up in the future.
