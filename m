Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213F8C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA34320838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691731;
	bh=NYHCE3c5CXGlnkIoemabE4su/VP+jFPsrCZJSRDeq/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t1cOTP+PYMulvHfCS8MxeYWFePyO81jWtqGeU84DK+AJU+ZC3X1bx/a7/2WAvpbJ/
	 pi/HFXnYq/LwoqKd4uIadtzPPXvG4AL3whRbvXGWyRoGYLYv/7h3SmffOhzfFiiZuQ
	 2/4MbdoMo8oFFRIS/P2KUz/1pkyhbgY9QQRuLURo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbgCaVza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:55:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41408 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgCaVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:55:29 -0400
Received: by mail-io1-f65.google.com with SMTP id b12so7240073ion.8;
        Tue, 31 Mar 2020 14:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yCr0rURC7Raa50CQ8IdO6e5tVecgPPHvPYdeIVC6eiE=;
        b=sLyR6I0Pqt/wA85K3A+uNB0MnGz0dbuAezGiwgonycwJxRa8tJuUNmzPWfQcOd/cZd
         KoZTaF94txCrkZCbvFpVjEA0ayeTrHax2H+en0Bag8mGZvXsTJsR6yAe3oZ7TF/qocDM
         9rgNE+9oghWZofU2mfJDTSk8E/rHOh9g3zBREyPsGajDvHfhrkjnHBgUXxDxN/jb2dUv
         pQQM0LtcIsYG30+XbminrswSiiAEvmnsTLpp3l910qi5uf4LFgnrz92DnjzRsq2qfH1U
         YZnoe+W94Pybwv1dbRppln6nqdbHuvnMQxYhnz1bUN1zGgW1+7jHUTW4kOXBaRbcX0Gj
         qnhg==
X-Gm-Message-State: ANhLgQ3L5JQuvr0sqZkHBeCCuVIO7/vx8B0BGcpkK9aoT30GGgjbLuN/
        K+bxrwfqdYH3lUSamRUYiQ==
X-Google-Smtp-Source: ADFU+vvwC0cEsQ2oSXhexAgioMtQjUohEsChYpbThieBRSP3Bx530D2FSjD7OC59CJBYMoRtXq4J0A==
X-Received: by 2002:a6b:4905:: with SMTP id u5mr12392280iob.134.1585691728741;
        Tue, 31 Mar 2020 14:55:28 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l12sm38432ils.55.2020.03.31.14.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:55:28 -0700 (PDT)
Received: (nullmailer pid 8706 invoked by uid 1000);
        Tue, 31 Mar 2020 21:55:25 -0000
Date:   Tue, 31 Mar 2020 15:55:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 11/13] dt-bindings: reset: imx8mp: Add ids for
 audiomix reset
Message-ID: <20200331215525.GA8176@bogus>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
 <1585150731-3354-12-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585150731-3354-12-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 05:38:49PM +0200, Abel Vesa wrote:
> Add all the reset ids for the audiomix reset.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/reset/imx-audiomix-reset.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 include/dt-bindings/reset/imx-audiomix-reset.h

This goes in the binding patch.

> 
> diff --git a/include/dt-bindings/reset/imx-audiomix-reset.h b/include/dt-bindings/reset/imx-audiomix-reset.h
> new file mode 100644
> index 00000000..571cacf
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx-audiomix-reset.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2019 NXP.
> + */
> +
> +#ifndef DT_BINDING_RESET_IMX_AUDIOMIX_H
> +#define DT_BINDING_RESET_IMX_AUDIOMIX_H
> +
> +#define IMX_AUDIOMIX_EARC_RESET		0x0
> +#define IMX_AUDIOMIX_EARC_PHY_RESET	0x1
> +
> +#define IMX_AUDIOMIX_RESET_NUM		2
> +
> +#endif
> +
> -- 
> 2.7.4
> 
