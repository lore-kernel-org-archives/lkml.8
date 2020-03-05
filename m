Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C951FC3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A331121556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPnvGwwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgCEEiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:38:09 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41174 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCEEiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:38:09 -0500
Received: by mail-vs1-f68.google.com with SMTP id k188so2733875vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wT7fX3XNpFUklA+4ubZ3A31ow/x3fc9U86BQ8duNKxk=;
        b=mPnvGwwIyc8PT9pu6q66/Xy/ag6QPMQHDyXJlCIiDTmTeYgipFoyhF1mRpzK0vT54c
         j7mVmd5I9pjGiM0Kgj4rIDhSIJ1vCE35gVKV5R9sD0dqxRnUnN479aGCHq4R0Ys/6QyJ
         AjH5TUwEl45CjFaDUVfjZT20unJjwtiCN9dz0pvaeKRUn0xPvQnxO9qHz9fhctfmKFvL
         ZfwXszJ3SCcT1z4FjJe6cdD3M1AQQoMtZmRVjvEPMhLufWXFeZsodXlZecriYJomGOdO
         AyBlIXzJbV3MTnDG0/ULrakFCgJdCH61wd8ssnq08gHeSwTXFPy86ENlrDxluvER3aZk
         eAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wT7fX3XNpFUklA+4ubZ3A31ow/x3fc9U86BQ8duNKxk=;
        b=ZyQNSUkySXoXCk2Xm+HsdU5FmR1NeI161EkbTxO+gzGamBIju/9mwV2eF1pZdSJse+
         xHMA+PT09Z7yoOh5zb5jfOaXZ4m61+9hORBw8T0zuQPfCeRnU5wLuE/owyhg0Rzy1bLV
         b/LlJ4WLpC5jJkv7x+zLHmyj642R7w5AG/WVFqI8fPrnP90QwTC/3B0Lx0JeQBzUA2WG
         WSyTXjpS5/ruViE4ceY29WbUkV8+yIb29b4L9wRo+CwyLTm3W8qX36UzwwzPANj1PRFx
         ALUuvpjMTFRrJFZR5vyZNGAVe8G7xtXWKFplEKswOBt+hXcMJEsxv6UF8ZUkpeGvsghK
         L+Og==
X-Gm-Message-State: ANhLgQ0iKsnddJNqW1Yl/EPAd7PMcb55XnSNHaojS0dceNgipVZ0jAY8
        q32en4B2qGo54xuBQxkcsq88tVxcYB2fntkv1nXHOg==
X-Google-Smtp-Source: ADFU+vtpr6/USWdDlF9OiCn6kxzaHvl/3Ges+ziOkGWGK22NIqrfWwtyXIjIUamxEVSJsteoPkHUpPj7fNkprubJfjE=
X-Received: by 2002:a67:ea84:: with SMTP id f4mr4016914vso.218.1583383085993;
 Wed, 04 Mar 2020 20:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20200304233856.257891-1-shakeelb@google.com> <CANn89i+TiiLKsE7k4TyRqr03uNPW=UpkvpXL1LVWvTmhE_AUpA@mail.gmail.com>
 <CALvZod7MSXGsV6nDngWS+mS-5tfu0ww3aJyXQ8GV2hRkEEcYDg@mail.gmail.com>
In-Reply-To: <CALvZod7MSXGsV6nDngWS+mS-5tfu0ww3aJyXQ8GV2hRkEEcYDg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 4 Mar 2020 20:37:53 -0800
Message-ID: <CANn89iJF3vSNG=uw5=-Knu48dKpceqXyYLm8z6d7aDoxaGDgTw@mail.gmail.com>
Subject: Re: [PATCH v2] net: memcg: late association of sock to memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 6:19 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Mar 4, 2020 at 5:36 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Mar 4, 2020 at 3:39 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > If a TCP socket is allocated in IRQ context or cloned from unassociated
> > > (i.e. not associated to a memcg) in IRQ context then it will remain
> > > unassociated for its whole life. Almost half of the TCPs created on the
> > > system are created in IRQ context, so, memory used by such sockets will
> > > not be accounted by the memcg.
> > >
> > > This issue is more widespread in cgroup v1 where network memory
> > > accounting is opt-in but it can happen in cgroup v2 if the source socket
> > > for the cloning was created in root memcg.
> > >
> > > To fix the issue, just do the late association of the unassociated
> > > sockets at accept() time in the process context and then force charge
> > > the memory buffer already reserved by the socket.
> > >
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > ---
> > > Changes since v1:
> > > - added sk->sk_rmem_alloc to initial charging.
> > > - added synchronization to get memory usage and set sk_memcg race-free.
> > >
> > >  net/ipv4/inet_connection_sock.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > > index a4db79b1b643..7bcd657cd45e 100644
> > > --- a/net/ipv4/inet_connection_sock.c
> > > +++ b/net/ipv4/inet_connection_sock.c
> > > @@ -482,6 +482,25 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
> > >                 }
> > >                 spin_unlock_bh(&queue->fastopenq.lock);
> > >         }
> > > +
> > > +       if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
> > > +               int amt;
> > > +
> > > +               /* atomically get the memory usage and set sk->sk_memcg. */
> > > +               lock_sock(newsk);
> > > +
> > > +               /* The sk has not been accepted yet, no need to look at
> > > +                * sk->sk_wmem_queued.
> > > +                */
> > > +               amt = sk_mem_pages(newsk->sk_forward_alloc +
> > > +                                  atomic_read(&sk->sk_rmem_alloc));
> > > +               mem_cgroup_sk_alloc(newsk);
> > > +
> > > +               release_sock(newsk);
> > > +
> > > +               if (newsk->sk_memcg)
> >
> > Most sockets in accept queue should have amt == 0, so maybe avoid
> > calling this thing only when amt == 0 ?
> >
>
> Thanks, will do in the next version. BTW I have tested with adding
> mdelay() here and running iperf3 and I did see non-zero amt.
>
> > Also  I would release_sock(newsk) after this, otherwise incoming
> > packets could mess with newsk->sk_forward_alloc
> >
>
> I think that is fine. Once sk->sk_memcg is set then
> mem_cgroup_charge_skmem() will be called for new incoming packets.
> Here we just need to call mem_cgroup_charge_skmem() with amt before
> sk->sk_memcg was set.


Unfortunately, as soon as release_sock(newsk) is done, incoming
packets can be fed to the socket,
and completely change memory usage of the socket.

For example, the whole queue might have been zapped, or collapsed, if
we receive a RST packet,
or if memory pressure asks us to prune the out of order queue.

So you might charge something, then never uncharge it, since at
close() time the socket will have zero bytes to uncharge.



>
> > if (amt && newsk->sk_memcg)
> >       mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
> > release_sock(newsk);
> >
> > Also, I wonder if     mem_cgroup_charge_skmem() has been used at all
> > these last four years
> > on arches with PAGE_SIZE != 4096
> >
> > ( SK_MEM_QUANTUM is not anymore PAGE_SIZE, but 4096)
> >
>
> Oh so sk_mem_pages() does not really give the number of pages. Yeah
> this needs a fix for non-4906 page size architectures. Though I can
> understand why this has not been caught yet. Network memory accounting
> is opt-in in cgroup v1 and most of the users still use v1. In cgroup
> v2, it is enabled and there is no way to opt-out. Facebook is a
> well-known v2 user and it seems like they don't have non-4096 page
> size arch systems.
