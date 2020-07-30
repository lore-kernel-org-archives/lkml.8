Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D84207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StlI6RkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgG3VQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgG3VQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:16:33 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C403C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:16:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l17so29713948iok.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Jk6W9UOIzPrRcj3YnPe6EdgKZLyd9ssfbR+74SoEEs=;
        b=StlI6RkZvkjYp4Ua10Z/QO8u57IBSYfob3BMUfFZbqcZbKOIMZj6H8S2c1VA+5ZM39
         bibros8tONh3GpshN64Qxt9X9nGHnBllmuUH9j5D/SHtwqjdor6ijsvqonBErhnZBHXL
         gwnD3nNIqvsvVNu1GERRO8WciamGU1d8SShtr7O3TcLavcB/f5PR4SUG9cKWBXTdGRXa
         3h+BgDkp5R5jiBgmKadRMW3piVNoTppaSZJjZ8CYOgwcC6aSF0t0UbBWdsuAAbOOgXjf
         r0EoiawB0QDcsbfJpWjXtAD/zK2FS8Sv2egoZZ+B7Ja7wsTFt5AKhNF8ac8Owh71Nbbn
         XSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Jk6W9UOIzPrRcj3YnPe6EdgKZLyd9ssfbR+74SoEEs=;
        b=TD2zYk1aB696wv76n3PV27kVN5X2soE42hpWWC7GV8JLyHEg/jFoyz8PYs43ocz2YS
         OavpV9GDPXIYwm8rn9ruUnhH5oqJHEHu7y6UwJdKznuifF0J83VECcuH5p5m+GoNEFDA
         MwxPgm8NXCptAwm+l+8lFoC2eNAXZHh7VsODNfpc3n4IHGjXBOeLPJL43ACv5+BuCBYn
         xY8ek8bmxOg6sAcivfIhNjGD29tkxFsQmKvTEOMtlFeTwfQ/GyJ/FOAxnks2YqlyeIjC
         XJRZOeP72EHBjEuMF/X5G04S1UW7XIASIGGpdq2vCjDLYBMli+4UBnm/eTbjhbftjRRb
         qnoA==
X-Gm-Message-State: AOAM532yDcJX9sb2Qtd8IX3/Hj95HSw3ckHU8lhCF0jbzRuX+PXLoEQM
        vMA2LjO1kH8T+P9rHx53diKvybMrJlAd++Il8AXo9A==
X-Google-Smtp-Source: ABdhPJwljSBFhldA5zSRyAo3DDoV7SOJr360N8Y0jCDmFcLoi+5OhqGo4hqoWPoGDjDjGZwW1BJvLujU6wY0dVUpu7w=
X-Received: by 2002:a05:6638:2493:: with SMTP id x19mr1356986jat.53.1596143792287;
 Thu, 30 Jul 2020 14:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200730210728.2051-1-f.fainelli@gmail.com>
In-Reply-To: <20200730210728.2051-1-f.fainelli@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 30 Jul 2020 14:16:21 -0700
Message-ID: <CANn89iJETzud8PK7eTj=rXMSCjBtnmcSq1y0qF7EVK8b5M_vXA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Export tcp_write_queue_purge()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 2:07 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> After tcp_write_queue_purge() got uninlined with commit ac3f09ba3e49
> ("tcp: uninline tcp_write_queue_purge()"), it became no longer possible
> to reference this symbol from kernel modules.
>
> Fixes: ac3f09ba3e49 ("tcp: uninline tcp_write_queue_purge()")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/ipv4/tcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 6f0caf9a866d..ea9d296a8380 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2626,6 +2626,7 @@ void tcp_write_queue_purge(struct sock *sk)
>         tcp_sk(sk)->packets_out = 0;
>         inet_csk(sk)->icsk_backoff = 0;
>  }
> +EXPORT_SYMBOL(tcp_write_queue_purge);
>
>  int tcp_disconnect(struct sock *sk, int flags)
>  {
> --
> 2.17.1
>

Hmmm.... which module would need this exactly ?

How come it took 3 years to discover this issue ?
