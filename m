Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC04C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCB7206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgGNSaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:30:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34408 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgGNSaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:30:24 -0400
Received: from x2f7fa33.dyn.telefonica.de ([2.247.250.51] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jvPh5-0008HH-Fi; Tue, 14 Jul 2020 20:30:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 07/25] pinctrl: samsung: pinctrl-s3c24xx: Fix formatting issues
Date:   Tue, 14 Jul 2020 20:30:18 +0200
Message-ID: <8131724.iLJVplcRQ0@phil>
In-Reply-To: <20200713144930.1034632-8-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org> <20200713144930.1034632-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 13. Juli 2020, 16:49:12 CEST schrieb Lee Jones:
> Kerneldoc struct titles must be followed by whitespace.  Also attributes
> need to be in the format '@.*: ' else the checker gets confused.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c:100: warning: cannot understand function prototype: 'struct s3c24xx_eint_domain_data '
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> index 9bd0a3de101dd..5e24838a582f5 100644
> --- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> +++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> @@ -80,7 +80,7 @@ static const struct samsung_pin_bank_type bank_type_2bit = {
>  	}
>  
>  /**
> - * struct s3c24xx_eint_data: EINT common data
> + * struct s3c24xx_eint_data - EINT common data
>   * @drvdata: pin controller driver data
>   * @domains: IRQ domains of particular EINT interrupts
>   * @parents: mapped parent irqs in the main interrupt controller
> @@ -92,10 +92,10 @@ struct s3c24xx_eint_data {
>  };
>  
>  /**
> - * struct s3c24xx_eint_domain_data: per irq-domain data
> + * struct s3c24xx_eint_domain_data - per irq-domain data
>   * @bank: pin bank related to the domain
>   * @eint_data: common data
> - * eint0_3_parent_only: live eints 0-3 only in the main intc
> + * @eint0_3_parent_only: live eints 0-3 only in the main intc
>   */
>  struct s3c24xx_eint_domain_data {
>  	struct samsung_pin_bank *bank;
> 




