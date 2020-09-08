Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A42C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BAC21D46
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCqQqYpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgIHHY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIHHYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:24:54 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDAEC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:24:53 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s62so8442806vsc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyzV6YOAXeUR+Q/NgZCtcCIE7mjN59pwymo2+o5Ygh8=;
        b=kCqQqYpYTq96LUe3GC8UbFrB9vQ9SQUHsr1pasN3RiWCDS0vXR/6+/niUf1k2TU1Fk
         BT09o6x5pb6BMBKjrXfgvd45ZszlQgmHst/EKdZ6hoJn2CQj86xZKlGPUa+Yas3D2Mdc
         gzMPS7yokA/kyuiigMuSizkN9CjW9dnRAPWhqb18EvHzLOt3XD36VPSK8IipI44JtkDA
         v5eKdISXUC1EKgmCgpk0oOUfvqQ3AhuWSL5XzRAyPw6jyPBTQahW7YZDyTfAe9SGAOGX
         /3rQtiJkunQT8/OWtYnPGDRxR044OuQ57jOfSLaYbFXtvuKFgC0otKGh9X2qImS5syMY
         8wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyzV6YOAXeUR+Q/NgZCtcCIE7mjN59pwymo2+o5Ygh8=;
        b=Eub/I3e7Ym4RyHD03g++dO3OG66R2ydo5lSEsLjk+9VuthmlDCPJZqGFZ7Cq1C2Kmm
         uiA3WiF9gaJcjQqVra7gfFY7bVQDeay1vCVT+p/z0odBc1F6MKmPoqyY1rQHwBvigUTN
         4+rXWgZJCbipUAjAtsJK5YP+t08qWpJwDaT8dbbDllHk1OvQGqyXzbIvfNPHzO2h/Szi
         Xxzb5g5jh0MwFHbVVTAeQ4EifhICKkuEj6WvEfehRn23mScpWeTQ4I/Y3uv2IexBKyXW
         pW46EiaqNAB3Oz5dX3dGTKRYKF5hHzddKbLtasFA4/5TbXTA4ddwsraRs8HpxRXSyEKl
         Ojwg==
X-Gm-Message-State: AOAM5307UDvjb8uOBWnA07piJoAJj5aGuSeeo1HAnboT/UVgix4jsT6C
        1aU0KgoKkxoyBJhxAztbJLB2pCMZckwvBQ==
X-Google-Smtp-Source: ABdhPJyIksdiL3Ka992LgRQqbotLLf6rgfTrYGr95L6GP6nrNUdPSBakAfnnF0+Z4i7JTM2UZ6L6ZQ==
X-Received: by 2002:a67:2f0a:: with SMTP id v10mr12815342vsv.6.1599549891662;
        Tue, 08 Sep 2020 00:24:51 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id y13sm907083vsm.15.2020.09.08.00.24.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 00:24:50 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id y194so8470450vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:24:50 -0700 (PDT)
X-Received: by 2002:a05:6102:150:: with SMTP id a16mr12488906vsr.99.1599549889782;
 Tue, 08 Sep 2020 00:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <1599286273-26553-1-git-send-email-tanhuazhong@huawei.com>
 <20200906114153.7dccce5d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+FuTSfeEuTLAGJZkzoMUvx+0j3dY265i8okPLyDO6S-8KHdbQ@mail.gmail.com>
 <126e5424-2453-eef4-d5b6-adeaedbb6eca@huawei.com> <CA+FuTSecsVRsOt7asv7aHGvAXCacHGYwbG1a1X9ynL83dqP8Bw@mail.gmail.com>
 <6cb146b5-8e0d-ed22-a0c1-b54c59685aa5@huawei.com>
In-Reply-To: <6cb146b5-8e0d-ed22-a0c1-b54c59685aa5@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Sep 2020 09:24:13 +0200
X-Gmail-Original-Message-ID: <CA+FuTScH8+psp7+6Wz-rh4FKSkvt62j2-8t1Y2YHkzFZqkf3_w@mail.gmail.com>
Message-ID: <CA+FuTScH8+psp7+6Wz-rh4FKSkvt62j2-8t1Y2YHkzFZqkf3_w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: two updates related to UDP GSO
To:     tanhuazhong <tanhuazhong@huawei.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 4:32 AM tanhuazhong <tanhuazhong@huawei.com> wrote:
>
>
>
> On 2020/9/7 23:35, Willem de Bruijn wrote:
> > On Mon, Sep 7, 2020 at 3:38 PM tanhuazhong <tanhuazhong@huawei.com> wrote:
> >>
> >>
> >>
> >> On 2020/9/7 17:22, Willem de Bruijn wrote:
> >>> On Sun, Sep 6, 2020 at 8:42 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >>>>
> >>>> On Sat, 5 Sep 2020 14:11:11 +0800 Huazhong Tan wrote:
> >>>>> There are two updates relates to UDP GSO.
> >>>>> #1 adds a new GSO type for UDPv6
> >>>>> #2 adds check for UDP GSO when csum is disable in netdev_fix_features().
> >>>>>
> >>>>> Changes since RFC V2:
> >>>>> - modifies the timing of setting UDP GSO type when doing UDP GRO in #1.
> >>>>>
> >>>>> Changes since RFC V1:
> >>>>> - updates NETIF_F_GSO_LAST suggested by Willem de Bruijn.
> >>>>>     and add NETIF_F_GSO_UDPV6_L4 feature for each driver who support UDP GSO in #1.
> >>>>>     - add #2 who needs #1.
> >>>>
> >>>> Please CC people who gave you feedback (Willem).
> >>>>
> >>>> I don't feel good about this series. IPv6 is not optional any more.
> >>>> AFAIU you have some issues with csum support in your device? Can you
> >>>> use .ndo_features_check() to handle this?
> >>>>
> >>>> The change in semantics of NETIF_F_GSO_UDP_L4 from "v4 and v6" to
> >>>> "just v4" can trip people over; this is not a new feature people
> >>>> may be depending on the current semantics.
> >>>>
> >>>> Willem, what are your thoughts on this?
> >>>
> >>> If that is the only reason, +1 on fixing it up in the driver's
> >>> ndo_features_check.
> >>>
> >>
> >> Hi, Willem & Jakub.
> >>
> >> This series mainly fixes the feature dependency between hardware
> >> checksum and UDP GSO.
> >> When turn off hardware checksum offload, run 'ethtool -k [devname]'
> >> we can see TSO is off as well, but udp gso still is on.
> >
> > I see. That does not entirely require separate IPv4 and IPv6 flags. It
> > can be disabled if either checksum offload is disabled. I'm not aware
> > of any hardware that only supports checksum offload for one of the two
> > network protocols.
> >
>
> below patch is acceptable? i have sent this patch before
> (https://patchwork.ozlabs.org/project/netdev/patch/1594180136-15912-3-git-send-email-tanhuazhong@huawei.com/)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c02bae9..dcb6b35 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9095,6 +9095,12 @@ static netdev_features_t
> netdev_fix_features(struct net_device *dev,
>                 features &= ~NETIF_F_TSO6;
>         }
>
> +       if ((features & NETIF_F_GSO_UDP_L4) && !(features & NETIF_F_HW_CSUM) &&
> +           (!(features & NETIF_F_IP_CSUM) || !(features & NETIF_F_IPV6_CSUM))) {
> +               netdev_dbg(dev, "Dropping UDP GSO features since no CSUM feature.\n");
> +               features &= ~NETIF_F_GSO_UDP_L4;
> +       }
> +
>         /* TSO with IPv4 ID mangling requires IPv4 TSO be enabled */
>         if ((features & NETIF_F_TSO_MANGLEID) && !(features & NETIF_F_TSO))
>                 features &= ~NETIF_F_TSO_MANGLEID;
>
> As Eric Dumazet commented "This would prevent a device providing IPv4
> checksum only (no IPv6 csum support) from sending IPv4 UDP GSO packets ?",
> so i send this series to decouple them. Is there any good ways to
> shuttle this issue? Or as you said there is not device only support
> checksum offload for one of the two network protocols.

As he pointed out

> This could be done in an ndo_fix_features(), or ndo_features_check()
>
> Or maybe we do not care, but this should probably be documented.

I am not aware of devices that only checksum one of the protocols (but
haven't searched for a counter-example).

This sounds fine to me, with a comment to that effect, as Eric suggested.

>
> > Alternatively, the real value of splitting the type is in advertising
> > the features separately through ethtool. That requires additional
> > changes.
> >
>
>
> > .
> >
>
