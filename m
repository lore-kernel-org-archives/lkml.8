Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18BEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7783220663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593586400;
	bh=dXBhHEPls7hLBapRWS5AGMEC2erUdD9Csqr28fSP9pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XQ8yLlQw1H7Zwkimt2vmD9Yd/Gv6uoRuTLwp4Nue+4BPCcGR+eQwDfOCm/l8yDrm7
	 n2FmdO3UsXhQVbsm6e2ys3QFcK//iyLACzPffqeQSRBeG12Jf/JenI11ZPZtJYNM/B
	 9mKQjg751r5fyiJlIqgAoIrna/TCCmWx7uK62BrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGAGxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGAGxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:53:17 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CF220663;
        Wed,  1 Jul 2020 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593586396;
        bh=dXBhHEPls7hLBapRWS5AGMEC2erUdD9Csqr28fSP9pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8eB5xTvyZai8hXpd1pcdc0CHm9taDe6vDGfPYx7sXpwjVz6r8ExHPUmXgBS8QhTm
         ayonsd3cJSSzuIZSGVuDce2UEWd0NYgViIxwqpz5gu0hKCi+y2ptcujuKz3Iv9h/aI
         cAZ8r14PQlW36iTVEBtUIUWAPVvSOx26j3Ocs5gE=
Date:   Wed, 1 Jul 2020 12:23:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     robh+dt@kernel.org, krzk@kernel.org, kwmad.kim@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kishon@ti.com
Subject: Re: [RESEND PATCH v10 2/2] phy: samsung-ufs: add UFS PHY driver for
 samsung SoC
Message-ID: <20200701065310.GX2599@vkoul-mobl>
References: <20200624235631.11232-1-alim.akhtar@samsung.com>
 <CGME20200625001545epcas5p2127fb1fac70397d9c23a1246cc86f753@epcas5p2.samsung.com>
 <20200624235631.11232-2-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624235631.11232-2-alim.akhtar@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alim,

On 25-06-20, 05:26, Alim Akhtar wrote:

> +int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy)

static ?

> +{
> +	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
> +	const unsigned int timeout_us = 100000;
> +	const unsigned int sleep_us = 10;
> +	u32 val;
> +	int err;
> +
> +	err = readl_poll_timeout(
> +			ufs_phy->reg_pma + PHY_APB_ADDR(PHY_PLL_LOCK_STATUS),
> +			val, (val & PHY_PLL_LOCK_BIT), sleep_us, timeout_us);
> +	if (err) {
> +		dev_err(ufs_phy->dev,
> +			"failed to get phy pll lock acquisition %d\n", err);
> +		goto out;
> +	}
> +
> +	err = readl_poll_timeout(
> +			ufs_phy->reg_pma + PHY_APB_ADDR(PHY_CDR_LOCK_STATUS),
> +			val, (val & PHY_CDR_LOCK_BIT), sleep_us, timeout_us);
> +	if (err) {
> +		dev_err(ufs_phy->dev,
> +			"failed to get phy cdr lock acquisition %d\n", err);
> +		goto out;

this one can be dropped

> +	}
> +
> +out:
> +	return err;
> +}
> +
> +int samsung_ufs_phy_calibrate(struct phy *phy)

static?

> +{
> +	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
> +	struct samsung_ufs_phy_cfg **cfgs = ufs_phy->cfg;
> +	const struct samsung_ufs_phy_cfg *cfg;
> +	int i;
> +	int err = 0;

err before i would make it look better

> +
> +	if (unlikely(ufs_phy->ufs_phy_state < CFG_PRE_INIT ||
> +		     ufs_phy->ufs_phy_state >= CFG_TAG_MAX)) {
> +		dev_err(ufs_phy->dev, "invalid phy config index %d\n",
> +							ufs_phy->ufs_phy_state);

single line now?

> +		return -EINVAL;
> +	}
> +
> +	if (ufs_phy->is_pre_init)
> +		ufs_phy->is_pre_init = false;

that sounds bit strange, you clear it if set? Can you explain what is
going on here, and add comments

> +static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy *phy)
> +{
> +	int ret = 0;

superfluous init

> +
> +	phy->tx0_symbol_clk = devm_clk_get(phy->dev, "tx0_symbol_clk");
> +	if (IS_ERR(phy->tx0_symbol_clk)) {
> +		dev_err(phy->dev, "failed to get tx0_symbol_clk clock\n");
> +		goto out;
> +	}
> +
> +	phy->rx0_symbol_clk = devm_clk_get(phy->dev, "rx0_symbol_clk");
> +	if (IS_ERR(phy->rx0_symbol_clk)) {
> +		dev_err(phy->dev, "failed to get rx0_symbol_clk clock\n");
> +		goto out;
> +	}
> +
> +	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
> +	if (IS_ERR(phy->rx0_symbol_clk)) {
> +		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
> +		goto out;
> +	}
> +
> +	ret = clk_prepare_enable(phy->tx0_symbol_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: tx0_symbol_clk enable failed %d\n",
> +				__func__, ret);
> +		goto out;
> +	}
> +	ret = clk_prepare_enable(phy->rx0_symbol_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: rx0_symbol_clk enable failed %d\n",
> +				__func__, ret);

so we keep tx0_symbol_clk enabled when bailing out?

> +		goto out;
> +	}
> +	ret = clk_prepare_enable(phy->rx1_symbol_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: rx1_symbol_clk enable failed %d\n",
> +				__func__, ret);

here as well

> +static int samsung_ufs_phy_init(struct phy *phy)
> +{
> +	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
> +	int ret;
> +
> +	_phy->lane_cnt = phy->attrs.bus_width;
> +	_phy->ufs_phy_state = CFG_PRE_INIT;
> +
> +	/**
> +	 * In ufs, PHY need to be calibrated at different stages / state
> +	 * mainly before Linkstartup, after Linkstartup, before power
> +	 * mode change and after power mode change.
> +	 * Below state machine initialize the initial state to handle
> +	 * PHY calibration at various stages of UFS initialization and power
> +	 * mode changes
> +	 */
> +	_phy->is_pre_init = true;
> +	_phy->is_post_init = false;
> +	_phy->is_pre_pmc = false;
> +	_phy->is_post_pmc = false;

hmm why not have phy_state and assign that
pre_init/post_init/pre_pmc/post_pmc states?

> +static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
> +					enum phy_mode mode, int submode)

pls align this to preceding line opening brace (tip: checkpatch with
--strict can tell you about these)
-- 
~Vinod
