Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA9BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3E7206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tXwtVQjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgHHVFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 17:05:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F75EC061756;
        Sat,  8 Aug 2020 14:05:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-78-184-nat.elisa-mobile.fi [85.76.78.184])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0239F9;
        Sat,  8 Aug 2020 23:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596920720;
        bh=AC6WiCHH+dGr8IJos7KFwBjM3cGjKVSu3ec5odbnuqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXwtVQjPzV4sLbaMNwCIziShtaJ5SBIJ1MR1n28bg6BvaQAc3d0D/cBH0CQ/f1HPM
         Qdar0v+DyCxxl1K1mRMJBW/zZysT8Q37JOSDsXnEOGA0GLRXJgc9E1rLUosLOGREhQ
         SWF1GgAwXyILLpHgaAgDPSNTcWAHU1jdgbeU+KH8=
Date:   Sun, 9 Aug 2020 00:05:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: display: renesas,lvds: Document r8a7742
 bindings
Message-ID: <20200808210507.GP6186@pendragon.ideasonboard.com>
References: <20200807174954.14448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200807174954.14448-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200808210321.GO6186@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200808210321.GO6186@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 12:03:27AM +0300, Laurent Pinchart wrote:
> Hi Prabhakar,
> 
> Thank you for the patch.
> 
> On Fri, Aug 07, 2020 at 06:49:50PM +0100, Lad Prabhakar wrote:
> > Document the RZ/G1H (R8A7742) LVDS bindings.
> > 
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I actually spoke too soon, this binding has been concerted to YAML in
drm-next. I can fix this when applying, no need to resubmit just for
this.

> > ---
> >  .../devicetree/bindings/display/bridge/renesas,lvds.txt          | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> > index c62ce2494ed9..40aa809f41cd 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> > @@ -7,6 +7,7 @@ Gen2, R-Car Gen3 and RZ/G SoCs.
> >  Required properties:
> >  
> >  - compatible : Shall contain one of
> > +  - "renesas,r8a7742-lvds" for R8A7742 (RZ/G1H) compatible LVDS encoders
> >    - "renesas,r8a7743-lvds" for R8A7743 (RZ/G1M) compatible LVDS encoders
> >    - "renesas,r8a7744-lvds" for R8A7744 (RZ/G1N) compatible LVDS encoders
> >    - "renesas,r8a774a1-lvds" for R8A774A1 (RZ/G2M) compatible LVDS encoders

-- 
Regards,

Laurent Pinchart
