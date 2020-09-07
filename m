Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD4CC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A82E2078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix+SP49a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgIGJXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgIGJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:23:21 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857CC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 02:23:20 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y15so3979961uan.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBjC6LgsXmyRTFlOrXgXx23bviroU6DrK6ZiFWBgik0=;
        b=Ix+SP49aOyHAg/LDL0Qfvoem123dBoUolQTXi7YjAo0uuVk0297CdTiC3zll82eiwX
         OIFk0d2c4pI1jm7uoNB+hwGS3lkU8t7LXUp6g4NOn2lP+TWO8ZA8MyLksvKmEndRpFb0
         G/uPQAgjEp3FLZCxIan72e6ghxZ7gtTcR/E7gbQDdNupo19nZ9Nml1dklJqEMvRmhUnm
         ZIzaYQ+BE1Fejp3GRiEF1iqePsK/WCtnvvWykHLUtCg4WE52KTCMDSEim0hNOIqhrgTl
         S+YIF8ZYPswYhgGPHgM0VYOfnPiGcDLpV5YPbvmiINDTKy+5aqHrG7Xpm2O1jGCzxrdO
         Cubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBjC6LgsXmyRTFlOrXgXx23bviroU6DrK6ZiFWBgik0=;
        b=UFOCC5NeNdukG3Z69kWXNk1egvoj/jluvqZRT2tggZifce3CYqyaCZEuaXnxitrfO9
         ZtWgy1ZR3zOpUNW2wOmrCZYypZ17BVI4UcUneYFAQgjjhtnifUVM2GciQKavvBFRga5E
         IjSV79lo+Wk/h2cA7d/q/GLeFOih8PzKBOeF6+L6bGvSUgU+HMxBniKs414gjph+bMm4
         7q4sO8YVcaOK/vWywMCVIGoRg8vds1tVh/NWCWXdUOAeD7VPRfe8yGnkLLsD4Klj1fwZ
         7PtnrliTtCFhGexgAje00eBVEKGJ5atP6kWRjz6sfB2bsKCBU3torA8EHatdAyHuAf9k
         8VAg==
X-Gm-Message-State: AOAM531TYyoJBQYuelxjZp72e339Z5aU5P00aO1kycfVEsXWzQ+cj54m
        +pCfb8hEHiMZ0OkzYFyaAiNqf4p9zCTz/w==
X-Google-Smtp-Source: ABdhPJympCXlRh7+J3sWe7BIH8oVaW4oyseH3WTG0LKg3ah1OWs7BaPY3N3q4IjFLQnVsKAT8zUv8A==
X-Received: by 2002:ab0:1e84:: with SMTP id o4mr10943217uak.74.1599470594225;
        Mon, 07 Sep 2020 02:23:14 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id f190sm853570vka.1.2020.09.07.02.23.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 02:23:13 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id b123so7024342vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 02:23:12 -0700 (PDT)
X-Received: by 2002:a67:ebc4:: with SMTP id y4mr11763629vso.119.1599470592359;
 Mon, 07 Sep 2020 02:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <1599286273-26553-1-git-send-email-tanhuazhong@huawei.com> <20200906114153.7dccce5d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200906114153.7dccce5d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 7 Sep 2020 11:22:33 +0200
X-Gmail-Original-Message-ID: <CA+FuTSfeEuTLAGJZkzoMUvx+0j3dY265i8okPLyDO6S-8KHdbQ@mail.gmail.com>
Message-ID: <CA+FuTSfeEuTLAGJZkzoMUvx+0j3dY265i8okPLyDO6S-8KHdbQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: two updates related to UDP GSO
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Huazhong Tan <tanhuazhong@huawei.com>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 6, 2020 at 8:42 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 5 Sep 2020 14:11:11 +0800 Huazhong Tan wrote:
> > There are two updates relates to UDP GSO.
> > #1 adds a new GSO type for UDPv6
> > #2 adds check for UDP GSO when csum is disable in netdev_fix_features().
> >
> > Changes since RFC V2:
> > - modifies the timing of setting UDP GSO type when doing UDP GRO in #1.
> >
> > Changes since RFC V1:
> > - updates NETIF_F_GSO_LAST suggested by Willem de Bruijn.
> >   and add NETIF_F_GSO_UDPV6_L4 feature for each driver who support UDP GSO in #1.
> >   - add #2 who needs #1.
>
> Please CC people who gave you feedback (Willem).
>
> I don't feel good about this series. IPv6 is not optional any more.
> AFAIU you have some issues with csum support in your device? Can you
> use .ndo_features_check() to handle this?
>
> The change in semantics of NETIF_F_GSO_UDP_L4 from "v4 and v6" to
> "just v4" can trip people over; this is not a new feature people
> may be depending on the current semantics.
>
> Willem, what are your thoughts on this?

If that is the only reason, +1 on fixing it up in the driver's
ndo_features_check.
