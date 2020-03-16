Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB52EC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFAA20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BG+T0vYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbgCPVTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:19:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35645 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732673AbgCPVTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:19:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id k8so18033673oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1XE8izbV0aV0z/olO49sH8BHMSQtnlugBK/5fYy8X0=;
        b=BG+T0vYj04UU9sc0t/b/Jp6Xu57WufXdocIV02O2pLWUTL7JSKwxuho3mNpbM9jdwq
         PcEvQRuGXBFH0UGhbqzkHMnAwE76hvV29U+dDluuIPfG+cYJ+1Wa9h2Ga8luBMzhytXQ
         /F19jp8jL/8Wj3/tnD0UKos3PSVniRiZkF9yfA9ob0vpZyQlascM4hRhkzNYxaDBFyCv
         UO2Cr/C3WYpKSMYMxW+nj8CtSv/rVoSMvCaGMxJ5KAb/uNigtrZhXvfEsIZOKJjbOvCA
         l7iIt2VAbz2JhqQ/YN1+zguDpLogygrIkwPpqEGSk9GN+d50v9cBsTD/bK1xUhamexa/
         9CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1XE8izbV0aV0z/olO49sH8BHMSQtnlugBK/5fYy8X0=;
        b=huzu/XqETUbuzXKR8mX0GG42j4lgAa/99+nrRVksXcgwstqy+Ywd7pnm1a8F9tgP2C
         3YGfRZ0MOjbfWcRMWj6iqjloUCLDdCIvdLdfc5YhO3Io6URmMAyLTg+Z1xDfxsR2YzlX
         qTjLBUS1cyaP80vKg8uEpbtE+ZHsiBKcjHmrYqOhrgNXW/Q0x0i3aEoHMufupGMXcHt6
         XX+elFt+VaK7lT/DEk4I9jhdHzQpxTorvIeOSZIe4n0RxO3nv+uRXtP8ANzLjArPTuW2
         STasowHjFfoUoMRPEpp9BgX2zRCCwU+/nrfChg86kOWVQsC4jZzLP00vkavI1z4UhRIK
         vr5A==
X-Gm-Message-State: ANhLgQ3eRhZu03r4oC/XWeXtL+N8dQDPTC5dUAyTJw5VYxGInjtxlMQC
        sblXVrwmocxnFNvSWP0+1+CKXkaYCbE31KKvlU3FZUX8J64=
X-Google-Smtp-Source: ADFU+vsaemYxmyGdocbM2kpjTzMPjGbgh08QpwLxFtv3b7euEF5rISbQaAAMQa0H+kZyei4/IN9RaC1RgEJh5qQKdk8=
X-Received: by 2002:aca:3354:: with SMTP id z81mr1137863oiz.129.1584393593967;
 Mon, 16 Mar 2020 14:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <1584340511-9870-1-git-send-email-yangpc@wangsu.com> <1584340511-9870-2-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1584340511-9870-2-git-send-email-yangpc@wangsu.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Mon, 16 Mar 2020 17:19:37 -0400
Message-ID: <CADVnQymUE6b5BFB8z-BLcsXx+W1KkuxwU9rAE0-nLfeQgzVsXw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v2 1/5] tcp: fix stretch ACK bugs in BIC
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 2:36 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> Changes BIC to properly handle stretch ACKs in additive
> increase mode by passing in the count of ACKed packets
> to tcp_cong_avoid_ai().
>
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  net/ipv4/tcp_bic.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/tcp_bic.c b/net/ipv4/tcp_bic.c
> index 645cc30..f5f588b 100644
> --- a/net/ipv4/tcp_bic.c
> +++ b/net/ipv4/tcp_bic.c
> @@ -145,12 +145,13 @@ static void bictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
>         if (!tcp_is_cwnd_limited(sk))
>                 return;
>
> -       if (tcp_in_slow_start(tp))
> -               tcp_slow_start(tp, acked);
> -       else {
> -               bictcp_update(ca, tp->snd_cwnd);
> -               tcp_cong_avoid_ai(tp, ca->cnt, 1);
> +       if (tcp_in_slow_start(tp)) {
> +               acked = tcp_slow_start(tp, acked);
> +               if (!acked)
> +                       return;
>         }
> +       bictcp_update(ca, tp->snd_cwnd);
> +       tcp_cong_avoid_ai(tp, ca->cnt, acked);
>  }
>
>  /*
> --

Acked-by: Neal Cardwell <ncardwell@google.com>

thanks,
neal
