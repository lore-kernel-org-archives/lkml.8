Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21916C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007D02145D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ0EYg5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDUAzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDUAzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:55:45 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A61C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:55:45 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id i16so6468602ybq.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjlgz4iiGJZDWAcs2kDeck3depX+Yf98ZBNqYF4UaYA=;
        b=WJ0EYg5pg+4/8R2lb3NoDqagsM6h3yDvt3PQtazEDA5NahCJApc7GCKHnOyvSLWm38
         H5G99miToiYVt16mrUQi0Iztfk5WKuHk3f7RmxYprA6cP8NG9q580hAuqMUlu6tGxHCg
         1o+kp//9DLxirifrqDnVrq6QMbw0f8mzgfEbOcbgW9Am6yg6ZO9+ixBjT/UteyFO9BB2
         VVb1vWkjx3pRXX4GcLmhyM0I1lJ4YBkOwuy+bzUbMbgSBZexlALkrmdowtehcBuNKWsH
         I5d42vCERTKBM80aba4XcES7TCrN7g1ZDbeEO9uHa+xuEPyYyldncLhTH8Njc3ZHHahg
         Dn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjlgz4iiGJZDWAcs2kDeck3depX+Yf98ZBNqYF4UaYA=;
        b=meitGMdQNKBEQBXGnclFcV3n+gt90KY7xofs7kk55rJTjRhkwdnlOGduzZqCgeIg25
         LD1Ov71bc0aN2WROjDXuQzvDZQ2TIyL+iWS8JjGuu3tLKIGI58Yimjrnv720c9FrsvoB
         pF9dllIPIL+S9TwHu2JNPf78u8RwlUnrkTI8iYZvM367wKEvwizcLFw2CYqDA6Hd5X7d
         EQcihUV9YUsJm9vA6lA0tEe6lWDISPzgfNxcOxBo6OO6dqkvKCNz8WSqMjznxV213pd5
         gsCrLdFwclurTscSjj4aiPlS5f6sFSg5alacc6DfZuzCniHqMBUwaYJoxpHWT39m2rhN
         UQzQ==
X-Gm-Message-State: AGi0PuavbbO3hYkHu7PyvNpbPlavMUdd5QEMQ2OR4IjPFCgzfy9ml+rU
        MDZWflgOuDJsdmaaSwwpgDePegLO/9qZthkTgCidAw==
X-Google-Smtp-Source: APiQypLnmc/lLWGYUiu3OVAcY5Pfzg+riBol6VMDq4lMsHjAWJpZpZXC3aZLcpHeQAMWcnxaSl4mg6l8jhZhxRLQr5Q=
X-Received: by 2002:a25:748f:: with SMTP id p137mr22648428ybc.287.1587430544396;
 Mon, 20 Apr 2020 17:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200415004353.130248-1-walken@google.com> <20200415004353.130248-8-walken@google.com>
 <20200420182211.exrzkszefraeylv2@ca-dmjordan1.us.oracle.com> <20200420192322.GD5820@bombadil.infradead.org>
In-Reply-To: <20200420192322.GD5820@bombadil.infradead.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 20 Apr 2020 17:55:30 -0700
Message-ID: <CANN689EKUoD5xTVk7V49sU3BcZ1Ntp+zkAubmxRADeioju1ioA@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] mmap locking API: add mmap_read_trylock_non_owner()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Apr 20, 2020 at 02:22:11PM -0400, Daniel Jordan wrote:
> > On Tue, Apr 14, 2020 at 05:43:50PM -0700, Michel Lespinasse wrote:
> > > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > > index 11d41f0c7005..998968659892 100644
> > > --- a/kernel/bpf/stackmap.c
> > > +++ b/kernel/bpf/stackmap.c
> > > @@ -317,7 +316,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> > >      * with build_id.
> > >      */
> > >     if (!user || !current || !current->mm || irq_work_busy ||
> > > -       mmap_read_trylock(current->mm) == 0) {
> > > +       !mmap_read_trylock_non_owner(current->mm)) {
> > >             /* cannot access current->mm, fall back to ips */
> > >             for (i = 0; i < trace_nr; i++) {
> > >                     id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> > > @@ -342,16 +341,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> > >     }
> > >
> > >     if (!work) {
> > > -           mmap_read_unlock(current->mm);
> > > +           mmap_read_unlock_non_owner(current->mm);
> >
> > These 'non_owner' calls are not intuitive because current _is the owner, so the
> > v3 version seems better, even if it adds a special wrapper for rwsem_release.
> >
> > Though it makes some sense if you think, "we're consistently using the
> > non_owner APIs because there's a legitimate use somewhere else," so I'm fine
> > either way.
>
> I'm not really a big fan of v3 nor v4.  What I'd like to see is a
> 'transfer of ownership' API.  This could be to a different task, IRQ work,
> RCU, softirq, timer, ...
>
> That would let us track locking dependencies across complex flows, eg this
> wouldn't be warned about right now:
>
> rcu_work():
>         lock(C)
>         kfree(B)
>         unlock(A)
>         unlock(C)
>
> thread 1:
>         lock(A)
>         call_rcu(B)
>
> thread 2:
>         lock(C)
>         synchronize_rcu()
>         unlock(C)
>
> but if we had an API that transferred ownership of A to RCU, then we'd
> see the C->RCU->A->C cycle.
>
> This is perhaps a bit much work to require of Laurent in order to get
> this patchset merged, but something to think about.

I think fundamentally, lockdep is better suited at handling locks that
are owned by a given task. I think extending lockdep just for the bpf
stacktrace use case would be way overkill ?

But yes, I agree that declining ownership as we do here leaves us open
to having lock dependency issues that lockdep won't diagnose.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
