Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343BBC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C28208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZk42z7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgAPFl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 00:41:59 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37842 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgAPFl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:41:59 -0500
Received: by mail-qv1-f68.google.com with SMTP id f16so8554370qvi.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 21:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMwt4Kf+lwn4jbueLKy88cnlrJ7dUdn8dfwXc0Z+Ehw=;
        b=NZk42z7aa263+BZfJm1pHilO6y1pR/qzdi+cyOYjOjOhSpPO9jm4n2LfRQjz829ilN
         E1vBqGi4dYo8BDgwZzTJ093qLODB/4LTdnKNFpzsCglf7E5hhaosdgNjyfIIzohsKrch
         Z5Vhds+CuGj3xQ+6Wmk2vIDR0iVoJ9SnpUKTtLVZJh40mek1xNPnnRi5CvG6l4nOIinQ
         UicHiwqwysj/fjhV/ZrZ2mGF5wemdUhPU8xOR//DNisfUOYSXPkFiBqB9snHoFOBskDe
         ocnYOopmNQeqCk7lZGpAqqOXLNNagr9V9WNgXVyQkx3yxYpkp5GglPEmY3uX3ZD3lWq5
         x2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMwt4Kf+lwn4jbueLKy88cnlrJ7dUdn8dfwXc0Z+Ehw=;
        b=e4gAuGlFv0WrqJcq6qwurNdwaV3WzOIi1jjIy5qe+kmlp3eJ3CvWC5dSWMChpZGdd1
         yBxcfhpDToiolqDc4kYCWMQvup0LZ42/guAXeJOaBj1uZbSP0EiJDDGM8/GUuiONvfex
         gaqp/+3hxsU8Y5rEVWmFPYYsV2ockYCylSeV1J//JVD0jci57zDILr8wuTuE7ASjhcmu
         nE2yiiH6OJOm9TBksndSSlqJ6Zh+qovjzrAB143xuNhE0R49eUL+CkDEOEu4tpMAC2mo
         wEl47WZ7GPyACi9f+R7S4fAKcLMZt7WyMRYqh+LQbL5rCd+EiXU8dk23zk5naXzAAUNs
         kgNQ==
X-Gm-Message-State: APjAAAWj7qMB0wVXzDx0s5VQl1jkshJFHmrEhKYu1q0ekweh5M3DlVv6
        RNE5/uYvLcbWDRaPuH8FZ1VTCYVM/LzwBTWYrTxvUg==
X-Google-Smtp-Source: APXvYqx5s6/wkJ/FCVo+bP1iquEi9GKltLpGTyiysYaPoc5DHaKUBWWZeqt+2WlUo+U6YcGp9qDyOdT2twEugQ0RQuw=
X-Received: by 2002:a0c:c351:: with SMTP id j17mr1008167qvi.80.1579153318184;
 Wed, 15 Jan 2020 21:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
 <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz> <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
 <20200115150315.GH19428@dhcp22.suse.cz> <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
 <20200115190528.GJ19428@dhcp22.suse.cz>
In-Reply-To: <20200115190528.GJ19428@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 06:41:46 +0100
Message-ID: <CACT4Y+b5HJW9PhjkSZ+L09YqQt08ALCtudHV4m5x5qv+xH-2Yg@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy.c: Fix out of bounds write in mpol_parse_str()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>, yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 8:05 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > On Wed, Jan 15, 2020 at 1:54 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > >
> > > > > On 1/15/20 6:54 AM, Dan Carpenter wrote:
> > > > > > What we are trying to do is change the '=' character to a NUL terminator
> > > > > > and then at the end of the function we restore it back to an '='.  The
> > > > > > problem is there are two error paths where we jump to the end of the
> > > > > > function before we have replaced the '=' with NUL.  We end up putting
> > > > > > the '=' in the wrong place (possibly one element before the start of
> > > > > > the buffer).
> > > > >
> > > > > Bleh.
> > > > >
> > > > > > Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
> > > > > > Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
> > > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > >
> > > > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > > >
> > > > > CC stable perhaps? Can this (tmpfs mount options parsing AFAICS?) become
> > > > > part of unprivileged operation in some scenarios?
> > > >
> > > > Yes, tmpfs can be mounted by any user inside of a user namespace.
> > >
> > > Huh, is there any restriction though? It is certainly not nice to have
> > > an arbitrary memory allocated without a way of reclaiming it and OOM
> > > killer wouldn't help for shmem.
> >
> > The last time I checked there were hundreds of ways to allocate
> > arbitrary amounts of memory without any restrictions by any user. The
> > example at hand was setting up GB-sized netfilter tables in netns
> > under userns. It's not subject to ulimit/memcg.
>
> That's bad!
>
> > Most kmalloc/vmalloc's are not accounted and can be abused.
>
> Many of those should be bound to some objects and if those are directly
> controllable by userspace then we should account at least. And if they
> are not bound to a process life time then restricted.

I see you actually added one GFP_ACCOUNT in netfilter in "netfilter:
x_tables: do not fail xt_alloc_table_info too easilly". But it seems
there are more:

$ grep vmalloc\( net/netfilter/*.c
net/netfilter/nf_tables_api.c: return kvmalloc(alloc, GFP_KERNEL);
net/netfilter/x_tables.c: xt[af].compat_tab = vmalloc(mem);
net/netfilter/x_tables.c: mem = vmalloc(len);
net/netfilter/x_tables.c: info = kvmalloc(sz, GFP_KERNEL_ACCOUNT);
net/netfilter/xt_hashlimit.c: /* FIXME: don't use vmalloc() here or
anywhere else -HW */
net/netfilter/xt_hashlimit.c: hinfo = vmalloc(struct_size(hinfo, hash, size));

These are not bound to processes/threads as namespaces are orthogonal to tasks.

Somebody told me that it's not good to use GFP_ACCOUNT if the
allocation is not tied to the lifetime of the process. Is it still
true?

In the end if user controls either size or number allocations, they
should be accounted, and it seems we still have thousands of
unaccounted ones. There are dozens of kmalloc's in netfilter code and
none of them use GFP_ACCOUNT...



> > Is tmpfs even worse than these?
>
> Well, tmpfs is accounted and restricted by memcg at least. The problem
> is that it the memory is not really bound to a process life time which
> makes it effectively unreclaimable once the swap space is depleted.
> Still bad.

I see. If I understand it correctly, this one is actually better than
all these non-GFP_ACCOUNT allocations.
If I would DoS a box (intentionally or unintentionally, just a bug in
my program) I would probably go for one of these easier ones without
GFP_ACCOUNT.
