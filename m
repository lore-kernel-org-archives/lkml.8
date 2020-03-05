Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5580C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BF521556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSsXtoDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCEV7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:59:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46128 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgCEV7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:59:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id a22so415322oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 13:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZ9X7pBOQ32PghBEC4+dP85I/S+wu1As9RhQFRnXXto=;
        b=lSsXtoDIO0iLHjqPicvvXtqjyT7OR/kBmY+VLmgBRevQBgKkkDTBQRGLxzsgcELH6t
         gqiGETJBzstXBAnv9oYvbcIBIz89GpuahxVSYeZiGIBZ4JvWLqjwVYKVD1bfwB074NTL
         9MZik/rr8kw3M1VyRiiRn60Ts6yKRUKNcOSsYWGch+SBvf7epfYp8rNztCtiP/kPuX9K
         10Bcd7ggd2vSizpgzvw3rq7TbbT5qAgso27hxp1LZMY9bXozbQWsZzRKL1BXWCK66cCq
         FzIrI80C7cvzbZRPcHeBZj4Pxdrxrivy0+6UjMRhYPpEW17iy/T0kUB0lmxycqhI6IJV
         wl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZ9X7pBOQ32PghBEC4+dP85I/S+wu1As9RhQFRnXXto=;
        b=Yqd34y93OA5trummg9NSghIvl7qVTKiYD3a4X6ImRjGGZYaERQIAr4NDeD6JVJWpJ7
         9aj+ilOAfjNOmYA5s2sCbFrElya0QOX7KdNkXIV0UU5eonkxN4tZbnItKCgjBQAqQh/h
         GKxeWcp6GeJIS3xD6UiISIK3T3AfovPtOWZ28n2x5yj2zsRgNugHgRknZ+w9koxGLOIr
         R9qGNYd5/j3DGp5hRvWOe/4P5V7MFMq92leVp033He0oMtMLfc7qzgL95XgC3lOapIho
         Aq5RG/oUmLnqqpZ5C2gjSMijPKKey94s10m/h5l2tgRP+nQAl4X43WENTL0KQjzn9JyY
         E1Zw==
X-Gm-Message-State: ANhLgQ1AZO/5l/b8w5GR0eUGvhF8xbuuxI6c9Jjpa5Uzrg4Uq9nAF7JY
        PY+eq6EhfmsbB0ORg/p3lEGzOQ7RSNRBMxjDbQxhhQ==
X-Google-Smtp-Source: ADFU+vtYXWLwZtcPM8JDPJKFFjMDljTV5RXVkWBf8UUOHRKcT1Dlz5TI0VyF36iQc7ZItQBmxNnUhKuVpOCALNdBsMo=
X-Received: by 2002:a05:6808:64e:: with SMTP id z14mr383631oih.79.1583445588674;
 Thu, 05 Mar 2020 13:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20200305205525.245058-1-shakeelb@google.com> <9505d35b-f9fc-149b-6df5-e65ad95acabb@gmail.com>
In-Reply-To: <9505d35b-f9fc-149b-6df5-e65ad95acabb@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 5 Mar 2020 13:59:37 -0800
Message-ID: <CALvZod68Raqfa2ZJOfF_OOQdb-hxkOs54G5KK3VQnUdxiZ=KTQ@mail.gmail.com>
Subject: Re: [PATCH v3] net: memcg: late association of sock to memcg
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 1:17 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 3/5/20 12:55 PM, Shakeel Butt wrote:
> > If a TCP socket is allocated in IRQ context or cloned from unassociated
> > (i.e. not associated to a memcg) in IRQ context then it will remain
> > unassociated for its whole life. Almost half of the TCPs created on the
> > system are created in IRQ context, so, memory used by such sockets will
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
> > Changes since v2:
> > - Additional check for charging.
> > - Release the sock after charging.
> >
> > Changes since v1:
> > - added sk->sk_rmem_alloc to initial charging.
> > - added synchronization to get memory usage and set sk_memcg race-free.
> >
> >  net/ipv4/inet_connection_sock.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index a4db79b1b643..5face55cf818 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -482,6 +482,26 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
> >               }
> >               spin_unlock_bh(&queue->fastopenq.lock);
> >       }
> > +
> > +     if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
> > +             int amt;
> > +
> > +             /* atomically get the memory usage, set and charge the
> > +              * sk->sk_memcg.
> > +              */
> > +             lock_sock(newsk);
> > +
> > +             /* The sk has not been accepted yet, no need to look at
> > +              * sk->sk_wmem_queued.
> > +              */
> > +             amt = sk_mem_pages(newsk->sk_forward_alloc +
> > +                                atomic_read(&sk->sk_rmem_alloc));
> > +             mem_cgroup_sk_alloc(newsk);
> > +             if (newsk->sk_memcg && amt)
> > +                     mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
> > +
> > +             release_sock(newsk);
> > +     }
> >  out:
> >       release_sock(sk);
> >       if (req)
> >
>
> This patch looks fine, but why keeping the mem_cgroup_sk_alloc(newsk);
> in sk_clone_lock() ?
>
> Note that all TCP sk_clone_lock() calls happen in softirq context.

So, basically re-doing something like 9f1c2674b328 ("net: memcontrol:
defer call to mem_cgroup_sk_alloc()") in this patch. I am fine with
that.

Roman, any concerns?
