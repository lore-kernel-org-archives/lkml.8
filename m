Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE88C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D2520801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hwpa5+EB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgFLKR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFLKR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:17:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81340C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:17:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n24so10403428lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZlUc07Rr8ksgIjTvwWUAkRdKf7159z7g2XNRXUltyI=;
        b=Hwpa5+EBWwC9JsHgTzkp9L0UNfpjyRoItxBOXVRcDB6BTWyLsPP66VWj7jFMRA7Jfn
         S3Ta3hY844UuAJyhy91+zzoZt3JF7YCMoR0+N42NKBr7WUwnBW0QqDaHbw/OCACM3R9x
         IxLn99jsfxcVSimF8KQS7D5rCyRCEHKpf6pR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZlUc07Rr8ksgIjTvwWUAkRdKf7159z7g2XNRXUltyI=;
        b=mcb4XVSsyXRya8ubZ1YOZoz72NVDa6T/iUaulV8nKJLXtFlFqTHRJx6W8v33qyPkAi
         bXC9dgY/DggZ0+PzdwznlEuh70sz0yRfFqMTqTQ/0QG9M/hzyhzqpINdBr0/4uwqKUZU
         Lw6H7Koa0shwqv8FfwqabomashcNzhiHO/LJ6ic47xGQrXamAoEMk3SRsYQ4W836HDqO
         ojJm0f6yXt9PhT/RVV8SqMdsvbgCuTdXn3qUwyHCvk2gZHZtaWBMI1O1hGvHH/JzOQT7
         EKWwIwOpmssUtq4F7z2qraxEycXF0U9HfBWB3eICywwrR5WoTzErwaMY8u8IxuGSTX84
         xFRQ==
X-Gm-Message-State: AOAM532rUewYBMWa6b+8xBJTKQ2tsmCJ/ILyMySp+kAcpTZi6VMOncPR
        cao70xoQEbPi13Z9QhtH0i/CuA==
X-Google-Smtp-Source: ABdhPJwUV5CjBcNm4+qoH43nmTNZKJ7PSGvfl/7KprEX5/5c/ou5DN9IOooDPHtM807G80gC7++NLA==
X-Received: by 2002:a2e:8690:: with SMTP id l16mr5792715lji.462.1591957073513;
        Fri, 12 Jun 2020 03:17:53 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w15sm1655270lfl.51.2020.06.12.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 03:17:53 -0700 (PDT)
Date:   Fri, 12 Jun 2020 12:17:50 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: sockmap: don't attach programs to UDP sockets
Message-ID: <20200612121750.0004c74d@toad>
In-Reply-To: <20200611172520.327602-1-lmb@cloudflare.com>
References: <20200611172520.327602-1-lmb@cloudflare.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 18:25:20 +0100
Lorenz Bauer <lmb@cloudflare.com> wrote:

> The stream parser infrastructure isn't set up to deal with UDP
> sockets, so we mustn't try to attach programs to them.
> 
> I remember making this change at some point, but I must have lost
> it while rebasing or something similar.
> 
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  net/core/sock_map.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 00a26cf2cfe9..35cea36f3892 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -424,10 +424,7 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
>  	return 0;
>  }
>  
> -static bool sock_map_redirect_allowed(const struct sock *sk)
> -{
> -	return sk->sk_state != TCP_LISTEN;
> -}
> +static bool sock_map_redirect_allowed(const struct sock *sk);
>  
>  static int sock_map_update_common(struct bpf_map *map, u32 idx,
>  				  struct sock *sk, u64 flags)
> @@ -508,6 +505,11 @@ static bool sk_is_udp(const struct sock *sk)
>  	       sk->sk_protocol == IPPROTO_UDP;
>  }
>  
> +static bool sock_map_redirect_allowed(const struct sock *sk)
> +{
> +	return sk_is_tcp(sk) && sk->sk_state != TCP_LISTEN;
> +}
> +
>  static bool sock_map_sk_is_suitable(const struct sock *sk)
>  {
>  	return sk_is_tcp(sk) || sk_is_udp(sk);

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
