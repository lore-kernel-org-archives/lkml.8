Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D941C54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5895920782
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXXBWTHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgDUAwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:52:00 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990D2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:52:00 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n188so6471824ybc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzVEjIhE3G8lvkyzAwCPpB3DMUYR5E+cR65yZNSQbxc=;
        b=tXXBWTHU+2qNp9K4xs2Ulr+LHFl6T2MeUb2ilsTIF1Z72AADbToaiIyMqNr0KwUVxk
         u6EvbZSc8mCoVUXlTEVkVN+U7Qa3ceu1tQUD77MTZUK0UbRVGeApyRGTKG5xPAqpfQL+
         oE3ANckoo6XeBV78XCLsQeDJE/PiyxzS5vAkiBSi4bfMiOqVU8IjAfd4VGzEedxJqnGW
         haC221Mr4P0tqgQokgCAIsS+iXqX97pnmTLfVlPIVJKK1SPOGiSSfCylJIjCdOlwSHSX
         k28nvoZ+zQGUl0hlqy2x3si0WSSh+uNJiWEM8Qx/vp3NtdqZTl5omyKqKSXxoZiBxuWb
         y84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzVEjIhE3G8lvkyzAwCPpB3DMUYR5E+cR65yZNSQbxc=;
        b=tEUHBsdmevnH7BHzeOnMi8CftPXTJYnF9gLQAmWvOQlwBMPzbki0rBGnOO+0vdVuZ3
         2uaWSIEX/kIwfUwpVIy2wm9Zo4U0q/Fn96Rr24LKFVx1Jnt+e7n8DCfStE8ncDGezctb
         cE94GPoj/j23c3nfwqbe4YvvgkGVJa8WllvsdNU8FEmup5l4OUF4fKSYtAVshtHZB+EK
         sWGQKwTF/EsLdIIAc4ElAJNm4bIoiiIsnoMLypkB1GjjNFzIpXqN3cIs++VEHGugNjS8
         7n7Fi6+SsU2vVHPChtifsReGAZWQZmvEd+Fbbj2xN654etPBVZNprhvffPfNFaIeJkuT
         l+4w==
X-Gm-Message-State: AGi0PuYSJYZ2TB6r2m0qf0PN131ADjR3JVWHo1of3oNaqQTMrddwvmxC
        3rb2w73p58c/H9oxf9GcboRqgl0jwj9IGWESs1Splg==
X-Google-Smtp-Source: APiQypI2k2dh6JVBflHjutO4XGPb5dcGoF3tBdky35qHOVENePPd/Bjq4BAYpRTFPx6qgQKk6qchd7f97Pq6xebk/GM=
X-Received: by 2002:a25:13ca:: with SMTP id 193mr20028377ybt.320.1587430319630;
 Mon, 20 Apr 2020 17:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200415004353.130248-1-walken@google.com> <20200415004353.130248-7-walken@google.com>
 <20200420193310.GF5820@bombadil.infradead.org>
In-Reply-To: <20200420193310.GF5820@bombadil.infradead.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 20 Apr 2020 17:51:47 -0700
Message-ID: <CANN689Eu72s1FTCfgXp8NZJ80jj9-pUNdj6gw4OKZPa1pR5+jg@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] mmap locking API: convert nested write lock sites
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

On Mon, Apr 20, 2020 at 12:33 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 14, 2020 at 05:43:49PM -0700, Michel Lespinasse wrote:
> > @@ -47,7 +48,7 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
> >        * when the new ->mm is used for the first time.
> >        */
> >       __switch_mm(&new->context.id);
> > -     down_write_nested(&new->mmap_sem, 1);
> > +     mmap_write_lock_nested(new, 1);
>
> This should have already been using SINGLE_DEPTH_NESTING.  1 is
> uninformative.

Sure, I can change that.
Note, all mmap_write_lock_nested call sites use single depth nesting,
so I'm not entirely sure if the argument should be passed to
mmap_write_lock_nested in the first place ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
