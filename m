Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E316AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAA2206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DT6WmVJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEFGqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbgEFGqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:46:21 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1146C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 23:46:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s10so700780iln.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/CvsVsRvsIe2fdwin42oKRwBiHMUNkSBi3zIOYY4k4=;
        b=DT6WmVJOSFGWbwoJzWlGLC1MHvldjbW1aPbGsebQDxlwZe7iwnSNTolfUa76eOd29p
         bY4+DyIu0HM7Ux+b79wpjv1HEfzbH79157RfuHSyksqzSHLknytmZWYPfXFm5QGWRjr4
         trPVXMgze6AHFPvmnwrxjqlJKc728qaSJfARZbGbfhF4give+X0eaTP+oNhRMf+5ac8P
         Arpc631AY/NRljNjuR5I9hcJdirqymusRyVIeUrXArJFWuT3SoexMOmMizUv/8UFF/8J
         GTpCWHc3c1BWYWTjKwX/5uBZaJK6C+gV4m4MOKsh1M5DtywTmEZjpryYodVi30SRoDCo
         EcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/CvsVsRvsIe2fdwin42oKRwBiHMUNkSBi3zIOYY4k4=;
        b=NWBbLW/2B67xdn3iyBS/9E3gHr4GKo/gBf1PA1up3HPP8gPkVcwQV3jxEEDTUhbRpo
         sWwwJi+NviRPzfWaKUZdYgIc15ghkuJ7iCnq51Rx7OB5R6qY2DXu30+fs7ydWmkml8aq
         4+8DDDj7aGBexdaHwljloohzVy1VwVnNPFWiEB22ORAufsldzajNc/TaCYJNPhGYjMlk
         2MrkulOEJC8XVKD5m2blxTOXAdgHXytoTcg+ZtyHe6wLALV5+jsqEkyq1BbiuLzMxl/q
         bS5880avsp5xXLwiWebjSV0tAGmxUEkbRfYgKooQFxCm186VfqzCeeTvZLpxuZaEsTa5
         HCqQ==
X-Gm-Message-State: AGi0PubyZbJnVwsE+77XoDVRAP2Yxxs4C1HvUhpL/3wjfB8vGUvQdY26
        1+yfTsmoKjIcUEkz3GO+Pi92zNh/sAXYi/sS0fU2Cg==
X-Google-Smtp-Source: APiQypKJEgnZebPwGNweIcvVeYvS0XTuBvG2j4m7bwSAxW9ci9eJ/kiRyX1pjwNIRh6SnysmSCqDdQb9gXdF8OxrFFg=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr7777424ili.40.1588747581285;
 Tue, 05 May 2020 23:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505140231.16600-1-brgl@bgdev.pl> <20200505140231.16600-6-brgl@bgdev.pl>
 <CAKOOJTzcNr7mc9xusQm3nCzkq5P=ha-si3fizeEL2_KJUOC3-Q@mail.gmail.com>
In-Reply-To: <CAKOOJTzcNr7mc9xusQm3nCzkq5P=ha-si3fizeEL2_KJUOC3-Q@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 6 May 2020 08:46:10 +0200
Message-ID: <CAMRc=Md7gLMThfGF-7YLqW17MpMhU=UFbdTvfjbr9fFHTLir8g@mail.gmail.com>
Subject: Re: [PATCH 05/11] net: core: provide devm_register_netdev()
To:     Edwin Peer <edwin.peer@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 5 maj 2020 o 21:25 Edwin Peer <edwin.peer@broadcom.com> napisa=C5=82(a=
):
> > +
> > +static void devm_netdev_release(struct device *dev, void *this)
> > +{
> > +       struct netdevice_devres *res =3D this;
> > +
> > +       unregister_netdev(res->ndev);
> > +}
> > +
> > +/**
> > + *     devm_register_netdev - resource managed variant of register_net=
dev()
> > + *     @ndev: device to register
> > + *
> > + *     This is a devres variant of register_netdev() for which the unr=
egister
> > + *     function will be call automatically when the parent device of n=
dev
> > + *     is detached.
> > + */
> > +int devm_register_netdev(struct net_device *ndev)
> > +{
> > +       struct netdevice_devres *dr;
> > +       int ret;
> > +
> > +       /* struct net_device itself must be devres managed. */
> > +       BUG_ON(!(ndev->priv_flags & IFF_IS_DEVRES));
> > +       /* struct net_device must have a parent device - it will be the=
 device
> > +        * managing this resource.
> > +        */
>
> Catching static programming errors seems like an expensive use of the
> last runtime flag in the enum. It would be weird to devres manage the
> unregister and not also choose to manage the underlying memory in the
> same fashion, so it wouldn't be an obvious mistake to make. If it must
> be enforced, one could also iterate over the registered release
> functions and check for the presence of devm_free_netdev without
> burning the flag.
>

Hi Edwin,

I've submitted this patch some time ago already and was told to check
if the underlying memory is managed too. I guess I could try to use
devres_find() here though.

Re the last bit in priv_flags: is this really a problem though? It's
not like struct net_device must remain stable - e.g. we can make
priv_flags a bitmap.

Bart
