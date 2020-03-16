Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E3C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB04F20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fw+Fzk5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbgCPVZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:25:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38692 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732641AbgCPVZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:25:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id k21so19491982oij.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7jm6R1lI66fN9dOATmAhH/neJJRs+NMkuLfeIMHpr8=;
        b=fw+Fzk5Nm5NC9Jjvn8y+I4rt14Z5Txz55IHQeV31ArJE88uELShhqpnkObRE5QZtmD
         jYMj0aYW4UFoNXmQYdsS7keXHF7J8MPwMX0fqG/DLhwfR4JW1s2tbnlFC2Ox7c0faXxJ
         b4K3YRyFMGS85VJnlMqBlqbcjmhoGhEjqw/5iwJkh2GA5Kli9USgQhTUXHtX/PDrI/kA
         Ro1G92+6c6x/dfMwER6p7Vg/PWNh201KOudDxPtz46mvigy08VngVUd4a9UkkBaXkNmM
         uS2lXIgqwdnUp2rhhr9ii9uFKVJFxThazdVykMUW+Cpqux+603zJr9aaHk0o6jfMw2Dv
         pzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7jm6R1lI66fN9dOATmAhH/neJJRs+NMkuLfeIMHpr8=;
        b=uYoNpndQPa8H39NBHMHYGUcNnPVsYRLQD82FN7K7fU3sZaT4IpitWCtKBAS8DEAZ2r
         NwNCwnrA34mAEwpw4LdBJY3WPsDuldbhL19+q+Ge/6s9PthvR5+Dh0vsjV2+tLeoeFQe
         Z2nzPg96xRjmtFOuwR8oOTpDk7TEeH1bZ03OfmFLWiEvXqira2qubp0D222pI/Vzs95d
         h1EndMZheI38P34sli7htDgVU3EVfunT4/PJjHFH/Vc6jN+Jx9xiYFGaNoETVoFDxROs
         M4Mzyi50AaDMgR2BvrfbT2dSX78z/Ugg4aFzkG1B/9utA3xR8z25z8Iz6oKsQeNDl+Pa
         Wt7A==
X-Gm-Message-State: ANhLgQ2bQ49g+8dpTEgteugj9qzKa7Oo4V+LwkPabwuLHG877BPvIX8R
        L9AHk8PiLmJJMP/5CK01IAWSgWvtoWP13RryjErVtw==
X-Google-Smtp-Source: ADFU+vvkxg9Ial7cYzV1SowN5+eIGc432CbfznEyhKHlbm/HUvs/rzGh+lWYhOHIHg7xIx54UQ3VntghxWyXsT5IU5o=
X-Received: by 2002:aca:aa12:: with SMTP id t18mr1157072oie.95.1584393957751;
 Mon, 16 Mar 2020 14:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <1584340511-9870-1-git-send-email-yangpc@wangsu.com> <1584340511-9870-3-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1584340511-9870-3-git-send-email-yangpc@wangsu.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Mon, 16 Mar 2020 17:25:41 -0400
Message-ID: <CADVnQy=nhaKY8Ub84TvFH4cFtW92_TU72OxXnV32FzdEGtDCvw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v2 2/5] tcp: fix stretch ACK bugs in Scalable
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

On Mon, Mar 16, 2020 at 2:37 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> Change Scalable to properly handle stretch ACKs in additive
> increase mode by passing in the count of ACKed packets to
> tcp_cong_avoid_ai().
>
> In addition, because we are now precisely accounting for
> stretch ACKs, including delayed ACKs, we can now change
> TCP_SCALABLE_AI_CNT to 100.
>
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  net/ipv4/tcp_scalable.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_scalable.c b/net/ipv4/tcp_scalable.c
> index 471571e..6cebf41 100644
> --- a/net/ipv4/tcp_scalable.c
> +++ b/net/ipv4/tcp_scalable.c
> @@ -10,10 +10,9 @@
>  #include <net/tcp.h>
>
>  /* These factors derived from the recommended values in the aer:
> - * .01 and and 7/8. We use 50 instead of 100 to account for
> - * delayed ack.
> + * .01 and and 7/8.
>   */
> -#define TCP_SCALABLE_AI_CNT    50U
> +#define TCP_SCALABLE_AI_CNT    100U
>  #define TCP_SCALABLE_MD_SCALE  3
>
>  static void tcp_scalable_cong_avoid(struct sock *sk, u32 ack, u32 acked)
> @@ -23,11 +22,13 @@ static void tcp_scalable_cong_avoid(struct sock *sk, u32 ack, u32 acked)
>         if (!tcp_is_cwnd_limited(sk))
>                 return;
>
> -       if (tcp_in_slow_start(tp))
> -               tcp_slow_start(tp, acked);
> -       else
> -               tcp_cong_avoid_ai(tp, min(tp->snd_cwnd, TCP_SCALABLE_AI_CNT),
> -                                 1);
> +       if (tcp_in_slow_start(tp)) {
> +               acked = tcp_slow_start(tp, acked);
> +               if (!acked)
> +                       return;
> +       }
> +       tcp_cong_avoid_ai(tp, min(tp->snd_cwnd, TCP_SCALABLE_AI_CNT),
> +                         acked);
>  }
>
>  static u32 tcp_scalable_ssthresh(struct sock *sk)
> --

Acked-by: Neal Cardwell <ncardwell@google.com>

thanks,
neal
