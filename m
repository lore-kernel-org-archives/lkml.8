Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D6020738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbJ72n1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCC3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFCC3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:29:39 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A0C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 19:29:38 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id v15so257108ybk.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 19:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+XO9SC5QE1UzVSk5S/GhGAG3dL8bmndI9l/Hk1kMRg=;
        b=XbJ72n1F6qmRExzIYYv3PoAXST79prZ1fWKeYuXaayFsFIaRl1qNqzAoCO7eDTaJ4U
         06GTl1FM6RnxnMYZlWZsOJztw1gE0URNojn6QYQvNbAKNP17sDihGNt+PzMHq4CPRm3d
         3KLtNKoFybQtemewslCy/oLPEDkSjdIRQ+oobw+GuvA3RXeiAWEaVosHEFpmKgHRpqpA
         BONcWsVuhVyyfmcFX6bvkiXeqPjIcFqZh5jnX/MfqO/4IFPf59eFr32lf791QeRF+V+W
         hcfjg24luoJVo57jqCjbOqNcAhNYMZ/HrVhsbPn4U5enlej/lr+CP1/2lRZAxmaeD9nM
         sdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+XO9SC5QE1UzVSk5S/GhGAG3dL8bmndI9l/Hk1kMRg=;
        b=XZCqcGDZKjc353WDeE/se/aVaLY/bQu7fixecv0COrPIflLv23+jOdztsLsCEwNBDs
         /dCbq2OhN3KbjWGMKv8HmZn/DKnjH5nf/s+Dbq24bOd7hPg6t5ANtWfE1/SRfEOlNe3W
         KwPMCAHHlREUG/isKAoT23E1ZDYiwcgGtpKkmpVJaiojEH84503hG47cZd2qLQME8Q6m
         L83NQ6sti3HD00BZJjx3+fiUSAWZ8QaGSnG6h+SPTnTNwvQkMddIP4eXY/egee8ckQEh
         QEY1eWEH5EykyhLEgZyWcB0+5V5jyct9h+Y0QjlXns+Ru0GDIQfURrjLT+2wNfxhoSwh
         em2A==
X-Gm-Message-State: AOAM530ylt9M0OG52zAWexH9ou6JVXet0Z4SJSQDfwfjs4YkCchDxrFH
        hmjUZJsNSp+MUa0+HBckY4XSKIfMMCJd/56a/B8rdQ==
X-Google-Smtp-Source: ABdhPJzddZEa2Y5Xs0+yB1nuuziVdZJXRqYA6crD+xaMeUxYImJOQ1hSHwFIFkckXn0ML1vtAOZKUJlBvC7AxZW75R0=
X-Received: by 2002:a25:ec0d:: with SMTP id j13mr6143030ybh.364.1591151377292;
 Tue, 02 Jun 2020 19:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200602080425.93712-1-kerneljasonxing@gmail.com>
 <CANn89iLNCDuXAhj4By0PDKbuFvneVfwmwkLbRCEKLBF+pmNEPg@mail.gmail.com> <CAL+tcoBjjwrkE5QbXDFADRGJfPoniLL1rMFNUkAKBN9L57UGHA@mail.gmail.com>
In-Reply-To: <CAL+tcoBjjwrkE5QbXDFADRGJfPoniLL1rMFNUkAKBN9L57UGHA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 2 Jun 2020 19:29:25 -0700
Message-ID: <CANn89iKDKnnW1na_F0ngGh3EEc0quuBB2XWo21oAKaHckdPK4w@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix TCP socks unreleased in BBR mode
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, liweishi@kuaishou.com,
        Shujin Li <lishujin@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 6:53 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> Hi Eric,
>
> I'm sorry that I didn't write enough clearly. We're running the
> pristine 4.19.125 linux kernel (the latest LTS version) and have been
> haunted by such an issue. This patch is high-important, I think. So
> I'm going to resend this email with the [patch 4.19] on the headline
> and cc Greg.

Yes, please always give for which tree a patch is meant for.

Problem is that your patch is not correct.
In these old kernels, tcp_internal_pacing() is called _after_ the
packet has been sent.
It is too late to 'give up pacing'

The packet should not have been sent if the pacing timer is queued
(otherwise this means we do not respect pacing)

So the bug should be caught earlier. check where tcp_pacing_check()
calls are missing.



>
>
> Thanks,
> Jason
>
> On Tue, Jun 2, 2020 at 9:05 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Jun 2, 2020 at 1:05 AM <kerneljasonxing@gmail.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > >
> > > TCP socks cannot be released because of the sock_hold() increasing the
> > > sk_refcnt in the manner of tcp_internal_pacing() when RTO happens.
> > > Therefore, this situation could increase the slab memory and then trigger
> > > the OOM if the machine has beening running for a long time. This issue,
> > > however, can happen on some machine only running a few days.
> > >
> > > We add one exception case to avoid unneeded use of sock_hold if the
> > > pacing_timer is enqueued.
> > >
> > > Reproduce procedure:
> > > 0) cat /proc/slabinfo | grep TCP
> > > 1) switch net.ipv4.tcp_congestion_control to bbr
> > > 2) using wrk tool something like that to send packages
> > > 3) using tc to increase the delay in the dev to simulate the busy case.
> > > 4) cat /proc/slabinfo | grep TCP
> > > 5) kill the wrk command and observe the number of objects and slabs in TCP.
> > > 6) at last, you could notice that the number would not decrease.
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > Signed-off-by: liweishi <liweishi@kuaishou.com>
> > > Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> > > ---
> > >  net/ipv4/tcp_output.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index cc4ba42..5cf63d9 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -969,7 +969,8 @@ static void tcp_internal_pacing(struct sock *sk, const struct sk_buff *skb)
> > >         u64 len_ns;
> > >         u32 rate;
> > >
> > > -       if (!tcp_needs_internal_pacing(sk))
> > > +       if (!tcp_needs_internal_pacing(sk) ||
> > > +           hrtimer_is_queued(&tcp_sk(sk)->pacing_timer))
> > >                 return;
> > >         rate = sk->sk_pacing_rate;
> > >         if (!rate || rate == ~0U)
> > > --
> > > 1.8.3.1
> > >
> >
> > Hi Jason.
> >
> > Please do not send patches that do not apply to current upstream trees.
> >
> > Instead, backport to your kernels the needed fixes.
> >
> > I suspect that you are not using a pristine linux kernel, but some
> > heavily modified one and something went wrong in your backports.
> > Do not ask us to spend time finding what went wrong.
> >
> > Thank you.
