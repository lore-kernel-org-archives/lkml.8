Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C16C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3389D20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgGAQH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:07:28 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43212 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbgGAQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:07:28 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AE60A20025;
        Wed,  1 Jul 2020 18:07:24 +0200 (CEST)
Date:   Wed, 1 Jul 2020 18:07:23 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
Cc:     Ondrej Jirman <megous@megous.com>, linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v6 02/13] dt-bindings: panel: Convert
 rocktech,jh057n00900 to yaml
Message-ID: <20200701160723.GA675098@ravnborg.org>
References: <20200701103126.1512615-1-megous@megous.com>
 <20200701103126.1512615-3-megous@megous.com>
 <20200701155857.GB174356@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701155857.GB174356@bogon.m.sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=J_fg_7IlAAAA:8 a=-sgrNTgQ70Twg4PVczQA:9
        a=wPNLvfGTeEIA:10 a=zGOw-GkVl6h1W4ZARoUA:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:58:57PM +0200, Guido Günther wrote:
> Hi Ondrej,
> On Wed, Jul 01, 2020 at 12:31:15PM +0200, Ondrej Jirman wrote:
> > Convert Rocktech MIPI DSI panel driver from txt to yaml bindings.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  .../display/panel/rocktech,jh057n00900.txt    | 23 -------
> >  .../display/panel/rocktech,jh057n00900.yaml   | 66 +++++++++++++++++++
> >  2 files changed, 66 insertions(+), 23 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> 
> Thanks for the conversion! Shouldn't we switch to `sitronix-st7703.yaml`
> as well in this patch?

That would be good if this rename is included.
Otherwise we will just have to do it later.

	Sam
