Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C94CC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101182083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgH3U2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:28:31 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:43940 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3U2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:28:30 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 48BCF804BA;
        Sun, 30 Aug 2020 22:28:24 +0200 (CEST)
Date:   Sun, 30 Aug 2020 22:28:22 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?B?5L2V5bCP6b6Z?= <Leon.He@unisoc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v2 6/6]
 drm/panel: Add Ilitek ILI9341 DBI panel driver
Message-ID: <20200830202822.GA950472@ravnborg.org>
References: <20200822163250.63664-1-paul@crapouillou.net>
 <20200822163250.63664-7-paul@crapouillou.net>
 <edf38d68214247f486db3cc1f81ec404@shmbx04.spreadtrum.com>
 <COYVFQ.2IA7KFB6BF4C3@crapouillou.net>
 <20200830191133.GB6043@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830191133.GB6043@pendragon.ideasonboard.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=5KLPUuaC_9wA:10 a=ZRaz1EvN7pzWBUx8I4YA:9
        a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent.

> > 
> > Please read the cover letter, it explains why it's done this way. The 
> > whole point of this patchset is to merge DSI and DBI frameworks in a 
> > way that can be maintained.
> 
> I think this proves the point that the proposed naming is confusing. At
> least a rename would be required.

Do you have any inputs on the amount of rename we are looking into.
Is this a simple s/struct mipi_dsi_device/struct mipi_dxi_device/
or something more?

We should script the rename as it will tocuh a lot of files,
and without a script we would chase this. But once it is scripted
it would be trivial to perform.

I did not look at this enough, but I had an idea that we
would have do to a s/dsi/dxi/ in a lot of places.

(dxi is my best proposal at the moment for something covering both dsi
and dbi).

PS. I am travelling for a few days, so do not expect quick responses.

	Sam
