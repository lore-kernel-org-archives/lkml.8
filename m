Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AB9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54A3206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgCMIHd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:07:33 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58289 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCMIHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:07:33 -0400
X-Originating-IP: 90.89.41.158
Received: from localhost (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 14635E0007;
        Fri, 13 Mar 2020 08:07:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200312.154336.1295319497057805539.davem@davemloft.net>
References: <20200312221033.777437-1-antoine.tenart@bootlin.com> <20200312221033.777437-3-antoine.tenart@bootlin.com> <20200312.154336.1295319497057805539.davem@davemloft.net>
Subject: Re: [PATCH net-next v2 2/3] net: phy: mscc: split the driver into separate files
To:     David Miller <davem@davemloft.net>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Antoine Tenart <antoine.tenart@bootlin.com>
Message-ID: <158408684876.668992.7957856749031634535@kwain>
Date:   Fri, 13 Mar 2020 09:07:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Quoting David Miller (2020-03-12 23:43:36)
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Date: Thu, 12 Mar 2020 23:10:32 +0100
> 
> > +inline int vsc8584_macsec_init(struct phy_device *phydev)
> > +{
> > +     return 0;
> > +}
> > +inline void vsc8584_handle_macsec_interrupt(struct phy_device *phydev)
> > +{
> > +}
> > +inline void vsc8584_config_macsec_intr(struct phy_device *phydev)
> > +{
> > +}
> 
> Please use "static inline", as otherwise if this file is included multiple times it
> will cause the compiler to emit potentially two uninlined copies which will result
> in a linking error.

Will do.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
