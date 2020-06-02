Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61807C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CAF20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4Mkc+dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFBNGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:05:59 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C2AC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 06:05:58 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id p123so6997514yba.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFsfcQemjMCArAIh7NlAUzZw5oK+VuGVflBxxbpyMNU=;
        b=G4Mkc+dNtZ2fipofo7VgIwjo6Ks9tpbC6pTKI3gzplgDni4JSiqB9yPwgmRwdCtu7+
         1bt4uS4hOVY5WynzAh8i58D7dIGglCDme3P1ciuce5tOW0mQrDhSWDPHIzwa6ghy/sJs
         PK1lXT4B+R20cEUL3r1zB1SaNHwTIfRosxBFat94kvDohAQKJuYdAUXVcE0KxCa5gMaQ
         HUi3iYsOlKIHYa2d0Omla2grPzxrYTDh07w/ihOgY0R0iDTHy3i9V5iatmaQJU5KBWE0
         0RQzW3uST/RJ/oMPznqN37S5lmuD+1lExLqMBwbEadjWNDISGstNiMp5Iigy7VsgZ0Eo
         /WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFsfcQemjMCArAIh7NlAUzZw5oK+VuGVflBxxbpyMNU=;
        b=DAWU+/AD4IrDJAraBfOvzREaZVltO4C4qHXaFVI/mDZGNiu2UExHzaCZMxmeYaE1/w
         AmrY7VYggJon2pG8wn9PMDtpKUeBQ7DQfxs61/78BKQ1uxOAmRI2ZCBAQAlG7x8tMp0R
         oA/UWgWvdhXUwBohVMw/tdsYecnlCsSLmwuQSizoqvqrSlJUtVpbVXgFX+3TNuWaDC+u
         fzGFiYg8LcHOqgPikdrpHZ5jgpK0LduQsjvR5HICWsiYmCdD0byuak3Y2wRN8MTl6msh
         uZGVvPar2WLv0b8sMz7pqDlo2p49T1Z9ww6gbSW07P1Nx93L2mNv6eTW7Qk0zLUelTQ/
         ZMAA==
X-Gm-Message-State: AOAM530U4apYcvQ6WDwfw4hr2FJLr2RIfG92GyttfpKZsSL1HEOlyuvC
        FuyjIPyUO+ShRTwXopH7eN0lyIaJNhqWoqDjF7jMCg==
X-Google-Smtp-Source: ABdhPJxnq83T9uPawX2t1PQAbsAWK2BSFIDF95VJt6uuLTrHGnv4Dsd7tdgkYmLmwexjJ1fZKR+RgjJN5pWQvPcwaVM=
X-Received: by 2002:a25:1484:: with SMTP id 126mr41221569ybu.380.1591103156614;
 Tue, 02 Jun 2020 06:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200602080425.93712-1-kerneljasonxing@gmail.com>
In-Reply-To: <20200602080425.93712-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 2 Jun 2020 06:05:44 -0700
Message-ID: <CANn89iLNCDuXAhj4By0PDKbuFvneVfwmwkLbRCEKLBF+pmNEPg@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix TCP socks unreleased in BBR mode
To:     kerneljasonxing@gmail.com
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, liweishi@kuaishou.com,
        lishujin@kuaishou.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 1:05 AM <kerneljasonxing@gmail.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
>
> TCP socks cannot be released because of the sock_hold() increasing the
> sk_refcnt in the manner of tcp_internal_pacing() when RTO happens.
> Therefore, this situation could increase the slab memory and then trigger
> the OOM if the machine has beening running for a long time. This issue,
> however, can happen on some machine only running a few days.
>
> We add one exception case to avoid unneeded use of sock_hold if the
> pacing_timer is enqueued.
>
> Reproduce procedure:
> 0) cat /proc/slabinfo | grep TCP
> 1) switch net.ipv4.tcp_congestion_control to bbr
> 2) using wrk tool something like that to send packages
> 3) using tc to increase the delay in the dev to simulate the busy case.
> 4) cat /proc/slabinfo | grep TCP
> 5) kill the wrk command and observe the number of objects and slabs in TCP.
> 6) at last, you could notice that the number would not decrease.
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: liweishi <liweishi@kuaishou.com>
> Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> ---
>  net/ipv4/tcp_output.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index cc4ba42..5cf63d9 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -969,7 +969,8 @@ static void tcp_internal_pacing(struct sock *sk, const struct sk_buff *skb)
>         u64 len_ns;
>         u32 rate;
>
> -       if (!tcp_needs_internal_pacing(sk))
> +       if (!tcp_needs_internal_pacing(sk) ||
> +           hrtimer_is_queued(&tcp_sk(sk)->pacing_timer))
>                 return;
>         rate = sk->sk_pacing_rate;
>         if (!rate || rate == ~0U)
> --
> 1.8.3.1
>

Hi Jason.

Please do not send patches that do not apply to current upstream trees.

Instead, backport to your kernels the needed fixes.

I suspect that you are not using a pristine linux kernel, but some
heavily modified one and something went wrong in your backports.
Do not ask us to spend time finding what went wrong.

Thank you.
