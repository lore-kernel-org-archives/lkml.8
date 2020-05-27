Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE45C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BD920899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LElVz68M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgE0RLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgE0RLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:11:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297F6C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:11:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q8so25450775iow.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ahHryfq5nLP7OxK7AYhV0J7hu5fGF/+Tti5VS7s9PGY=;
        b=LElVz68MiE/YQDaQQkjnIce2x8Dp72FAmdzi9u6cMlW5QOxCfMAHEVZGRsqVX5mpXC
         XFl0fP6CtVCeyb6KGocVAlBzo4eJh1t3LZ9leAqqCcOCP+D4KfHUerX23DpoV5FPP2dp
         rwgefUVg9DscpsWiswBskJBCWxWPQnUB8pbaeeRukkyBb3tddMZAHl74S/fCexuRZrpf
         MV4BYsWxXwxhQRhTEEH4BEI80Gq1fduPhL+urfsUed94PDAOB5hVrHulP9XWSx9jtrHD
         ELrUxbe2N8532doDagOConj6vAYlqv2PkbeRMAFebDIRKToIWc11KXSI5HyZiggVdBHu
         02TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ahHryfq5nLP7OxK7AYhV0J7hu5fGF/+Tti5VS7s9PGY=;
        b=EVtqsJaD35rmFLgDyfd7GX/GHYnYBk6eLccI0S4v+UPDbdU9R+YmpvGoipg/L44i83
         5EAyL9aK1gLSOE0Kn9jajgpM6qgjaB5b9GktNiaIwFzI8k0fnh3BqIvDz7jsrzsaWXY5
         LOh115gOdMGXfK6tPTJeCCZ9GnyIWFEWYux0LZEht5Am6SxHZT9m0BirWB+/gf6qoz9e
         k3jpWBR4cM7cuIMHW2g0L5CGd/YPbjIRyr0Rq3NkcGW2ntOb+cGQZLRPd/pyfVDIoUQ6
         yhr+6v+CFrqBqdHDp1or50OLSiOYOZ4VriwnmAhrQ6T7qjWQMi+eE7Exka8HVfA5Pfr4
         /4oQ==
X-Gm-Message-State: AOAM532c6c/kmlYkJlMTk1fznPm4ApfBxM+1wdMgYUnyyfZh0ljYQCPc
        LCxD/MRgFrw5gEZ9ZHqCaaeGV8+NvskRx3pii3nTBA==
X-Google-Smtp-Source: ABdhPJzRJWD2xome9tmo6qlIlwT/4yiFIyh+d5ScsqUx9bHKbFX0P+hIQwjCVykxFquNovp8ybfZbwyVzATHrIEOpfg=
X-Received: by 2002:a05:6602:2c88:: with SMTP id i8mr22263788iow.74.1590599492383;
 Wed, 27 May 2020 10:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200525154633.GB22403@atlantis>
In-Reply-To: <20200525154633.GB22403@atlantis>
From:   Christophe Gouault <christophe.gouault@6wind.com>
Date:   Wed, 27 May 2020 19:11:21 +0200
Message-ID: <CADdy8Ho0v7SV_dNR+syBFX79U+iE62sumLjDQypgkxs536fCbQ@mail.gmail.com>
Subject: Re: [PATCH net-next] xfrm: no-anti-replay protection flag
To:     =?UTF-8?Q?Petr_Van=C4=9Bk?= <pv@excello.cz>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

This patch is useful, however I think you should change the name of
the option and amend its description:
the option does not disable anti-replay in output (it can only be
disabled in input), it allows the output sequence number to wrap, and
it assumes that the remote peer disabled anti-replay in input.

So you I suggest you change the name of the option to something like
XFRM_SA_XFLAG_OSEQ_MAY_WRAP or XFRM_SA_XFLAG_ALLOW_OSEQ_WRAP.

Best regards,
Christophe


Le lun. 25 mai 2020 =C3=A0 17:53, Petr Van=C4=9Bk <pv@excello.cz> a =C3=A9c=
rit :
>
> RFC 4303 in section 3.3.3 suggests to disable anti-replay for manually
> distributed ICVs.
>
> This patch introduces new extra_flag XFRM_SA_XFLAG_NO_ANTI_REPLAY which
> disables anti-replay for outbound packets if set. The flag is used only
> in legacy and bmp code, because esn should not be negotiated if
> anti-replay is disabled (see note in 3.3.3 section).
>
> Signed-off-by: Petr Van=C4=9Bk <pv@excello.cz>
> ---
>  include/uapi/linux/xfrm.h |  1 +
>  net/xfrm/xfrm_replay.c    | 12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 5f3b9fec7b5f..4842b1ed49e9 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -387,6 +387,7 @@ struct xfrm_usersa_info {
>  };
>
>  #define XFRM_SA_XFLAG_DONT_ENCAP_DSCP  1
> +#define XFRM_SA_XFLAG_NO_ANTI_REPLAY   2
>
>  struct xfrm_usersa_id {
>         xfrm_address_t                  daddr;
> diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
> index 98943f8d01aa..1602843aa2ec 100644
> --- a/net/xfrm/xfrm_replay.c
> +++ b/net/xfrm/xfrm_replay.c
> @@ -89,7 +89,8 @@ static int xfrm_replay_overflow(struct xfrm_state *x, s=
truct sk_buff *skb)
>         if (x->type->flags & XFRM_TYPE_REPLAY_PROT) {
>                 XFRM_SKB_CB(skb)->seq.output.low =3D ++x->replay.oseq;
>                 XFRM_SKB_CB(skb)->seq.output.hi =3D 0;
> -               if (unlikely(x->replay.oseq =3D=3D 0)) {
> +               if (unlikely(x->replay.oseq =3D=3D 0) &&
> +                   !(x->props.extra_flags & XFRM_SA_XFLAG_NO_ANTI_REPLAY=
)) {
>                         x->replay.oseq--;
>                         xfrm_audit_state_replay_overflow(x, skb);
>                         err =3D -EOVERFLOW;
> @@ -168,7 +169,8 @@ static int xfrm_replay_overflow_bmp(struct xfrm_state=
 *x, struct sk_buff *skb)
>         if (x->type->flags & XFRM_TYPE_REPLAY_PROT) {
>                 XFRM_SKB_CB(skb)->seq.output.low =3D ++replay_esn->oseq;
>                 XFRM_SKB_CB(skb)->seq.output.hi =3D 0;
> -               if (unlikely(replay_esn->oseq =3D=3D 0)) {
> +               if (unlikely(replay_esn->oseq =3D=3D 0) &&
> +                   !(x->props.extra_flags & XFRM_SA_XFLAG_NO_ANTI_REPLAY=
)) {
>                         replay_esn->oseq--;
>                         xfrm_audit_state_replay_overflow(x, skb);
>                         err =3D -EOVERFLOW;
> @@ -572,7 +574,8 @@ static int xfrm_replay_overflow_offload(struct xfrm_s=
tate *x, struct sk_buff *sk
>
>                 XFRM_SKB_CB(skb)->seq.output.hi =3D 0;
>                 xo->seq.hi =3D 0;
> -               if (unlikely(oseq < x->replay.oseq)) {
> +               if (unlikely(oseq < x->replay.oseq) &&
> +                   !(x->props.extra_flags & XFRM_SA_XFLAG_NO_ANTI_REPLAY=
)) {
>                         xfrm_audit_state_replay_overflow(x, skb);
>                         err =3D -EOVERFLOW;
>
> @@ -611,7 +614,8 @@ static int xfrm_replay_overflow_offload_bmp(struct xf=
rm_state *x, struct sk_buff
>
>                 XFRM_SKB_CB(skb)->seq.output.hi =3D 0;
>                 xo->seq.hi =3D 0;
> -               if (unlikely(oseq < replay_esn->oseq)) {
> +               if (unlikely(oseq < replay_esn->oseq) &&
> +                   !(x->props.extra_flags & XFRM_SA_XFLAG_NO_ANTI_REPLAY=
)) {
>                         xfrm_audit_state_replay_overflow(x, skb);
>                         err =3D -EOVERFLOW;
>
> --
> 2.26.2
>
