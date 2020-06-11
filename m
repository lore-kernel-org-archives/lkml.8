Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BD3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3082053B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="LDLIbuQx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u293WYbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgFKQws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:52:48 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54833 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbgFKQwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:52:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 039A258020E;
        Thu, 11 Jun 2020 12:52:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 12:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=g
        F0btmld4U26k5IsFwX2l44MfY0Gg3/saFgkLyH4blE=; b=LDLIbuQxI36aNk5ga
        ggJ7wdX9TM3II8gptiBPX+McLxBtUVosZzwYVq8kPs0Hi/trZJFyMRbHEVChTNiR
        daUcnRePipy7Q4ESJhkDNtAiz0wMUeWo2pHPuaSthP26W3tt/eaFjdvt3ZWY8FBl
        Ugh4Ko2+Azl7gV2x9a8LRjYysMeSikKFpJGESQp1yVSfNjef/9PDq+XMSGX8mz/l
        xNl63aMV1gevwytHYVTRUmEeRf8GOV8cAZZd/W6fJc9PVZJpUj6+Jr5ve/CJbZtR
        hpu0fAie5o6HXGXyUNS6WaPQByhpSgaXGyZ7MaJcLg27S2R81r6jlmESFh/CCXCN
        n320A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=gF0btmld4U26k5IsFwX2l44MfY0Gg3/saFgkLyH4b
        lE=; b=u293WYbh5c64oJUtk1LeO+ED1Pe7Xl/BQoVYeuU+7y2yGw+R4goF3Xrqo
        HtACc02exwfB4ydHwPiDTmFQBZho7CFe37VZYGtZPpqhRsD0ZL7uwR+6AXAl0max
        tvgxaIRYazyf0Pad5aH0NxqOWHAxdmv0v58Fy70l38NCQNKbhVAZUu0CRTAi9Pt7
        0lABEHfykR5p/jrCZfKfb+P6yo0s8muMwokSft+QL4TmAdGFYqBpENPOUzxS6qE6
        PCuRMVxFTY3r8jXWPS0Pey5qLN4vY15OqJzLC1MPfv4UJWCvHRDd+k5rLzDsheWV
        IwO2YcHH3IAI2Iao2odyjTAArHuEg==
X-ME-Sender: <xms:VGHiXnovudi9KX_Z41tX43XfOTSiyZ6dysIo16MD-SO50Y6AtONFcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VGHiXhrv7n_qPG6Dg1JvMoP7SJb1mZefOlGqbCFM72uJiyER836R5w>
    <xmx:VGHiXkOC5RJ2JJjnPXteLYQpqlJLckZltIQH7nGDuHwcHMt2tg29Vw>
    <xmx:VGHiXq4UaLPK5R8-UjFbo1GZiVHVg3fPSkUw9HraS2P6CP8778LOWw>
    <xmx:W2HiXug5u6IraGY0iHPbmC28CpzjCiorQafylCKk933PPBd7cDdzPw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C30193280060;
        Thu, 11 Jun 2020 12:52:35 -0400 (EDT)
Date:   Thu, 11 Jun 2020 18:52:33 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] clk: bcm: Add BCM2711 DVP driver
Message-ID: <20200611165233.dmwxuz5lhxxbh7fb@gilmour.lan>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
 <bb60d97fc76b61c2eabef5a02ebd664c0f57ede0.1591867332.git-series.maxime@cerno.tech>
 <e9e83c60-ef4c-8806-bcdb-a09702bf7559@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e9e83c60-ef4c-8806-bcdb-a09702bf7559@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Thu, Jun 11, 2020 at 05:50:30PM +0200, Stefan Wahren wrote:
> > diff --git a/drivers/clk/bcm/clk-bcm2711-dvp.c b/drivers/clk/bcm/clk-bc=
m2711-dvp.c
> > new file mode 100644
> > index 000000000000..84dbc886e303
> > --- /dev/null
> > +++ b/drivers/clk/bcm/clk-bcm2711-dvp.c
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// Copyright 2020 Cerno
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset-controller.h>
> > +#include <linux/reset/reset-simple.h>
> > +
> > +#define DVP_HT_RPI_SW_INIT	0x04
> > +#define DVP_HT_RPI_MISC_CONFIG	0x08
>=20
> sorry for not noticing this before. Are these defines specific to the
> Raspberry Pi, because of RPI?

I'm not entirely sure to be honest. It's the names that the register
have, but it's not clear to me if it's something specific to the RPi
itself, or it just means something else entirely.

Maxime
