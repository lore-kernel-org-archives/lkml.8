Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF9C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE9E207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="B9521p8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgEGRB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727978AbgEGRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:01:55 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37195C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:01:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o10so5389942qtr.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AogGO7KQ2cbQNwYsj968bylJ7TQTugwVFwFQ369LPww=;
        b=B9521p8GGVcZpv1qM6GfYzouKvPp4grKwjYFaXKUDPG4zfEuTqq3geopKa9AL0tOb+
         5Mxtar2ygaAjvMyZDIRb0W9xvnacTchxTSMHI1tZPA2PbNDtQCUh8e9BQackKUrAvFvD
         K/r3KBj6JEFLxpFwhYYzgnUafXu+gr4v+lpgKsj9w51U75EBYUNEN5AEE+mpiXIoVLfX
         YUCLKWuxDU6umtMxIF3sS2wwRZWavK4GF7RBR78va/EV/Trd0n92xXmWZM15cG1YUCPE
         447hhPafKpmEgEnBqlAtJlVO7nr1VcdIbXbeVCxKhZwsqhFlAFqrzadqLRKUS34zqkYz
         Sbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AogGO7KQ2cbQNwYsj968bylJ7TQTugwVFwFQ369LPww=;
        b=X5QitP8Uuma9AJaJRNPGjUfdkxO1RZ24iuPL6j9pCyk5RsVfwHda4I7pS0pkrkM4hS
         MiORGTziTrUQcDH1/HRk7FlopbQW9e1UB8zOqNa9bI6C95oj5SdEIRDxk9rXDwf3D7I5
         T5K51KMVVQtUCZPc0FdkuF5HiTiUoiF1PFu9fBGSM7TJTpMK5E12SbczgA7Q6+s8J2FK
         3U6BTkbI56FseifD1lhyMV5Wt8RDkeQbFPwdY2QSFFr6lEQjpT5Jr1nJM46iKBoL1Dc2
         256ZNSdcys770NbiRWDsuMUlPqqN0T/P9f3KKd4CdO25KUVj3/TxrYRgTD/E7aWtxHWX
         aEzw==
X-Gm-Message-State: AGi0PubR3+bVfTY2DkCgQ7FBUECQ3rsi9eBD8T43rw1KaHavb3C76OaX
        nUnqG8FERXsAwLV3ucT8niXoSi2DpoESdqYaKEqyvQ==
X-Google-Smtp-Source: APiQypIICB3A2kzpJhwMTKVrN3+4Xn62nAmH23vrPICDvrpFzW7p9tV7KhQx84nSLJLOK2UmDVQW8wd1hjqshOZqSn0=
X-Received: by 2002:ac8:568b:: with SMTP id h11mr15009985qta.197.1588870913354;
 Thu, 07 May 2020 10:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200505140231.16600-1-brgl@bgdev.pl> <20200505140231.16600-7-brgl@bgdev.pl>
 <1588844771.5921.27.camel@mtksdccf07> <CAMpxmJW4qZ_Wnp_oRa=j=YnvTzVa3HZ13Hgwy71jS6L3Bd3oMQ@mail.gmail.com>
 <20200507131645.GM208718@lunn.ch>
In-Reply-To: <20200507131645.GM208718@lunn.ch>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 7 May 2020 19:01:42 +0200
Message-ID: <CAMpxmJV7xGhE4DoZAEYg=wjE-a1MEnc7carZ39zdvWtKAp+qfA@mail.gmail.com>
Subject: Re: [PATCH 06/11] net: ethernet: mtk-eth-mac: new driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Mark-MC.Lee" <Mark-MC.Lee@mediatek.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Felix Fietkau <nbd@openwrt.org>, Arnd Bergmann <arnd@arndb.de>,
        netdev <netdev@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sean Wang <sean.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 7 maj 2020 o 15:16 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Thu, May 07, 2020 at 12:50:15PM +0200, Bartosz Golaszewski wrote:
> > czw., 7 maj 2020 o 11:46 Mark-MC.Lee <Mark-MC.Lee@mediatek.com> napisa=
=C5=82(a):
> > >
> > > Hi Bartosz:
> > >  I think the naming of this driver and its Kconfig option is too gene=
ric
> > > that will confuse with current mediatek SoCs eth driver architecture(=
for
> > > all mt7xxx SoCs).
> > >   Since mtk_eth_mac.c is not a common MAC part for all mediatek SoC b=
ut
> > > only a specific eth driver for mt85xx, it will be more reasonable to
> > > name it as mt85xx_eth.c and change NET_MEDIATEK_MAC to
> > > NET_MEDIATEK_MT85XX. How do you think?
> > >
> >
> > Hi Mark,
> >
> > I actually consulted this with MediaTek and the name is their idea.
> > Many drivers in drivers/net/ethernet have very vague names. I guess
> > this isn't a problem.
>
> They have vague names, but they tend to be not confusing.
>
> NET_MEDIATEK_MAC vs NET_MEDIATEK_SOC is confusing.
>
> I think the proposed name, mt85xx_eth.c and NET_MEDIATEK_MT85XX is
> good. Or some variant on this, mt8xxx?
>

I've just verified with MediaTek that this IP will be used in future
designs as well - even on ones that don't share the mt8* prefix. It
doesn't really have a name though by itself. How much confusion can it
cause anyway? People who want to compile this driver will know which
one to choose, right? It's not like it's an i2c component shared
across many board designs.

Bart
