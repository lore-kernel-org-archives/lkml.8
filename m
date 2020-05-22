Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DCEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB0206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgEVTHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:07:51 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:56664 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgEVTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:07:50 -0400
Received: from belgarion ([86.210.245.36])
        by mwinf5d03 with ME
        id hv7i220030nqnCN03v7iXH; Fri, 22 May 2020 21:07:47 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 22 May 2020 21:07:47 +0200
X-ME-IP: 86.210.245.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 2/3] gpio: pxa: Fix return value of pxa_gpio_probe()
References: <1590120740-22912-1-git-send-email-yangtiezhu@loongson.cn>
        <1590120740-22912-2-git-send-email-yangtiezhu@loongson.cn>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 22 May 2020 21:07:23 +0200
In-Reply-To: <1590120740-22912-2-git-send-email-yangtiezhu@loongson.cn>
        (Tiezhu Yang's message of "Fri, 22 May 2020 12:12:19 +0800")
Message-ID: <874ks7okk4.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiezhu Yang <yangtiezhu@loongson.cn> writes:

> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value and return PTR_ERR() if failed.
>
> Fixes: 542c25b7a209 ("drivers: gpio: pxa: use devm_platform_ioremap_resource()")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/gpio/gpio-pxa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index 1361270..0cb6600 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -660,8 +660,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
>  	pchip->irq1 = irq1;
>  
>  	gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (!gpio_reg_base)
> -		return -EINVAL;
> +	if (IS_ERR(gpio_reg_base))
> +		return PTR_ERR(gpio_reg_base);
As far as I know, devm_platform_ioremap_resource() could return NULL which is
not handled by this test (unless __devm_ioremap() semantics changed since I had
a look).

Therefore, this patch is incorrect, or rather incomplete.

Cheers.

-- 
Robert
