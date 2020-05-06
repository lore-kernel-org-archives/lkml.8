Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89FC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B3120CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgEFTYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:24:38 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:52916 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728770AbgEFTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:24:38 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id E692F18289F65;
        Wed,  6 May 2020 19:24:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D560118221882;
        Wed,  6 May 2020 19:24:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: group10_aa59a2ed6d34
X-Filterd-Recvd-Size: 3211
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 May 2020 19:24:33 +0000 (UTC)
Message-ID: <fd17302d94f6e2242d041268989e94a04df159de.camel@perches.com>
Subject: Re: [PATCH 06/11] net: ethernet: mtk-eth-mac: new driver
From:   Joe Perches <joe@perches.com>
To:     Leon Romanovsky <leon@leon.nu>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-netdev <netdev@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 06 May 2020 12:24:31 -0700
In-Reply-To: <CALq1K=Lu0hv9UCgxgrwCVoOe9L7A4sgBEM=RW2d9JkizHmdBPQ@mail.gmail.com>
References: <20200505140231.16600-1-brgl@bgdev.pl>
         <20200505140231.16600-7-brgl@bgdev.pl>
         <CALq1K=Lu0hv9UCgxgrwCVoOe9L7A4sgBEM=RW2d9JkizHmdBPQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-06 at 22:16 +0300, Leon Romanovsky wrote:
> On Tue, May 5, 2020 at 5:03 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > This adds the driver for the MediaTek Ethernet MAC used on the MT8* SoC
> > family. For now we only support full-duplex.
[]
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_mac.c b/drivers/net/ethernet/mediatek/mtk_eth_mac.c
[]
> > +struct mtk_mac_priv {
> > +       struct regmap *regs;
> > +       struct regmap *pericfg;
> > +
> > +       struct clk_bulk_data clks[MTK_MAC_NCLKS];
> > +
> > +       void *ring_base;
> > +       struct mtk_mac_ring_desc *descs_base;
> > +       dma_addr_t dma_addr;
> > +       struct mtk_mac_ring tx_ring;
> > +       struct mtk_mac_ring rx_ring;
> > +       struct work_struct tx_work;
> > +
> > +       struct mii_bus *mii;
> > +       struct napi_struct napi;
> > +
> > +       struct device_node *phy_node;
> > +       phy_interface_t phy_intf;
> > +       struct phy_device *phydev;
> > +       unsigned int link;
> > +       int speed;
> > +       int duplex;
> > +
> > +       /* Protects against concurrent descriptor access. */
> > +       spinlock_t lock;
> > +       unsigned long lock_flags;
> > +
> > +       struct rtnl_link_stats64 stats;
> > +};
> > +
> > +static struct net_device *mtk_mac_get_netdev(struct mtk_mac_priv *priv)
> > +{
> > +       char *ptr = (char *)priv;
> > +
> > +       return (struct net_device *)(ptr - ALIGN(sizeof(struct net_device),
> > +                                                NETDEV_ALIGN));
> > +}

This code looks ugly/fragile.
Why not store the struct net_device * in struct mtk_mac_priv ?


