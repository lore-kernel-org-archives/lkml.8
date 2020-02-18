Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A425DC34045
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D75C22527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nbl5NQ2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBRQLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:11:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgBRQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582042281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xtVxSnLQhBRQi9E46Vg+UFDvswVXyAHUtw4gNVo9AWU=;
        b=Nbl5NQ2CQpfCnkM4+3mdtccT/XwWGnTSHT3M3yptzXkKAskC6LQpl8lXOgFEVNzXl/MU4h
        7MloLqgg5cJ5t/zvetFLjeHbxAN+e252YF4rAochi5732lLihEOTRlekmQKoLplbhow3Xw
        IR4ZHSjJYYH897eoIzW0mWwZuwyT+V8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-5gykuEayP_-1ynYUJN7k6A-1; Tue, 18 Feb 2020 11:11:16 -0500
X-MC-Unique: 5gykuEayP_-1ynYUJN7k6A-1
Received: by mail-qv1-f71.google.com with SMTP id r9so12682688qvs.19
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtVxSnLQhBRQi9E46Vg+UFDvswVXyAHUtw4gNVo9AWU=;
        b=gzY6B+TcMom1sOngMWZbM0e9c/PSRo1jhokVPwiYLHbNm9gXpgPnVj4KQzZm9vZHtL
         h3l3oEdG2MIt5A7cpY1w3oN1zNFXZJck5coOJVWqNHL8Bj9C/LXvB8PhBSGGSJaA0vSd
         dvozfPC4qGgihnzMHzJ430+RBo4xRwLpEYYrz0m1+i9dTCROXHtEIgiRGwVzC76ANOPm
         Upat9bbCxe4qOXbr/41eLvXSbzltd6zwSp6wau2R2KM1Yw7uv9cO6nNfiPFvdjmI9gZc
         k3I7ad4W0KgX3mihK4peukqAVpb7VJK/1Jit5Rlcu1rw4OvLyBYJvziyPqvQfxg9ZT+x
         dOaQ==
X-Gm-Message-State: APjAAAUO5OFW1Ay1EqrddV67gHl7CsS0uSio8YxETvNUXCGtvBec9l0B
        pCdyOU8pLa8VAu5VcOhAs1iBFUnFpS6JyRrNlQwYze5WgeUOBajJSN1eGVfLxknU1FJzxYSA7n+
        HRPOR4U1M+OstRJF0t4fdnRPq
X-Received: by 2002:ad4:4d85:: with SMTP id cv5mr16879803qvb.171.1582042276099;
        Tue, 18 Feb 2020 08:11:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsAFNHnhCqjsdFksUjKyJOjKL33lq+lIUXEzX2KQ7pwl8HAXt1k5OJPRMX/bXlWcKQWVks9w==
X-Received: by 2002:ad4:4d85:: with SMTP id cv5mr16879778qvb.171.1582042275771;
        Tue, 18 Feb 2020 08:11:15 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id 65sm2013694qtf.95.2020.02.18.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 08:11:14 -0800 (PST)
Date:   Tue, 18 Feb 2020 11:11:13 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Bobby Powers <bobbypowers@gmail.com>
Cc:     linux-mm@kvack.org,
        Kernel development list <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 00/25] userfaultfd: write protection support
Message-ID: <20200218161113.GA1408806@xz-x1>
References: <20190620022008.19172-1-peterx@redhat.com>
 <CAArOQ2Vbpyu=JGfWNgOSQbXe15WzAB6VSah1OV8Cbx99bf0AXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAArOQ2Vbpyu=JGfWNgOSQbXe15WzAB6VSah1OV8Cbx99bf0AXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 07:59:12PM -0800, Bobby Powers wrote:
> On Wed, Jun 19, 2019 at 7:20 PM Peter Xu <peterx@redhat.com> wrote:
> > This series implements initial write protection support for
> > userfaultfd.  Currently both shmem and hugetlbfs are not supported
> > yet, but only anonymous memory.  This is the 4nd version of it.
> >
> > The latest code can also be found at:
> >
> >   https://github.com/xzpeter/linux/tree/uffd-wp-merged
> 
> Hi Peter - I ported the branch you had above on top of v5.4.20 (what I
> happened to be running locally), and fixed one issue that was causing
> crashes for me:
> https://github.com/bpowers/linux/commit/61086b5a0fa4aeb494e86d999926551a4323b84f

Hi, Bobby,

Thanks for playing with the branch!

Yes, this should be needed if you have 7d0325749a6c ("userfaultfd:
untag user pointers", 2019-09-25) in your base branch where the
address is replaced by its pointer.

> I wrote a small test program here:
> https://github.com/plasma-umass/Mesh/blob/master/src/test/userfaultfd-kernel-copy.cc

Just FYI that there's some other tests/libraries over there [1,2].
Also the series has the uffd selftest for write-protection as well.

> and write protection support for userfaultfd (with eventual shmem
> support) would be _hugely_ helpful for a userspace memory allocator
> I'm working on.  Is there anything I can do to help get this
> considered for mainline?  We have some time before the 5.7 merge
> window opens up.  Tested-by: Bobby Powers <bobbypowers@gmail.com>

Thanks for the tag!  Yes it would be great if we can continue to work
on those, but for now let's see whether we can move on what we have
first (it's already two series without much certainty on whether it
could get merged soon).  Considering that we've got quite a few pings
again for either the mm retry series and the write-protect work, I'll
rebase the two series, test & post soon this week.  I'll keep you in
the loop.

Thanks,

[1] https://github.com/LLNL/umap
[2] https://github.com/xzpeter/clibs/blob/master/gpl/userspace/uffd-test/uffd-test.c

-- 
Peter Xu

