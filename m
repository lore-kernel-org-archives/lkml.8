Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B4C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE132076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgCRLOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:14:32 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41696 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgCRLOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:14:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CF602201204;
        Wed, 18 Mar 2020 12:14:30 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C1E1E200F02;
        Wed, 18 Mar 2020 12:14:30 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id ACE2820506;
        Wed, 18 Mar 2020 12:14:30 +0100 (CET)
Date:   Wed, 18 Mar 2020 13:14:30 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        t-kristo@ti.com, jonas.gorski@gmail.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx: clk-sscg-pll: Remove unnecessary blank lines
Message-ID: <20200318111430.ugbcekyk75yg7jh4@fsr-ub1664-175>
References: <1584495566-15110-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584495566-15110-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-18 09:39:25, Anson Huang wrote:
> Remove many unnecessary blank lines for cleanup.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-sscg-pll.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pll.c
> index d4a2be1..773d8a5 100644
> --- a/drivers/clk/imx/clk-sscg-pll.c
> +++ b/drivers/clk/imx/clk-sscg-pll.c
> @@ -72,7 +72,6 @@ struct clk_sscg_pll_setup {
>  	int divr2, divf2;
>  	int divq;
>  	int bypass;
> -
>  	uint64_t vco1;
>  	uint64_t vco2;
>  	uint64_t fout;
> @@ -86,11 +85,8 @@ struct clk_sscg_pll_setup {
>  struct clk_sscg_pll {
>  	struct clk_hw	hw;
>  	const struct clk_ops  ops;
> -
>  	void __iomem *base;
> -
>  	struct clk_sscg_pll_setup setup;
> -
>  	u8 parent;
>  	u8 bypass1;
>  	u8 bypass2;
> @@ -194,7 +190,6 @@ static int clk_sscg_pll2_find_setup(struct clk_sscg_pll_setup *setup,
>  					struct clk_sscg_pll_setup *temp_setup,
>  					uint64_t ref)
>  {
> -
>  	int ret;
>  
>  	if (ref < PLL_STAGE1_MIN_FREQ || ref > PLL_STAGE1_MAX_FREQ)
> @@ -253,7 +248,6 @@ static int clk_sscg_pll1_find_setup(struct clk_sscg_pll_setup *setup,
>  					struct clk_sscg_pll_setup *temp_setup,
>  					uint64_t ref)
>  {
> -
>  	int ret;
>  
>  	if (ref < PLL_REF_MIN_FREQ || ref > PLL_REF_MAX_FREQ)
> @@ -280,7 +274,6 @@ static int clk_sscg_pll_find_setup(struct clk_sscg_pll_setup *setup,
>  	temp_setup.fout_request = rate;
>  
>  	switch (try_bypass) {
> -
>  	case PLL_BYPASS2:
>  		if (prate == rate) {
>  			setup->bypass = PLL_BYPASS2;
> @@ -288,11 +281,9 @@ static int clk_sscg_pll_find_setup(struct clk_sscg_pll_setup *setup,
>  			ret = 0;
>  		}
>  		break;
> -
>  	case PLL_BYPASS1:
>  		ret = clk_sscg_pll2_find_setup(setup, &temp_setup, prate);
>  		break;
> -
>  	case PLL_BYPASS_NONE:
>  		ret = clk_sscg_pll1_find_setup(setup, &temp_setup, prate);
>  		break;
> @@ -301,7 +292,6 @@ static int clk_sscg_pll_find_setup(struct clk_sscg_pll_setup *setup,
>  	return ret;
>  }
>  
> -
>  static int clk_sscg_pll_is_prepared(struct clk_hw *hw)
>  {
>  	struct clk_sscg_pll *pll = to_clk_sscg_pll(hw);
> -- 
> 2.7.4
> 
