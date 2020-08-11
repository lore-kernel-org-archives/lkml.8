Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0021206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StcvkEIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgHKKut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgHKKun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:50:43 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEF1C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:50:42 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o184so5764527vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2vKN6djCQsHiDDNdDQAZoPqXDVr1uTSX4rbhVukZV4=;
        b=StcvkEIk5iKzN5OGYcbplBV0OzvB0ZMp2ibijJdGRrErwoJvbHYeK1pKp/UpMPjzIr
         flsBwhMlc++z3LCK/yeVKDvDpro44dHfnkl2omnbhxAgoDG+P6IGd26n9CVSxcE9lfI3
         Dj3jE/cgQiQ8MsNtIQrlN/AYRSXLfZ9JsfZArNvSkObhtKbH7z+0RTuiJ3U8vZwj8DFL
         /0AGq3IaH/elcmhTxdiz5s46xDEiOiXeqFSpTvt6ltk37JWbFGjBQJIfCnOFipDyYzcu
         Tii8pcKUivwccp9vT96k74ltNumDEYTP6Ci0sLhtPwFwygkUYmWu1X7fGmrFHkCpWlmV
         fkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2vKN6djCQsHiDDNdDQAZoPqXDVr1uTSX4rbhVukZV4=;
        b=DPTcSrnKv8Ak2cjMbaTOcRDkXbM125IzlNhrTwIz5LmZrFC4IjKxXpL2G3n433GFxc
         veX839sZXMxiMWabph4JkD5FLAI7DQLN+bnQV3c6m2ufMiDjhpXoxcd9GEVF2gc3Ixad
         hHW+86DNUqDiNvTRFsMGTaz+IvDjut2BsuD2BHfRKb88HQauSYTt1ajgeRIukqvYBBrB
         Kq+Z2F8WWrMemGGDOsEc1Whs4ayDQG/seeGWzmzrmcLz0LvwHHhzdijDydiiPU3HxMck
         /jyx+4wZiCd5qV5zMKC3FuFE4r3htejv820fK8D2CfjBHUa4h0sxxwTq5/JCm3CvkuB8
         846Q==
X-Gm-Message-State: AOAM531mR8cld0AZI9hKUNKwXhG+V+vVYEs0tNh5BAAMPecx0YnZr9kc
        Oi887upcNFQYEF9r/fYciXStRsxs
X-Google-Smtp-Source: ABdhPJyXkbaLKSFzFjFcOyXXlJNUjYDaOZZQJ8/II/7D97FBxr+JxrrZN/sY/PKZ00kCAgM5TGoTiw==
X-Received: by 2002:a67:8750:: with SMTP id j77mr22962416vsd.5.1597143041070;
        Tue, 11 Aug 2020 03:50:41 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id h139sm6315251vke.2.2020.08.11.03.50.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 03:50:39 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id k25so347646vsm.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:50:39 -0700 (PDT)
X-Received: by 2002:a67:fdc4:: with SMTP id l4mr23523503vsq.51.1597143038561;
 Tue, 11 Aug 2020 03:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200809023548.684217-1-xie.he.0141@gmail.com>
 <CA+FuTSe-FaQFn4WNvVPJ1v+jVZAghgd1AZc-cWn2+GjPR4GzVQ@mail.gmail.com>
 <CAJht_EOao3-kA-W-SdJqKRiFMAFUxw7OARFGY5DL8pXvKd4TLw@mail.gmail.com>
 <CA+FuTSc7c+XTDU10Bh1ZviQomHgiTjiUvOO0iR1X95rq61Snrg@mail.gmail.com> <CAJht_EORX2intix=HxS+U+O1hiuSb25=GWi5ONHtFdEF_BS_Ng@mail.gmail.com>
In-Reply-To: <CAJht_EORX2intix=HxS+U+O1hiuSb25=GWi5ONHtFdEF_BS_Ng@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 11 Aug 2020 12:50:01 +0200
X-Gmail-Original-Message-ID: <CA+FuTSfS1XX9ag6npPM95Tiu_hhuan+Foxe1B+_66M-cf+26UA@mail.gmail.com>
Message-ID: <CA+FuTSfS1XX9ag6npPM95Tiu_hhuan+Foxe1B+_66M-cf+26UA@mail.gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a
 skb->len check
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Martin Schiller <ms@dev.tdt.de>, andrew.hendry@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 2) The code quality of this driver is actually very low, and I also
> > > hope to improve it gradually. Actually this driver had been completely
> > > broken for many years and no one had noticed this until I fixed it in
> > > commit 8fdcabeac398 (drivers/net/wan/x25_asy: Fix to make it work)
> > > last month.
> >
> > Just curious: how come that netif_rx could be removed?
>
> When receiving data, the driver should only submit skb to upper layers
> after it has been processed by the lapb module, i.e., it should only
> call netif_rx in the function x25_asy_data_indication. The removed
> netif_rx is in the function x25_asy_bump. This function is responsible
> for passing the skb to the lapb module to process. It doesn't make
> sense to call netif_rx here. If we call netif_rx here, we may pass
> control frames that shouldn't be passed to upper layers (and have been
> consumed and freed by the lapb module) to upper layers.

Ah of course. Thanks for explaining.

> > One thing to keep in mind is that AF_PACKET sockets are not the normal
> > datapath. AF_X25 sockets are. But you mention that you also exercise
> > the upper layer? That gives confidence that these changes are not
> > accidentally introducing regressions for the default path while fixing
> > oddly crafted packets with (root only for a reason) packet sockets.
>
> Yes, I test with AF_X25 sockets too to make sure the changes are OK.
> I usually test AF_X25 sockets with:
> https://github.com/hyanggi/testing_linux/blob/master/network_x25/x25/server.c
> https://github.com/hyanggi/testing_linux/blob/master/network_x25/x25/client.c

Excellent. Thanks for the link. Good to know that these changes are
getting real code coverage.

> I became interested in X.25 when I was trying different address
> families that Linux supported. I tried AF_X25 sockets. And then I
> tried to use the X.25 link layer directly through AF_PACKET. I believe
> both AF_X25 sockets and AF_PACKET sockets need to work without
> problems with X.25 drivers - lapbether and x25_asy. There is another
> X.25 driver (hdlc_x25) in the kernel. I haven't been able to run that
> driver. But that driver seems to be the real driver which is really
> used, and I know Martin Schiller <ms@dev.tdt.de> is an active user and
> developer of that driver.

Great, sounds like we might have additional LAPB and X25 maintainers soon? :)

MAINTAINERS lists Andrew Hendry as maintainer for X.25. Please do CC them.
