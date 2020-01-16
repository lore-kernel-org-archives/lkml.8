Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E493FC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C3621582
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jn4zIb4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgAPKNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:13:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43187 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgAPKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:13:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so18394728qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 02:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rX5IkiB8JnoTfZs5uAlFbe8tyhYqjCAyIiplOz/1Kc=;
        b=jn4zIb4qAGDMK7he3rujwEt2kFJ8nh+3qcTL0IeX2mGtII77ctTbqQTL3Xz/ggwYSL
         Yng2Dxnvx7bk+3yuD5hsbwo5MFrQVRsON277YPGXWsnXc4FKqRJcqSiKvvdrHACYMX8W
         9iRegSAmGeDWiHdc+scR2sDX2iG+vNWmo4b4dlj9RzHNI7xNhoatHVWUdq8DpmTRytjy
         nQ3QPTIE7G/ps37AYWdftpV5HecE/PWBcXqa02RV9osZPNJM9g1fKDg68UxWkNO54hAs
         c6MfUGD/26SEgbClZDD18lcCIKAdvv1d7D8ad4iqo+m05iuA7pQi3TBtI0Bl54FwOm2e
         gxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rX5IkiB8JnoTfZs5uAlFbe8tyhYqjCAyIiplOz/1Kc=;
        b=IQhxfgE/hsY58B077MPt5JZX+Sc1bC+OdbGU0QZiPEVOrRYNxOmNLN6Bg84U0QdvtJ
         4/YZqSLlfwjJNUegHvspuSr3CedQu6qArptIFQ/rSdI/f7D08pWw6w9wktIfj48A76QK
         jVYD19JUL5AL03vXsMe6hxiDMyuoquEyfuTaVbD8oIO6yJynZ26X2gqpN3fc+8vsb9a0
         cmrxXpPrh78A3VBv9k80EJV5kKwRTXblVkP0RO/v9xtghP5Njf51EgNB6ZRtmBzf08OK
         UIGUkABCylr3oIe4WxEES5JXUgDz5/einmPCUq2u7hP8dVQqeA+BvnKjcA9qLXc2oH9D
         lzOA==
X-Gm-Message-State: APjAAAVr753TK7ts4/WKv8MYI/+VjOVepfP6XwJ7tJi33+KT1WitWQzb
        i6i8vhP5pVUS4xhPjtbMRXPtPyPPQSz387gl1oa0kw==
X-Google-Smtp-Source: APXvYqx4WBtKtL6XktEWiHiyq3Ao2I2Zn09FzikCu1MvcM716Qphn9AqdQAyZQmvqvdhK27tPjIyTZPcA0jsdbSBTKs=
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr1544540qtt.257.1579169600719;
 Thu, 16 Jan 2020 02:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
 <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz> <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
 <20200115150315.GH19428@dhcp22.suse.cz> <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
 <20200115190528.GJ19428@dhcp22.suse.cz> <CACT4Y+b5HJW9PhjkSZ+L09YqQt08ALCtudHV4m5x5qv+xH-2Yg@mail.gmail.com>
 <20200116073922.GL19428@dhcp22.suse.cz>
In-Reply-To: <20200116073922.GL19428@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 11:13:09 +0100
Message-ID: <CACT4Y+aWNQxSMSnHn6ORkBNM2wWp_K6tPxthj=_FmnyOfO5huA@mail.gmail.com>
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

On Thu, Jan 16, 2020 at 8:39 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > > > On 1/15/20 6:54 AM, Dan Carpenter wrote:
> > > > > > > > What we are trying to do is change the '=' character to a NUL terminator
> > > > > > > > and then at the end of the function we restore it back to an '='.  The
> > > > > > > > problem is there are two error paths where we jump to the end of the
> > > > > > > > function before we have replaced the '=' with NUL.  We end up putting
> > > > > > > > the '=' in the wrong place (possibly one element before the start of
> > > > > > > > the buffer).
> > > > > > >
> > > > > > > Bleh.
> > > > > > >
> > > > > > > > Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
> > > > > > > > Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
> > > > > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > > >
> > > > > > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > >
> > > > > > > CC stable perhaps? Can this (tmpfs mount options parsing AFAICS?) become
> > > > > > > part of unprivileged operation in some scenarios?
> > > > > >
> > > > > > Yes, tmpfs can be mounted by any user inside of a user namespace.
> > > > >
> > > > > Huh, is there any restriction though? It is certainly not nice to have
> > > > > an arbitrary memory allocated without a way of reclaiming it and OOM
> > > > > killer wouldn't help for shmem.
> > > >
> > > > The last time I checked there were hundreds of ways to allocate
> > > > arbitrary amounts of memory without any restrictions by any user. The
> > > > example at hand was setting up GB-sized netfilter tables in netns
> > > > under userns. It's not subject to ulimit/memcg.
> > >
> > > That's bad!
> > >
> > > > Most kmalloc/vmalloc's are not accounted and can be abused.
> > >
> > > Many of those should be bound to some objects and if those are directly
> > > controllable by userspace then we should account at least. And if they
> > > are not bound to a process life time then restricted.
> >
> > I see you actually added one GFP_ACCOUNT in netfilter in "netfilter:
> > x_tables: do not fail xt_alloc_table_info too easilly". But it seems
> > there are more:
> >
> > $ grep vmalloc\( net/netfilter/*.c
> > net/netfilter/nf_tables_api.c: return kvmalloc(alloc, GFP_KERNEL);
> > net/netfilter/x_tables.c: xt[af].compat_tab = vmalloc(mem);
> > net/netfilter/x_tables.c: mem = vmalloc(len);
> > net/netfilter/x_tables.c: info = kvmalloc(sz, GFP_KERNEL_ACCOUNT);
> > net/netfilter/xt_hashlimit.c: /* FIXME: don't use vmalloc() here or
> > anywhere else -HW */
> > net/netfilter/xt_hashlimit.c: hinfo = vmalloc(struct_size(hinfo, hash, size));
> >
> > These are not bound to processes/threads as namespaces are orthogonal to tasks.
>
> I cannot really comment on those. This is for networking people to
> examine and find out whether they allow an untrusted user to runaway.

Unless I am missing an elephant in this whole picture, kernel code
contains 20K+ unaccounted allocations and if I am not mistaken few of
them were audited and are intentionally unaccounted rather than
unaccounted just because it's the default. So if we want DoS
protection, it's really for every kernel developer/maintainer to audit
and fix these allocation sites. And since we have a unikernel, a
single unaccounted allocation may compromise the whole kernel. I
assume we would need something like GFP_UNACCOUNTED to mark audited
allocations that don't need accounting and then slowly reduce number
of allocations without both ACCOUNTED and UNACCOUNTED.


> > Somebody told me that it's not good to use GFP_ACCOUNT if the
> > allocation is not tied to the lifetime of the process. Is it still
> > true?
>
> Those are more tricky. Mostly because there is no way to reclaim the
> memory once the hard limit is hit. Even the memcg oom killer will not
> help much. So a care should be taken when adding GFP_ACCOUNT for those.
> On the other hand it would prevent an unbounded allocations at least
> so the DoS would be reduced to the hard limited memcg.

What exactly is this care in practice?
It seems that in a148ce15375fc664ad64762c751c0c2aecb2cafe you just
added it and the allocation is not tied to the process. At least I
don't see any explanation as to why that one is safe, while accounting
other similar allocation is not...
