Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78C2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E95220759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vQpa/V/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEOM40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgEOM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:56:22 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC9C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:56:20 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c20so242241ilk.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UKroOh2PouJyW9aIDGfDz6KjqY9gVQj12EPFSDublmA=;
        b=vQpa/V/2d27tMcZAv7Abd34xjhVsIEeZzrDrtJyVTfhsRI5XbTGjwCIO/aERLAuHrZ
         /IDDIp2Nyi2dbSZdL6+Ei9b5G3ZMuxLX9s5g4bydz+1ckRRkhVPa7wy6pmUCguarxPbh
         epoFYuHCZKmDhp6ZKwj5KTTRyS1Q0tbs+LrdiSIOPYHBYzINIkvLAHCEr5lqIFc76ZZb
         5e0do7Y2NA3anxjjEQ+kcNYGtmyW38wVsVqiIBJnGEzJucPGI8FbisgPd1XdjqPAcXQE
         VqOmfZPXnTlhqnPmebHsDCU0B2A3gx3qh3moPnlcGFqdaG/G3Psf36RCkMHMJmKYMYoU
         xLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UKroOh2PouJyW9aIDGfDz6KjqY9gVQj12EPFSDublmA=;
        b=Bkq+AoO5DXqiA3ygQ7MInolIADH/crpujhNGiLzMOYOAIJRc3axXp+mt2eeZ1MQ5Xn
         2ZKR23h8iu7MJbi7GxAvawSFmCphq9PAt+BhgQ2PqCBkEM3Epd3KxD+3oqnBGzUE7m1J
         PdfTRr2NoI8cd+cAZNZUcWmtTyKiCB3GIz8jHzxIKOhO/ZlD55/ALcWHdAVRbvvGb7MX
         JXmTYdj4lKnFOh3h5RwbuqMB33mTQlWKyUOjdMtGXXIx5ZSgIeb6jJU0kVWMScex4o4B
         nzT2LVVh5+yO5ssOSClIbZZQGRGMESToYC9tMqsigMuhGQ7noNFuy0u0I3qd+oTvxiv1
         32oA==
X-Gm-Message-State: AOAM530XBLhNEWW5V6heRE5nMAfnmEn2tLnvXP6+ZG6Yya3Be9F8+iqn
        cKz0JMI9a6U4jS+DdEJmoMAd+WDK7eYZ1pGCMfV6Rw==
X-Google-Smtp-Source: ABdhPJwxlPUfGtzfy33AVJzkSkvw1FkcvOCUrRT614H0OzqvY7RE2DoHu5yieo8v50b5ATxQYMVDFbWOcCKbmYEaOxE=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr3394310ili.40.1589547379907;
 Fri, 15 May 2020 05:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200514075942.10136-1-brgl@bgdev.pl> <20200514075942.10136-11-brgl@bgdev.pl>
 <CAK8P3a3=xgbvqrSpCK5h96eRH32AA7xnoK2ossvT0-cLFLzmXA@mail.gmail.com>
 <CAMRc=MeypzZBHo6dJGKm4JujYyejqHxtdo7Ts95DXuL0VuMYCw@mail.gmail.com> <CAK8P3a0u53rHSW=72CnnbhrY28Z+9f=Yv2K-bbj5OD+2Ds4unA@mail.gmail.com>
In-Reply-To: <CAK8P3a0u53rHSW=72CnnbhrY28Z+9f=Yv2K-bbj5OD+2Ds4unA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 15 May 2020 14:56:09 +0200
Message-ID: <CAMRc=Mf_vYt1J-cc6aZ2-Qv_YDEymVoC7ZiwuG9BrXoGMsXepw@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] net: ethernet: mtk-eth-mac: new driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 15 maj 2020 o 14:04 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> On Fri, May 15, 2020 at 9:11 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >
> > czw., 14 maj 2020 o 18:19 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a)=
:
> > >
> > > On Thu, May 14, 2020 at 10:00 AM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> > > > +static unsigned int mtk_mac_intr_read_and_clear(struct mtk_mac_pri=
v *priv)
> > > > +{
> > > > +       unsigned int val;
> > > > +
> > > > +       regmap_read(priv->regs, MTK_MAC_REG_INT_STS, &val);
> > > > +       regmap_write(priv->regs, MTK_MAC_REG_INT_STS, val);
> > > > +
> > > > +       return val;
> > > > +}
> > >
> > > Do you actually need to read the register? That is usually a relative=
ly
> > > expensive operation, so if possible try to use clear the bits when
> > > you don't care which bits were set.
> > >
> >
> > I do care, I'm afraid. The returned value is being used in the napi
> > poll callback to see which ring to process.
>
> I suppose the other callers are not performance critical.
>
> For the rx and tx processing, it should be better to just always look at
> the queue directly and ignore the irq status, in particular when you
> are already in polling mode: suppose you receive ten frames at once
> and only process five but clear the irq flag.
>
> When the poll function is called again, you still need to process the
> others, but I would assume that the status tells you that nothing
> new has arrived so you don't process them until the next interrupt.
>
> For the statistics, I assume you do need to look at the irq status,
> but this doesn't have to be done in the poll function. How about
> something like:
>
> - in hardirq context, read the irq status word
> - irq rx or tx irq pending, call napi_schedule
> - if stats irq pending, schedule a work function
> - in napi poll, process both queues until empty or
>   budget exhausted
> - if packet processing completed in poll function
>   ack the irq and check again, call napi_complete
> - in work function, handle stats irq, then ack it
>

I see your point. I'll try to come up with something and send a new
version on Monday.

> > > > +static void mtk_mac_tx_complete_all(struct mtk_mac_priv *priv)
> > > > +{
> > > > +       struct mtk_mac_ring *ring =3D &priv->tx_ring;
> > > > +       struct net_device *ndev =3D priv->ndev;
> > > > +       int ret;
> > > > +
> > > > +       for (;;) {
> > > > +               mtk_mac_lock(priv);
> > > > +
> > > > +               if (!mtk_mac_ring_descs_available(ring)) {
> > > > +                       mtk_mac_unlock(priv);
> > > > +                       break;
> > > > +               }
> > > > +
> > > > +               ret =3D mtk_mac_tx_complete_one(priv);
> > > > +               if (ret) {
> > > > +                       mtk_mac_unlock(priv);
> > > > +                       break;
> > > > +               }
> > > > +
> > > > +               if (netif_queue_stopped(ndev))
> > > > +                       netif_wake_queue(ndev);
> > > > +
> > > > +               mtk_mac_unlock(priv);
> > > > +       }
> > > > +}
> > >
> > > It looks like most of the stuff inside of the loop can be pulled out
> > > and only done once here.
> > >
> >
> > I did that in one of the previous submissions but it was pointed out
> > to me that a parallel TX path may fill up the queue before I wake it.
>
> Right, I see you plugged that hole, however the way you hold the
> spinlock across the expensive DMA management but then give it
> up in each loop iteration feels like this is not the most efficient
> way.
>

Maybe my thinking is wrong here, but I assumed that with a spinlock
it's better to give other threads the chance to run in between each
iteration. I didn't benchmark it though.

> The easy way would be to just hold the lock across the entire
> loop and then be sure you do it right. Alternatively you could
> minimize the locking and only do the wakeup after up do the final
> update to the tail pointer, at which point you know the queue is not
> full because you have just freed up at least one entry.
>

Makes sense, I'll see what I can do.

Bartosz
