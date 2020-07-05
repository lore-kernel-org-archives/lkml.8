Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C2FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1725D206A1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 11:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="TEKWJPO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGELaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 07:30:21 -0400
Received: from vps.xff.cz ([195.181.215.36]:49000 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 07:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593948618; bh=nHfOIwXc+Zz/lwPPI+EBR9cQnyaeOaO4WMoyx4yZ8qc=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=TEKWJPO4rNp+Rawce4HThyB16qKwHLkiusLO/vjFr0IN0+E2OSCrL8cSz0eMGQPM3
         2F4oaHSVqfrsD4+DjXMl0+ALgaVcsiF5pbbqSeSWvCwDoBp8vbMOPyC+LKi1KiAf5f
         tTZve66RLFVZWTMYZ4G/rWsSRmdZabyyArlxkQYc=
Date:   Sun, 5 Jul 2020 13:30:17 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust entry to renaming and conversion
Message-ID: <20200705113017.mostxjvatkqkhqf6@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200705065917.22285-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200705065917.22285-1-lukas.bulwahn@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lukas,

On Sun, Jul 05, 2020 at 08:59:17AM +0200, Lukas Bulwahn wrote:
> Commit a74e81a56405 ("drm/panel: rocktech-jh057n00900: Rename the driver to
> st7703") and commit 7317f4574492 ("dt-bindings: panel: Convert
> rocktech,jh057n00900 to yaml") renamed and converted the files mentioned in
> DRM DRIVER FOR ROCKTECH JH057N00900 PANELS, but did not adjust the entries
> in MAINTAINERS.

A similar patch was already posted:

https://lkml.kernel.org/lkml/20200701184640.1674969-1-megous@megous.com/

thank you and regards,
	o.

> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches  F: \
>   Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
>   warning: no file matches  F: \
>   drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> 
> Adjust entries after this file renaming and devicetree conversion.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20200703
> 
> Ondrej, please ack this patch.
> Sam, please pick this minor non-urgent patch into your -next tree.
> 
> This is the minimal change to address the warning. You might consider
> changing the name of the section from ROCKTECH to ST7703, change
> maintainers etc.
> 
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9375edaef11f..8a7b92faff99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5493,8 +5493,8 @@ DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
>  M:	Guido Günther <agx@sigxcpu.org>
>  R:	Purism Kernel Team <kernel@puri.sm>
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> -F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> +F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> +F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
>  
>  DRM DRIVER FOR SAVAGE VIDEO CARDS
>  S:	Orphan / Obsolete
> -- 
> 2.17.1
> 
