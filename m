Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8DCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58470214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cm0aso3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgAaQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:55:23 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46533 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgAaQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:55:21 -0500
Received: by mail-yw1-f68.google.com with SMTP id z141so4847890ywd.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KhtHImXtz0JOAa4RO8x+lv3CDdZ2tWniHcetxHbNDM=;
        b=cm0aso3/Xjvi4skad8txSnRwV2bnnpVCWs5H/1KesxyDUCchgXrPHUKtGgfkVrIzsr
         RhA/i4SUp2BpBBIijrJ1hq5NlmlUfmutY/imQFb6qcUBrPKcnO6RjnUtUzIRzk0k5eBV
         EOf/lVdhObbZ7QaFGuZlVmXc1qmLclUXsVXXD+de7m3c3nmLpdS7elL4LXGhgOPjHysz
         WrFDwnOHRJh8lms8SkByj18vTFjadZmwwNj4/a+RJTgB1qQJfypSpcUKJoOuT6qChWaI
         H1RwaSeIOjio8RJmhOq88wFsHisugJaCDK/IZaWJQeAc3XB8xxOCCxVrZLlUnZF36wgv
         70Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KhtHImXtz0JOAa4RO8x+lv3CDdZ2tWniHcetxHbNDM=;
        b=o/sSkCulKB9TZGiUs+AgkreTrgOr+A6TVsj6uHzluf890mm9TvI/52Ey+OXM2ho8Ds
         mdfl8HcuVQcty1ySzwyh8xz/vrsl8kiqnC0RXv32CaMI+o7cG1Yj/mFunEpcySUL1PHs
         O3p6fDqGSo8ATFTV3FNE6M52KrbDw6JmTzuFNFw/oIvoODMlc5snCexkjihJ5QfZk/45
         /4b9H6uupdhq/YwrGDBCNIYT9E3779ql11BafLWQP1lnyuiodSs/o/7A7dRqSnZhcxnt
         00QC9ih7KCmeu9veo6wyVdvY7oPr8RyRUY4PUowWEJ+72ix/BJ2NMxho7Uycj3jsjBvw
         rnbw==
X-Gm-Message-State: APjAAAVDWoK9DW01Y6t7vx7IKM+wBf12h8OB5AvGuAisWm/v7DyXFp7G
        ll7HdocLyGyW9JQvUXo01OGYBxx2wax/qWFcjCRsiQ==
X-Google-Smtp-Source: APXvYqy1pS828g+jsBdHmsd0kpbGo7NWEEkG1HfX+h0fyxOklzg1bd4R3xdI/sm4OG5ERTTWBOOwY9txYilItD+ZW7k=
X-Received: by 2002:a81:3845:: with SMTP id f66mr9055421ywa.220.1580489719518;
 Fri, 31 Jan 2020 08:55:19 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+rKfAhUjYLoEhyYj8OsRBtHC+ukPcE6CuTAJjb183GRQ@mail.gmail.com>
 <20200131161200.8852-1-sjpark@amazon.com>
In-Reply-To: <20200131161200.8852-1-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 08:55:08 -0800
Message-ID: <CANn89iJjZdoTKnnHNAByp7euDWo0aW9bL8ngw78vx4z7pwBJiw@mail.gmail.com>
Subject: Re: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous ACK
 is received
To:     sjpark@amazon.com
Cc:     David Miller <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sj38.park@gmail.com,
        aams@amazon.com, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 8:12 AM <sjpark@amazon.com> wrote:
>
> On Fri, 31 Jan 2020 07:01:21 -0800 Eric Dumazet <edumazet@google.com> wrote:
>
> > On Fri, Jan 31, 2020 at 4:25 AM <sjpark@amazon.com> wrote:
> >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > ---
> > >  net/ipv4/tcp_input.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 2a976f57f7e7..b168e29e1ad1 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -5893,8 +5893,12 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
> > >                  *        the segment and return)"
> > >                  */
> > >                 if (!after(TCP_SKB_CB(skb)->ack_seq, tp->snd_una) ||
> > > -                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt))
> > > +                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> > > +                       /* Previous FIN/ACK or RST/ACK might be ignore. */
> > > +                       inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
> > > +                                                 TCP_ATO_MIN, TCP_RTO_MAX);
> >
> > This is not what I suggested.
> >
> > I suggested implementing a strategy where only the _first_ retransmit
> > would be done earlier.
> >
> > So you need to look at the current counter of retransmit attempts,
> > then reset the timer if this SYN_SENT
> > socket never resent a SYN.
> >
> > We do not want to trigger packet storms, if for some reason the remote
> > peer constantly sends
> > us the same packet.
>
> You're right, I missed the important point, thank you for pointing it.  Among
> retransmission related fields of 'tcp_sock', I think '->total_retrans' would
> fit for this check.  How about below change?
>
> ```
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2a976f57f7e7..29fc0e4da931 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5893,8 +5893,14 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>                  *        the segment and return)"
>                  */
>                 if (!after(TCP_SKB_CB(skb)->ack_seq, tp->snd_una) ||
> -                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt))
> +                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> +                       /* Previous FIN/ACK or RST/ACK might be ignored. */
> +                       if (tp->total_retrans == 0)

canonical fied would be icsk->icsk_retransmits (look in net/ipv4/tcp_timer.c )

AFAIK, it seems we forget to clear tp->total_retrans in tcp_disconnect()
I will send a patch for this tp->total_retrans thing.

> +                               inet_csk_reset_xmit_timer(sk,
> +                                               ICSK_TIME_RETRANS, TCP_ATO_MIN,
> +                                               TCP_RTO_MAX);
>                         goto reset_and_undo;
> +               }
>
>                 if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
>                     !between(tp->rx_opt.rcv_tsecr, tp->retrans_stamp,
> ```
>
> Thanks,
> SeongJae Park
>
> >
> > Thanks.
> >
> > >                         goto reset_and_undo;
> > > +               }
> > >
> > >                 if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
> > >                     !between(tp->rx_opt.rcv_tsecr, tp->retrans_stamp,
> > > --
> > > 2.17.1
> > >
> >
