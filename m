Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034B0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9AF22075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgEFVB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:01:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgEFVBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:01:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 59C212A22DB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v14 03/11] soc: mediatek: Add basic_clk_name to
 scp_power_data
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Fan Chen <fan.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
 <1588752963-19934-4-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <7ad67855-a3f8-f979-8849-3765bd8289d3@collabora.com>
Date:   Wed, 6 May 2020 23:01:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588752963-19934-4-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

Thank you for your patch.

On 6/5/20 10:15, Weiyi Lu wrote:
> Try to stop extending the clk_id or clk_names if there are
> more and more new BASIC clocks. To get its own clocks by the
> basic_clk_name of each power domain.
> And then use basic_clk_name strings for all compatibles, instead of
> mixing clk_id and clk_name.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 134 ++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f669d37..c9c3cf7 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -78,34 +78,6 @@
>  #define PWR_STATUS_HIF1			BIT(26)	/* MT7622 */
>  #define PWR_STATUS_WB			BIT(27)	/* MT7622 */
>  
> -enum clk_id {
> -	CLK_NONE,
> -	CLK_MM,
> -	CLK_MFG,
> -	CLK_VENC,
> -	CLK_VENC_LT,
> -	CLK_ETHIF,
> -	CLK_VDEC,
> -	CLK_HIFSEL,
> -	CLK_JPGDEC,
> -	CLK_AUDIO,
> -	CLK_MAX,
> -};
> -
> -static const char * const clk_names[] = {
> -	NULL,
> -	"mm",
> -	"mfg",
> -	"venc",
> -	"venc_lt",
> -	"ethif",
> -	"vdec",
> -	"hif_sel",
> -	"jpgdec",
> -	"audio",
> -	NULL,
> -};
> -
>  #define MAX_CLKS	3
>  
>  /**
> @@ -116,7 +88,7 @@ enum clk_id {
>   * @sram_pdn_bits: The mask for sram power control bits.
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>   * @bus_prot_mask: The mask for single step bus protection.
> - * @clk_id: The basic clocks required by this power domain.
> + * @basic_clk_name: The basic clocks required by this power domain.
>   * @caps: The flag for active wake-up action.
>   */
>  struct scp_domain_data {
> @@ -126,7 +98,7 @@ struct scp_domain_data {
>  	u32 sram_pdn_bits;
>  	u32 sram_pdn_ack_bits;
>  	u32 bus_prot_mask;
> -	enum clk_id clk_id[MAX_CLKS];
> +	const char *basic_clk_name[MAX_CLKS];

I only reviewed v13, so sorry if this was already discussed. I am wondering if
would be better take advantage of the devm_clk_bulk_get() function instead of
kind of reimplementing the same, something like this

	const struct clk_bulk_data *basic_clocks;

>  	u8 caps;
>  };
>  
> @@ -411,12 +383,19 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	return ret;
>  }
>  
> -static void init_clks(struct platform_device *pdev, struct clk **clk)
> +static int init_basic_clks(struct platform_device *pdev, struct clk **clk,
> +			const char * const *name)
>  {
>  	int i;
>  
> -	for (i = CLK_NONE + 1; i < CLK_MAX; i++)
> -		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> +	for (i = 0; i < MAX_CLKS && name[i]; i++) {
> +		clk[i] = devm_clk_get(&pdev->dev, name[i]);
> +
> +		if (IS_ERR(clk[i]))
> +			return PTR_ERR(clk[i]);
> +	}

You will be able to remove this function, see below ...

> +
> +	return 0;
>  }
>  
>  static struct scp *init_scp(struct platform_device *pdev,
> @@ -426,9 +405,8 @@ static struct scp *init_scp(struct platform_device *pdev,
>  {
>  	struct genpd_onecell_data *pd_data;
>  	struct resource *res;
> -	int i, j;
> +	int i, ret;
>  	struct scp *scp;
> -	struct clk *clk[CLK_MAX];
>  
>  	scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
>  	if (!scp)
> @@ -481,8 +459,6 @@ static struct scp *init_scp(struct platform_device *pdev,
>  
>  	pd_data->num_domains = num;
>  
> -	init_clks(pdev, clk);
> -
>  	for (i = 0; i < num; i++) {
>  		struct scp_domain *scpd = &scp->domains[i];
>  		struct generic_pm_domain *genpd = &scpd->genpd;
> @@ -493,17 +469,9 @@ static struct scp *init_scp(struct platform_device *pdev,
>  
>  		scpd->data = data;
>  
> -		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> -			struct clk *c = clk[data->clk_id[j]];
> -
> -			if (IS_ERR(c)) {
> -				dev_err(&pdev->dev, "%s: clk unavailable\n",
> -					data->name);
> -				return ERR_CAST(c);
> -			}
> -
> -			scpd->clk[j] = c;
> -		}
> +		ret = init_basic_clks(pdev, scpd->clk, data->basic_clk_name);
> +		if (ret)
> +			return ERR_PTR(ret);

Just call:

	ret = devm_clk_bulk_get(&pdev->dev, ARRAY_SIZE(basic_clocks),
				data->basic_clocks);
	if (ret)
		return ERR_PTR(ret);

>  
>  		genpd->name = data->name;
>  		genpd->power_off = scpsys_power_off;
> @@ -560,7 +528,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  		.ctl_offs = SPM_CONN_PWR_CON,
>  		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
>  				 MT2701_TOP_AXI_PROT_EN_CONN_S,
> -		.clk_id = {CLK_NONE},
>  		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_DISP] = {
> @@ -568,7 +535,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  		.sta_mask = PWR_STATUS_DISP,
>  		.ctl_offs = SPM_DIS_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
> -		.clk_id = {CLK_MM},
> +		.basic_clk_name = {"mm"},

		.basic_clocks[] = {
			{ .id = "mm" },
		};

>  		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_MM_M0,
>  		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
> @@ -578,7 +545,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  		.ctl_offs = SPM_MFG_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
> -		.clk_id = {CLK_MFG},
> +		.basic_clk_name = {"mfg"},

		.basic_clocks[] = {
			{ .id = "mfg" },
		};

>  		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_VDEC] = {
> @@ -587,7 +554,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  		.ctl_offs = SPM_VDE_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
> -		.clk_id = {CLK_MM},
> +		.basic_clk_name = {"mm"},

...

[snip]
