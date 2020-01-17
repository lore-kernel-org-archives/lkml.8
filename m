Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6BCC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7522072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p06gb2hX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgAQO27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:28:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46020 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgAQO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:28:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so22313437oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wx4YHHjEIs92WXguLwylQ65bmTpEJbutpC1Q71wXrBE=;
        b=p06gb2hXYIMEDQpGF7mdZEZrZWYjtpQ1BEfPre6zr33CM9N+acDO34sBaYwzGDByue
         wPLnKvVOpaIJ/A87KPmeFsERTpl/aCaUzbx+6Sy6TDbj8uzqbWocREvhCtUjbiAkgfCY
         WE8fbNUggQFye5KHjGGeNsM7MF415Of+515a+sBJDRDb037aeNwoSPd5PXItviYFlVB/
         Hmg9Ii+VK8RyJVix4RB2JKlhQfOA5/TNL4izlQlGPFwArX7KAiNSPMoHbr6aPR7HEnnN
         UgpUooHsPlCXKGw+Y/D+zLI5qDzFsiNANBh3dp4xs3tgmlyFQGe2rH2mEuNyAWhly0G5
         f3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wx4YHHjEIs92WXguLwylQ65bmTpEJbutpC1Q71wXrBE=;
        b=WHDr610l5hCHayiGBd6miaRo/U9SYpdNk38rnsP4Yujx3i48kJxXei5oMVI1xH4oKX
         /ADCo3bcTGO23PHrK4Z/Vcmjl/RS88V/vpWv5YOwiHqMc6jbvVfpqpShamgQlQGFwNEo
         uN4wIlVGzEvcVm4/A07PwH4pEe7gsFhnZAcWjOmQa7UMKa7WvgN1jtcSyjKlg3nEDgvu
         1SWWXWVD5EJq2O2W4HzDw6TNvGsktOqd1zjZtSqz/bg7v4wdnJ9UNfRVz2fyg0KM1Sqg
         QMk0Aq62yNbblgL7NdhF/QOuFf798X94uSK7y9gP15xqx1ZH282idpmiK/5Q09LMf9dS
         5J3Q==
X-Gm-Message-State: APjAAAVP9gdzTgoxF01s25OD3wDfIDej4x0rfNH+Pgq0vtKHFf9KwGq3
        Sr6vgAkX7ocEUApX7MXFF5oGcnsc2NOdkm2uWnkw3A==
X-Google-Smtp-Source: APXvYqyj18+lg03nqliskH8h7SVrSTN6fS4lw6uzfLiAmC/Mh4BQKZwSDccwQPDUX7KHk9ITXarRCiAeGDogQ0SHA6Y=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr3493809oid.22.1579271338082;
 Fri, 17 Jan 2020 06:28:58 -0800 (PST)
MIME-Version: 1.0
References: <1579255425-29273-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1579255425-29273-1-git-send-email-yangpc@wangsu.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 17 Jan 2020 09:28:41 -0500
Message-ID: <CADVnQynRGvRYpPAyLG7hDX-yVK29sHAV4vUSAYxEm-8s9dNV1A@mail.gmail.com>
Subject: Re: [PATCH] tcp: Use REXMIT_NEW instead of 2
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 5:04 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> Use REXMIT_NEW instead of the confusing 2 in tcp_xmit_recovery()
>
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5347ab2..de07439 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3554,7 +3554,7 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
>         if (rexmit == REXMIT_NONE || sk->sk_state == TCP_SYN_SENT)
>                 return;
>
> -       if (unlikely(rexmit == 2)) {
> +       if (unlikely(rexmit == REXMIT_NEW)) {
>                 __tcp_push_pending_frames(sk, tcp_current_mss(sk),
>                                           TCP_NAGLE_OFF);
>                 if (after(tp->snd_nxt, tp->high_seq))
> --

This change was already made recently in the net-next branch (see
below). To avoid duplicate work like this, please submit improvement
patches like this as patches against the very latest net-next branch
(or net branch, for bug fixes).

thanks,
neal

--

commit d0e8bcafc8aff5553beffe55046795f9bab9fe7b
Author: Mao Wenan <maowenan@huawei.com>
Date:   Thu Jan 2 22:02:27 2020 +0800

    tcp: use REXMIT_NEW instead of magic number

    REXMIT_NEW is a macro for "FRTO-style
    transmit of unsent/new packets", this patch
    makes it more readable.

    Signed-off-by: Mao Wenan <maowenan@huawei.com>
    Acked-by: Neal Cardwell <ncardwell@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 88b987ca9ebb..1d1e3493965f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3550,7 +3550,7 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
        if (rexmit == REXMIT_NONE || sk->sk_state == TCP_SYN_SENT)
                return;

-       if (unlikely(rexmit == 2)) {
+       if (unlikely(rexmit == REXMIT_NEW)) {
                __tcp_push_pending_frames(sk, tcp_current_mss(sk),
                                          TCP_NAGLE_OFF);
                if (after(tp->snd_nxt, tp->high_seq))
