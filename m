Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D85C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AAE2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1RTeYs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgANQFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:05:44 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40427 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:05:43 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so9423989ywe.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAAP2JdXcgFxBhl56nV1tk8WCkwM6wjoMIO0G3IteqI=;
        b=o1RTeYs0to9YmBEHxHTwHSEUv/fnUFuviFip7biVyFBtfv5BDeL0yAdUT55WtszMqM
         ZtntMmTkEAMK1rWaB7QrdvmGZ2EOI74jVS4ilQfTFWt2lt2dJZVYZ5NRZNNlJWMjDcFl
         QCiLlI8UBrYup1P8VCdFz2ls7TLH19qwmU4f1qd5CfW2IaKnFt50WMK6C9XCquq5YStv
         FBo42piZx2N64YHzBR3D4m7KVj5PPEoZSWXhvrNLga+L1DrLnshGrTNdkSCAzAfOP6jP
         0u/2VH5CuV3aVHEM5/D4L45RP6aMp27BEqdvWtX1tRhHzXMSj2V7op94wQugvjwU7jGA
         TKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAAP2JdXcgFxBhl56nV1tk8WCkwM6wjoMIO0G3IteqI=;
        b=Iz2UJn1iXRHP4Ggn7cJHvWYtrhJDCtHQm/4+HXebyFFnrNK4WGapPxOUfBtECIwFKY
         J+pCTKCkeLwVgBEkltf/3aX8qhAn+w9ArRPCygYr0AM/wgZO7bps/e6MvuuWKUdYnxKu
         cCW+qAMGJk0SHR2PuGs+Kb4oDqFzvQqVo5u22+reEYUkPcMEVJrZ9/jBR3DW9LZS3qDu
         0JJrRMxiNtb0pVHfbbLHQ5cKcedzAJsOYqcfhzH4LRhBOoCOX4HCTaWl3VbIAessV/Hk
         lxIaXOYsRajJ2Y8A8/WaGWFPJ8uTN7M4aAEGcuJEOGgweup/hXcqaijESgLjqVF2o9NJ
         bFBg==
X-Gm-Message-State: APjAAAVg5aon7G57W7aRdLK/5n7wZaJEDMWmAlvGXqgMEpb52+uHwTTZ
        +1f2p6JbvlQ8dTCOswxZC9qnyf5mX0+pEpOJYR1KFw==
X-Google-Smtp-Source: APXvYqwC0OB/6gLA6rihbYKssh977hvwsHcfpO/KRTW1EX3faERVWGaeFnIgAC1VBqkXkhCGpThc6iCZ1wiXtKcbvxU=
X-Received: by 2002:a0d:dd56:: with SMTP id g83mr17603981ywe.174.1579017942555;
 Tue, 14 Jan 2020 08:05:42 -0800 (PST)
MIME-Version: 1.0
References: <1578993820-2114-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1578993820-2114-1-git-send-email-yangpc@wangsu.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 14 Jan 2020 08:05:30 -0800
Message-ID: <CANn89i+nf+cPSxZdRziRa3NaDvdMG+xKYBsy752NX+3vkLba1w@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix marked lost packets not being retransmitted
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     David Miller <davem@davemloft.net>,
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

On Tue, Jan 14, 2020 at 1:24 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> When the packet pointed to by retransmit_skb_hint is unlinked by ACK,
> retransmit_skb_hint will be set to NULL in tcp_clean_rtx_queue().
> If packet loss is detected at this time, retransmit_skb_hint will be set
> to point to the current packet loss in tcp_verify_retransmit_hint(),
> then the packets that were previously marked lost but not retransmitted
> due to the restriction of cwnd will be skipped and cannot be
> retransmitted.


"cannot be retransmittted"  sounds quite alarming.

You meant they will eventually be retransmitted, or that the flow is
completely frozen at this point ?

Thanks for the fix and test !

(Not sure why you CC all these people having little TCP expertise btw)

> To fix this, when retransmit_skb_hint is NULL, retransmit_skb_hint can
> be reset only after all marked lost packets are retransmitted
> (retrans_out >= lost_out), otherwise we need to traverse from
> tcp_rtx_queue_head in tcp_xmit_retransmit_queue().
>
> Packetdrill to demonstrate:
>
> // Disable RACK and set max_reordering to keep things simple
>     0 `sysctl -q net.ipv4.tcp_recovery=0`
>    +0 `sysctl -q net.ipv4.tcp_max_reordering=3`
>
> // Establish a connection
>    +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
>    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
>    +0 bind(3, ..., ...) = 0
>    +0 listen(3, 1) = 0
>
>   +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
>    +0 > S. 0:0(0) ack 1 <...>
>  +.01 < . 1:1(0) ack 1 win 257
>    +0 accept(3, ..., ...) = 4
>
> // Send 8 data segments
>    +0 write(4, ..., 8000) = 8000
>    +0 > P. 1:8001(8000) ack 1
>
> // Enter recovery and 1:3001 is marked lost
>  +.01 < . 1:1(0) ack 1 win 257 <sack 3001:4001,nop,nop>
>    +0 < . 1:1(0) ack 1 win 257 <sack 5001:6001 3001:4001,nop,nop>
>    +0 < . 1:1(0) ack 1 win 257 <sack 5001:7001 3001:4001,nop,nop>
>
> // Retransmit 1:1001, now retransmit_skb_hint points to 1001:2001
>    +0 > . 1:1001(1000) ack 1
>
> // 1001:2001 was ACKed causing retransmit_skb_hint to be set to NULL
>  +.01 < . 1:1(0) ack 2001 win 257 <sack 5001:8001 3001:4001,nop,nop>
> // Now retransmit_skb_hint points to 4001:5001 which is now marked lost
>
> // BUG: 2001:3001 was not retransmitted
>    +0 > . 2001:3001(1000) ack 1
>
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  net/ipv4/tcp_input.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0238b55..5347ab2 100644
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
>
> --
> 1.8.3.1
>
