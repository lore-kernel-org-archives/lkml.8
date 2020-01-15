Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2762CC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C742467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZUijKwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAOPO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:14:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39457 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:14:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so15934697qko.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LajS/tijvHJKVOveFc4JIx8xOUQsWStHiqkJwmAZBiI=;
        b=EZUijKwluEKR/Fm/uagjKMtw+XZ6QjjlD1lpbbuVcxDC1y1Dl4OFFyqH9kjW3MldEC
         frIFYj7k2O8zTf43JnlX+VqciIwWC8hPW2OHZcJ9pRNwT2DJKBcEWjkgyOi5wU89H/p9
         dftMYLv8SymDEPWogq9Sk+Hb+BltTuGtCUJApRxm1RE8v5hZ0Yes9YNFXfnqTHAM86Pd
         9WNgpEVdAB7a6tUHKPmafF6nVemMY8Lm8kKeIANRlnPsiHuIBoQOMs89fyXnCZeavPqG
         3i8GEEdPmOvTMUqLFXt+pPs1LlZJZcQNshBGuhiww/TK9Y67PTw57B05ZV5FaJeWY6vJ
         pQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LajS/tijvHJKVOveFc4JIx8xOUQsWStHiqkJwmAZBiI=;
        b=EzfIl4KMCjoAGIXuF14hInXOCleQva3IRVzEtZfcQXVcLKHdAMWUTe2u6VWDKyYfRZ
         3+8aVX6+EMa33FNGf1we7S6DLTyfo0Gi+zRgkaUnC/EA35c7IsLXP1Nyr2pZ0LOPSSAU
         LB+I+ptoTnTIcZTnPtD9advx7Twb3Oya20bMjm/qRFX8hBy9HpU2+w2+vSdLPZne06DC
         zslPVmsHbACxQwm92dU3KlWtBXgm4uT3VqM8J+2J74h049gSRCxyDDdeCvV9YIUF42Hm
         dDgYfFAh/IVV8EEsNugMAPVUl2SQzsTke8Q7QAi9TPddJarIgagW1rP/iCGJe/loUH/S
         o8ig==
X-Gm-Message-State: APjAAAUohC22b6NbTTDUtsrxPibq8ahtpIteP/waHtwmov3mxGat+AkH
        qOz8KCks5W4kz7izTa4xguhmPxYUBHPALnjFoReauA==
X-Google-Smtp-Source: APXvYqyubzmHMquoqpqvPa5HvJRuTFDjjNXYgEg2v1BLOaT8YzQxqQ7Z7nIUZQyBAHUahP47SeQV846dPfb8jGRj65E=
X-Received: by 2002:ae9:e50c:: with SMTP id w12mr25439679qkf.407.1579101294597;
 Wed, 15 Jan 2020 07:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
 <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz> <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
 <20200115150315.GH19428@dhcp22.suse.cz>
In-Reply-To: <20200115150315.GH19428@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Jan 2020 16:14:43 +0100
Message-ID: <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
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

On Wed, Jan 15, 2020 at 4:03 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 15-01-20 13:57:47, Dmitry Vyukov wrote:
> > On Wed, Jan 15, 2020 at 1:54 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >
> > > On 1/15/20 6:54 AM, Dan Carpenter wrote:
> > > > What we are trying to do is change the '=' character to a NUL terminator
> > > > and then at the end of the function we restore it back to an '='.  The
> > > > problem is there are two error paths where we jump to the end of the
> > > > function before we have replaced the '=' with NUL.  We end up putting
> > > > the '=' in the wrong place (possibly one element before the start of
> > > > the buffer).
> > >
> > > Bleh.
> > >
> > > > Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
> > > > Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > >
> > > CC stable perhaps? Can this (tmpfs mount options parsing AFAICS?) become
> > > part of unprivileged operation in some scenarios?
> >
> > Yes, tmpfs can be mounted by any user inside of a user namespace.
>
> Huh, is there any restriction though? It is certainly not nice to have
> an arbitrary memory allocated without a way of reclaiming it and OOM
> killer wouldn't help for shmem.

The last time I checked there were hundreds of ways to allocate
arbitrary amounts of memory without any restrictions by any user. The
example at hand was setting up GB-sized netfilter tables in netns
under userns. It's not subject to ulimit/memcg. Most kmalloc/vmalloc's
are not accounted and can be abused. Is tmpfs even worse than these?
