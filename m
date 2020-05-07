Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA553C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AA2207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1lm1uYG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEGKu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgEGKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:50:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D30C061A41
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 03:50:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so11939qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1TQDLXk4eka+0Oxp2Bn8b1wcydmS2119xNQQ8v9Of3A=;
        b=1lm1uYG4FqWg47V6Y+gYDIshBO9zX4KSYru04NwBJPv6kFFVFfM5JuAxDs6tZvphbJ
         oTJilxGIAeSQOYU0i6u9kVh9LY2c67xWbyrpnSBiPqECpZSiW2moygN7fZbQTfav8QK2
         PVhyXc4CtEJIGCrd0bzJhiTefp0mzyZ+EbOyJMUDZqyQufbiHgLItmYN1hQD9wMB44pb
         +U7sR5l34T2+ELpQdAtOqjowgdxN4GWWNkcVU6+j6hZhi4t6FdtitjmBcfH4EYiq0eXp
         4P1xej1eG3C2yyeUwdIE9QTRIDhAZrZ/5hXNsRThBODI7DVg3bGoIKHJESig7V88bGr5
         VM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1TQDLXk4eka+0Oxp2Bn8b1wcydmS2119xNQQ8v9Of3A=;
        b=mQVvPqJmiB9WquFeHP+SAA7raH63XLr02DxZ5i8K8nXwitRNLmTpmf3fZkO5mXA6Sk
         qo+Z43DXXxtrHZjkTUM6HGObzQH1f1AdSTRKw/uSWBXKF99tWY9e4lI3R9GdhxMmj4D8
         T7jpFF+2zazWsWtM7g794vT5sH5lzgebxHftTX9Qv4vsQj6nOdbEpskmp42D7ORL2Aep
         0apWqYqnr991sal8Imo1FGspkQPNJt3VvDg9X7KCHG/ljvBCm/wRYAv9nNQeOvvVHbIX
         ElGyQqbC38mIOdYymRBkgoWGcAo60URt9K25tDUfUZ3d2R+bh6ncX72u2A+n2q+HHOsw
         +G2g==
X-Gm-Message-State: AGi0PubJumsb1SZDjpQVePpxIJeLkasQa8P+29VQqcB4HHjYEphJxa7T
        mZ9vJ24O6p9+RNUVEvCXV9Y+Mu/d/lIJ6SLtsPem2g==
X-Google-Smtp-Source: APiQypJYXCCd2c3pYbt+kfphPDDGvjl+YT7aIrmnou1JUBqsathcHJRlRjCQ8fMwJjvYV4gCZxU1KJCPXjpaGZcnQi0=
X-Received: by 2002:a05:620a:1f1:: with SMTP id x17mr13989074qkn.330.1588848626441;
 Thu, 07 May 2020 03:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200505140231.16600-1-brgl@bgdev.pl> <20200505140231.16600-7-brgl@bgdev.pl>
 <1588844771.5921.27.camel@mtksdccf07>
In-Reply-To: <1588844771.5921.27.camel@mtksdccf07>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 7 May 2020 12:50:15 +0200
Message-ID: <CAMpxmJW4qZ_Wnp_oRa=j=YnvTzVa3HZ13Hgwy71jS6L3Bd3oMQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] net: ethernet: mtk-eth-mac: new driver
To:     "Mark-MC.Lee" <Mark-MC.Lee@mediatek.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 7 maj 2020 o 11:46 Mark-MC.Lee <Mark-MC.Lee@mediatek.com> napisa=C5=
=82(a):
>
> Hi Bartosz:
>  I think the naming of this driver and its Kconfig option is too generic
> that will confuse with current mediatek SoCs eth driver architecture(for
> all mt7xxx SoCs).
>   Since mtk_eth_mac.c is not a common MAC part for all mediatek SoC but
> only a specific eth driver for mt85xx, it will be more reasonable to
> name it as mt85xx_eth.c and change NET_MEDIATEK_MAC to
> NET_MEDIATEK_MT85XX. How do you think?
>

Hi Mark,

I actually consulted this with MediaTek and the name is their idea.
Many drivers in drivers/net/ethernet have very vague names. I guess
this isn't a problem.

Bart
