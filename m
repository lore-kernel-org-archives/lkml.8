Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC6EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC5F20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hhpHlRaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEONPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:15:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33974 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEONPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iWit2H79Tb0qaINFisbPojdkHSI5mJJzBhDaFk5Qr7E=; b=hhpHlRaYRjua1uzCeXxgDoEOCt
        lAV6E7I5b1M2C99iceVmPVZFIdm65z6dBzz+K5ZS0+rYbhvUQzuCN4x3V6Cwe5qMIXraMRRfRqBf4
        Iof8oT26KglqmqYzlByG4bgcwab347Pa/whj1QTLL/FUnXVS2KAEddTscechzQ91hxpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jZaB1-002NcN-Fb; Fri, 15 May 2020 15:14:59 +0200
Date:   Fri, 15 May 2020 15:14:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Edwin Peer <edwin.peer@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Networking <netdev@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 10/15] net: ethernet: mtk-eth-mac: new driver
Message-ID: <20200515131459.GQ527401@lunn.ch>
References: <20200514075942.10136-1-brgl@bgdev.pl>
 <20200514075942.10136-11-brgl@bgdev.pl>
 <CAK8P3a3=xgbvqrSpCK5h96eRH32AA7xnoK2ossvT0-cLFLzmXA@mail.gmail.com>
 <CAMRc=MeypzZBHo6dJGKm4JujYyejqHxtdo7Ts95DXuL0VuMYCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeypzZBHo6dJGKm4JujYyejqHxtdo7Ts95DXuL0VuMYCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:11:14AM +0200, Bartosz Golaszewski wrote:
> czw., 14 maj 2020 o 18:19 Arnd Bergmann <arnd@arndb.de> napisał(a):
> >
> > On Thu, May 14, 2020 at 10:00 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > This adds the driver for the MediaTek Ethernet MAC used on the MT8* SoC
> > > family. For now we only support full-duplex.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Looks very nice overall. Just a few things I noticed, and some ideas
> > that may or may not make sense:
> >
> > > +/* This is defined to 0 on arm64 in arch/arm64/include/asm/processor.h but
> > > + * this IP doesn't work without this alignment being equal to 2.
> > > + */
> > > +#ifdef NET_IP_ALIGN
> > > +#undef NET_IP_ALIGN
> > > +#endif
> > > +#define NET_IP_ALIGN                           2
> >
> > Maybe you should just define your own macro instead of replacing
> > the normal one then?
> >
> 
> I did in an earlier version and was told to use NET_IP_ALIGN but then
> found out its value on arm64 doesn't work for me so I did the thing
> that won't make anybody happy - redefine the existing constant. :)

Hi Bartosz

I did not realise ARM64 set it to 0. As Arnd suggested, please define
your own macro.

    Andrew
