Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4162078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EINNHW9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgEOOjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726719AbgEOOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:39:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE8EC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:39:37 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id x5so2976631ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4hpPbKuo/eM3pj3/8Bij0gexeSDdOJHguLYolZpnKs=;
        b=EINNHW9tIkICYl47a8AU63VrYU5C2scpuARJTsP/TsQ5cQzHBrJb64es1TdQNfzB0Z
         kx7VDchChuQupqL21ecTM6d/vWEDCBR9/Mj/T6gCVP0egVvjgWc7NmEIgxAoa3uMxKpz
         /K88McJ4rzVlfbFGm6J2bLOCcOht/xcZvDaX00RYyCcawkdq3Actzuwtq2TK8fl4s2Lg
         avUNEFz4X/u6f28O1W0p/sBimqX3ruf1yDupSHCBp+B2z/g1atEgcEquvjabpI5aDhUr
         ADEyA1YhRpY5L0XbORk0kp3IMCV2isKMD5faV9CGzmeFxs+bulJlaVVu/F6kP1dZnPac
         8d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4hpPbKuo/eM3pj3/8Bij0gexeSDdOJHguLYolZpnKs=;
        b=WueS372cuLqqi1HfJkZW4Df43YqDUHW5Lw+xsscbEcsSJBA9r5Az3qzFPHDY0HshnS
         XYgxLNC5FGqlgCDEdY6FkdBEDNn6mNwbCuKWx1wysTKqi652wxxjjO9GLP0u2zSKHBi3
         YxHypDSzXrEHM5WENHi0SiCCV1W5CW/YiqJ65Y6ZetbKnfNE/6p/ELhhEd6xkcZAarXg
         KZvZmDb8MmFR/jq8z5vzFZV2HHd6t9Wc2GWR4NA79YZFS/Ulfg0PAY9Hl8gJ4VEUbYbi
         a1pIR5bbcT80ucatJAcyEfGp2/tiFxgO5Muo0Uhji5DWP5ksKEffQh+WQAb/ZevA+T0o
         Homw==
X-Gm-Message-State: AOAM533f+zSz6CfxNFreLBd6J/a0ImX79fahLq/fLRJ/+HO7g6iDj2qg
        RWCeHNQSvgsm0rY+rfd7fCb/9cZugshGzfXkkrc=
X-Google-Smtp-Source: ABdhPJwzD0QkHIguS5g7gqQWdRioLG5NpbqHvkBIRDn2sKkJGrf0li0RxdR/lDgkeQQFPY4463LkRvsZOTwKU4ubiHY=
X-Received: by 2002:a05:6638:158:: with SMTP id y24mr3441021jao.43.1589553576465;
 Fri, 15 May 2020 07:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200515124710.16439-1-laijs@linux.alibaba.com> <20200515130030.GV2957@hirez.programming.kicks-ass.net>
In-Reply-To: <20200515130030.GV2957@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 15 May 2020 22:39:25 +0800
Message-ID: <CAJhGHyAMOQ7Bp8kYF7urp572SguFjiLs5PmqQvTKAkwfwBrOKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rbtree_latch: quit searching when reaching to maximum depth
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <David.Woodhouse@intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 9:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 15, 2020 at 12:47:06PM +0000, Lai Jiangshan wrote:
> > lib/rbtree.c has ensured that there is not possible to
> > inadvertently cause (temporary) loops in the tree structure
> > as seen in program order of the modifier. But loop is still
> > possible to be seen in searcher due to CPU's reordering.
> >
> > for example:
> > modifier                              searcher
> >
> > left rotate at parent
> > parent->rb_right is node
> >                                       search to parent
> >                                       parent->rb_right is node
> >                                    +->see node->rb_left changed
> > WRITE_ONCE(parent->rb_right, tmp);-+ |  node->rb_left is parennt
> > no smp_wmb(), some arch can        | |
> > reorder these two writes           | |  loop long between
> > WRITE_ONCE(node->rb_left, parent);-+-+  parent and node
> >                                  |
> >                                  +--->finally see
> >                                       parent->rb_right
> >
> > The long loop won't stop until the modifer's CPU flushes
> > its writes. Too avoid it, we should limit the searching depth.
>
> Cute, have you actually observed this? Did you have performance issues?

I can only test it on x86 by now, which implies smp_wmb() between
writes. I haven't observed any thing wrong. I'm just imaging
it on some other ARCHs.

I accidentally found this part of code when I searched for
whether there is any attempt again to use rbtree with RCU, and
whether there are the cases besides speculative page fault.

>
> > There are no more than (1<<BITS_PER_LONG)-1 nodes in the tree.
> > And the max_depth of a tree is no more than 2*lg(node_count+1),
> > which is no mare than 2*BITS_PER_LONG.
> >
> > So the serarch should stop when diving down up to
> > 2*BITS_PER_LONG depth.
>
> Arguably you can have a larger key space, but I think due to memory
> constraints this limit still isn't wrong. But I do feel you need a
> comment with that.

Sure, I will add some comments about why "2*BITS_PER_LONG" in code.

But how it could be larger key space? there are not more than
(1<<BITS_PER_LONG) bytes in the kernel dereferencable address
space, and (1<<BITS_PER_LONG)/sizeof(rb_node) must be less than
(1<<BITS_PER_LONG)-1.
