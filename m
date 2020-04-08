Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA06C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0864206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgDHUSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:18:10 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47342 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgDHUSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:18:09 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B564B804E6;
        Wed,  8 Apr 2020 22:18:03 +0200 (CEST)
Date:   Wed, 8 Apr 2020 22:18:02 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Lu <david.lu@bitland.com.cn>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, jungle.chiang@bitland.com.cn,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dt-bindings: boe, tv101wum-n16: Add compatible for boe
 tv105wum-nw0.
Message-ID: <20200408201802.GB612@ravnborg.org>
References: <20200324094525.4758-1-david.lu@bitland.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324094525.4758-1-david.lu@bitland.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=iKCrp2iyAAAA:8
        a=e5mUnYsNAAAA:8 a=KSWG7gIH_8gM9piVvoQA:9 a=CjuIK1q_8ugA:10
        a=6dnM-gFdnRAg0d82BWIM:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

On Tue, Mar 24, 2020 at 05:45:25PM +0800, David Lu wrote:
> Add bindings documentation for BOE TV105WUM-NW0 10.5" WUXGA TFT LCD
> panel.
> 
> Signed-off-by: David Lu <david.lu@bitland.com.cn>
> Change-Id: I450c0e52aae080728d4794bdffc50bb0d2f39f40

I dropped the Change-Id while applying.
Applied to drm-misc-next and pushed out.

	Sam

> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> index 740213459134..7f5df5851017 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -24,6 +24,8 @@ properties:
>        - boe,tv101wum-n53
>          # AUO B101UAN08.3 10.1" WUXGA TFT LCD panel
>        - auo,b101uan08.3
> +        # BOE TV105WUM-NW0 10.5" WUXGA TFT LCD panel
> +      - boe,tv105wum-nw0
>  
>    reg:
>      description: the virtual channel number of a DSI peripheral
> -- 
> 2.24.1
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
