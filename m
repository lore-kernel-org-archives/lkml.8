Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3AFC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59BD20578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cT1aVW9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgBXH3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:29:20 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42070 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgBXH3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:29:19 -0500
Received: by mail-yw1-f68.google.com with SMTP id b81so4793901ywe.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 23:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pu7YZUk9S4E/pNGkKq9v6WlWWKovjGT+ogGtMRUpTlY=;
        b=cT1aVW9aEmNffyJsbSnpD1pePBSTJmnbrzeS1G1xYMa+f/EI6Ix7TCrDA2k7COPesT
         nCNnqeSTzMOzj9Dop4WbLhHHv4N6u/cpIlGFjewYNHHviMvEopaL5JfcJWNiNYOy828a
         5q0KS5TdQWwz9hJAk7r952F3mLit5GROR1edHOg1LGu+yE8oWQ3LB3TLurElJ+N/IUhS
         yJOqnGyl9XxLMZrwR8wmW/j6Hkht8FySi7RJe6fJtKM5dYhMdn9bTuo8r9THb3skjq7K
         /3mYHGC5MFfzeDS085t/m1H8wI9bVvbmxd3lRfq7AH9PkcpWJXQWmBQKz0NmH5Zm2SVy
         CC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pu7YZUk9S4E/pNGkKq9v6WlWWKovjGT+ogGtMRUpTlY=;
        b=d+NpYbbZqS3CeC6wEK1c1f1ijCJ7yPoK1NohuHdKquiiOwApxBGTXrDy9t7Hf+cw3+
         4sNEgLgm1a/Qz58AUDyhXk4YXrvC7CmOAuEmHwqDzPIu327A9PA1IFYg6EERqVyhDy3Z
         NCCk3HjuohPFyN/PSMDyKH/QdMQ/PljFpvhOCzzmD1o0VtKrsUkwmzXp9FL8YDXh6ROw
         0xhSSOFnV2aTVL/fZ+H/Lv9UvoUfMhfnrxt8SRpQnYScMsid3dxXtSEv2b0FbHyBFpGU
         zgoamkiANOqQ44+E1YrLBsiowon29Zs2FT6aevleFOOXPlE3VR4aGgcVxwU0VE94ie6j
         5c9A==
X-Gm-Message-State: APjAAAX5BFl30e/sziUgiiEQv4zSryBI0jfioOuUMv+NLuqXdWsEnv7V
        b68+IfTqwPUgpM1KM5AmhnjEhiF8+2/LK0nzBhZ2ZQ==
X-Google-Smtp-Source: APXvYqxZIwuqqBEDmmlfQUkUBgpzYL2C3CpS2lE4a1qMVtMJH7Paj2i9si0t8xcdBW8R0TX6IMVC8K2dWXRjAM3RHXU=
X-Received: by 2002:a81:3a06:: with SMTP id h6mr39722556ywa.170.1582529356484;
 Sun, 23 Feb 2020 23:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20200222010456.40635-1-shakeelb@google.com>
In-Reply-To: <20200222010456.40635-1-shakeelb@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 23 Feb 2020 23:29:04 -0800
Message-ID: <CANn89iJ2CWSeLp-+mfBLWKNdS2vw=r1iLFtWhyzav_SYcjFrAg@mail.gmail.com>
Subject: Re: [PATCH] net: memcg: late association of sock to memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        netdev <netdev@vger.kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-mm <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 5:05 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> If a TCP socket is allocated in IRQ context or cloned from unassociated
> (i.e. not associated to a memcg) in IRQ context then it will remain
> unassociated for its whole life. Almost half of the TCPs created on the
> system are created in IRQ context, so, memory used by suck sockets will
> not be accounted by the memcg.
>
> This issue is more widespread in cgroup v1 where network memory
> accounting is opt-in but it can happen in cgroup v2 if the source socket
> for the cloning was created in root memcg.
>
> To fix the issue, just do the late association of the unassociated
> sockets at accept() time in the process context and then force charge
> the memory buffer already reserved by the socket.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  net/ipv4/inet_connection_sock.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index a4db79b1b643..df9c8ef024a2 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -482,6 +482,13 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>                 }
>                 spin_unlock_bh(&queue->fastopenq.lock);
>         }
> +
> +       if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
> +               mem_cgroup_sk_alloc(newsk);
> +               if (newsk->sk_memcg)
> +                       mem_cgroup_charge_skmem(newsk->sk_memcg,
> +                                       sk_mem_pages(newsk->sk_forward_alloc));

I am not sure what you  are trying to do here.

sk->sk_forward_alloc is not the total amount of memory used by a TCP socket.
It is only some part that has been reserved, but not yet consumed.

For example, every skb that has been stored in TCP receive queue or
out-of-order queue might have
used memory.

I guess that if we assume that  a not yet accepted socket can not have
any outstanding data in its transmit queue,
you need to use sk->sk_rmem_alloc as well.

To test this patch, make sure to add a delay before accept(), so that
2MB worth of data can be queued before accept() happens.

Thanks.
