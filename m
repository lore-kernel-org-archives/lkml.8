Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97EAC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E53246B3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgARRa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:30:28 -0500
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:38583 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726490AbgARRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:30:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AEB62182CED5B;
        Sat, 18 Jan 2020 17:30:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: uncle83_5b0aae334862c
X-Filterd-Recvd-Size: 1758
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Jan 2020 17:30:25 +0000 (UTC)
Message-ID: <d7010f3bc07d2666e6bbde3140d51acd539cb55b.camel@perches.com>
Subject: Re: [PATCH 4/4] GPIO: creg-snps: fixed a typo
From:   Joe Perches <joe@perches.com>
To:     sachin agarwal <asachin591@gmail.com>, Eugeniy.Paltsev@synopsys.com
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 18 Jan 2020 09:29:26 -0800
In-Reply-To: <20200118104506.68524-1-sachinagarwal@sachins-MacBook-2.local>
References: <20200118104506.68524-1-sachinagarwal@sachins-MacBook-2.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-01-18 at 16:15 +0530, sachin agarwal wrote:
> From: Sachin agarwal <asachin591@gmail.com>
> 
> we had written "valiue" rather than "value".
[]
> diff --git a/drivers/gpio/gpio-creg-snps.c b/drivers/gpio/gpio-creg-snps.c
[]
> @@ -64,11 +64,11 @@ static int creg_gpio_validate_pg(struct device *dev, struct creg_gpio *hcg,
>  	if (layout->bit_per_gpio[i] < 1 || layout->bit_per_gpio[i] > 8)
>  		return -EINVAL;
>  
> -	/* Check that on valiue fits it's placeholder */
> +	/* Check that on value fits it's placeholder */

Might as well fix the it's/its usages too.

>  	if (GENMASK(31, layout->bit_per_gpio[i]) & layout->on[i])
>  		return -EINVAL;
> 
> -	/* Check that off valiue fits it's placeholder */
> +	/* Check that off value fits it's placeholder */
>  	if (GENMASK(31, layout->bit_per_gpio[i]) & layout->off[i])
>  		return -EINVAL;
>  

