Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199DCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0B4207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592490276;
	bh=vudr6oJRzoUwNx1PuJdEGZLBjHEzAYe0suL8lQzVm1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q43UyYZEs15wPoPwl1W29Xz3/GS22UoE1XMOz12GtdmOvFlfUKxV+NuyewzgGd0Ex
	 uu8rcgaALsLqakEJkbjPHwH1w/cUYyeRksmgC+0RsuPdqYPErx9G42bVEDHtknXfqz
	 DjWTPnJrPYDHwj8IEkB3v8LqlVvvswB7uulzII8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgFROYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgFROYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:24:34 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C862082F;
        Thu, 18 Jun 2020 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592490273;
        bh=vudr6oJRzoUwNx1PuJdEGZLBjHEzAYe0suL8lQzVm1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iy4P2NP+QIfVquNNJLRQ4Hrqll+YheeMWy9qqqECKLV5qnu9pdaRZ8rWRKFAldofC
         r11vp7twz6+piMBuDO2kkHboiA8qfVD/FQb8QxXhxaNWDg0XhlRgtStwedXBSFu0tY
         mq8ycgwCwCMlliZUr1uOwEgJV2cwRwtdjUY1uAC4=
Date:   Thu, 18 Jun 2020 22:24:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v8 5/5] dt-bindings: arm: fsl: add different Protonic
 boards
Message-ID: <20200618142426.GA464@dragon>
References: <20200520154116.12909-1-o.rempel@pengutronix.de>
 <20200520154116.12909-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520154116.12909-6-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:41:16PM +0200, Oleksij Rempel wrote:
> Add Protonic PRTI6Q, WD2, RVT, VT7 boards.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Ah, okay.  The compatible is defined here.  This patch should really
go first.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index cd3fbe7e39487..a1657505b3357 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -119,6 +119,8 @@ properties:
>                - fsl,imx6q-sabreauto
>                - fsl,imx6q-sabrelite
>                - fsl,imx6q-sabresd
> +              - prt,prti6q                # Protonic PRTI6Q board
> +              - prt,prtwd2                # Protonic WD2 board
>                - technexion,imx6q-pico-dwarf   # TechNexion i.MX6Q Pico-Dwarf
>                - technexion,imx6q-pico-hobbit  # TechNexion i.MX6Q Pico-Hobbit
>                - technexion,imx6q-pico-nymph   # TechNexion i.MX6Q Pico-Nymph
> @@ -170,6 +172,8 @@ properties:
>                - emtrion,emcon-mx6-avari   # emCON-MX6S or emCON-MX6DL SoM on Avari Base
>                - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
>                - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
> +              - prt,prtrvt                # Protonic RVT board
> +              - prt,prtvt7                # Protonic VT7 board
>                - technexion,imx6dl-pico-dwarf   # TechNexion i.MX6DL Pico-Dwarf
>                - technexion,imx6dl-pico-hobbit  # TechNexion i.MX6DL Pico-Hobbit
>                - technexion,imx6dl-pico-nymph   # TechNexion i.MX6DL Pico-Nymph
> -- 
> 2.26.2
> 
