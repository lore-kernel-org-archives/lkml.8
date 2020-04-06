Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AEFC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F420A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ckj6jk12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgDFRaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:30:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52480 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgDFRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:30:14 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66AE5F8D;
        Mon,  6 Apr 2020 19:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586194211;
        bh=swkdVcdC2H1+7+6XfdlSPcf9t/No80pcQTnku5aQfJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ckj6jk129jCHFALj+3tmXctBu5SN4Fh7d8H4kR+tW9Fgwp2TwdNJds+nOif2fa/id
         8TUP5EaZl4s3sxpNa88rr7p6Tn6wygC92QlrjXqxaWHJDd6dV9hhP4jhLllagayKd+
         eccAUhkdwlDgkwnwhbsEN9sfie3z98DEmTSVWRdU=
Date:   Mon, 6 Apr 2020 20:30:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v5 1/5] media: dt-bindings: media: i2c: Deprecate usage
 of the clock-frequency property
Message-ID: <20200406173002.GC16885@pendragon.ideasonboard.com>
References: <1586191361-16598-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1586191361-16598-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1586191361-16598-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Mon, Apr 06, 2020 at 05:42:37PM +0100, Lad Prabhakar wrote:
> OV5645 sensor supports input clock frequency ranging from 6MHz to 27MHz
> but the driver strictly expects this to be 24MHz (with tolerance of 1%)
> with this restrictions let the driver enforce the clock frequency

Maybe s/with/With/ ?

> internally to 24MHz rather then being passed as dt-property.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/media/i2c/ov5645.txt | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> index 72ad992f77be..a55bb728ea48 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> @@ -8,7 +8,6 @@ Required Properties:
>  - compatible: Value should be "ovti,ov5645".
>  - clocks: Reference to the xclk clock.
>  - clock-names: Should be "xclk".
> -- clock-frequency: Frequency of the xclk clock.
>  - enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
>    to the hardware pin PWDNB which is physically active low.
>  - reset-gpios: Chip reset GPIO. Polarity is GPIO_ACTIVE_LOW. This corresponds to
> @@ -37,7 +36,6 @@ Example:
>  
>  			clocks = <&clks 200>;
>  			clock-names = "xclk";
> -			clock-frequency = <24000000>;
>  
>  			vdddo-supply = <&camera_dovdd_1v8>;
>  			vdda-supply = <&camera_avdd_2v8>;

-- 
Regards,

Laurent Pinchart
