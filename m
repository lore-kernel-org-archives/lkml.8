Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0703C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C750C2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593000810;
	bh=k5aJPIUQtuGKmsQnsAtOLsmnYCwAV+fYGVXQ7sK6b88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HhRrKE3ghmCPPmID3/J6njw3igsV2VkPMGisl4wOg8mGx4qSdWZOwC3ZxxN9POUq0
	 pdvV1NZD3tJOuCBuzgDdgciFa3ZeePwJ27Y3UH3SdovfbWoFoLA9ODEqzbrGrEFvU+
	 Iu3CEEOSqrLppNxY9KIZYo6sahVCtH7lZmZ+6inw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390395AbgFXMN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388811AbgFXMN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:13:28 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9BA62088E;
        Wed, 24 Jun 2020 12:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593000807;
        bh=k5aJPIUQtuGKmsQnsAtOLsmnYCwAV+fYGVXQ7sK6b88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkHPlmFsIMH0YQj9EeTwKg1qiipF1q8RUudWPZmSXczMMRIssKC4jBnGgX5o9Sk1A
         gqlSgqT+qZ0uwxJfYfKEzaJNgGDjhOq8/CeZepiledKAYqZMlg0vY8TyORDZ77MbTD
         TcMqBbbV2Rj+J2tdMxFtDOvXOay7yZdGklLZogTQ=
Date:   Wed, 24 Jun 2020 17:43:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] phy: intel: Eliminate unnecessary assignment in
 intel_cbphy_set_mode
Message-ID: <20200624121323.GB2324254@vkoul-mobl>
References: <20200523035043.3305846-1-natechancellor@gmail.com>
 <20200616003004.GB1307277@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616003004.GB1307277@ubuntu-n2-xlarge-x86>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-20, 17:30, Nathan Chancellor wrote:
> On Fri, May 22, 2020 at 08:50:43PM -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > drivers/phy/intel/phy-intel-combo.c:202:34: warning: implicit conversion
> > from enumeration type 'enum intel_phy_mode' to different enumeration
> > type 'enum intel_combo_mode' [-Wenum-conversion]
> >         enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
> >                               ~~~~~~~   ^~~~~~~~~~~~~
> > 1 warning generated.
> > 
> > The correct enum to use would be PCIE0_PCIE1_MODE. However, eliminating
> > this assignment is a little better because the switch statement always
> > assigns a new value to cb_mode, which also takes care of the warning.
> > 
> > Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1034
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/phy/intel/phy-intel-combo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
> > index c2a35be4cdfb..4bc1276ecf23 100644
> > --- a/drivers/phy/intel/phy-intel-combo.c
> > +++ b/drivers/phy/intel/phy-intel-combo.c
> > @@ -199,9 +199,9 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
> >  
> >  static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
> >  {
> > -	enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
> >  	enum aggregated_mode aggr = cbphy->aggr_mode;
> >  	struct device *dev = cbphy->dev;
> > +	enum intel_combo_mode cb_mode;
> >  	enum intel_phy_mode mode;
> >  	int ret;
> >  
> > 
> > base-commit: c11d28ab4a691736e30b49813fb801847bd44e83
> > -- 
> > 2.27.0.rc0
> > 
> 
> Gentle ping for review. Nick did comment that maybe keeping the
> assignment and tidying up one of the switch cases would be better but
> every maintainer has their preference. This warning has slipped into
> mainline so it would be nice to get it cleaned up.

Sorry for the delay, I have applied Anrd patch for this already and
should be in linux-next tomorrow

-- 
~Vinod
