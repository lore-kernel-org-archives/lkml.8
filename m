Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF8C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7247E207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594876284;
	bh=fVIx7exM1IL4il1EvPnQv2j2V1fBwT20/XpSLo7h7UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k7XOKpvUrNaPmR0Ecm6yhuB5yC03rFGYsk2GKaUpHmBpxuL1IWDmpTs0AyVcd/Q/o
	 OW24kCZHE2s15DcvjRCHOyD8zY8I15saUwtudeB7C3jTw9xid+YpIsshBlFYwEFvK4
	 Nrw41q7WiFXuU+7kyNA3n0xgjiCSwKgroblOyp40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGPFLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgGPFLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:11:23 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A226F207BC;
        Thu, 16 Jul 2020 05:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594876282;
        bh=fVIx7exM1IL4il1EvPnQv2j2V1fBwT20/XpSLo7h7UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFfk/MgqkxjA56TqPGaFqo3E5C+UKWoOOglSrFeYYnF/KgHxASQLgFomcd5uiZvRb
         KnNUejif5jQf0QE3YNyKokUBewlqLrdf4a21iJIb4jysDeBRgzJAEwe0TvHtfyjslP
         1+XQ67ae0Mr7Gra1wG7mGb56g1/D8m4H820f5Yko=
Date:   Thu, 16 Jul 2020 10:41:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     robh+dt@kernel.org, krzk@kernel.org, kwmad.kim@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kishon@ti.com
Subject: Re: [PATCH v12 2/2] phy: samsung-ufs: add UFS PHY driver for samsung
 SoC
Message-ID: <20200716051118.GB55478@vkoul-mobl>
References: <20200703171135.77389-1-alim.akhtar@samsung.com>
 <CGME20200703173144epcas5p1daa9f5c594e7f299638cc75b7425b7c8@epcas5p1.samsung.com>
 <20200703171135.77389-2-alim.akhtar@samsung.com>
 <20200713061737.GD34333@vkoul-mobl>
 <077501d65b0e$e1630100$a4290300$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077501d65b0e$e1630100$a4290300$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alim,

On 16-07-20, 06:47, Alim Akhtar wrote:

> > > +static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy
> > > +*phy) {
> > > +	int ret = 0;
> > 
> > superfluous init, am sure I flagged it before as well
> > 
> Yes, you did, but 0-DAY CI kernel test gave warning [1], so I kept this as
> it is.
> [1] https://lkml.org/lkml/2020/7/3/81

But you moved away from return below to goto, so that is no longer
the case. First use of ret is for clk_prepare_enable() call below which
is not conditional hence this is superfluous. Earlier it was not as it was
conditional so required to be initialized

> 
> > > +
> > > +	phy->tx0_symbol_clk = devm_clk_get(phy->dev, "tx0_symbol_clk");
> > > +	if (IS_ERR(phy->tx0_symbol_clk)) {
> > > +		dev_err(phy->dev, "failed to get tx0_symbol_clk clock\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	phy->rx0_symbol_clk = devm_clk_get(phy->dev, "rx0_symbol_clk");
> > > +	if (IS_ERR(phy->rx0_symbol_clk)) {
> > > +		dev_err(phy->dev, "failed to get rx0_symbol_clk clock\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
> > > +	if (IS_ERR(phy->rx0_symbol_clk)) {
> > > +		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	ret = clk_prepare_enable(phy->tx0_symbol_clk);
> > > +	if (ret) {
> > > +		dev_err(phy->dev, "%s: tx0_symbol_clk enable failed %d\n",
> > __func__, ret);
> > > +		goto out;
> > > +	}
-- 
~Vinod
