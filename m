Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE723C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A971820775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCYJyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:54:22 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40939 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCYJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:54:21 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B6BD7FF812;
        Wed, 25 Mar 2020 09:54:18 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:54:18 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] clk: at91: allow setting PCKx parent via DT
Message-ID: <20200325095418.GS5504@piout.net>
References: <cover.1584825247.git.mirq-linux@rere.qmqm.pl>
 <b1f0dc89798c4a6edae25436f98171b5d69acbe0.1584825247.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1f0dc89798c4a6edae25436f98171b5d69acbe0.1584825247.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2020 22:18:03+0100, Michał Mirosław wrote:
> This exposes PROGx clocks for use in assigned-clocks DeviceTree property
> for selecting PCKx parent clock.
> 

I'm wondering whether this is really necessary, you could assign the
clock rate to the PCK and the parent end prescaler selection would be
done properly. That was my reasoning behind not exposing the internal
clocks of the PMC.

> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> v2: rebase and update to clk/clk-at91 branch
> v3: rebase
> ---
>  drivers/clk/at91/at91rm9200.c    |  4 +++-
>  drivers/clk/at91/at91sam9260.c   |  5 ++++-
>  drivers/clk/at91/at91sam9g45.c   |  4 +++-
>  drivers/clk/at91/at91sam9n12.c   |  4 +++-
>  drivers/clk/at91/at91sam9rl.c    |  4 +++-
>  drivers/clk/at91/at91sam9x5.c    |  4 +++-
>  drivers/clk/at91/pmc.c           | 12 ++++++++++--
>  drivers/clk/at91/pmc.h           |  5 ++++-
>  drivers/clk/at91/sam9x60.c       |  4 +++-
>  drivers/clk/at91/sama5d2.c       |  4 +++-
>  drivers/clk/at91/sama5d3.c       |  4 +++-
>  drivers/clk/at91/sama5d4.c       |  4 +++-
>  include/dt-bindings/clock/at91.h |  1 +
>  13 files changed, 46 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
> index 6f4e1151553d..8da88e9a95d8 100644
> --- a/drivers/clk/at91/at91rm9200.c
> +++ b/drivers/clk/at91/at91rm9200.c
> @@ -100,7 +100,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>  
>  	at91rm9200_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					    nck(at91rm9200_systemck),
> -					    nck(at91rm9200_periphck), 0);
> +					    nck(at91rm9200_periphck), 0, 4);
>  	if (!at91rm9200_pmc)
>  		return;
>  
> @@ -159,6 +159,8 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>  						    &at91rm9200_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91rm9200_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
> index 946f03a09858..7e5ff252fffc 100644
> --- a/drivers/clk/at91/at91sam9260.c
> +++ b/drivers/clk/at91/at91sam9260.c
> @@ -354,7 +354,8 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  
>  	at91sam9260_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					    ndck(data->sck, data->num_sck),
> -					    ndck(data->pck, data->num_pck), 0);
> +					    ndck(data->pck, data->num_pck),
> +					    0, data->num_progck);
>  	if (!at91sam9260_pmc)
>  		return;
>  
> @@ -434,6 +435,8 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  						    &at91rm9200_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9260_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < data->num_sck; i++) {
> diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
> index 53e8252b8a63..5d18eb04c218 100644
> --- a/drivers/clk/at91/at91sam9g45.c
> +++ b/drivers/clk/at91/at91sam9g45.c
> @@ -117,7 +117,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>  
>  	at91sam9g45_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					    nck(at91sam9g45_systemck),
> -					    nck(at91sam9g45_periphck), 0);
> +					    nck(at91sam9g45_periphck), 0, 2);
>  	if (!at91sam9g45_pmc)
>  		return;
>  
> @@ -182,6 +182,8 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>  						    &at91sam9g45_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9g45_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91sam9g45_systemck); i++) {
> diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
> index f3ae1cd3cb8d..3a2564c2f724 100644
> --- a/drivers/clk/at91/at91sam9n12.c
> +++ b/drivers/clk/at91/at91sam9n12.c
> @@ -129,7 +129,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>  		return;
>  
>  	at91sam9n12_pmc = pmc_data_allocate(PMC_MAIN + 1,
> -					   nck(at91sam9n12_systemck), 31, 0);
> +					   nck(at91sam9n12_systemck), 31, 0, 2);
>  	if (!at91sam9n12_pmc)
>  		return;
>  
> @@ -198,6 +198,8 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>  						    &at91sam9x5_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9n12_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91sam9n12_systemck); i++) {
> diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
> index cc739d214ae3..bcf07f6a0e0e 100644
> --- a/drivers/clk/at91/at91sam9rl.c
> +++ b/drivers/clk/at91/at91sam9rl.c
> @@ -89,7 +89,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
>  
>  	at91sam9rl_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					   nck(at91sam9rl_systemck),
> -					   nck(at91sam9rl_periphck), 0);
> +					   nck(at91sam9rl_periphck), 0, 2);
>  	if (!at91sam9rl_pmc)
>  		return;
>  
> @@ -138,6 +138,8 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
>  						    &at91rm9200_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9rl_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91sam9rl_systemck); i++) {
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index aac99d699568..f13756b407e2 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -151,7 +151,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  		return;
>  
>  	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
> -					   nck(at91sam9x5_systemck), 31, 0);
> +					   nck(at91sam9x5_systemck), 31, 0, 2);
>  	if (!at91sam9x5_pmc)
>  		return;
>  
> @@ -227,6 +227,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  						    &at91sam9x5_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9x5_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91sam9x5_systemck); i++) {
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index ac46ea1b9fda..8a1577e2c2fd 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -67,6 +67,10 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
>  		if (idx < pmc_data->ngck)
>  			return pmc_data->ghws[idx];
>  		break;
> +	case PMC_TYPE_PROGRAMMABLE:
> +		if (idx < pmc_data->npck)
> +			return pmc_data->pchws[idx];
> +		break;
>  	default:
>  		break;
>  	}
> @@ -77,9 +81,10 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
>  }
>  
>  struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
> -				   unsigned int nperiph, unsigned int ngck)
> +				   unsigned int nperiph, unsigned int ngck,
> +				   unsigned int npck)
>  {
> -	unsigned int num_clks = ncore + nsystem + nperiph + ngck;
> +	unsigned int num_clks = ncore + nsystem + nperiph + ngck + npck;
>  	struct pmc_data *pmc_data;
>  
>  	pmc_data = kzalloc(struct_size(pmc_data, hwtable, num_clks),
> @@ -99,6 +104,9 @@ struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
>  	pmc_data->ngck = ngck;
>  	pmc_data->ghws = pmc_data->phws + nperiph;
>  
> +	pmc_data->npck = npck;
> +	pmc_data->pchws = pmc_data->ghws + ngck;
> +
>  	return pmc_data;
>  }
>  
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index fc3ef772b9d9..df616f2937e7 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -24,6 +24,8 @@ struct pmc_data {
>  	struct clk_hw **phws;
>  	unsigned int ngck;
>  	struct clk_hw **ghws;
> +	unsigned int npck;
> +	struct clk_hw **pchws;
>  
>  	struct clk_hw *hwtable[];
>  };
> @@ -96,7 +98,8 @@ struct clk_pcr_layout {
>  #define ndck(a, s) (a[s - 1].id + 1)
>  #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
>  struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
> -				   unsigned int nperiph, unsigned int ngck);
> +				   unsigned int nperiph, unsigned int ngck,
> +				   unsigned int npck);
>  
>  int of_at91_get_clk_range(struct device_node *np, const char *propname,
>  			  struct clk_range *range);
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index a7d4f648db26..db14e0427c7f 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -185,7 +185,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  	sam9x60_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					nck(sam9x60_systemck),
>  					nck(sam9x60_periphck),
> -					nck(sam9x60_gck));
> +					nck(sam9x60_gck), 8);
>  	if (!sam9x60_pmc)
>  		return;
>  
> @@ -255,6 +255,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  						    &sam9x60_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		sam9x60_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sam9x60_systemck); i++) {
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index b2560670e5af..ae5e83cadb3d 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -169,7 +169,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  	sama5d2_pmc = pmc_data_allocate(PMC_I2S1_MUX + 1,
>  					nck(sama5d2_systemck),
>  					nck(sama5d2_periph32ck),
> -					nck(sama5d2_gck));
> +					nck(sama5d2_gck), 3);
>  	if (!sama5d2_pmc)
>  		return;
>  
> @@ -267,6 +267,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  						    &sama5d2_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		sama5d2_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d2_systemck); i++) {
> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> index 914e6f225510..507eef6797f1 100644
> --- a/drivers/clk/at91/sama5d3.c
> +++ b/drivers/clk/at91/sama5d3.c
> @@ -127,7 +127,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>  
>  	sama5d3_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					nck(sama5d3_systemck),
> -					nck(sama5d3_periphck), 0);
> +					nck(sama5d3_periphck), 0, 3);
>  	if (!sama5d3_pmc)
>  		return;
>  
> @@ -201,6 +201,8 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>  						    &at91sam9x5_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		sama5d3_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d3_systemck); i++) {
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index 4ca9a4619500..80692902b4e4 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -142,7 +142,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>  
>  	sama5d4_pmc = pmc_data_allocate(PMC_MCK2 + 1,
>  					nck(sama5d4_systemck),
> -					nck(sama5d4_periph32ck), 0);
> +					nck(sama5d4_periph32ck), 0, 3);
>  	if (!sama5d4_pmc)
>  		return;
>  
> @@ -224,6 +224,8 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>  						    &at91sam9x5_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		sama5d4_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d4_systemck); i++) {
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index 38b5554153c8..c3f4aa6a2d29 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -12,6 +12,7 @@
>  #define PMC_TYPE_SYSTEM		1
>  #define PMC_TYPE_PERIPHERAL	2
>  #define PMC_TYPE_GCK		3
> +#define PMC_TYPE_PROGRAMMABLE	4
>  
>  #define PMC_SLOW		0
>  #define PMC_MCK			1
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
