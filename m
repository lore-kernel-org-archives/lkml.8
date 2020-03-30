Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4554DC2D0F2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2057B20774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585601170;
	bh=lOgFT3LsqVV1YDo8f2DUvvy7lhJ9V4ORW7vn1hCfoMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NeYXnvodS4di70pRKgEUny8ZTbthrxedP3mujPt/RJCTksxc0VHuTr4gURhHbrewn
	 W8L+sr40q2RRJ4k6ozTMQO9H1It0kCLYSSR0CkIIblOHU8VE0IGR2qdh92OaXTXp8+
	 o5P0fTXhmZKs4NxMBNhcl+tfej72UOhuqN6ifjUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgC3UqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:46:09 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37152 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgC3UqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:46:09 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so17273900ilr.4;
        Mon, 30 Mar 2020 13:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BAHD/YUBzhydWwE/iCZpMojP/quu8HcEwcDTrZ8h834=;
        b=qTyt2h9F/NWE5rQW6SF1OVQHhW1uAFq11I8mrVWwOzJ/HMM7PdtJLBWHNuZqOVmXQ8
         QEtQCC2eVP4fRuzjOV0Fs1UmERC1Gjwf3k228aGdfFvle3aBEwVBcWwvOL6Xx2r6cpIe
         cbXtprRvjjYPvSJCt214wXsToei/v3uQEj2RAnpPGjveSekNtOQkGTqe5t35q2y+NJT4
         8U9G4ZJxytCQBY+KFc+tdwH9SX64Lav39H/rjSFmUSWUud4BfyETAkt9b3jZfDS7wKi5
         HThfaaqwEqYi2UbHVuePmgukjA0ckX1yGqK/H/k+yFqnQm1Rm7d9ydPTJJAcjb1nR6MB
         uAjg==
X-Gm-Message-State: ANhLgQ0S1UtTAaVmo7dmwLo+xtYkPoy5dYwz5ZPuhRKsLTFDQSYJLNMR
        l5ucpHzYglgPErS8m15B2w==
X-Google-Smtp-Source: ADFU+vvlE38IaEgB1E1VNG9brIWJQdKajCluZzFENMztoPQXJvNW6huFEyZfTsPzQyXIopjuR2Ju+g==
X-Received: by 2002:a92:6501:: with SMTP id z1mr13264790ilb.235.1585601166355;
        Mon, 30 Mar 2020 13:46:06 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k8sm5160637ilk.85.2020.03.30.13.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:46:05 -0700 (PDT)
Received: (nullmailer pid 13031 invoked by uid 1000);
        Mon, 30 Mar 2020 20:46:04 -0000
Date:   Mon, 30 Mar 2020 14:46:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/5] ARM: dts: imx6: Dual license adding MIT
Message-ID: <20200330204604.GA11575@bogus>
References: <20200317101947.27250-1-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317101947.27250-1-igor.opaniuk@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 12:19:43PM +0200, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> Dual license files adding MIT license, which will permit to re-use
> device trees in other non-GPL OSS projects.

Are you the only author on these files? If not, you don't have rights to 
do this.

> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> ---
> 
>  arch/arm/boot/dts/imx6dl-pinfunc.h | 2 +-
>  arch/arm/boot/dts/imx6dl.dtsi      | 2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx6dl-pinfunc.h
> index 9d88d09f9bf6..960d300ea9ba 100644
> --- a/arch/arm/boot/dts/imx6dl-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>  /*
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 008312ee0c31..77e946b3d012 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  //
>  // Copyright 2013 Freescale Semiconductor, Inc.
>  
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index e6b4b8525f98..75d746952932 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  //
>  // Copyright 2011 Freescale Semiconductor, Inc.
>  // Copyright 2011 Linaro Ltd.
> -- 
> 2.17.1
> 
