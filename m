Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A9C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065D12075E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588656088;
	bh=Y2jL3pSvPWYflkCioX814L9QG12+dvqUxYSa5B3DQp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tBVAQ/xHMHvHU01fsOuSyS1AMdm+j3PCfdLYyKuLwB30ZH6tD1l7IMOTq3eVM51Oa
	 TC75nJmJydxbZ37+/Gd5fFQvzpwZbssFoRvZU3JYMGMn3lhWBlvdxSskh5bAiL2xDA
	 1teEJ/6BljKvSLZMObVeR39S4rX5oB290c6Ctp+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEEFV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 01:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEFV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 01:21:27 -0400
Received: from localhost (unknown [171.61.99.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880C4206FA;
        Tue,  5 May 2020 05:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588656086;
        bh=Y2jL3pSvPWYflkCioX814L9QG12+dvqUxYSa5B3DQp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDbWqchGcvTFtjPTOVNucbIEpIesP5OdB7LGUFpSLW7FxtiCA8gY83OzmTfKXw0PT
         p/qCIPshq5bbEWbHKDN08JXowaeclj+PH7R+h6HkBSOA0vTTwV9fBf7JYaG1PJ7qbO
         2CHeCmY1+Td2N6K3rx/hCsQAumHFe7tnI5b9yVyM=
Date:   Tue, 5 May 2020 10:51:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Subject: Re: [PATCH v7 3/3] phy: intel: Add driver support for ComboPhy
Message-ID: <20200505052122.GW1375924@vkoul-mobl>
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
 <af8a7d7025990d22f6062953247cf80e64c6fd2f.1588230494.git.eswara.kota@linux.intel.com>
 <20200504072923.GN1375924@vkoul-mobl>
 <f12e76ac-e0fd-4afa-e1cd-2b90f175adfd@linux.intel.com>
 <20200504092034.GS1375924@vkoul-mobl>
 <0de7ba47-bc98-9267-46b4-230a86151c2d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0de7ba47-bc98-9267-46b4-230a86151c2d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-20, 17:32, Dilip Kota wrote:
> 
> On 5/4/2020 5:20 PM, Vinod Koul wrote:
> > On 04-05-20, 16:26, Dilip Kota wrote:
> > > On 5/4/2020 3:29 PM, Vinod Koul wrote:
> > > > On 30-04-20, 15:15, Dilip Kota wrote:
> > > > 
> > > > > +					  u32 mask, u32 val)
> > > > > +{
> > > > > +	u32 reg_val;
> > > > > +
> > > > > +	reg_val = readl(base + reg);
> > > > > +	reg_val &= ~mask;
> > > > > +	reg_val |= FIELD_PREP(mask, val);
> > > > > +	writel(reg_val, base + reg);
> > > > bypassing regmap here... why?
> > > It is not regmap address, one of the below two addresses are passed to this
> > > function.
> > okay, perhaps add a comment somewhere that regmap is not used for this
> > base?
> I dont see a need of adding a comment, describing don't do regmap here.

Driver uses regmap except here, which seems odd hence explanation
required for this.

> > 
> > > struct intel_combo_phy {
> > > ...
> > >          void __iomem            *app_base;
> > >          void __iomem            *cr_base;
> > > ...
> > > }
> > 
> > > > > +static int intel_cbphy_calibrate(struct phy *phy)
> > > > > +{
> > > > > +	struct intel_cbphy_iphy *iphy = phy_get_drvdata(phy);
> > > > > +	struct intel_combo_phy *cbphy = iphy->parent;
> > > > > +	void __iomem *cr_base = cbphy->cr_base;
> > > > > +	int val, ret, id;
> > > > > +
> > > > > +	if (cbphy->phy_mode != PHY_XPCS_MODE)
> > > > > +		return 0;
> > > > > +
> > > > > +	id = PHY_ID(iphy);
> > > > > +
> > > > > +	/* trigger auto RX adaptation */
> > > > > +	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
> > > > > +			       ADAPT_REQ_MSK, 3);
> > > > > +	/* Wait RX adaptation to finish */
> > > > > +	ret = readl_poll_timeout(cr_base + CR_ADDR(PCS_XF_RX_ADAPT_ACK, id),
> > > > > +				 val, val & RX_ADAPT_ACK_BIT, 10, 5000);
> > > > > +	if (ret)
> > > > > +		dev_err(cbphy->dev, "RX Adaptation failed!\n");
> > > > you want to continue her and not return error?
> > > Next step is stopping the Adaptation, it should be done in both error and
> > > success case.
> > Again documenting this helps, pls add some comments on this behaviour
> Comments are already in place, mentioning Start and Stop of Rx Adaptation.
> And Stop is being is done as Start is triggered, so not needed to mention
> error and success.

Ok

-- 
~Vinod
