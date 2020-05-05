Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E3C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455F4206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhNrbnjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgEEQA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgEEQA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:00:57 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C8C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:00:57 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id v9so1513343ybq.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORJwrAAwnpoHqLqwdK95lxsUlCDtaaRCVzNicAVFK9Q=;
        b=nhNrbnjfR6QYiydMzB+2Zg1gss9xSUkVPcDk/hIKxB3JreekfD7jPisLqPr+ZtnhtY
         vFBPr83g2DbXb387d3P4r0hJMkdiSUfwXrQHjAm9su6PU0iELhjn5hfh0cTDdSgbAzW+
         UH0SRMil6UjWMRGp+yBxX7aFGMOa3j8dNLGXoYo8YHR/jlZQGyY8Jn4m32kpkh1vZDUP
         RLtmV63YHi+ooBlWy7erEOR0taKW4UTSKF3AAN+Ij6RVd10rzTtDzrsqOyWNDHod91aq
         +pBHCr7jx1Fsu7ZzCrPY7FJRIfh4H9zrQS+t56Ohxb92FBiRDH9NJ2dXq++AC5MwDTH/
         FLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORJwrAAwnpoHqLqwdK95lxsUlCDtaaRCVzNicAVFK9Q=;
        b=UI3ekiAgJPKGW/iFpe3iDXOys9cqUH1tQumo/f6yuEjjTT3s7hgx2y91PM6WWxuQC8
         719h7OsQnz0daMIWrBe3qWXYxKKcjAtonaDeE28PdINPRoANrybpKF3Cwcwyuj5cikuE
         Z7knKG5QmKRDPmICpzuqK9Q9bz1GBLsEMJlcjVZBjkJfipPrD4nBk8BF/2TLXzbmm9Ur
         LmkiELGtAb9kcNh2ZGZpM0+kJnXzmLZntgWc5x+djkoYuQFwEsyikdhYQjF/XhOkkw3l
         g1Nkh+ljbiGs+1Tb0Mw+HhVDzyQc21gXlafr3st57Y8V5+9jWO7gwk8B/gH/p7c01KRx
         Dw4w==
X-Gm-Message-State: AGi0PuZcmywFHsVgPQjl+hgHLag/90aBZkPztWaaA4z8gLhsRgaJFETV
        s4FITo0aaKsMP3LEsrLpmhVYjUpsGQZnEEYj1KTUVQ==
X-Google-Smtp-Source: APiQypIMaAW9Xq0PmO+ItBBc/hPsz72qqCag9yC+T74EMR2STsOZlVRrHFkAljXR65MPzOEFNwalv+CLofTDx8F+C4c=
X-Received: by 2002:a25:6f86:: with SMTP id k128mr5689837ybc.520.1588694455583;
 Tue, 05 May 2020 09:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <a8510327-d4f0-1207-1342-d688e9d5b8c3@gmail.com> <20200505154644.18997-1-sjpark@amazon.com>
In-Reply-To: <20200505154644.18997-1-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 5 May 2020 09:00:44 -0700
Message-ID: <CANn89iLHV2wyhk6-d6j_4=Ns01AEE5HSA4Qu3LO0gqKgcG81vQ@mail.gmail.com>
Subject: Re: Re: [PATCH net v2 0/2] Revert the 'socket_alloc' life cycle change
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sj38.park@gmail.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>, snu@amazon.com,
        amit@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 8:47 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> On Tue, 5 May 2020 08:20:50 -0700 Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> >
> >
> > On 5/5/20 8:07 AM, SeongJae Park wrote:
> > > On Tue, 5 May 2020 07:53:39 -0700 Eric Dumazet <edumazet@google.com> wrote:
> > >
> >
> > >> Why do we have 10,000,000 objects around ? Could this be because of
> > >> some RCU problem ?
> > >
> > > Mainly because of a long RCU grace period, as you guess.  I have no idea how
> > > the grace period became so long in this case.
> > >
> > > As my test machine was a virtual machine instance, I guess RCU readers
> > > preemption[1] like problem might affected this.
> > >
> > > [1] https://www.usenix.org/system/files/conference/atc17/atc17-prasad.pdf
> > >
> > >>
> > >> Once Al patches reverted, do you have 10,000,000 sock_alloc around ?
> > >
> > > Yes, both the old kernel that prior to Al's patches and the recent kernel
> > > reverting the Al's patches didn't reproduce the problem.
> > >
> >
> > I repeat my question : Do you have 10,000,000 (smaller) objects kept in slab caches ?
> >
> > TCP sockets use the (very complex, error prone) SLAB_TYPESAFE_BY_RCU, but not the struct socket_wq
> > object that was allocated in sock_alloc_inode() before Al patches.
> >
> > These objects should be visible in kmalloc-64 kmem cache.
>
> Not exactly the 10,000,000, as it is only the possible highest number, but I
> was able to observe clear exponential increase of the number of the objects
> using slabtop.  Before the start of the problematic workload, the number of
> objects of 'kmalloc-64' was 5760, but I was able to observe the number increase
> to 1,136,576.
>
>           OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> before:   5760   5088  88%    0.06K     90       64       360K kmalloc-64
> after:  1136576 1136576 100%    0.06K  17759       64     71036K kmalloc-64
>

Great, thanks.

How recent is the kernel you are running for your experiment ?

Let's make sure the bug is not in RCU.

After Al changes, RCU got slightly better under stress.
