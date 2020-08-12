Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03048C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB582076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h7TuowcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHLQJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:09:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54040 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgHLQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:09:48 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 46B5C9E7;
        Wed, 12 Aug 2020 18:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597248586;
        bh=mvaE9LRN2Vt1ZNzUVCtlae6gaNBI7AG1lJg+ohOIPbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7TuowcKaI+k5MhXWhn9BBr+xNXe0zFVCBU2eTgRN+JZAC4SPXKm8maN3frNZ1KQN
         UXCxrQwY9JTMGvos3oKsweCPpSVizFLxCAomy6yW5vGz9i2qsmbjJf+m/IWPXcMOpR
         dPgc9mLGPANblj4wlRnVmDpkOp1JjrFICQPQAmEU=
Date:   Wed, 12 Aug 2020 19:09:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Subject: Re: [PATCH 1/9] dt-bindings: display: renesas,du: Document r8a774e1
 bindings
Message-ID: <20200812160932.GK6057@pendragon.ideasonboard.com>
References: <20200812140217.24251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200812140217.24251-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812140217.24251-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Wed, Aug 12, 2020 at 03:02:09PM +0100, Lad Prabhakar wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Document the RZ/G2H (a.k.a. r8a774e1) SoC in the R-Car DU bindings.
> 
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
> index 51cd4d162770..67cded5ad827 100644
> --- a/Documentation/devicetree/bindings/display/renesas,du.txt
> +++ b/Documentation/devicetree/bindings/display/renesas,du.txt
> @@ -10,6 +10,7 @@ Required Properties:
>      - "renesas,du-r8a774a1" for R8A774A1 (RZ/G2M) compatible DU
>      - "renesas,du-r8a774b1" for R8A774B1 (RZ/G2N) compatible DU
>      - "renesas,du-r8a774c0" for R8A774C0 (RZ/G2E) compatible DU
> +    - "renesas,du-r8a774e1" for R8A774E1 (RZ/G2H) compatible DU
>      - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
>      - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
>      - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
> @@ -75,6 +76,7 @@ corresponding to each DU output.
>   R8A774A1 (RZ/G2M)      DPAD 0         HDMI 0         LVDS 0         -
>   R8A774B1 (RZ/G2N)      DPAD 0         HDMI 0         LVDS 0         -
>   R8A774C0 (RZ/G2E)      DPAD 0         LVDS 0         LVDS 1         -
> + R8A774E1 (RZ/G2H)      DPAD 0         HDMI 0         LVDS 0         -
>   R8A7779 (R-Car H1)     DPAD 0         DPAD 1         -              -
>   R8A7790 (R-Car H2)     DPAD 0         LVDS 0         LVDS 1         -
>   R8A7791 (R-Car M2-W)   DPAD 0         LVDS 0         -              -

-- 
Regards,

Laurent Pinchart
