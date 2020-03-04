Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0076C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7461206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YOR70frZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgCDIjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:39:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46967 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgCDIj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:39:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id a22so1247915oid.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/X0UovT4DE7O4vko2XBAkSIwy+JqphUDS53Lj39Gf8=;
        b=YOR70frZUhrhwBN3fad57kF8tT2fIXif5ULTtPDhRJ7rO+Byhs+5kROA5eaEVK8hKV
         5qY+GNFsbIlmtCy49oPdAcoHJl03BT3SzPWBtSf0/boOlTvtoAlBmBBUgfU8GQgLMGL/
         /zixN0sDPnUHuPNEB6LfRZOsrR7q2fFcdVtvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/X0UovT4DE7O4vko2XBAkSIwy+JqphUDS53Lj39Gf8=;
        b=ZLTtz62MJMP0zeEtcpQHLlv+M5Q3XAx1uZh0C+nMa+W/zY/O9XqbJ6c/IZly1ODvKC
         2DLyhw3DdeyN7XH6TwS+r0v7Aqka7KfZYa1s9gJgLY7WcAlqy3+ODBrdN7KGvPanAjrz
         mqRmt/FGi9dLyTXQDlnxznTTAB+5DDjo4X4K8t3eXXtkGpV0pLN9XkDyyVSgG6FEek3d
         0v2oM3TfkBd8bZN297XXk3Pkq8LH1ZV0srHCUNqcQ85yMl0ap78Sert9pB7iEmepHyhB
         8nEAHTnOlsh5dfF0I9y845RMmauPfYdhzILHb35xnlU/KMH2SrbtmXpM0ltQLjiRglC1
         +KUg==
X-Gm-Message-State: ANhLgQ1RZYgcCmeiLZ0cTWb6KnTdl+/r/fgWHmoCyBeZamHA+teQGbNJ
        ojMIOXBVGPlqA7V0Geny7UaihM4Jdj3pYslMA6YSLQ==
X-Google-Smtp-Source: ADFU+vtoZ8+1Zm7KA6Uyx6vtB0DyfWaSmrmraBfYE72PaCJ0Y8a0K5KaZAJlzK/bCc4jOHppkANa/k941ZvJkcFJHDw=
X-Received: by 2002:aca:b60a:: with SMTP id g10mr970157oif.102.1583311168743;
 Wed, 04 Mar 2020 00:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20200228115344.17742-1-lmb@cloudflare.com> <20200228115344.17742-2-lmb@cloudflare.com>
 <5e5e955a27139_60e72b06ba14c5bc67@john-XPS-13-9370.notmuch>
In-Reply-To: <5e5e955a27139_60e72b06ba14c5bc67@john-XPS-13-9370.notmuch>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 4 Mar 2020 09:39:17 +0100
Message-ID: <CACAyw98oHs0CTR0k+JwZgM6maT__j5OvgsoVUGMMHx_4jW_OuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/9] bpf: sockmap: only check ULP for TCP sockets
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 18:35, John Fastabend <john.fastabend@gmail.com> wrote:
>
> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > index 112765bd146d..54a9a3e36b29 100644
> > --- a/include/linux/skmsg.h
> > +++ b/include/linux/skmsg.h
> > @@ -360,7 +360,13 @@ static inline void sk_psock_restore_proto(struct sock *sk,
> >                                         struct sk_psock *psock)
> >  {
> >       sk->sk_prot->unhash = psock->saved_unhash;
> > -     tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
> > +     if (inet_sk(sk)->is_icsk) {
>
> use sock_map_sk_has_ulp() here as well and then drop the !icsk->icsk_ulp_ops
> case in tcp_update_ulp()?

This requires moving sock_map_sk_has_ulp to the header, which seemed like the
incorrect place. How about adding bool inet_csk_has_ulp(sk) to
inet_connection_sock.h?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
