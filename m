Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC8C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF2820738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHVJkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:40:04 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:54676 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:40:02 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D0C6C80516;
        Sat, 22 Aug 2020 11:40:00 +0200 (CEST)
Date:   Sat, 22 Aug 2020 11:39:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>, drinkcat@chromium.org,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        hsinyi@chromium.org, matthias.bgg@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH 3/3] drm/bridge: ps8640: Rework power state handling
Message-ID: <20200822093959.GD430436@ravnborg.org>
References: <20200615205320.790334-1-enric.balletbo@collabora.com>
 <20200615205320.790334-4-enric.balletbo@collabora.com>
 <20200620214225.GD74146@ravnborg.org>
 <0220cfe5-2ac9-2d8b-529d-bb1a61478395@collabora.com>
 <20200624070738.GA1807736@ravnborg.org>
 <20b2f097-d789-3f5a-cd7e-3701669f43cb@collabora.com>
 <5af757da-87ec-c0d1-374d-0a69401e09a3@collabora.com>
 <20200821113809.GA283294@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821113809.GA283294@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=aBBcIbYZM5gs4jnWP7QA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric.

On Fri, Aug 21, 2020 at 01:38:09PM +0200, Sam Ravnborg wrote:
> Hi Enric.
> 
> > 
> > Let me reformulate the question for if it was not clear.
> > 
> > What I did is be able to read the EDID every time userspace asks for it (so
> > kernel enables all the required) and Sam is proposing to just fail if all is not
> > setup. I can obviously do this but my question is, at which point I should leave
> > all the logic enabled to be able to read the EDID (after probe?, after
> > pre_enable, after enable?) It is not clear for me from the API.
> 
> I am not clear if my suggestion is a good suggestion.
> 
> I recall I saw something similar in another bridge driver.

I have noew checked - and there is several bridge drivers that
do a power_on to read get_edid - so I was mistaken. Sorry!

	Sam
