Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B17C3566E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173DF24653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBy54IX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBUULQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:11:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35660 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726761AbgBUULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582315874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Gz/b9tAua2Q4fMbTSmY0pGnQmTNc4CSxCSn9ArkmH4=;
        b=JBy54IX1UCgyq+QwnOaZ8l1pudNu+x/AXLJ7MUl7RSn1lQ5X+LLJJJv/RJd3MStNTDoWUQ
        8m9jEjwLexU0RWDGdzHOhtk3wNbnKo+O0sIOm79CSp7DIIqrnFHu65onohkNFPCtWKQflV
        eE30GHUrdqN1M/GWn8WnYZgVCTaOBtA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-1Bhvph2OO86luUjaCwsttA-1; Fri, 21 Feb 2020 15:11:12 -0500
X-MC-Unique: 1Bhvph2OO86luUjaCwsttA-1
Received: by mail-qk1-f199.google.com with SMTP id m25so2575897qka.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 12:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Gz/b9tAua2Q4fMbTSmY0pGnQmTNc4CSxCSn9ArkmH4=;
        b=jZRpJ1kkQF4tzYnMvZ80sFtLCLfM6txo3FgjrzGPuFHzTeuOocomX9BoizHHaKGfBl
         K6J3begw3ZRrJaRnYPIyTWnizeNbEAb4uZl93gvNJMAgGVV/HpiO6J6SVNslaXtC5kTx
         2L9/oDeqH6qN9OIR1SDGOBy90R/3sklUPHh5U90a/Itop0u1IHHYheiT5SYVHd+xUKu9
         PTXeYhR5UGS9UAkx3oQc9rOHU41Y2vVCnHGN8KNJtzCqGrrDlr+9mpXRFOlVkPBwaUq/
         5BpeaTbJIsAaJEdPt19rBY/0JgZCh7aFPyrfUmOLbpYQVWRPOrDruzi2VatdbJtALWJa
         FUUQ==
X-Gm-Message-State: APjAAAVc3RN7/YoLCZZoRlIequVGJZKcEFmdv64VZPR3ZWTX8OWqPkig
        aXGvNlqXRyAJ3ocha7UHMAT7fEXr3Bp3UXPKb6Okkwy0owXPMRjVehAFEgZEZv7yCxcbCAlPpXa
        +Fhaj7ZZJVQrwEJoRfLsinX7x
X-Received: by 2002:a05:6214:209:: with SMTP id i9mr31803591qvt.54.1582315871644;
        Fri, 21 Feb 2020 12:11:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4BkknkVZ9+EecFTrsNvRKvHosigsHM3LMGrSwNqgXCCWe84767ilsxYYyezA4GFqlHStDtA==
X-Received: by 2002:a05:6214:209:: with SMTP id i9mr31803560qvt.54.1582315871391;
        Fri, 21 Feb 2020 12:11:11 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id j4sm1985671qkk.84.2020.02.21.12.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 12:11:10 -0800 (PST)
Date:   Fri, 21 Feb 2020 15:11:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH RESEND v6 00/16] mm: Page fault enhancements
Message-ID: <20200221201108.GF37727@xz-x1>
References: <20200220155353.8676-1-peterx@redhat.com>
 <CAHk-=wjboPc5diXRfhgMQbDOxfJAW=8XyVmAVhAjx3Ha3W+u0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjboPc5diXRfhgMQbDOxfJAW=8XyVmAVhAjx3Ha3W+u0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:32:36AM -0800, Linus Torvalds wrote:
> On Thu, Feb 20, 2020 at 7:54 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > This is v6 of the series.  It is majorly a rebase to 5.6-rc2, nothing
> > else to be expected (plus some tests after the rebase).  Instead of
> > rewrite the cover letter I decided to use what we have for v5.
> 
> I continue to think this is the right thing to do, and the series
> looks good to me.
> 
> I'd love for it to get more testing, but realistically I suspect that
> being in linux-next will be the right thing.
> 
> I've been assuming this will go through Andrew. He's not explicitly
> cc'd, though (although maybe he does read all of linux-mm and has seen
> this several times as a result).

I'm very sorry for missing that.  I should have cced Andrew for every
mm patches.  Hope that's not a problem for this series.  I'll remember
to do that from now on.  Thanks!

-- 
Peter Xu

