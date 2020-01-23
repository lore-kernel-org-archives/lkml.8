Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A57C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D6B24125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAWSGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:06:13 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:45782 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAWSGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:06:12 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id F25A020031;
        Thu, 23 Jan 2020 19:06:04 +0100 (CET)
Date:   Thu, 23 Jan 2020 19:06:03 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, dri-devel@lists.freedesktop.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: add vendor prefix for logic
 technologies limited
Message-ID: <20200123180603.GB17233@ravnborg.org>
References: <20200120080100.170294-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120080100.170294-1-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=m8ToADvmAAAA:8
        a=6h0QpovlAAAA:8 a=k76NmfXvAAAA:8 a=VwQbUJbxAAAA:8 a=5161Qnb4PEtQmF6y4tUA:9
        a=_A8lN0e7biOy-kDP:21 a=1vGcD8wBxvxDrBQY:21 a=CjuIK1q_8ugA:10
        a=kCrBFHLFDAq2jDEeoMj9:22 a=UMgBrLottiFGRxIVDUvr:22
        a=xklTzJp5TIrWR6y8xC-k:22 a=AjGcO6oz07-iQ99wixmX:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel.

On Mon, Jan 20, 2020 at 09:00:58AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add vendor prefix for Logic Technologies Limited [1] which is a Chinese
> display manufacturer e.g. distributed by German Endrich Bauelemente
> Vertriebs GmbH [2].
> 
> [1] https://logictechno.com/contact-us/
> [2] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks for the quick revision.
All three patches applied to drm-misc-next.

I applied patch 2 by hand due to conflicts caused
by another patch I added just minutes ago.

	Sam

> 
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - Added Philippe's reviewed-by.
> - Added Rob's acked-by.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index f9b84f24a382..ac4804d0a991 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -549,6 +549,8 @@ patternProperties:
>      description: Linear Technology Corporation
>    "^logicpd,.*":
>      description: Logic PD, Inc.
> +  "^logictechno,.*":
> +    description: Logic Technologies Limited
>    "^longcheer,.*":
>      description: Longcheer Technology (Shanghai) Co., Ltd.
>    "^lsi,.*":
> -- 
> 2.24.1
