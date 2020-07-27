Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B50C43457
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0582073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbgG0QQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:16:43 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42585 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731292AbgG0QQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:16:36 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AE5ADFF806;
        Mon, 27 Jul 2020 16:16:32 +0000 (UTC)
Date:   Mon, 27 Jul 2020 18:16:32 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jon Nettleton <jon@solid-run.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>,
        Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>,
        a.zummo@towertech.it, Baruch Siach <baruch@tkos.co.il>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200727161632.GF239143@piout.net>
References: <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus>
 <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk>
 <20200727144938.GC239143@piout.net>
 <20200727152439.GK1551@shell.armlinux.org.uk>
 <20200727154104.GE239143@piout.net>
 <20200727154335.GL1551@shell.armlinux.org.uk>
 <CABdtJHuVaTa5T0-KdQ-wZQrmFQ6HO3FvgnTgSo3aOi+=SPzDZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdtJHuVaTa5T0-KdQ-wZQrmFQ6HO3FvgnTgSo3aOi+=SPzDZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2020 17:55:50+0200, Jon Nettleton wrote:
> > So, can we please have that discussion, it is pertinent to this patch.
> >
> 
> Thinking about this some more, I believe whether or not an IOCTL
> interface is in the works or needed is irrelevant.  This patch
> describes the hardware and how it is designed and the topic of
> discussion is if we need a simple boolean state, or if we need
> something that could be used to support dynamic configuration in the
> future.  I would rather make this decision now rather than keep
> tacking on boolean config options, or revisit a bunch of device-tree
> changes.

Something that would describe the hardware is a property telling whether
the filter is present on VDD, not a property selecting DSM. The driver
can then chose to avoid standard mode when needed.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
