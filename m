Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82413C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D8B20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgBTVVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:21:35 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:50392 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgBTVVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:21:31 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6003D8092B;
        Thu, 20 Feb 2020 22:21:22 +0100 (CET)
Date:   Thu, 20 Feb 2020 22:21:20 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jonas Karlman <jonas@kwiboo.se>, Torsten Duwe <duwe@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: Add Guangdong Neweast Optoelectronics
 CO. LTD vendor prefix
Message-ID: <20200220212120.GA24526@ravnborg.org>
References: <20200220083508.792071-1-anarsoul@gmail.com>
 <20200220083508.792071-4-anarsoul@gmail.com>
 <20200220135608.GE4998@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220135608.GE4998@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=f-gQsFuhAAAA:8
        a=Yq3xfVepBXnQ4hnRxQcA:9 a=CjuIK1q_8ugA:10 a=rK24_1OTlYzjfT9fWsed:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent.

> > +  "^neweast,.*":
> > +    description: Guangdong Neweast Optoelectronics CO., LT
> 
> Google only returns two hits for this name, beside the ones related to
> this patch series. Are you sure this is the correct company name ?

Seems legit:
http://www.eastbl.com/

But maybe their chinese name was better a basis for vendor prefix?

Guangdong New Oriental Optoelectronics

	Sam
