Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EAAC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAAC32070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGQJKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:10:43 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:40853 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:10:42 -0400
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id EAC4F100007;
        Fri, 17 Jul 2020 09:10:36 +0000 (UTC)
Date:   Fri, 17 Jul 2020 11:10:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/19] clk: at91: clk-generated: check best_rate against
 ranges
Message-ID: <20200717091036.GJ3428@piout.net>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594812267-6697-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 14:24:10+0300, Claudiu Beznea wrote:
> Check best_rate against available clock ranges.
> 
> Fixes: df70aeef6083 ("clk: at91: add generated clock driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-generated.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index 995a13133cfb..f8e557e0e1b8 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -185,8 +185,8 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>  		 __clk_get_name((req->best_parent_hw)->clk),
>  		 req->best_parent_rate);
>  
> -	if (best_rate < 0)
> -		return best_rate;
> +	if (best_rate < 0 || (gck->range.max && best_rate > gck->range.max))
> +		return -EINVAL;
>  
>  	req->rate = best_rate;
>  	return 0;
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
