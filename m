Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EABDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F70B207FB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgGAPZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:25:39 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:39080 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbgGAPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:25:39 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 492D920025;
        Wed,  1 Jul 2020 17:25:34 +0200 (CEST)
Date:   Wed, 1 Jul 2020 17:25:32 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
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
Subject: Re: [PATCH v6 00/13] Add support for PinePhone LCD panel
Message-ID: <20200701152532.GA670324@ravnborg.org>
References: <20200701103126.1512615-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701103126.1512615-1-megous@megous.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=J_fg_7IlAAAA:8 a=SxmoPjm5-5tPnGG2PkAA:9
        a=CjuIK1q_8ugA:10 a=zGOw-GkVl6h1W4ZARoUA:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej.

On Wed, Jul 01, 2020 at 12:31:13PM +0200, Ondrej Jirman wrote:
> This patchset adds support for the LCD panel of PinePhone.
> 
> I've tested this on PinePhone 1.0 and 1.2.
> 
> Please take a look.
> 
> thank you and regards,
>   Ondrej Jirman
> 
> Changes in v6:
> - Fixed spacing in yaml
> - Fixed wrong vccio->iovcc supply name in the bindings doc
> - I noticed that the original driver uses a delay of 20ms in the init
>   function to achieve a combined total of 120ms required from post-reset
>   to display_on. I've added a similar delay to xbd599_init, so that
>   xbd599 panel also has the right timing. (patch 9)
> - v5->v6 diff: https://megous.com/dl/tmp/v5-v6.patch
> - Added review/ack tags
> - Learned to run dt_binding_check by myself ;)
The patch-set does not apply clean on top of drm-misc-next - due to
vrefresh removal.
Please re-spin.

	Sam
