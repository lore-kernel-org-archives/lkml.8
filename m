Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2004C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA497205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehrEFKSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgB1XyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:54:07 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46621 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:54:07 -0500
Received: by mail-yw1-f66.google.com with SMTP id n1so4551065ywe.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJ5ojO5Np681CC2oVjkjjG2+Xs87TvHsctuTnLocErE=;
        b=ehrEFKSdeYbf6yWDD3UNYs5YoO/BagSQOxMGt/C8jtA9S87UmtPg9QdS6qmoGIYcFg
         hoMBxfPCo4d+JoXNyfWoNoo5zJ1Gj96gHrmfbJP8KlQ6NhnXAkR23ZbaUifBglOIzsys
         RgeEL/VdfJx8nSTQHLdX2QIMcZa4HiTJxw2Gd2FN8lQiCpR1ODw2OwntVvK84LJQxDh+
         9+gTR0Ub0boZZ23v/aCJn037knAlRODVEtAdZOYQ5Np4wc10rDVhq1QVzynxrbwszcaF
         6MLkPAzybGOVgtkUAdQiAJhubHcuUP/+LMV22GahmBRdGSulNAQsSaEXV1fsCbSovVjq
         SLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJ5ojO5Np681CC2oVjkjjG2+Xs87TvHsctuTnLocErE=;
        b=i+cvYbGGAngv+sMWk3TU2BWZaFnF7SDiIhMCPEThJ04H70L19gwxNRvhCBAfI/VIK/
         Y2RvMPuf//nDHkSSljJLaFmj6d3eU+zRptwQLD8pslJjguguBhPkjVxb0Nw6GYjtlAS2
         HRZ3otJpj/Wnc8II0sHsrPu+lrwH1uBE5Lwx+Ez5V3klYHrWz6Zfe7HHMbqXnLbB6zhN
         1F8oZmOM96aJuaMW5C4l+xmvgIaxKdrVBB71sVkBw9ERFHb3JyaGWw1uZujNw+od6Yfb
         PznFbVSvLns2CoiDjl6imCK73DTlb8VFp6iRXLSAQ0ka6a2d+NPFywnY39Soor5RSpf+
         4pFw==
X-Gm-Message-State: APjAAAV3OOrAGX0fzsUzrN7wKw2YE1WHvaMZGo3KyBoReysE19eT8PsQ
        wy4Jfo6GUJ4oW0WI1q+pcTEDDVGd
X-Google-Smtp-Source: APXvYqxYgaphwR962Z9IQs/I4mChNpN3J0wsW0i5/QqOtlzFmtZkAeLWU0NWtl41m4mjkSU30r7UzQ==
X-Received: by 2002:a5b:d09:: with SMTP id y9mr5814020ybp.188.1582934045642;
        Fri, 28 Feb 2020 15:54:05 -0800 (PST)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id e186sm4680061ywb.73.2020.02.28.15.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 15:54:04 -0800 (PST)
Received: by mail-yw1-f52.google.com with SMTP id 10so5091973ywv.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:54:04 -0800 (PST)
X-Received: by 2002:a81:6588:: with SMTP id z130mr6419395ywb.355.1582934043863;
 Fri, 28 Feb 2020 15:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20200228105435.75298-1-lrizzo@google.com> <20200228110043.2771fddb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200228110043.2771fddb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 28 Feb 2020 18:53:27 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfd80pZroxtqZDsTeEz4FaronC=pdgjeaBBfYqqi5HiyQ@mail.gmail.com>
Message-ID: <CA+FuTSfd80pZroxtqZDsTeEz4FaronC=pdgjeaBBfYqqi5HiyQ@mail.gmail.com>
Subject: Re: [PATCH v4] netdev attribute to control xdpgeneric skb linearization
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Luigi Rizzo <lrizzo@google.com>,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        David Miller <davem@davemloft.net>, hawk@kernel.org,
        "Jubran, Samih" <sameehj@amazon.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 2:01 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 28 Feb 2020 02:54:35 -0800 Luigi Rizzo wrote:
> > Add a netdevice flag to control skb linearization in generic xdp mode.
> >
> > The attribute can be modified through
> >       /sys/class/net/<DEVICE>/xdpgeneric_linearize
> > The default is 1 (on)
> >
> > Motivation: xdp expects linear skbs with some minimum headroom, and
> > generic xdp calls skb_linearize() if needed. The linearization is
> > expensive, and may be unnecessary e.g. when the xdp program does
> > not need access to the whole payload.
> > This sysfs entry allows users to opt out of linearization on a
> > per-device basis (linearization is still performed on cloned skbs).
> >
> > On a kernel instrumented to grab timestamps around the linearization
> > code in netif_receive_generic_xdp, and heavy netperf traffic with 1500b
> > mtu, I see the following times (nanoseconds/pkt)
> >
> > The receiver generally sees larger packets so the difference is more
> > significant.
> >
> > ns/pkt                   RECEIVER                 SENDER
> >
> >                     p50     p90     p99       p50   p90    p99
> >
> > LINEARIZATION:    600ns  1090ns  4900ns     149ns 249ns  460ns
> > NO LINEARIZATION:  40ns    59ns    90ns      40ns  50ns  100ns
> >
> > v1 --> v2 : added Documentation
> > v2 --> v3 : adjusted for skb_cloned
> > v3 --> v4 : renamed to xdpgeneric_linearize, documentation
> >
> > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
>
> Just load your program in cls_bpf. No extensions or knobs needed.
>
> Making xdpgeneric-only extensions without touching native XDP makes
> no sense to me. Is this part of some greater vision?

Yes, native xdp has the same issue when handling packets that exceed a
page (4K+ MTU) or otherwise consist of multiple segments. The issue is
just more acute in generic xdp. But agreed that both need to be solved
together.

Many programs need only access to the header. There currently is not a
way to express this, or for xdp to convey that the buffer covers only
part of the packet.
