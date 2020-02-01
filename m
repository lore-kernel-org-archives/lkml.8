Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58606C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6ED206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 13:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goCZp6+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBANwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 08:52:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37015 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBANwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 08:52:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so10276100oic.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 05:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3AaLiSgUpwnrDQv05c/qJKIdQCilADN186xzpPJhdU=;
        b=goCZp6+IUJI5npgvOJ0kF1kfxQQylb+P82vhQUKd4WlXPSxrca9aNU1SXU3jZ6tkYn
         ZYpi8BfF5KgHvvL5ErsGJYyGYVDB0/mDAbhPYEtqDsE/7NfVMbecwrJ/LWHYtUo5XJnz
         RsFLpkTdur4ZyZbCXum2h8q4TgPn50RctmsxUgqp5mDBl+UkBh8n1oRBp0ejkq7lqhN4
         7ssCmf6PzDtPES302YpCttV6QKpyon+PjEWs6i5ZxqF6UPIFZoK3LqjPCXuKDsSwC4T6
         Zh+4A914mHHh2kcC7et0XZDUc2GqWF9xaaWR2JdY493bAL3vryP1zFY03U2mBXsy/iDZ
         8mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3AaLiSgUpwnrDQv05c/qJKIdQCilADN186xzpPJhdU=;
        b=I5s9No9OsJzRhkIFV9Ah57k2Fa6gA/caIWtOaXDkZKw7vdBn0TXWtbfoH5i1V1v6Ln
         rXzsDihXE7ugGUPZDQYAcNbTJiweXfheJU7G7keHqC45HFPp8i4z9UKSVBiRQNWCC/iV
         MpxbbfJmnf/VX7ZGXPgOGXUyFq5DaSO5biKBJpt9gUqWmQmva4AbxqxOGmE8f0fIGk/f
         suUiCuOawaRVy42xP1eYmYU86+U/BI+AlIKvca5EOL/ehgCBhD9hR3xbKXCWXXqyjjr5
         UOZv4kIiKhWrVUfrPDwTXqDW8CZNGkTl+T0HTxqP/Zv3bkSJiqQEi4JbiR0/sMPuVDgM
         HzUQ==
X-Gm-Message-State: APjAAAUvyHANw+Bg+sCEel2zHf3Upw1XL3J/fakoKFKmAJ7vgv73PxNt
        OfjIL2Kq/BCHSd1tbw7h/ruX2qJb50Fxk9AbG5HuWQ==
X-Google-Smtp-Source: APXvYqw2dafn9mepdzZIWV9YnlUBbKegKBnKRlebMmKi+zD0h8rhtskaucvq/SsqG6noQWrLaIS6LUDPakUaIFn31Oo=
X-Received: by 2002:aca:ec13:: with SMTP id k19mr9210014oih.22.1580565125380;
 Sat, 01 Feb 2020 05:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20200201071859.4231-1-sj38.park@gmail.com> <20200201071859.4231-2-sj38.park@gmail.com>
In-Reply-To: <20200201071859.4231-2-sj38.park@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Sat, 1 Feb 2020 08:51:48 -0500
Message-ID: <CADVnQynpW0BZXK+hp94HF75sVnmCjTfpc9NbKU2Y+UQODnxwyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp: Reduce SYN resend delay if a suspicous ACK is received
To:     sj38.park@gmail.com
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, aams@amazon.com,
        Netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, shuah@kernel.org,
        Yuchung Cheng <ycheng@google.com>,
        David Laight <David.Laight@aculab.com>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 2:19 AM <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> When closing a connection, the two acks that required to change closing
> socket's status to FIN_WAIT_2 and then TIME_WAIT could be processed in
> reverse order.  This is possible in RSS disabled environments such as a
> connection inside a host.
>
> For example, expected state transitions and required packets for the
> disconnection will be similar to below flow.
>
>          00 (Process A)                         (Process B)
>          01 ESTABLISHED                         ESTABLISHED
>          02 close()
>          03 FIN_WAIT_1
>          04             ---FIN-->
>          05                                     CLOSE_WAIT
>          06             <--ACK---
>          07 FIN_WAIT_2
>          08             <--FIN/ACK---
>          09 TIME_WAIT
>          10             ---ACK-->
>          11                                     LAST_ACK
>          12 CLOSED                              CLOSED
>
> In some cases such as LINGER option applied socket, the FIN and FIN/ACK
> will be substituted to RST and RST/ACK, but there is no difference in
> the main logic.
>
> The acks in lines 6 and 8 are the acks.  If the line 8 packet is
> processed before the line 6 packet, it will be just ignored as it is not
> a expected packet, and the later process of the line 6 packet will
> change the status of Process A to FIN_WAIT_2, but as it has already
> handled line 8 packet, it will not go to TIME_WAIT and thus will not
> send the line 10 packet to Process B.  Thus, Process B will left in
> CLOSE_WAIT status, as below.
>
>          00 (Process A)                         (Process B)
>          01 ESTABLISHED                         ESTABLISHED
>          02 close()
>          03 FIN_WAIT_1
>          04             ---FIN-->
>          05                                     CLOSE_WAIT
>          06                             (<--ACK---)
>          07                             (<--FIN/ACK---)
>          08                             (fired in right order)
>          09             <--FIN/ACK---
>          10             <--ACK---
>          11             (processed in reverse order)
>          12 FIN_WAIT_2
>
> Later, if the Process B sends SYN to Process A for reconnection using
> the same port, Process A will responds with an ACK for the last flow,
> which has no increased sequence number.  Thus, Process A will send RST,
> wait for TIMEOUT_INIT (one second in default), and then try
> reconnection.  If reconnections are frequent, the one second latency
> spikes can be a big problem.  Below is a tcpdump results of the problem:
>
>     14.436259 IP 127.0.0.1.45150 > 127.0.0.1.4242: Flags [S], seq 2560603644
>     14.436266 IP 127.0.0.1.4242 > 127.0.0.1.45150: Flags [.], ack 5, win 512
>     14.436271 IP 127.0.0.1.45150 > 127.0.0.1.4242: Flags [R], seq 2541101298
>     /* ONE SECOND DELAY */
>     15.464613 IP 127.0.0.1.45150 > 127.0.0.1.4242: Flags [S], seq 2560603644
>
> This commit mitigates the problem by reducing the delay for the next SYN
> if the suspicous ACK is received while in SYN_SENT state.
>
> Following commit will add a selftest, which can be also helpful for
> understanding of this issue.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  net/ipv4/tcp_input.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2a976f57f7e7..980bd04b9d95 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5893,8 +5893,14 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>                  *        the segment and return)"
>                  */
>                 if (!after(TCP_SKB_CB(skb)->ack_seq, tp->snd_una) ||
> -                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt))
> +                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> +                       /* Previous FIN/ACK or RST/ACK might be ignored. */
> +                       if (icsk->icsk_retransmits == 0)
> +                               inet_csk_reset_xmit_timer(sk,
> +                                               ICSK_TIME_RETRANS, TCP_ATO_MIN,
> +                                               TCP_RTO_MAX);
>                         goto reset_and_undo;
> +               }
>
>                 if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
>                     !between(tp->rx_opt.rcv_tsecr, tp->retrans_stamp,
> --

Scheduling a timer for TCP_ATO_MIN, typically 40ms, sounds like it
might be a bit on the slow side. How about TCP_TIMEOUT_MIN, which is
typically 2ms on a HZ=1000 kernel?

I think this would be closer to what Eric mentioned: "sending the SYN
a few ms after the RST seems way better than waiting 1 second as if we
received no packet at all."

neal
