Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070A2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84DC21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfdm8KVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCBUHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:07:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbgCBUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583179656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xNlKnbLN0v72Ztmp2WjTjNwQkPfjH13OEcSBlAuwDK8=;
        b=Dfdm8KVE6Ypw06/dZkBdrBSZVCf4KoPYqs0gG3VWaMddk1NPRYz7zPX6N8VYR7eleYTwhg
        kgbPpn9Cqvv3DwilERSqmQAJd9jtuPjWcpu/BWXwJUe7v+rw8uktoQLBtUbaMBWZmzoQWp
        BiLpH072Rv7t25HZVb4ykAfTsx02HKc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-dEytM5RYNlSAYGUHdHDTtQ-1; Mon, 02 Mar 2020 15:07:35 -0500
X-MC-Unique: dEytM5RYNlSAYGUHdHDTtQ-1
Received: by mail-qv1-f71.google.com with SMTP id g11so582413qvl.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 12:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNlKnbLN0v72Ztmp2WjTjNwQkPfjH13OEcSBlAuwDK8=;
        b=C2Jvm1I/hwI5HunQQPvBq1XQNjlCVvDN+lLiAQybqlx1BAKfWNqWsF7vL570mSj65F
         PN5LvhFPW6zwm46/M3jX26j09N2E3S5URcHq9+5VIEPcmefupd58xqHUgcrOJKaMyZmy
         Hbg30i5TCuYO4slDn91BvJmhgpJPYxYqavFS7PNFW0pP/2QJmhnxS0XuW28k3Auzgz5H
         DSGdcdceFG48jlKou9gGVP1+zzRsUxtMZA3ZodhK3Y3byb03L+TIQSZuhXGThNzT5VAD
         PfEQTvBtxP9PxO2YiJydNceY+C6VbdnVimUhR40t8XKtKDu8PVcqCnCjxQw43xNyubY8
         qB1g==
X-Gm-Message-State: ANhLgQ0HZT5rwVNlgX7zQQi6wkd78eatRWMSs7eOGEF/3CDwlJz4QUVA
        +9YNduEejEVUBHxYCYRwRTG+cwBpgYw1B5wGn2ietoOOP1VRSSjMr66oFZruJBEtC3CZgF/V4qG
        dT6QTmuwO+IjkHbxj4+v+JnPH
X-Received: by 2002:a05:620a:a1d:: with SMTP id i29mr818695qka.343.1583179655108;
        Mon, 02 Mar 2020 12:07:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt4mLwVG8IPiAAyTTiGWUspe6vZEnd6gPc3TKBTEpjy2EAlI/KijkqJ4tNw1XwrD+Qjdbn2Wg==
X-Received: by 2002:a05:620a:a1d:: with SMTP id i29mr818663qka.343.1583179654817;
        Mon, 02 Mar 2020 12:07:34 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i16sm10439193qkh.120.2020.03.02.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:07:33 -0800 (PST)
Date:   Mon, 2 Mar 2020 15:07:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
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
Subject: Re: [PATCH RESEND v6 02/16] mm/gup: Fix __get_user_pages() on fault
 retry of hugetlb
Message-ID: <20200302200731.GA464129@xz-x1>
References: <20200220155353.8676-1-peterx@redhat.com>
 <20200220155353.8676-3-peterx@redhat.com>
 <795d9bd0-3f82-d5ce-fe03-4d405d9e6bce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <795d9bd0-3f82-d5ce-fe03-4d405d9e6bce@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 08:02:34PM +0100, David Hildenbrand wrote:
> On 20.02.20 16:53, Peter Xu wrote:
> > When follow_hugetlb_page() returns with *locked==0, it means we've got
> > a VM_FAULT_RETRY within the fauling process and we've released the
> > mmap_sem.  When that happens, we should stop and bail out.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/gup.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 1b4411bd0042..76cb420c0fb7 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -849,6 +849,16 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> >  				i = follow_hugetlb_page(mm, vma, pages, vmas,
> >  						&start, &nr_pages, i,
> >  						gup_flags, locked);
> > +				if (locked && *locked == 0) {
> > +					/*
> > +					 * We've got a VM_FAULT_RETRY
> > +					 * and we've lost mmap_sem.
> > +					 * We must stop here.
> > +					 */
> > +					BUG_ON(gup_flags & FOLL_NOWAIT);
> > +					BUG_ON(ret != 0);
> 
> Can we be sure ret is really set to != 0 at this point? At least,
> reading the code this is not clear to me.

Here I wanted to make sure ret is zero (it's BUG_ON, not assert).

"ret" is the fallback return value only if error happens when i==0.
Here we want to make sure even if no page is pinned we'll return zero
gracefully when VM_FAULT_RETRY happened when following the hugetlb
pages.

> 
> Shouldn't we set "ret = i" and assert that i is an error (e.g., EBUSY?).
> Or set -EBUSY explicitly?

No.  Here "i" could only be either positive (when we've got some pages
pinned no matter where), or zero (when follow_hugetlb_page released
the mmap_sem on the first page that it wants to pin).  So imo "i"
should never be negative instead.

Thanks,

-- 
Peter Xu

