Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75514C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472F620679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clLQ6l6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBUJHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:07:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727629AbgBUJHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582276029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GREwfrgxkk1HbO+SZaRpjMMVBwgQQJRkF803U5Z9C54=;
        b=clLQ6l6Tr8GG4aVn4CDeGiYvneqFOjvjKL5nahXLPoMUsgTWIOQkMmFQzhifry8nfG+Cao
        /UOoL0vGN9jkWlKREiOf4+VsXW/4grj6jRqSo0I9kp2PB8cwGM3jSUx2lqSmZDCFdGDP9z
        ilCwVQ5Pfcc/0xzrgrRGeNhXzqhj7UA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-x6k32M7WOVWOg9Nm-d5hjw-1; Fri, 21 Feb 2020 04:07:07 -0500
X-MC-Unique: x6k32M7WOVWOg9Nm-d5hjw-1
Received: by mail-qv1-f72.google.com with SMTP id p3so916169qvt.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 01:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GREwfrgxkk1HbO+SZaRpjMMVBwgQQJRkF803U5Z9C54=;
        b=UGJaxlszWYRHGP0nc/qWcHbppke+5F6U0szu/XIYEtPmxCHBxRc62V7nbKSlFGbxTF
         o2R5Cz3EcH1GddZcvwyBFY5+C9pqhb4q7DK30xwtZMVyMGyDN5pMcY9iIp/XHTvqmvaT
         uVUP0EHF5ARZuZssVZ4ut8UfEtWEWFhOQ3JFfbhfDXw93xlvWkQtEOty3Je1PJurMhAi
         7SweoHhLRZMCMf2KqYInLhgXvYnI4BOnQPvgQG8KAWWyJSyNq7amMw5u0IxD0D0QFgYd
         UYjZjqaGxXMnqZsKllIHWRbvRCcn/g+SJBp+uQebwbh2P62yDdaW4VpF0ppARrgzplYt
         9+rw==
X-Gm-Message-State: APjAAAWNNBZ2+PioCJh3O4hXrwSmbdtpk8/WViIG+0ZLE5Q8t50VL6w+
        Plo3+8VSlee5UcaDQa94rGofuZvh7D0VhSKl5Liwix3/xJDYxytQuP5YJfbQhVZyyLqUeQ5dKP1
        SWJak74HwJGEn8PLB7Tp9LA05
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr1543819qke.194.1582276026622;
        Fri, 21 Feb 2020 01:07:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1yfT9Eg0qzuzZet7xGSWjuarIHmnyu/s75tE6f74fiWaY7L+P44sC2l0CgRisg/MBESaIGg==
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr1543800qke.194.1582276026376;
        Fri, 21 Feb 2020 01:07:06 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
        by smtp.gmail.com with ESMTPSA id w1sm1262373qtk.31.2020.02.21.01.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 01:07:05 -0800 (PST)
Date:   Fri, 21 Feb 2020 04:07:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
Message-ID: <20200221040237-mutt-send-email-mst@kernel.org>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:16:54AM -0800, Alexander Duyck wrote:
> On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >
> > Currently when truncating shmem file, if the range is partial of THP
> > (start or end is in the middle of THP), the pages actually will just get
> > cleared rather than being freed unless the range cover the whole THP.
> > Even though all the subpages are truncated (randomly or sequentially),
> > the THP may still be kept in page cache.  This might be fine for some
> > usecases which prefer preserving THP.
> >
> > But, when doing balloon inflation in QEMU, QEMU actually does hole punch
> > or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
> > So, when using shmem THP as memory backend QEMU inflation actually doesn't
> > work as expected since it doesn't free memory.  But, the inflation
> > usecase really needs get the memory freed.  Anonymous THP will not get
> > freed right away too but it will be freed eventually when all subpages are
> > unmapped, but shmem THP would still stay in page cache.
> >
> > Split THP right away when doing partial hole punch, and if split fails
> > just clear the page so that read to the hole punched area would return
> > zero.
> >
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> 
> One question I would have is if this is really the desired behavior we
> are looking for?
> 
> By proactively splitting the THP you are likely going to see a
> performance regression with the virtio-balloon driver enabled in QEMU.
> I would suspect the response to that would be to update the QEMU code
> to  identify the page size of the shared memory ramblock. At that
> point I suspect it would start behaving the same as how it currently
> handles anonymous memory, and the work done here would essentially
> have been wasted other than triggering the desire to resolve this in
> QEMU to avoid a performance regression.
> 
> The code for inflating a the balloon in virtio-balloon in QEMU can be
> found here:
> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L66
> 
> If there is a way for us to just populate the value obtained via
> qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
> which is the size I am assuming it is at since you indicated that it
> is just freeing the base page size, then we could address the same
> issue and likely get the desired outcome of freeing the entire THP
> page when it is no longer used.
> 
> - Alex

Well that would be racy right? It could be THP when you call
the function, by the time you try to free it, it's already
split up ...


Two more points:

1. we can probably teach QEMU to always use the pbp
machinery - will be helpful to reduce number of madvise calls too.

2. Something we should do is teach balloon to
inflate using address/length pairs instead of PFNs.
This way we can pass a full THP in one go.

-- 
MST

