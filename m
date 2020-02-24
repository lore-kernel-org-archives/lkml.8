Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF3C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FC720836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cj0x+qTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgBXQis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:38:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45122 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgBXQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:38:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so9244786otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gO1Y0WzjkHxYIBlGhH4yAQ+tmF9LMDtnMgPaRxoyaM=;
        b=cj0x+qTlOH8bogprsI1KxF0PwXK+DJOMYjbq8x5Xr0Peoeo3LPolVoXCH2d+1bFHyn
         cJGd+9woHFNvbMXIOehX7Uzt631Xj8BTQdWcqeMXoFhgFbKjRr7mJfKxZJ9B9dypEoi+
         0a/c7ukYfIWAmmQ2dGInzkXyM3vzdfJmtfUzx21/4NbAICg5fQ5csiFBDWljYeEiu/Kc
         ks5XUrla6niH4fjrg/j57lJHfVnvBdGq1Hccd9QyueUwpBWZdCtJgXSm2A8RnugrhcWq
         A//qAoh7mL2CDYzh7DZXY86nzBSrghF1gLfSmibRpfRYSp4ADTbJUFptp8GZpd6JsWt5
         clyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gO1Y0WzjkHxYIBlGhH4yAQ+tmF9LMDtnMgPaRxoyaM=;
        b=jHh4qn5TiQGavX6Y87NyoQWBhk2BFoX85Kw/a9tkWOsLUz4njlybVIdt5Cm7NEDKsL
         +MWPaFPPKeUogsB7JPWhy6Ehax7dHHjhp2UK5SHf+st1mnBOzdo0T1qVxItQLA+eCPxQ
         g1yXVpGFn8vodnHwR+f91+4TTm4cP+V0QyDuBmvB8V8lEHiClBmZkTY9k1fqpzdRd3DN
         DMXCa94wF7OR/KaDLPZYQlJAw2N1D+3Xh9LBvHun2x/YlgCA6xB0iwFvc9t6inSdOg6m
         Kw7uVHUFU4BX8FVDz+hhz62ty6Exj1y9OvpzOEwvWj/sbDhPN/6IpqUl/HPchH4Gg7eO
         E/rQ==
X-Gm-Message-State: APjAAAUFjC+NMU2RZJETmd3Y9K0R14SG341RzbBZgtM2zrngB64mFVq0
        MHmQNdmtuxdIOZVQS/4V7kurcvdmWZ9X2n8rjbsw9w==
X-Google-Smtp-Source: APXvYqysPXjk8gDJk/QITNaTz1FQWVQyPK2BoG7VAZDGX1W2Z7UD9Rk4eTaTNlVvaHwLmq2ty0hZHD6Yw2YU55V5t+0=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr41277314otq.191.1582562326606;
 Mon, 24 Feb 2020 08:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20200222010456.40635-1-shakeelb@google.com> <CANn89iJ2CWSeLp-+mfBLWKNdS2vw=r1iLFtWhyzav_SYcjFrAg@mail.gmail.com>
In-Reply-To: <CANn89iJ2CWSeLp-+mfBLWKNdS2vw=r1iLFtWhyzav_SYcjFrAg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 24 Feb 2020 08:38:35 -0800
Message-ID: <CALvZod5Hns1pcPLOHrpnrmxEtU2vT2uVBWpKmU7u5EMYPJwrzQ@mail.gmail.com>
Subject: Re: [PATCH] net: memcg: late association of sock to memcg
To:     Eric Dumazet <edumazet@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        netdev <netdev@vger.kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-mm <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 11:29 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Feb 21, 2020 at 5:05 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > If a TCP socket is allocated in IRQ context or cloned from unassociated
> > (i.e. not associated to a memcg) in IRQ context then it will remain
> > unassociated for its whole life. Almost half of the TCPs created on the
> > system are created in IRQ context, so, memory used by suck sockets will
> > not be accounted by the memcg.
> >
> > This issue is more widespread in cgroup v1 where network memory
> > accounting is opt-in but it can happen in cgroup v2 if the source socket
> > for the cloning was created in root memcg.
> >
> > To fix the issue, just do the late association of the unassociated
> > sockets at accept() time in the process context and then force charge
> > the memory buffer already reserved by the socket.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index a4db79b1b643..df9c8ef024a2 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -482,6 +482,13 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
> >                 }
> >                 spin_unlock_bh(&queue->fastopenq.lock);
> >         }
> > +
> > +       if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
> > +               mem_cgroup_sk_alloc(newsk);
> > +               if (newsk->sk_memcg)
> > +                       mem_cgroup_charge_skmem(newsk->sk_memcg,
> > +                                       sk_mem_pages(newsk->sk_forward_alloc));
>
> I am not sure what you  are trying to do here.
>
> sk->sk_forward_alloc is not the total amount of memory used by a TCP socket.
> It is only some part that has been reserved, but not yet consumed.
>
> For example, every skb that has been stored in TCP receive queue or
> out-of-order queue might have
> used memory.
>
> I guess that if we assume that  a not yet accepted socket can not have
> any outstanding data in its transmit queue,
> you need to use sk->sk_rmem_alloc as well.

Thanks a lot. I will add that with a comment. BTW for my knowledge
which field represents the transmit queue size?

>
> To test this patch, make sure to add a delay before accept(), so that
> 2MB worth of data can be queued before accept() happens.

Yes, I will test this with a delay.

thanks,
Shakeel
