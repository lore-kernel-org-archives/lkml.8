Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF81C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEB920705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjC9sj0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAaPBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:01:34 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41885 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAaPBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:01:34 -0500
Received: by mail-yw1-f65.google.com with SMTP id l22so4927752ywc.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 07:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lP6TzEP91d7hLsESfdMqNdtjrOfbthLJkOU6UXoqTVs=;
        b=JjC9sj0bkY+d7wSCXaj+o8kYk69s9tJNc3C2A70tF2dKMLJG5FFvog7iey+EBH5tkS
         R2aSMJpoMMRCHqY17xrSS5Cr6n0aReHPNRY3UI1Q2jNoC28C+IB6ZSKLOi2Ljy3ucS8i
         VbZ7wosy2IjQCeQQRaYpJ8CIuxVesucU1Ll0y323e9Fp4ZPxPB1VSSDMuAlFeShpoVJ2
         Zp/zpk9vDLlIvK1X6Xrs/P5eKsJhXpaHJy4chljIaOzmj9gXt8yeNTN7HueQPSF93WJN
         bBfbkKkvNhAGzoUiF6pP4gzT1Glae++rA5nYHhRAa1zXKG8rCazvnGSwwk+05bmdG2uG
         PwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lP6TzEP91d7hLsESfdMqNdtjrOfbthLJkOU6UXoqTVs=;
        b=UPfPqZMcwS4rUmJf3cIaju/nA2VnChGP+DFPzziX6FiM2m4ULqBOJaZJt/N2Oss6P/
         WQB7Y3sBQTUys62SIviNQSdO7qgqdm9Vx5oH45LnuTYkSmtWzvFs5019u6jFvGMZKVqu
         qAZ+ZhGvKuho0VST/wPODB/Orz6iUnzf7KuVmD0ZpMHOpNDl3VloLm4n1QOEo76u0c3n
         qywaVnK6mke+eNKKsShqf67eCkW19ioUY+IRbEeiRFUoAS2XoBjJonwswirnWX5ea3ER
         DvR9CoeggAO9uBQZN2KxDKl0oax6MzD98rkwcSFh+Q3Xx4ImTOKgBTgI8EORiW2TOofG
         Ypnw==
X-Gm-Message-State: APjAAAVpkZ8GDIXkz2M26KU8VqnCMLIRGSLPsj0MW/sAT4vrUVWgQA/d
        3KT7ETSSe2kfdAoVTAHpRQDA89PBkbzm8ApXVWiKug==
X-Google-Smtp-Source: APXvYqzs7gtN6z+3DwxRauYOyBeJ0zMKdNI1QZWw5WgJpiiQ/ixWmcWH3ZOyJ2v3tzlLqA2ss5ytj9xF+z66rXG7cCs=
X-Received: by 2002:a81:b38a:: with SMTP id r132mr8677745ywh.114.1580482892732;
 Fri, 31 Jan 2020 07:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20200131122421.23286-1-sjpark@amazon.com> <20200131122421.23286-3-sjpark@amazon.com>
In-Reply-To: <20200131122421.23286-3-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 07:01:21 -0800
Message-ID: <CANn89i+rKfAhUjYLoEhyYj8OsRBtHC+ukPcE6CuTAJjb183GRQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous ACK is received
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

On Fri, Jan 31, 2020 at 4:25 AM <sjpark@amazon.com> wrote:

> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  net/ipv4/tcp_input.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2a976f57f7e7..b168e29e1ad1 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5893,8 +5893,12 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>                  *        the segment and return)"
>                  */
>                 if (!after(TCP_SKB_CB(skb)->ack_seq, tp->snd_una) ||
> -                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt))
> +                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> +                       /* Previous FIN/ACK or RST/ACK might be ignore. */
> +                       inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
> +                                                 TCP_ATO_MIN, TCP_RTO_MAX);

This is not what I suggested.

I suggested implementing a strategy where only the _first_ retransmit
would be done earlier.

So you need to look at the current counter of retransmit attempts,
then reset the timer if this SYN_SENT
socket never resent a SYN.

We do not want to trigger packet storms, if for some reason the remote
peer constantly sends
us the same packet.

Thanks.

>                         goto reset_and_undo;
> +               }
>
>                 if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
>                     !between(tp->rx_opt.rcv_tsecr, tp->retrans_stamp,
> --
> 2.17.1
>
