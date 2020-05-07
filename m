Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C0C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956D72064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSM6qpbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgEGArb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgEGAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:47:26 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFFC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 17:47:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y26so4383075ioj.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 17:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYSzKMOk3or2uFoTZZzRJZRiS035mjjJocvNWlKm6tM=;
        b=dSM6qpbUf+qLjqBHYANWC6rRaGEkZVYX7hCaUGcJC4jffs2/nlqOD1bGMOPdjX+0+u
         a0tj0jTWA0vqVQieHoGIHDnsiNYn7Dw+2q0mr2Gkf68qDvpGO82TQyegMyE/Z4LiOJ3b
         GRJ84a2QIlYNH31ggzEgMyWSqShuOj+CH5JvSNPUzWdeAQutmWJ3P1ZvJ86vbBd6iuHN
         n7389hKng19UxWWQQEuY62XlkhD1bR4w7Zd7sbnyOUdPU72sUqC4eCcSP5J7GiTdAQQB
         9y6MfecM3KC1F5nVtFVqksBFcaWUYIxAFWHlo3HuzbCvAuzZoI38OKi7Mr/JvPGr4KE1
         /whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYSzKMOk3or2uFoTZZzRJZRiS035mjjJocvNWlKm6tM=;
        b=QpP+NCcMVW06ru0/D321URWLNfvWsENlaVZXxvzYQBmbuluCyl0+K6lHsFjV40drNr
         4ATvIxcu5TDqOBgzXDnX7mHPkOHH8KHORoMz/GIIxzAcmwLPwWc9EDDQcg3cex26ZaNU
         aLN8B9c/qlVCosr2TXlB4jCJaGueU7h6FE41v+7v5Fj0aMq+UmQLI8NqsFQ5l6y7I7LN
         46y8CiW1MLsFXgCDX7b9eG7Vjhokeg4Wg78ue1V6BIXm+0jeiYpyYolRHE3lnCStILzp
         chP26bTBjfq3HZGE9OchDzjt+0rIpqk04tj6mHfeS4f5UdcxmjK0T/Fyx5djwAsRxChB
         ANeg==
X-Gm-Message-State: AGi0PubCv7iUKbRAbXg5fbGYWX5zaS6PPtEPneh/c7VUSxfgEJIigUUw
        gSV2k1OG7h+ewW7FjXiq67bkBhjaNw2f74obkSLGnw==
X-Google-Smtp-Source: APiQypJvM5QMB5Afb5RNgm1KdSj0U7xDMShFulj/eorpksz8gZajXOONziEH5xmbd7Mj52enCkEHqDk9ToBBgmsDRQU=
X-Received: by 2002:a02:cd03:: with SMTP id g3mr10773598jaq.61.1588812445532;
 Wed, 06 May 2020 17:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200420231427.63894-1-zenczykowski@gmail.com>
 <20200506233259.112545-1-zenczykowski@gmail.com> <20200506165517.140d39ac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200506165517.140d39ac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Wed, 6 May 2020 17:47:12 -0700
Message-ID: <CANP3RGc4aWPM09SoD3gk1R9f1UL4Ef57LHGiTKMBvYBLotwPGQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: bpf: permit redirect from L3 to L2 devices at
 near max mtu
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought we have established that checking device MTU (m*T*u)
> at ingress makes a very limited amount of sense, no?
>
> Shooting from the hip here, but won't something like:
>
>     if (!skb->dev || skb->tc_at_ingress)
>         return SKB_MAX_ALLOC;
>     return skb->dev->mtu + skb->dev->hard_header_len;
>
> Solve your problem?

I believe that probably does indeed solve the ingress case of tc
ingress hook on cellular redirecting to wifi.

However, there's 2 possible uplinks - cellular (rawip, L3), and wifi
(ethernet, L2).
Thus, there's actually 4 things I'm trying to support:

- ipv6 ingress on cellular uplink (L3/rawip), translate to ipv4,
forward to wifi/ethernet <- need to add ethernet header

- ipv6 ingress on wifi uplink (L2/ether), translate to ipv4, forward
to wifi/ethernet <- trivial, no packet size change

- ipv4 egressing through tun (L3), translate to ipv6, forward to
cellular uplink <- trivial, no packet size change

- ipv4 egressing through tun (L3), translate to ipv6, forward to wifi
uplink <- need to add ethernet header [*]

I think your approach doesn't solve the reverse path (* up above):

ie. ipv4 packets hitting a tun device (owned by a clat daemon doing
ipv4<->ipv6 translation in userspace), being stolen by a tc egress
ebpf hook, mutated to ipv6 by ebpf and bpf_redirect'ed to egress
through a wifi ipv6-only uplink.

Though arguably in this case I could probably simply increase the tun
device mtu by another 14, while keeping ipv4 route mtus low...
(tun mtu already has to be 28 bytes lower then wifi mtu to allow
replacement of ipv4 with ipv6 header (20 bytes extra), with possibly
an ipv6 frag header (8 more bytes))

Any further thoughts?
