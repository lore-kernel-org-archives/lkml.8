Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE9C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B62024658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKPotuqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgANSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:40:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40822 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgANSkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:40:18 -0500
Received: by mail-vs1-f67.google.com with SMTP id g23so8873522vsr.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 10:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ivUmuNAkWazT8Rmepnfw9ZSxh+wUrJfBzNAinxZwNo=;
        b=mKPotuqtvmE58gvfUyuvyTUq3M205KEn1qNnNgHEDCJZZkd2ObYz7EcBPPGLmKxZH0
         dt5fmMKXyhYDalldw/0EwxmIoeNGeucWLkpal2282TqvB8Dxl+qf68qnSViTTs+m+N+9
         bCIaMTgGh4P/gZa+/aXfGNrIQHII6F7EMruh22gttnvsCg9GX9PcZVL0H8fGBh7VgDeA
         SQgs0yzV+ENpyEqrdqLqCcBu9oTqBNIzmc1dkmMmzoA5A9tXlfZKBs2kmwvFSXSH/eAc
         fSGZydXJsW1poiq92JLVQeTPRAAdfqRFugyxP/ODFhKckJZLIaN0Ignr0bMbPXJxUS52
         OU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ivUmuNAkWazT8Rmepnfw9ZSxh+wUrJfBzNAinxZwNo=;
        b=j3gzvB6hH92v4xYO2aEG2WKTrb4ZabjqP1VMKs6KGNKfB+6oSlgvB55I2XtM+/MViV
         HdQYD6vKmZO/T/teUF7VdIIIx18RsnNQrSAr+Tpbc4ZNy/6pMxyGts/Nr8tHb8XEhLcW
         BChbsSKB0KmaIF9LjfjBytIXiAgOk5pBarJa/vrGfYNeUW+ie6s4HaKNRcILnaXStuZ1
         YQApa/s1p3ezJwjLHwERobHgTgUBFPI0GzrABM9D5fxmMWvsXUuwFwhzVjDE6UK2GJp/
         1GyzchZ2wc4IgXwpYfHh+agj0Rt9wzCpNBFyF0jwC6PZjeyljUN14GtY2CxUrycYKAx9
         wCfA==
X-Gm-Message-State: APjAAAWhn40R6Gf7FGQMQq/P3DO9Or+ONqBe+w/+GL8hLRBu5/OPtYhh
        yVAE6pAkckO2pUqfFLZveT7/nQn2ashfOOpiG2aisg==
X-Google-Smtp-Source: APXvYqzNnExJuG8STh9vToLWZkXPxQNwjQ1lu/VaeZvWo48XbBwIgkh9ZudmGGdHICQQZeZERA06kxSh1tUJGB6b5hc=
X-Received: by 2002:a67:de12:: with SMTP id q18mr2114645vsk.104.1579027216543;
 Tue, 14 Jan 2020 10:40:16 -0800 (PST)
MIME-Version: 1.0
References: <1578993820-2114-1-git-send-email-yangpc@wangsu.com> <CANn89i+nf+cPSxZdRziRa3NaDvdMG+xKYBsy752NX+3vkLba1w@mail.gmail.com>
In-Reply-To: <CANn89i+nf+cPSxZdRziRa3NaDvdMG+xKYBsy752NX+3vkLba1w@mail.gmail.com>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Tue, 14 Jan 2020 10:39:40 -0800
Message-ID: <CAK6E8=d9uRNQuHEx-6xYMvM8Xyshg_FK0AgHGGu3ngT76a45BQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix marked lost packets not being retransmitted
To:     Eric Dumazet <edumazet@google.com>
Cc:     Pengcheng Yang <yangpc@wangsu.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        andriin@fb.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 8:06 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Jan 14, 2020 at 1:24 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
> >
> > When the packet pointed to by retransmit_skb_hint is unlinked by ACK,
> > retransmit_skb_hint will be set to NULL in tcp_clean_rtx_queue().
> > If packet loss is detected at this time, retransmit_skb_hint will be set
> > to point to the current packet loss in tcp_verify_retransmit_hint(),
> > then the packets that were previously marked lost but not retransmitted
> > due to the restriction of cwnd will be skipped and cannot be
> > retransmitted.
>
>
> "cannot be retransmittted"  sounds quite alarming.
>
> You meant they will eventually be retransmitted, or that the flow is
> completely frozen at this point ?
He probably means those lost packets will be skipped until a timeout
that reset hint pointer. nice fix this would save some RTOs.

>
> Thanks for the fix and test !
>
> (Not sure why you CC all these people having little TCP expertise btw)
>
> > To fix this, when retransmit_skb_hint is NULL, retransmit_skb_hint can
> > be reset only after all marked lost packets are retransmitted
> > (retrans_out >= lost_out), otherwise we need to traverse from
> > tcp_rtx_queue_head in tcp_xmit_retransmit_queue().
> >
> > Packetdrill to demonstrate:
> >
> > // Disable RACK and set max_reordering to keep things simple
> >     0 `sysctl -q net.ipv4.tcp_recovery=0`
> >    +0 `sysctl -q net.ipv4.tcp_max_reordering=3`
> >
> > // Establish a connection
> >    +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> >    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> >    +0 bind(3, ..., ...) = 0
> >    +0 listen(3, 1) = 0
> >
> >   +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
> >    +0 > S. 0:0(0) ack 1 <...>
> >  +.01 < . 1:1(0) ack 1 win 257
> >    +0 accept(3, ..., ...) = 4
> >
> > // Send 8 data segments
> >    +0 write(4, ..., 8000) = 8000
> >    +0 > P. 1:8001(8000) ack 1
> >
> > // Enter recovery and 1:3001 is marked lost
> >  +.01 < . 1:1(0) ack 1 win 257 <sack 3001:4001,nop,nop>
> >    +0 < . 1:1(0) ack 1 win 257 <sack 5001:6001 3001:4001,nop,nop>
> >    +0 < . 1:1(0) ack 1 win 257 <sack 5001:7001 3001:4001,nop,nop>
> >
> > // Retransmit 1:1001, now retransmit_skb_hint points to 1001:2001
> >    +0 > . 1:1001(1000) ack 1
> >
> > // 1001:2001 was ACKed causing retransmit_skb_hint to be set to NULL
> >  +.01 < . 1:1(0) ack 2001 win 257 <sack 5001:8001 3001:4001,nop,nop>
> > // Now retransmit_skb_hint points to 4001:5001 which is now marked lost
> >
> > // BUG: 2001:3001 was not retransmitted
> >    +0 > . 2001:3001(1000) ack 1
> >
> > Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> > ---
> >  net/ipv4/tcp_input.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 0238b55..5347ab2 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -915,9 +915,10 @@ static void tcp_check_sack_reordering(struct sock *sk, const u32 low_seq,
> >  /* This must be called before lost_out is incremented */
> >  static void tcp_verify_retransmit_hint(struct tcp_sock *tp, struct sk_buff *skb)
> >  {
> > -       if (!tp->retransmit_skb_hint ||
> > -           before(TCP_SKB_CB(skb)->seq,
> > -                  TCP_SKB_CB(tp->retransmit_skb_hint)->seq))
> > +       if ((!tp->retransmit_skb_hint && tp->retrans_out >= tp->lost_out) ||
> > +           (tp->retransmit_skb_hint &&
> > +            before(TCP_SKB_CB(skb)->seq,
> > +                   TCP_SKB_CB(tp->retransmit_skb_hint)->seq)))
> >                 tp->retransmit_skb_hint = skb;
> >  }
> >
> > --
> > 1.8.3.1
> >
