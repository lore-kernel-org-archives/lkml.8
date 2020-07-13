Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6DEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE342075F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594621064;
	bh=XlMSuqTpDlP5SWU0u/vnLYHw1UcIUbZbzLp5CEBxgos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uj+aMTUfuCDXfI6XRM2pnqGulY3YmpeadcFz34eoYz7N/fKqu3JEYA/DiefmEZMJA
	 s3Ozxu01alrENlf3bBrcARnA3Cr3lbN1L7mjV26SgO8/fnUr9i7lk6bmVtDwRcSMVw
	 SsSOMXKmnoBBt6oheyRx1QEqN5LhP624AQZP51qM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgGMGRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgGMGRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:17:42 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16AD92065F;
        Mon, 13 Jul 2020 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594621062;
        bh=XlMSuqTpDlP5SWU0u/vnLYHw1UcIUbZbzLp5CEBxgos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNl3g7zAwv+h/dlFGVcJySB7qXgYhqSUXJL0PPfLcAGCk3tLLFl2RrRafkjXCinex
         QWnlowxFpGmoM2BSqp7SB5VYvrvyQSy5jbs96BqZRi0TjzeaYVt/IO+21BwLCy8xUg
         mzPQZ8Cj5k1e2eVM/4sghR236HDiiMZa9F51B2i0=
Date:   Mon, 13 Jul 2020 11:47:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     robh+dt@kernel.org, krzk@kernel.org, kwmad.kim@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kishon@ti.com
Subject: Re: [PATCH v12 2/2] phy: samsung-ufs: add UFS PHY driver for samsung
 SoC
Message-ID: <20200713061737.GD34333@vkoul-mobl>
References: <20200703171135.77389-1-alim.akhtar@samsung.com>
 <CGME20200703173144epcas5p1daa9f5c594e7f299638cc75b7425b7c8@epcas5p1.samsung.com>
 <20200703171135.77389-2-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703171135.77389-2-alim.akhtar@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-20, 22:41, Alim Akhtar wrote:

> +static const struct samsung_ufs_phy_cfg exynos7_post_init_cfg[] = {
> +	END_UFS_PHY_CFG
> +};

This is dummy, why not add a check to make config optional?

> +static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy *phy)
> +{
> +	int ret = 0;

superfluous init, am sure I flagged it before as well

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
> +		dev_err(phy->dev, "%s: tx0_symbol_clk enable failed %d\n", __func__, ret);
> +		goto out;
> +	}
> +
> +	ret = clk_prepare_enable(phy->rx0_symbol_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: rx0_symbol_clk enable failed %d\n", __func__, ret);
> +		clk_disable_unprepare(phy->tx0_symbol_clk);
> +		goto out;
> +	}
> +
> +	ret = clk_prepare_enable(phy->rx1_symbol_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: rx1_symbol_clk enable failed %d\n", __func__, ret);
> +		clk_disable_unprepare(phy->tx0_symbol_clk);
> +		clk_disable_unprepare(phy->rx0_symbol_clk);

maybe it will look better if we add common rollback and jump to proper
labels

> +static int samsung_ufs_phy_clks_init(struct samsung_ufs_phy *phy)
> +{
> +	int ret;
> +
> +	phy->ref_clk = devm_clk_get(phy->dev, "ref_clk");
> +	if (IS_ERR(phy->ref_clk))
> +		dev_err(phy->dev, "failed to get ref_clk clock\n");
> +
> +	ret = clk_prepare_enable(phy->ref_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: ref_clk enable failed %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	dev_info(phy->dev, "UFS MPHY ref_clk_rate = %ld\n", clk_get_rate(phy->ref_clk));

debug pls

> +static int samsung_ufs_phy_init(struct phy *phy)
> +{
> +	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);

ss_phy perhaps?

> +	int ret;
> +
> +	_phy->lane_cnt = phy->attrs.bus_width;
> +	_phy->ufs_phy_state = CFG_PRE_INIT;
> +
> +	if (_phy->drvdata->has_symbol_clk) {
> +		ret = samsung_ufs_phy_symbol_clk_init(_phy);
> +		if (ret)
> +			dev_err(_phy->dev, "failed to set ufs phy symbol clocks\n");
> +	}
> +
> +	ret = samsung_ufs_phy_clks_init(_phy);
> +	if (ret)
> +		dev_err(_phy->dev, "failed to set ufs phy  clocks\n");
> +
> +	samsung_ufs_phy_calibrate(phy);
> +
> +	return 0;

not return samsung_ufs_phy_calibrate() ?
-- 
~Vinod
