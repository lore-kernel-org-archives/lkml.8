Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1234C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8838720797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599290412;
	bh=maligWyu2rsKm0ydVFPC4p+dMXWBEXpFFDpVZnTLus8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dGz2TO54FFuoYbo9zqsO23cAuTnRCNo5qFspEpJEB7WYmC2zZOLZW2W5WfBvZyQL5
	 SEBr3QyTO1C3szJJbbYHDcmfJOfU6iajTQMLnTNIdBYycGQim9IaGWgP+Fco155TPk
	 UUuohVVqRbmXfy0OsNV91G4tjSNuwtaz4NtOgFBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIEHUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 03:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEHUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:20:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C056320760;
        Sat,  5 Sep 2020 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599290409;
        bh=maligWyu2rsKm0ydVFPC4p+dMXWBEXpFFDpVZnTLus8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0xvkDx6adp64WeaSKLXjckrcivtNcZHvXo4Lzw5ebM26Jcqs1Z4dgBsBpri0GYNyT
         8g5TNOEZNc4Sed8pPM+GH7eVBe+fyehR3TMyCv68LcTbEZlQ+a6TQi7yBDoefNZeGu
         32PjxuZnZxbieyi5PiSGL6dkarFbrVkrwT8K2rKM=
Date:   Sat, 5 Sep 2020 15:20:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: fsl: add Plymovent M2M board
Message-ID: <20200905072002.GI9261@dragon>
References: <20200901093736.29316-1-o.rempel@pengutronix.de>
 <20200901093736.29316-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901093736.29316-3-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:37:34AM +0200, Oleksij Rempel wrote:
> Add Plymovent Group BV M2M iMX6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 6da9d734cdb7..5ecd3dd6ff23 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -176,6 +176,7 @@ properties:
>                - kontron,imx6dl-samx6i     # Kontron i.MX6 Solo SMARC Module
>                - prt,prtrvt                # Protonic RVT board
>                - prt,prtvt7                # Protonic VT7 board
> +              - ply,plym2m                # Plymovent M2M board

'l' goes before 'r'.

Shawn

>                - technexion,imx6dl-pico-dwarf   # TechNexion i.MX6DL Pico-Dwarf
>                - technexion,imx6dl-pico-hobbit  # TechNexion i.MX6DL Pico-Hobbit
>                - technexion,imx6dl-pico-nymph   # TechNexion i.MX6DL Pico-Nymph
> -- 
> 2.28.0
> 
