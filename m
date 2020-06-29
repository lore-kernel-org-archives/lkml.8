Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7340C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DF6206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="PSx0WywE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbgF2VMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgF2S5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D97C00F802
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:29:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so16333159ejd.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nLPL88OfKWPjoDgMrUq7HX0bJ21PFQyFVAStT19x/30=;
        b=PSx0WywEstp6kzCgrb2T780nS7vnNFzJS+U+DK53C0PhGN6LZvYDc2EFvOEAdEmhEj
         RUqqwUYHPI+moJOm1Lu+qDnTY8k7w4i1ZmDLAcEGCt5/VfkthQIciG4scNhgkF7qBZsF
         vapojTxZMy6hzLbJ19FtwmOG4LeFbtDfvu2hGXI5r15prpIVDn5Q6Ex36/ORxBC8HOMu
         p8sNi03zdwEm4JKaNFhsJFwkK43/7a69OrK8KLs3I2Jj3FUWqdHQLOJ+ViEJxwPsy3tk
         RJ+tPHTitdFJ/MPwm7Oci+jsb+VVt/S6RIkCjMGIh8K6vN3UA3j4206+/RBfGp3XCb1e
         Wcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nLPL88OfKWPjoDgMrUq7HX0bJ21PFQyFVAStT19x/30=;
        b=na+EoObF9ajzqcgmxD+WyurO+6Mx7BQLDM0DYtGJEV+ukuHqAjHM2RVWXNJHPN5xco
         6F41g6EcMlkF143NzbbxP2iuX/TQJjVlalqUPGFLp9wDrEMPBZ90gilt8iK9jAS089Bb
         YFY1mF+KO57n5/k3g2RuZseh1V0fXuDuygUV6/AvCUyoBY5f2E2ROFwn71HZtYqrswPm
         e/n+Nz43xZQ+HIutNFKbzQBVG/yaWdm1TuAj1iJcpWkiHrNfyCFbvFghBR2OE8iBoBt5
         L/bV4vto16rmdj7d43Ss/jam1Udy11AwLGwQbfiTgDjbVZhDcVTyIcjxfJ8RlEJBDuPL
         sBSg==
X-Gm-Message-State: AOAM532EH19XuItOfE26cQXLpdEOT5R777vgsw4voUYYKydgxjlw6piQ
        nDbwtHaN0R1Tom4ZfVdQwNJnsw==
X-Google-Smtp-Source: ABdhPJysnXFWJwpJ6uF9IEbsegahi3Y1+BUPbpahxlycTv66BVhVh2m/VMBwbtCgMcpWhDDWY9vklw==
X-Received: by 2002:a17:906:fa15:: with SMTP id lo21mr14416147ejb.156.1593433742019;
        Mon, 29 Jun 2020 05:29:02 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id a1sm18278094ejk.125.2020.06.29.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:29:01 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:28:58 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        devicetree@vger.kernel.org, bcousson@baylibre.com,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v3 0/3] pinctrl: single: support #pinctrl-cells = 2
Message-ID: <20200629122858.GA506802@x1>
References: <20200622172951.524306-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622172951.524306-1-drew@beagleboard.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 07:29:48PM +0200, Drew Fustini wrote:
> Currently, pinctrl-single only allows #pinctrl-cells = 1.
> 
> This series will allow pinctrl-single to also support #pinctrl-cells = 2
> 
> If "pinctrl-single,pins" has 3 arguments (offset, conf, mux) then
> pcs_parse_one_pinctrl_entry() does an OR operation on to get the
> value to store in the register.
>     
> To take advantage of #pinctrl-cells = 2, the AM33XX_PADCONF macro in
> omap.h is modified to keep pin conf and pin mux values separate.
> 
> change log:
> - v3: change order of patches to make sure the pinctrl-single.c patch
>   does not break anything without the dts patches
> 
> - v2: remove outer parentheses from AM33XX_PADCONF macro as it causes a
>   compile error in dtc.  I had added it per suggestion from checkpatch
>   about having parentheses around complex values.
> 
> Drew Fustini (3):
>   pinctrl: single: parse #pinctrl-cells = 2
>   ARM: dts: change AM33XX_PADCONF macro separate conf and mux
>   ARM: dts: am33xx-l4: change #pinctrl-cells from 1 to 2
> 
>  arch/arm/boot/dts/am33xx-l4.dtsi   |  2 +-
>  drivers/pinctrl/pinctrl-single.c   | 11 +++++++++--
>  include/dt-bindings/pinctrl/omap.h |  2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.25.1
> 

Hi Tony - do you think this series is useful as-is?

Or do you want to see some usage of the seperate conf and mux values
first?

thanks,
drew
