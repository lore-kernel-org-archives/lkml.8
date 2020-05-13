Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBBC2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9AF205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589349105;
	bh=JIVkHaAe6zIIWxhNRMgSqeXbtj4d7lTqShCIfC4OdH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DKSc9ML6fpR1/mCyfPtcDxryBlaiEeAeLm1OYdD4XdHl+niaaRasCqPLDmASZWZjc
	 FlmtljEevWztoKehCPALYOhDPLy5obORAdOF8aL34hFaKxIiHkjWrwMnd+fwqk5tJy
	 TF+mra5rv239RtNEsPWKQtRZ3rPcoq57dXBp66AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgEMFvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgEMFvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:51:44 -0400
Received: from localhost (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420BB205C9;
        Wed, 13 May 2020 05:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589349104;
        bh=JIVkHaAe6zIIWxhNRMgSqeXbtj4d7lTqShCIfC4OdH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOCeiQC7fZb1Bsc2EtNeF8a+YfrZFN/vdFkbuJuJul/K2/x9owzSrlDpFYtKu2DAj
         MPzxKYRCcQobgTGvo/Cq0ZTxy2zdlKmOND3pMvk4txaac3Gw4NQqv8i601rVA9hx/z
         8GJwA8Sxnqas3HlDBVgfXJmkpbJp0o3PTGsc544Q=
Date:   Wed, 13 May 2020 11:21:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: gcc: Add missing UFS clocks for SM8150
Message-ID: <20200513055139.GA14092@vkoul-mobl>
References: <20200424044311.2155917-1-vkoul@kernel.org>
 <20200424044311.2155917-2-vkoul@kernel.org>
 <158784189516.117437.15588556636278394035@swboyd.mtv.corp.google.com>
 <20200427045534.GB4625@vkoul-mobl.Dlink>
 <158933311835.215346.12980712108351352362@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158933311835.215346.12980712108351352362@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-20, 18:25, Stephen Boyd wrote:
> Quoting Vinod Koul (2020-04-26 21:55:34)
> > On 25-04-20, 12:11, Stephen Boyd wrote:
> > > Quoting Vinod Koul (2020-04-23 21:43:11)
> > > > Add the missing ufs card and ufs phy clocks for SM8150. They were missed
> > > > in earlier addition of clock driver.
> > > > 
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > >  drivers/clk/qcom/gcc-sm8150.c | 84 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 84 insertions(+)
> > > > 
> > > > diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> > > > index 5c3dc34c955e..4354620fa12d 100644
> > > > --- a/drivers/clk/qcom/gcc-sm8150.c
> > > > +++ b/drivers/clk/qcom/gcc-sm8150.c
> > > > @@ -2881,6 +2881,45 @@ static struct clk_branch gcc_ufs_card_phy_aux_hw_ctl_clk = {
> > > >         },
> > > >  };
> > > >  
> > > > +/* external clocks so add BRANCH_HALT_SKIP */
> > > > +static struct clk_branch gcc_ufs_card_rx_symbol_0_clk = {
> > > > +       .halt_check = BRANCH_HALT_SKIP,
> > > > +       .clkr = {
> > > > +               .enable_reg = 0x7501c,
> > > > +               .enable_mask = BIT(0),
> > > > +               .hw.init = &(struct clk_init_data){
> > > > +                       .name = "gcc_ufs_card_rx_symbol_0_clk",
> > > 
> > > Any reason to not use .fw_name?
> > 
> > Did i understand it correct that you would like these to have .fw_name
> > for parent? Should we start adding these clocks in DT description?
> 
> Sorry I misread the patch. This isn't a parent name description so .name
> is correct here.

No worries, I will add fixes and send the update

Thanks
-- 
~Vinod
