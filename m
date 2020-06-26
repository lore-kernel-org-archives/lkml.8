Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257F420836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tecf5TAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgFZNpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgFZNpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:45:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4F1C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:45:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so4956321pge.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iIKrcqeZ/i+f7whrTWQttEpM7MFJWEe9ttvjCjKg7/w=;
        b=tecf5TAVVVyUR8ngN4Fz8fZJiiv6DU71FIxKoobEUl9C1tK2V3fCAdIu+fHD4inYV4
         ltdndw4wnRj5zca5dt0YbD2/MUdVIlK+Jz+/DYQwX1myIucKxCdsrl8Z6rQxSi25Q+yt
         A5P8ARb7Lz/p3uBXflHy1kdvumhHTzr0T9q+sLgNSd3Ly5oB6W6wFg1cjp+iM67z0opm
         11wj0g7cZnxjlccOm3oFe0XNqyL+dKESSjjhi+9WjvO1k1ikn/GJgCwPXIgaXB0NDmPI
         h7W0j/TO+AWkPw9berZQ9RQf7HDKkMrr6D5DUIo+uz2e1dDIWIVYgFWTxpJ6+ukI8dG0
         Li+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iIKrcqeZ/i+f7whrTWQttEpM7MFJWEe9ttvjCjKg7/w=;
        b=O9pRSSOSeFnF5t4UOUgAz31PuYTfWMhDmWwhcY7g8psS0SqFhJP2WAWp3rENcO8oXL
         FeK9fXqVhzFVdcJnQEk8ODvPSwB47lm3hVXAnOzxKXznTIsmhXEUa+qTnJ8VsOHVMpnp
         qLALkp3DoJzm8K4G1yVxQ8jjKhzpTO7Rkfp0LtmRaEn+PGlWf6avlsR/KZBJtsbmyk0Q
         +xUv20lBOcbX5Dws3iWfOoLFtDjQyp/M5nC74JrYzTwmV6UE/dGkfLOXYKrb8l2hxDHV
         zu/ApWAu8Aw1Gx+B+w2ghlYbJt2xARrlQxK+LWt3XVgzjAUOzmnBajAQYOlei0FeB54o
         gYtA==
X-Gm-Message-State: AOAM533qqiJPIW1GK2wKCUytrMjJNdLbzF5kP4w8BaHOVwEvgYwvY1pX
        Kp56szBdQ/vtwvHPG07frcBp
X-Google-Smtp-Source: ABdhPJy6GKN5oZxhs1qJPhycRPPQhrr0M0SAerf2AVBlPOHDu89roVwvCH8Zidvh8yoTQVGjpN518Q==
X-Received: by 2002:aa7:9ec2:: with SMTP id r2mr2868941pfq.265.1593179150313;
        Fri, 26 Jun 2020 06:45:50 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e11:8623:980f:4d73:2b9:f602])
        by smtp.gmail.com with ESMTPSA id b19sm25459300pft.74.2020.06.26.06.45.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 06:45:49 -0700 (PDT)
Date:   Fri, 26 Jun 2020 19:15:41 +0530
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
Subject: Re: [PATCH v2 1/6] clk: actions: Fix h_clk for Actions S500 SoC
Message-ID: <20200626134541.GB8333@Mani-XPS-13-9360>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
 <58c4bddaf178cb85d9930064af342190f6010e6e.1592941257.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c4bddaf178cb85d9930064af342190f6010e6e.1592941257.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:47:52PM +0300, Cristian Ciocaltea wrote:
> The h_clk clock in the Actions Semi S500 SoC clock driver has an
> invalid parent. Replace with the correct one.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

You should add fixes tag for this patch and it needs to be backported as well.

Thanks,
Mani

> ---
>  drivers/clk/actions/owl-s500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index e2007ac4d235..0eb83a0b70bc 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -183,7 +183,7 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
>  static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
>  
>  /* divider clocks */
> -static OWL_DIVIDER(h_clk, "h_clk", "ahbprevdiv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
> +static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
>  static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
>  
>  /* factor clocks */
> -- 
> 2.27.0
> 
