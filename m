Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA16C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D65D20735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588577373;
	bh=RVrLaZjhLOD6uwD5aubD0n/GFXSYLoQc9WAUH62n6gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HTq9Thmq82Mc9MG+ybWWmOaGrhPKM8PfMjFRefumup39+ceXpUua2aI81ZRgk9hF9
	 HnKb5xqkm8vvmYBkjni4AMQIvyMW+Qa99RKZFHVLme2qSL+dSoZMIvPLcmEnv6iFm5
	 c2nA5lCeCeR3mNJG7yWMyVlqwTMsMNJ7Qj3ywwVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgEDH3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgEDH3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:29:32 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281522075B;
        Mon,  4 May 2020 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588577371;
        bh=RVrLaZjhLOD6uwD5aubD0n/GFXSYLoQc9WAUH62n6gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOTaLk5xOoJcVIpzluCt8uxCroCS7M7qK5Fj4Yt6KaHGYUldVFsJO+fpnfSwOZ/tb
         q4ZymWNMGM7aOQdS58RmzZRaAVyuS1/KYrOnY8vKIrAVZlmEib+fDC22uGzIqE81hs
         ak8CKQKIADfbCGPwf8iwSKo/F8/jtDVqEqPX2iGA=
Date:   Mon, 4 May 2020 12:59:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Subject: Re: [PATCH v7 3/3] phy: intel: Add driver support for ComboPhy
Message-ID: <20200504072923.GN1375924@vkoul-mobl>
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
 <af8a7d7025990d22f6062953247cf80e64c6fd2f.1588230494.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8a7d7025990d22f6062953247cf80e64c6fd2f.1588230494.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-04-20, 15:15, Dilip Kota wrote:

> +enum {
> +	PHY_0,
> +	PHY_1,
> +	PHY_MAX_NUM

PHY_MAX_NUM = PHY_1?

> +static inline void combo_phy_w32_off_mask(void __iomem *base, unsigned int reg,
> +					  u32 mask, u32 val)
> +{
> +	u32 reg_val;
> +
> +	reg_val = readl(base + reg);
> +	reg_val &= ~mask;
> +	reg_val |= FIELD_PREP(mask, val);
> +	writel(reg_val, base + reg);

bypassing regmap here... why?

> +static int intel_cbphy_calibrate(struct phy *phy)
> +{
> +	struct intel_cbphy_iphy *iphy = phy_get_drvdata(phy);
> +	struct intel_combo_phy *cbphy = iphy->parent;
> +	void __iomem *cr_base = cbphy->cr_base;
> +	int val, ret, id;
> +
> +	if (cbphy->phy_mode != PHY_XPCS_MODE)
> +		return 0;
> +
> +	id = PHY_ID(iphy);
> +
> +	/* trigger auto RX adaptation */
> +	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
> +			       ADAPT_REQ_MSK, 3);
> +	/* Wait RX adaptation to finish */
> +	ret = readl_poll_timeout(cr_base + CR_ADDR(PCS_XF_RX_ADAPT_ACK, id),
> +				 val, val & RX_ADAPT_ACK_BIT, 10, 5000);
> +	if (ret)
> +		dev_err(cbphy->dev, "RX Adaptation failed!\n");

you want to continue her and not return error?
-- 
~Vinod
