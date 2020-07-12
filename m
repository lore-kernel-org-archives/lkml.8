Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1468C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D165D2068F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ri/8DHJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGLQ5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgGLQ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 12:57:22 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C8C08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 09:57:22 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f2so4430743plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CPkl/fwjqSvU16542/LkecvuecxR0K2ncOMxvrSe7NE=;
        b=ri/8DHJCrZj2aPu+BZBBMbrgWxU5X0reDn4yF7oiqicN18H9KEWTnfWiwU6o0lFv0j
         CR+gKIE8y1H5nja1iD9lv4MbYDB56AWfHLrRzEMKluhzZHtl8/UBt85cMOlSh3lAz8TW
         Jmxoc5Rx7P+L6I80/zIqR7i3xvTmZEej9PL/iDj4gJgUCVoVJud8SFqzVa3ZSJpO7Lv5
         YhOILn3AfbcjufDc6fkqxa0XyXEMvTeWETtoaj3hbpktip/dQFGOy5/HF7YdKoZtBkqE
         jBJdvbl5S8kH2vyUhT2lghLdXksq5KPriM2jwUx7FxZctbMI4nQSlfO4zp8iYs7PzVj7
         vbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CPkl/fwjqSvU16542/LkecvuecxR0K2ncOMxvrSe7NE=;
        b=B5g1QnOIY+4zEAZDG6zMeWd7u3fzH/ci+orwD2n6zYmL56RulEoAII8oquvUzXofDc
         5gUiUgJuPBECKUSm6HrCuKW5g3b17gB01B3GMLRKfWq6qyCNrIqlblsoyXq4TF1/TcKt
         +9jrDvaQpCtuKBLNcZO9GRIrJIu/OCFiEBEnJL5uACTfBc2k+fGJFpQRkN08sfra/Foo
         cuw4tOfAO+GAm4MbUSRDZ9tQz0dusMvigRoUg96OqB8RPSlGdYPGdXy46qnAajzKsVoj
         OtJD7Jcpc7WO4u+t82assCbrjqEwX3CvH1OIxUQcIofyHFJ40zzU0fRYq2BS9RxypjU+
         LP8A==
X-Gm-Message-State: AOAM532o5V7hG1VBMl1KrAvVrtX6BOWvMQzD5iLZzTVt6foMh5KXG7Ld
        LtOk7PMhAonwrC9AJppzqJbP
X-Google-Smtp-Source: ABdhPJyQCFxGpgMAOKCeaJPmYY4B/hH9RTOBNaBOL6mE5Dj9lnKy4l4/DYZdr1WJMXgBCaqv7qVnyQ==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr57166264pls.273.1594573041785;
        Sun, 12 Jul 2020 09:57:21 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id n18sm13093540pfd.99.2020.07.12.09.57.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 09:57:21 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:27:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v3 3/6] clk: actions: Add APB, DMAC, GPIO clock support
 for Actions S500 SoC
Message-ID: <20200712165715.GB6110@Mani-XPS-13-9360>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
 <87964ae012e513597b8b4c7be2e7ac332a70087a.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87964ae012e513597b8b4c7be2e7ac332a70087a.1593788312.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 08:05:09PM +0300, Cristian Ciocaltea wrote:
> Add support for the missing APB, DMAC and GPIO clocks in the Actions
> Semi S500 SoC clock driver.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v3:
>  - None
> 
> Changes in v2:
>  - None
> 
>  drivers/clk/actions/owl-s500.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index 0eb83a0b70bc..025a8f6d6482 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -175,6 +175,8 @@ static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RAT
>  static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
>  
>  /* gate clocks */
> +static OWL_GATE(gpio_clk, "gpio_clk", "apb_clk", CMU_DEVCLKEN0, 18, 0, 0);
> +static OWL_GATE(dmac_clk, "dmac_clk", "h_clk", CMU_DEVCLKEN0, 1, 0, 0);
>  static OWL_GATE(spi0_clk, "spi0_clk", "ahb_clk", CMU_DEVCLKEN1, 10, 0, CLK_IGNORE_UNUSED);
>  static OWL_GATE(spi1_clk, "spi1_clk", "ahb_clk", CMU_DEVCLKEN1, 11, 0, CLK_IGNORE_UNUSED);
>  static OWL_GATE(spi2_clk, "spi2_clk", "ahb_clk", CMU_DEVCLKEN1, 12, 0, CLK_IGNORE_UNUSED);
> @@ -184,6 +186,7 @@ static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
>  
>  /* divider clocks */
>  static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
> +static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
>  static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
>  
>  /* factor clocks */
> @@ -428,6 +431,9 @@ static struct owl_clk_common *s500_clks[] = {
>  	&spdif_clk.common,
>  	&nand_clk.common,
>  	&ecc_clk.common,
> +	&apb_clk.common,
> +	&dmac_clk.common,
> +	&gpio_clk.common,
>  };
>  
>  static struct clk_hw_onecell_data s500_hw_clks = {
> @@ -484,6 +490,9 @@ static struct clk_hw_onecell_data s500_hw_clks = {
>  		[CLK_SPDIF]		= &spdif_clk.common.hw,
>  		[CLK_NAND]		= &nand_clk.common.hw,
>  		[CLK_ECC]		= &ecc_clk.common.hw,
> +		[CLK_APB]		= &apb_clk.common.hw,
> +		[CLK_DMAC]		= &dmac_clk.common.hw,
> +		[CLK_GPIO]		= &gpio_clk.common.hw,
>  	},
>  	.num = CLK_NR_CLKS,
>  };
> -- 
> 2.27.0
> 
