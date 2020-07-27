Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92ECA2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgG0TZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:25:40 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60217 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgG0TZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:25:40 -0400
X-Originating-IP: 193.22.133.58
Received: from hyperion.localnet (unknown [193.22.133.58])
        (Authenticated sender: relay@treewalker.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D5A7920002;
        Mon, 27 Jul 2020 19:24:52 +0000 (UTC)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: display: Document NewVision NV3052C DT node
Date:   Mon, 27 Jul 2020 21:24:52 +0200
Message-ID: <2191202.OZe27ScSiE@hyperion>
In-Reply-To: <20200727191052.GA1011220@ravnborg.org>
References: <20200727164613.19744-1-paul@crapouillou.net> <20200727164613.19744-2-paul@crapouillou.net> <20200727191052.GA1011220@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 27 July 2020 21:10:52 CEST Sam Ravnborg wrote:
> > +description: |
> > +  This is a driver for 320x240 TFT panels,
> 
> The binding describes the HW, not the driver. So please re-phrase this
> part.
> 
> This datasheet:
> https://www.phoenixdisplay.com/wp-content/uploads/2019/05/NV3052C-Dat
> asheet-V0.2.pdf tells that the driver supports additional resoltions.
> I guess the 320x240 resolution is limited to the leadtek panel.

The word "driver" is overloaded ;)

I guess "driver IC" would make it clearer.

Bye,
		Maarten



