Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669ECC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46745208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEAVAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:00:43 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:49320 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:00:43 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E48FE2002A;
        Fri,  1 May 2020 23:00:39 +0200 (CEST)
Date:   Fri, 1 May 2020 23:00:38 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for TM5P5 NT35596 video mode panel
Message-ID: <20200501210038.GB26726@ravnborg.org>
References: <20200501204825.146424-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501204825.146424-1-konradybcio@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=bAtGagR5AAAA:20 a=7LVGNgU6USOl37Ea4AYA:9
        a=CjuIK1q_8ugA:10 a=443qOekVpzXbzkAZ2tlV:22 a=pHzHmUro8NiASowvMSCR:22
        a=Ew2E2A-JSTLzCXPT_086:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad.

On Fri, May 01, 2020 at 10:48:21PM +0200, Konrad Dybcio wrote:
> I am aware of the fact that this is probably not the correct
> naming of this panel, yet I am unable to retrieve any additional
> information about it, as it is used in a smartphone to which no
> schematics are released.
> 
> The driver has been generated with the help of 
> linux-mdss-dsi-panel-driver-generator [1] and works perfectly
> on a Asus Zenfone 2 Laser Z00T smartphone, including brighness
> control and switching on/off.
> 
> [1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator

Panle driver looks good.
Will take a closer look tomorrow.

Any chance you can work on the TODO in the driver so we can have that
resolved before we apply it?

Also for a v2 it would be perfect if you could work on top of
drm-misc-next.
There is at least one small fix needed to build that I spotted.

But wait until I get back on the driver patch before submitting a v2.

	Sam

> 
> Konrad Dybcio (2):
>   drivers: drm: panel: Add TM5P5 NT35596 panel driver
>   dt-bindings: display: Document TM5P5 NT35596 panel compatible
> 
>  .../bindings/display/panel/tm5p5,nt35596.txt  |   7 +
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-tm5p5-nt35596.c   | 366 ++++++++++++++++++
>  4 files changed, 383 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt
>  create mode 100644 drivers/gpu/drm/panel/panel-tm5p5-nt35596.c
> 
> -- 
> 2.26.1
