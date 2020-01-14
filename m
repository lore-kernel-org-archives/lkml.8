Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6398AC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347DD2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tW70tSHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgANP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:27:12 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46802 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:27:11 -0500
Received: by mail-oi1-f194.google.com with SMTP id 13so12117454oij.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSfqseDXRgYxW6cos6v42MObIz83bjZm/sycYhBbN3U=;
        b=tW70tSHkFefhGMQBaoalcMtSt3B5DYYWSmjZV/rPTpWhZYygQfcHuVKlotIKs2vf/G
         P9pSElpqO9AU+sAtmlIw1h/03uLca12hPe7NHMpSOkCY6OfVFlRem4SrUKrqQk0/f6+X
         23V+kyjk/Pko0j8sAKsRhpaCYfcTyQKjsi2vyNMoUttjfE+kEhGgGgU0cfuoyS6NcdOR
         x7OpWImyZKRdZaXFP91OQUCWaLe0ou9MYAmsQDTCYFuiqqRfm+lMVj6qZ6ausD/X8zIQ
         bmeMa23eQ211WC6eEzP8vl/oPiWqYuw9Y9r5y8e4mWnUQLLtWKm29+5EEiLtuxEoUWf/
         Q+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSfqseDXRgYxW6cos6v42MObIz83bjZm/sycYhBbN3U=;
        b=TI2HMPLPCKBCpXMVPm9UslzZ1CD99jSvQKa39bSpwfxj6i1svazWFyB9X8IvPq3MdY
         U8mXVBaoz0Z2fTrLKF/9/ptSm/mES+tQ8QN/id3zXM/hjjMI632BJCYoaTHYpnwMTAFD
         bkVQ0ukAsqwBynYDSZNpEbuE/m5lsunWVJxR6L4e499ENoJIHQZmfuiycZYSVsUGSbhP
         pHcWeQ4tLT/PFYTchHn/qmCMQHiKpnX85WcZwZwpKphq6jfs4sGbYwpFFY7HEoUEuxw0
         5/Pyp6/2YivTrGrrEu/nOThdk5h1uJO4KrzI55gnPTupVAd4Qhj1H0P/5azTkskEfAgP
         vNmA==
X-Gm-Message-State: APjAAAUzN86ytnqEGNYF9ALn74J8bagKp1fGUF9b/8ybWKSgp49ajyDs
        0JVdq1Oxp3Pg3/5CGNuW/E5WPGVYfcz21nurWZ3/MA==
X-Google-Smtp-Source: APXvYqyDF+nT7rgbrbcfjhIbUn+78PrCncjeMOKUmQqVuSd26q3pleG6o3IYx35IjTpdNlh2Zqkf8KGPbmV3FIk48zk=
X-Received: by 2002:a05:6808:64e:: with SMTP id z14mr16070335oih.79.1579015628785;
 Tue, 14 Jan 2020 07:27:08 -0800 (PST)
MIME-Version: 1.0
References: <1578993820-2114-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1578993820-2114-1-git-send-email-yangpc@wangsu.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Tue, 14 Jan 2020 10:26:52 -0500
Message-ID: <CADVnQynVoi=__EE20L5y1KD5Asw+=PbFesSeQE0pf8WmB3cx5Q@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix marked lost packets not being retransmitted
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 4:24 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> When the packet pointed to by retransmit_skb_hint is unlinked by ACK,
> retransmit_skb_hint will be set to NULL in tcp_clean_rtx_queue().
> If packet loss is detected at this time, retransmit_skb_hint will be set
> to point to the current packet loss in tcp_verify_retransmit_hint(),
> then the packets that were previously marked lost but not retransmitted
> due to the restriction of cwnd will be skipped and cannot be
> retransmitted.
>
> To fix this, when retransmit_skb_hint is NULL, retransmit_skb_hint can
> be reset only after all marked lost packets are retransmitted
> (retrans_out >= lost_out), otherwise we need to traverse from
> tcp_rtx_queue_head in tcp_xmit_retransmit_queue().
...
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -915,9 +915,10 @@ static void tcp_check_sack_reordering(struct sock *sk, const u32 low_seq,
>  /* This must be called before lost_out is incremented */
>  static void tcp_verify_retransmit_hint(struct tcp_sock *tp, struct sk_buff *skb)
>  {
> -       if (!tp->retransmit_skb_hint ||
> -           before(TCP_SKB_CB(skb)->seq,
> -                  TCP_SKB_CB(tp->retransmit_skb_hint)->seq))
> +       if ((!tp->retransmit_skb_hint && tp->retrans_out >= tp->lost_out) ||
> +           (tp->retransmit_skb_hint &&
> +            before(TCP_SKB_CB(skb)->seq,
> +                   TCP_SKB_CB(tp->retransmit_skb_hint)->seq)))
>                 tp->retransmit_skb_hint = skb;
>  }

Thanks for finding and fixing this issue, and for providing the very
nice packetdrill test case! The fix looks good to me.

I verified that the packetdrill test fails at the line notated "BUG"
without the patch applied:

fr-retrans-hint-skip-fix.pkt:33: error handling packet: live packet
field tcp_seq: expected: 2001 (0x7d1) vs actual: 4001 (0xfa1)
script packet:  0.137311 . 2001:3001(1000) ack 1
actual packet:  0.137307 . 4001:5001(1000) ack 1 win 256

Also verified that the test passes with the patch applied, and that
our internal SACK and fast recovery tests continue to pass with this
patch applied.

Acked-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>

thanks,
neal
