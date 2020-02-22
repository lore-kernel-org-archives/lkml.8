Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD1DC35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342B520656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHl51ojs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBVBy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:54:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40792 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgBVByz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:54:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so3810447otr.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 17:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sw7GUZ8pSeTtd2D2gBjMqfVeJ6NiOruxqtzQHUcbXAE=;
        b=RHl51ojseo7iryCem5GSsxvnC3ShVs3uMsdYTB/dvjcL2ajlQMa+5vHX1oFp//4BRD
         Ox4SCW1s6tUDg0ECSWE5b0dWoY1XLsw0p8h1op0TLp55JMD2lXWxT8s5730OatksAgcy
         kGuyRceUWy+zrrBkZFmTnQU9VsI2cBUGSo491ie/es5JJ9C+RhHbnj0brJJZtSxjmWH9
         ZxPPrwBlCDDgvYW3KdYjZc94tAWvw2JNynNaMJkAaUnvOGCl/gaO6jBJb1xyDogSQ/Uv
         PUGCmp/AFfqBM5w52zSxo3gpfAtTDMeu8P/Hj63dqUcORBbMWXcd2yvixbNsHPh91+lh
         Gt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sw7GUZ8pSeTtd2D2gBjMqfVeJ6NiOruxqtzQHUcbXAE=;
        b=NdEB38xwss6klMAn6uPXEZcmSh+wAaZgFzmfNWLOEkRKoMxRLnviB48oFip3A7qLdR
         l9HSbsTWPcubPMNDCu502wfwkdLJt/A0QhSVvjfr1oGnlr0LqFOUd2HwkL6ftpC7Mr7a
         mr1B7ozwPBfKcRNAnSet7zSbGc+dP2NVj1VV+HEl/TFOtCO8zZ0LCNAFta9+c9I7LDfR
         DxLpSI6BndkA8/VtVgpa//HEJFwU98TO0CjIbsYJWo8N2JObX4FXClPnv4yCSfpA9/x9
         yEEq3JujvPcpdZH7vUaaqAxSFlQsJyRUcIJYpmhNP6EBhX9wfFK3Sjf2/JX0aEd1cexl
         uClA==
X-Gm-Message-State: APjAAAUP3QrBSfNrtNzMetdFU4XsU7czc/MEIBNZB+v3if0kVwk3P1bt
        6hyK/5L+bp1/B5U80zDStgghLlU/FAXnvL3zaADFhA==
X-Google-Smtp-Source: APXvYqwA2FLdzOYAZnzv8L6gxTKWf/O7OoyWGLV81E0wtW5gnT6B29/EwVNKaP1myT00aDYqCcKhzWES2cnjryeszMw=
X-Received: by 2002:a05:6830:1e2b:: with SMTP id t11mr31146916otr.81.1582336494304;
 Fri, 21 Feb 2020 17:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20200222010456.40635-1-shakeelb@google.com> <20200222014850.GC459391@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200222014850.GC459391@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Feb 2020 17:54:43 -0800
Message-ID: <CALvZod6njD5Km=qqaQNOwHdPjx+dt=LJRkzosBYUJLEWyYtHMQ@mail.gmail.com>
Subject: Re: [PATCH] net: memcg: late association of sock to memcg
To:     Roman Gushchin <guro@fb.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        netdev@vger.kernel.org,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 5:49 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Feb 21, 2020 at 05:04:56PM -0800, Shakeel Butt wrote:
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
>
> Hello, Shakeel!
>
> > ---
> >  net/ipv4/inet_connection_sock.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index a4db79b1b643..df9c8ef024a2 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -482,6 +482,13 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
> >               }
> >               spin_unlock_bh(&queue->fastopenq.lock);
> >       }
> > +
> > +     if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
> > +             mem_cgroup_sk_alloc(newsk);
> > +             if (newsk->sk_memcg)
> > +                     mem_cgroup_charge_skmem(newsk->sk_memcg,
> > +                                     sk_mem_pages(newsk->sk_forward_alloc));
> > +     }
>
> Looks good for me from the memcg side. Let's see what networking people will say...
>
> Btw, do you plan to make a separate patch for associating the socket with the default
> cgroup on the unified hierarchy? I mean cgroup_sk_alloc().
>

Yes. I tried to do that here but was not able to do without adding the
(newsk->sk_cgrp_data.val) check which I can not do in this file as
sk_cgrp_data might not be compiled. I will send a separate patch.

Shakeel
