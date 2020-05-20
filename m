Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47295C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA4C20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1tBNZ3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgETICz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETICy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:02:54 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E5C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:02:53 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id g79so535132ybf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMh4r2XDfrH+QhUAjbGNaAAedxRKs2n77NOZ3gAlNgM=;
        b=j1tBNZ3vq8QjvMUxKQLFkSaXLnMqXwQrzxwRSQwsFakURnOmf52OxUufogNpo15Vi+
         TqcklyRtsYt6ye34t3EbcbPFOWiFoXFKBPkjjm97yJrD7k3ilSGHzcoiLsffHpQWknjo
         YATZgknEk4I7HHu7fnVchqq+bkDBzrh8l5gvO5p+v/4G0RHJ651mTilPUYKq2M2l1v9U
         rR2V24mTZajqpmBGTbQL3SzWGzXWL02NaqCLZjcquUlfitFdAKw3WhsUuC81K71ZBr+P
         QfwZ82hxj7CVZhB5ho1ZoDGwBUjyecyoU8I/PPQ/NgrVAcqzP9MAWcu+XW+TOijNZXxv
         1S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMh4r2XDfrH+QhUAjbGNaAAedxRKs2n77NOZ3gAlNgM=;
        b=ZbNdgGpT1h3NQDXiHtCVQxXgFQ85yvalwRaKW4TufkMIe1bkg883psC29E6pvVXbY9
         keLG4KWZdUWoYIW85tbvTO5ZwXQy8CAs5jftz3zET+KzOKK7slOdqT1dnLNO/FrBHvo2
         /ME7HYqTTRrQmmc6xDhz73xp/W4J8F2aqxTpKkgBLXKRLI46ym9+Bxcd9JXee40/bK64
         E5eMK/a0H+fpi28jMXsO01iR/XRacfYF6RfcToOVnFvjGRaiCwmg9JLunfW66h3V30VS
         QL7mrB6tQzS0uO6BV8tI2jBUZw4y9cgyN1wdCX6Bbx70OcwwQDswXluL0mzV71lkZoXA
         mymw==
X-Gm-Message-State: AOAM530y4rIstlcFXoH+GCu6u59KiJSXUXSq66JlavHHuZqZcu1Jl2y9
        JQYtn0EcYfqw2jrYonKca04x24KEjuEZ9KFcE6q2gw==
X-Google-Smtp-Source: ABdhPJwQP7HRbxwX6H9f7OR6UQElQShg+ArQT0pXrQiBLvOhGRi2/6SEChtkn7AJjr2RHgYOnsxQYJKuH+CxrxrzCk4=
X-Received: by 2002:a25:ab4c:: with SMTP id u70mr4884998ybi.298.1589961772695;
 Wed, 20 May 2020 01:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200422001422.232330-1-walken@google.com> <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org> <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org> <20200424012612.GA158937@google.com>
 <20200424013958.GC158937@google.com> <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
 <20200519131009.GD189720@google.com> <7c540ac9-ba44-7187-5dc2-60b4c761e91c@linux.ibm.com>
 <20200519153251.GY16070@bombadil.infradead.org> <10d48b77-5c6e-2e10-84e6-16cdd76a45f1@nvidia.com>
 <CANN689EubtJL2mbcz5Au05nW87gVuY-19r7nZd9x0y320PUb0g@mail.gmail.com> <9c45327f-5542-c033-ec5e-201e9b0583aa@nvidia.com>
In-Reply-To: <9c45327f-5542-c033-ec5e-201e9b0583aa@nvidia.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 20 May 2020 01:02:39 -0700
Message-ID: <CANN689Gpg1dCRvujUiFE91r4STGk8MCiUOB7wpfO9eDGneeEiQ@mail.gmail.com>
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Wed, May 20, 2020 at 12:32 AM John Hubbard <jhubbard@nvidia.com> wrote:
> On 2020-05-19 19:39, Michel Lespinasse wrote:
> >> That gives you additional options inside internal_get_user_pages_fast(), such
> >> as, approximately:
> >>
> >> if (!(gup_flags & FOLL_FAST_ONLY))
> >>          might_lock_read(&current->mm->mmap_lock);
> >>
> >> ...not that that is necessarily a great idea, seeing as how it merely changes
> >> "might lock" into "maybe might lock".  :)
> >
> > I think that is completely fine, makes sure everyone not using
> > FOLL_FAST_ONLY realizes that the call could block.
> >
> > Can I ask you to add that assertion in your patchset ? Based on
> > Matthew's feedback, I would do it in my patchset, but it doesn't seem
> > worth doing if we know this will conflict with your changes.
>
> Sure, that's no problem. Although it looks like my changes may land
> in mmotm first, and then your patchset, so maybe the right move is to
> make this change *after* both of those things happen, yes?

I don't have a strong opinion on this. I would suggest you add the
might_lock_read() assertion and whoever comes in second will deal with
the conflict by changing mmap_sem to mmap_lock in that assertion.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
