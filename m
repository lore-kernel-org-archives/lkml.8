Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36596C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1CA246B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fY67vAMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgB1NUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:20:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45961 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB1NUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:20:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id h62so1384171edd.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1o3ZaVxV/UHmnlqOInMF9HnyNuLw4+witDWbmSfAHA=;
        b=fY67vAMmBHerQM7XkvTQBkSA8tEf+aCHqDBjwlzp5a4bTCOvfypvTHAj/eaojnLgpC
         V0+x4GMOypHHEgXfD1t8O8qsBR/iRbzm6ukGvgnPNS39YyBh4c1F4r5dWQQ8wNXxJvE0
         cjU7yXLgSVLiUvLfB/ngIGRXrStBYZo2mQNeA4qs6oR6KnhRzFgurZq0RkEVC5ao11bZ
         aPLkKZ10jKrw/5QDiUmqA4dWZtCMucPm1f8fo1E3pgBCQIDF7t++cfKSWXScAmAFpOgZ
         BG5crqbc3wGq04qzPo04HjySY5if6xLywXFJw+5r7Y/pKWEM9y763qH/a38E2wKuE1Hg
         14Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1o3ZaVxV/UHmnlqOInMF9HnyNuLw4+witDWbmSfAHA=;
        b=uV4qclMN7PBrr8DIZnDtja0nbbpsR7ZLqW3B4yCzGsOH6QheDY+jLYdfdqlACyUFXm
         tP8JD6L2WHeExieFDx8utDujpjX7TY0mA7/s5xzUEw1OaQtfOcoyeItXgwZIbdr4SCJr
         izBt+zO0MZwsRweZPQPmdO9U2imMSTwyLSfOol3VAfyk+Wl9IJPrnu+QN3Zj3K0+Lli/
         5eXD/3wdWXHQ0xI8Nmwo6ke0DbSwJbLbnVpfoH+Zq8/fm53mQe/dDTR/5aFSv3IDeVwN
         SKqzqQqDy97hgsYW8ZW+dvI+N1NuEPKjT0gat37Mdnicqmp1MWp9QaXcbd1tf7ZWUK+f
         9hPw==
X-Gm-Message-State: APjAAAWOkYAfazoce0ot2PIqKVhYzKq9I6j7X4/MjQVmdOs21WmSxTj/
        Ffr8dGfdCpp/gcjCoVneZ7XoB49oVZcWaSYzYa+CLQ==
X-Google-Smtp-Source: APXvYqyJQGGzScOu1xNpz+S7N8XNCiv+gfOglc2WrYXHEDHviX3IvuW5D87BD0xwI83XTKj18Iegtoqje98Vl3Zxp2M=
X-Received: by 2002:a05:6402:1694:: with SMTP id a20mr3977439edv.211.1582896005450;
 Fri, 28 Feb 2020 05:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20200228105435.75298-1-lrizzo@google.com> <20200228132941.2c8b8d01@carbon>
In-Reply-To: <20200228132941.2c8b8d01@carbon>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Fri, 28 Feb 2020 05:19:54 -0800
Message-ID: <CAMOZA0KnC0n+U+n3vjx4bb6o_1_MtzLxUfoGj22NdNVQO33uAA@mail.gmail.com>
Subject: Re: [PATCH v4] netdev attribute to control xdpgeneric skb linearization
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     netdev@vger.kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>, sameehj@amazon.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 4:30 AM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
> On Fri, 28 Feb 2020 02:54:35 -0800
> Luigi Rizzo <lrizzo@google.com> wrote:
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index dbbfff123196..c539489d3166 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4520,9 +4520,12 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
> >       /* XDP packets must be linear and must have sufficient headroom
> >        * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> >        * native XDP provides, thus we need to do it here as well.
> > +      * For non shared skbs, xdpgeneric_linearize controls linearization.
> >        */
> > -     if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> > -         skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> > +     if (skb_cloned(skb) ||
> > +         (skb->dev->xdpgeneric_linearize &&
> > +          (skb_is_nonlinear(skb) ||
> > +           skb_headroom(skb) < XDP_PACKET_HEADROOM))) {
> >               int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
> >               int troom = skb->tail + skb->data_len - skb->end;
> >
>
> Have you checked that calling bpf_xdp_adjust_tail() is not breaking anything?

It won't leak memory or cause crashes if that is what you mean.
Of course if there are more segments the effect won't be the desired one,
as it will chop off the tail of the first segment.

But this is an opt-in feature and requires the same permissions needed to load
an xdp program, so I expect it to be used consciously.

It would be nice if we had a flag in the xdp_buff to communicate that
the packet is
incomplete, but there isn't a way that I can see.

cheers
luigi
