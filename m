Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A24C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E991C223FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lk+g/0wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgDFPtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:49:35 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44094 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgDFPte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:49:34 -0400
Received: by mail-yb1-f196.google.com with SMTP id 11so65816ybj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/3b78oJ09xJkiGfrBiJR5l3+5N4Ozbz5u6ig6+HSko=;
        b=Lk+g/0wmVGpGlrqBdfdX+z0aKzeA4LGEFY2825RDe1iQv8Cm7vlebpkdzF0wU3fKny
         mB5+W+fc8rVAYKW5ArHQOt6x0neNCj2oNVVD4xNudOalqTj3dKhC580gdG04oFb3gMB3
         DAhzLMgpWWbquWBXtNuCyd/MTtI+DYWY3wDcEPXYJw1pjKj04mHP4k148ZvuzFly/W3f
         3tDw8KUXg+jAxHeiX0GPRez01zErS0IfYusuE54oVqv8TzlPHnLnSjS6IKPfN2C4upED
         51MrCT0TOHsrfTjF9+iRZapEvp7meWjZ+Tu0wvWpYB/A4ZUwqHcE5N96otIRiSC3sttN
         9Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/3b78oJ09xJkiGfrBiJR5l3+5N4Ozbz5u6ig6+HSko=;
        b=U3AuLynyj8+6sX+68w+EwcSvHaeUIlRG9Oehl61y2ms7A8Hq2V1J1wqTLNd+QPoDs3
         cZbTIePNlwKYAUw5Xr4UrqDi02LwJiTUt+y78me5kPWsy+pmFXSP65HqHsUgj+OCE5UI
         SKXfWvY3NHnPmItXtf7ozFZJZ5i1SmK0F+YbUkvYVjpDBUL208524LZ3TaW4ZYCIIaFr
         UXZ0suAL2Ca38zPRh1WNT39TYxD7XkfPJRU8bXk0WrO39TwlExarVHEFTWXFlS8Ps95U
         EAKQpD3pSjSejIHFpYmOrGMJ1uBsckNcNUVlPYiujHr4dxiDKEH/eaNhNqBdD8w9BXkv
         evyg==
X-Gm-Message-State: AGi0PuZULVWNrHzmhH7rwU6tbu05tvulcJgNGOdLW9kIkhVUGt1kQaoP
        ShnAvWjtks74ebyv0LTiU/QhYKctiAsK4GTifh8Xerw2nnQ=
X-Google-Smtp-Source: APiQypI3Q9m2jolxt+9cNUCkVprdmIltsXpYYGqSNMxBq5Jtyad05BwTo8VY+vSoJTNUvv2Uqrkf7jE2UT0m9E+2rRE=
X-Received: by 2002:a5b:cc7:: with SMTP id e7mr37091185ybr.7.1586188173435;
 Mon, 06 Apr 2020 08:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200327225102.25061-1-walken@google.com> <20200327225102.25061-11-walken@google.com>
 <20200401134853.GT20696@hirez.programming.kicks-ass.net>
In-Reply-To: <20200401134853.GT20696@hirez.programming.kicks-ass.net>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 6 Apr 2020 08:49:21 -0700
Message-ID: <CANN689F9YSG7US=daU7Gp2diEkeb2K6cHs0fsBuM9b3+Vo=n8Q@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] mmap locking API: rename mmap_sem to mmap_lock
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

On Wed, Apr 1, 2020 at 6:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 27, 2020 at 03:51:02PM -0700, Michel Lespinasse wrote:
> > Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> > should now go through the new mmap locking api. The mmap_lock is
> > still implemented as a rwsem, though this could change in the future.
>
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index c28911c3afa8..a168d13b5c44 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -431,7 +431,7 @@ struct mm_struct {
> >               spinlock_t page_table_lock; /* Protects page tables and some
> >                                            * counters
> >                                            */
> > -             struct rw_semaphore mmap_sem;
> > +             struct rw_semaphore mmap_lock;
>
> It would be best if you change the type too.

I suppose you mean wrapping the struct rw_semaphore within a new
struct ? I did not do that in this patchset because there remains some
calls to lockdep_assert_held() on that field, which imply that the
field must have a .dep_map field that's not tucked away behind an
additional struct.

I have another patchset that reimplements the mmap_lock as a different
type (for range locking), with its own dep_map handling, but it's not
ready for pushing to mainline yet...

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
