Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9CEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC1520708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="r4XZYIJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgETRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:35:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB70C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:35:06 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a14so4026371ilk.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ITvG/zOOXAkl5Gwlwf12ijELNdjsFlvzWOtL11Uq48M=;
        b=r4XZYIJVgKoei2Gux63mqAaVfJyYbFVpk7+WfoKNGZEK7msflp9xnnuGWZkdl9idTB
         wU1ROaXW/G4vVezm+AnkdB67DZbVk4/cUAA1LG5mSqPL1TuHAypRgE9Z9AErIEnAQz1l
         XS3b2gHRiljslqyb44zViB5r2tpem/ToZ6iJbBnG/uydzlZTX1TqigZ1f/EJqUh/sFWs
         +/9EORWetlCfOTu1AvSOjU/s65kIio4GgNaDMzB5PAt/yHMsPgtKs5IpR420tRvPuPLB
         DcSm1YWqLOydirxP2zH2Tm3h4pf5gsFlJpJ4F4t55MXzy9LKmHdcitC/DPP/pTMV24Gb
         v9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ITvG/zOOXAkl5Gwlwf12ijELNdjsFlvzWOtL11Uq48M=;
        b=cR0Q1wDxBr7rIRnlP2ZgU2a+WL0fSqS9LbhA9sBf4P7jkpQcWHXGQ9xjMR4io51LE4
         iOzJozofSdkUriNaydMPnMdRLGzPZKu28u8B51we+0PQKZvXZtx2QWJU425HmAdY3nVu
         Z5obezca3PZivQkpOOGu4g+czj0fWWA54SwSGsi9QcU5LXpC4PgI29jw1RfJLNAHGtQV
         Ho2kF9SFdNd26J3CFSyoCUfhZ0bGDEhQHRedq8S307C2PDJOvkw1SKmi914YQ0XOL/vc
         CYipxfY6Iu/1+j868vFSB0usc1oIizw8k8Xwu+hitqKzSsSz1WXuzY/6KQHqX9CK07mP
         q73g==
X-Gm-Message-State: AOAM530pEMAhRhbSYdNQydQGOHX/pL57ZXKJcbI7wNfcDTc4BxOu8d7u
        zZJWTLjDdUDZ5rj/iQsBr65qorHrZJVnjHqAtUCeXQ==
X-Google-Smtp-Source: ABdhPJzqOdlVwdZMX32DJQaIXzX81Kay98uYeBjfWRV2DGyglRl5QU9mAiiZt/VifvLh5oJoQjQyxfBerc2nlUNWOcs=
X-Received: by 2002:a92:8d4d:: with SMTP id s74mr4904339ild.287.1589996105649;
 Wed, 20 May 2020 10:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200520112523.30995-1-brgl@bgdev.pl> <20200520112523.30995-7-brgl@bgdev.pl>
 <CAK8P3a3jhrQ3p1JsqMNMOOnfo9t=rAPWaOAwAdDuFMh7wUtZQw@mail.gmail.com>
In-Reply-To: <CAK8P3a3jhrQ3p1JsqMNMOOnfo9t=rAPWaOAwAdDuFMh7wUtZQw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 20 May 2020 19:34:54 +0200
Message-ID: <CAMRc=MeuQk9rFDFGWK0ijsiM-r296cVz9Rth8hWhW5Aeeti_cA@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] net: ethernet: mtk-eth-mac: new driver
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 20 maj 2020 o 16:37 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a)=
:
>
> On Wed, May 20, 2020 at 1:25 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This adds the driver for the MediaTek Ethernet MAC used on the MT8* SoC
> > family. For now we only support full-duplex.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Looks much better, thanks for addressing my feedback. A few more things
> about this version:
>
> > ---
> >  drivers/net/ethernet/mediatek/Kconfig       |    6 +
> >  drivers/net/ethernet/mediatek/Makefile      |    1 +
> >  drivers/net/ethernet/mediatek/mtk_eth_mac.c | 1668 +++++++++++++++++++
> >  3 files changed, 1675 insertions(+)
> >  create mode 100644 drivers/net/ethernet/mediatek/mtk_eth_mac.c
> >
> > diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethern=
et/mediatek/Kconfig
> > index 5079b8090f16..5c3793076765 100644
> > --- a/drivers/net/ethernet/mediatek/Kconfig
> > +++ b/drivers/net/ethernet/mediatek/Kconfig
> > @@ -14,4 +14,10 @@ config NET_MEDIATEK_SOC
> >           This driver supports the gigabit ethernet MACs in the
> >           MediaTek SoC family.
> >
> > +config NET_MEDIATEK_MAC
> > +       tristate "MediaTek Ethernet MAC support"
> > +       select PHYLIB
> > +       help
> > +         This driver supports the ethernet IP on MediaTek MT85** SoCs.
>
> I just noticed how the naming of NET_MEDIATEK_MAC and NET_MEDIATEK_SOC
> for two different drivers doing the same thing is really confusing.
>
> Maybe someone can come up with a better name, such as one
> based on the soc it first showed up in.
>

This has been discussed under one of the previous submissions.
MediaTek wants to use this IP on future designs as well and it's
already used on multiple SoCs so they want the name to be generic. I
also argued that this is a driver strongly tied to a specific
platform(s) so if someone wants to compile it - they probably know
what they're doing.

That being said: I verified with MediaTek and the name of the IP I can
use is "star" so they proposed "mtk-star-eth". I would personally
maybe go with "mtk-star-mac". How about those two?

> > +       struct mtk_mac_ring_desc *desc =3D &ring->descs[ring->head];
> > +       unsigned int status;
> > +
> > +       status =3D desc->status;
> > +
> > +       ring->skbs[ring->head] =3D desc_data->skb;
> > +       ring->dma_addrs[ring->head] =3D desc_data->dma_addr;
> > +       desc->data_ptr =3D desc_data->dma_addr;
> > +
> > +       status |=3D desc_data->len;
> > +       if (flags)
> > +               status |=3D flags;
> > +       desc->status =3D status;
> > +
> > +       /* Flush previous modifications before ownership change. */
> > +       dma_wmb();
> > +       desc->status &=3D ~MTK_MAC_DESC_BIT_COWN;
>
> You still do the read-modify-write on the word here, which is
> expensive on uncached memory. You have read the value already,
> so better use an assignment rather than &=3D, or (better)
> READ_ONCE() and WRITE_ONCE() to prevent the compiler
> from adding further accesses.
>

Will do.

>
> > +static void mtk_mac_lock(struct mtk_mac_priv *priv)
> > +{
> > +       spin_lock_bh(&priv->lock);
> > +}
> > +
> > +static void mtk_mac_unlock(struct mtk_mac_priv *priv)
> > +{
> > +       spin_unlock_bh(&priv->lock);
> > +}
>
> I think open-coding the locks would make this more readable,
> and let you use spin_lock() instead of spin_lock_bh() in
> those functions that are already in softirq context.
>

Will do.

> > +static void mtk_mac_intr_enable_tx(struct mtk_mac_priv *priv)
> > +{
> > +       regmap_update_bits(priv->regs, MTK_MAC_REG_INT_MASK,
> > +                          MTK_MAC_BIT_INT_STS_TNTC, 0);
> > +}
> > +static void mtk_mac_intr_enable_rx(struct mtk_mac_priv *priv)
> > +{
> > +       regmap_update_bits(priv->regs, MTK_MAC_REG_INT_MASK,
> > +                          MTK_MAC_BIT_INT_STS_FNRC, 0);
> > +}
>
> These imply reading the irq mask register and then writing it again,
> which is much more expensive than just writing it. It's also not
> atomic since the regmap does not use a lock.
>
> I don't think you actually need to enable/disable rx and tx separately,
> but if you do, then writing to the Ack register as I suggested instead
> of updating the mask would let you do this.
>
> > +/* All processing for TX and RX happens in the napi poll callback. */
> > +static irqreturn_t mtk_mac_handle_irq(int irq, void *data)
> > +{
> > +       struct mtk_mac_priv *priv;
> > +       struct net_device *ndev;
> > +       bool need_napi =3D false;
> > +       unsigned int status;
> > +
> > +       ndev =3D data;
> > +       priv =3D netdev_priv(ndev);
> > +
> > +       if (netif_running(ndev)) {
> > +               status =3D mtk_mac_intr_read(priv);
> > +
> > +               if (status & MTK_MAC_BIT_INT_STS_TNTC) {
> > +                       mtk_mac_intr_disable_tx(priv);
> > +                       need_napi =3D true;
> > +               }
> > +
> > +               if (status & MTK_MAC_BIT_INT_STS_FNRC) {
> > +                       mtk_mac_intr_disable_rx(priv);
> > +                       need_napi =3D true;
> > +               }
>
> I think you mixed up the rx and tx bits here: when you get
> an rx interrupt, that one is already blocked until it gets
> acked and you just need to disable tx until the end of the
> poll function.
>
> However, I suspect that the overhead of turning them off
> is higher than what  you can save, and simply ignoring
> the mask with
>
> if (status & (MTK_MAC_BIT_INT_STS_FNRC | MTK_MAC_BIT_INT_STS_TNTC))
>         napi_schedule(&priv->napi);
>
> would be simpler and faster.
>
>  +               /* One of the counters reached 0x8000000 - update stats =
and
> > +                * reset all counters.
> > +                */
> > +               if (unlikely(status & MTK_MAC_REG_INT_STS_MIB_CNT_TH)) =
{
> > +                       mtk_mac_intr_disable_stats(priv);
> > +                       schedule_work(&priv->stats_work);
> > +               }
> > + befor
> > +               mtk_mac_intr_ack_all(priv);
>
> The ack here needs to be dropped, otherwise you can get further
> interrupts before the bottom half has had a chance to run.
>

My thinking was this: if I mask the relevant interrupt (TX/RX
complete) and ack it right away, the status bit will be asserted on
the next packet received/sent but the process won't get interrupted
and when I unmask it, it will fire right away and I won't have to
recheck the status register. I noticed that if I ack it at the end of
napi poll callback, I end up missing certain TX complete interrupts
and end up seeing a lot of retransmissions even if I reread the status
register. I'm not yet sure where this race happens.

> You might be lucky because you had already disabled the individual
> bits earlier, but I don't think that was intentional here.
>
> > +static int mtk_mac_netdev_start_xmit(struct sk_buff *skb,
> > +                                    struct net_device *ndev)
> > +{
> > +       struct mtk_mac_priv *priv =3D netdev_priv(ndev);
> > +       struct mtk_mac_ring *ring =3D &priv->tx_ring;
> > +       struct device *dev =3D mtk_mac_get_dev(priv);
> > +       struct mtk_mac_ring_desc_data desc_data;
> > +
> > +       desc_data.dma_addr =3D mtk_mac_dma_map_tx(priv, skb);
> > +       if (dma_mapping_error(dev, desc_data.dma_addr))
> > +               goto err_drop_packet;
> > +
> > +       desc_data.skb =3D skb;
> > +       desc_data.len =3D skb->len;
> > +
> > +       mtk_mac_lock(priv);
> > +
> > +       mtk_mac_ring_push_head_tx(ring, &desc_data);
> > +
> > +       netdev_sent_queue(ndev, skb->len);
> > +
> > +       if (mtk_mac_ring_full(ring))
> > +               netif_stop_queue(ndev);
> > +
> > +       mtk_mac_unlock(priv);
> > +
> > +       mtk_mac_dma_resume_tx(priv);
>
> mtk_mac_dma_resume_tx() is an expensive read-modify-write
> on an mmio register, so it would make sense to defer it based
> on netdev_xmit_more(). (I had missed this in the previous
> review)
>

Thanks for bringing it to my attention, I'll see about using it.

> > +static void mtk_mac_tx_complete_all(struct mtk_mac_priv *priv)
> > +{
> > +       struct mtk_mac_ring *ring =3D &priv->tx_ring;
> > +       struct net_device *ndev =3D priv->ndev;
> > +       int ret, pkts_compl, bytes_compl;
> > +       bool wake =3D false;
> > +
> > +       mtk_mac_lock(priv);
> > +
> > +       for (pkts_compl =3D 0, bytes_compl =3D 0;;
> > +            pkts_compl++, bytes_compl +=3D ret, wake =3D true) {
> > +               if (!mtk_mac_ring_descs_available(ring))
> > +                       break;
> > +
> > +               ret =3D mtk_mac_tx_complete_one(priv);
> > +               if (ret < 0)
> > +                       break;
> > +       }
> > +
> > +       netdev_completed_queue(ndev, pkts_compl, bytes_compl);
> > +
> > +       if (wake && netif_queue_stopped(ndev))
> > +               netif_wake_queue(ndev);
> > +
> > +       mtk_mac_intr_enable_tx(priv);
>
> No need to ack the interrupt here if napi is still active. Just
> ack both rx and tx when calling napi_complete().
>
> Some drivers actually use the napi budget for both rx and tx:
> if you have more than 'budget' completed tx frames, return
> early from this function and skip the napi_complete even
> when less than 'budget' rx frames have arrived.
>

IIRC Jakub said that the most seen approach is to free all TX descs
and receive up to budget packets, so this is what I did. I think it
makes the most sense.

Best regards,
Bartosz

> This way you get more fairness between devices and
> can run for longer with irqs disabled as long as either rx
> or tx is busy.
>
>          Arnd
