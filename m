Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63723C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EE920716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584022972;
	bh=1tyFYkYNgWZaP/Fj/CSjoWSlP2yoXwZznqa1gCTEDsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zzfX4rn2bolUSRjYF9X/MzMkVc6KTnNmjX2/X2wHZL5WvMu30xoQD7/Nc/nfUOqD6
	 O+ankz/oj8YNYtTQ/NNpymuebQaIMhJxOVn3lmAJKKTMFWzImqGNkVsjLkuDeXFEpO
	 H8TlLcf9iZq52P4XZSru6x/kqFgpgynRN6X85urg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgCLOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgCLOWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:22:50 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599ED20650;
        Thu, 12 Mar 2020 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584022969;
        bh=1tyFYkYNgWZaP/Fj/CSjoWSlP2yoXwZznqa1gCTEDsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cxmt4QTznZbNnbUYifOJ+cTEHY4uVUMapdZ8bTOy2AP5cgfWMJNsKB6Nj6JVACZ6/
         JpWYLW7VciFOGnKjao0BjHdUpVdP8T5ngEbpLU7osiQfIDV2qZzAsjNshRa8zna9wk
         Q0kTyNmDaLzDBISffNgwdGxaAd3gm6r4HUzEDafw=
Date:   Thu, 12 Mar 2020 22:22:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
Message-ID: <20200312142229.GA1249@dragon>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
 <1582585690-463-8-git-send-email-leoyang.li@nxp.com>
 <20200311061220.GB29269@dragon>
 <VE1PR04MB66873A9B6773FFBF96F37C6B8FFC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66873A9B6773FFBF96F37C6B8FFC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 06:54:00PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Wednesday, March 11, 2020 1:12 AM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
> > 
> > On Mon, Feb 24, 2020 at 05:08:02PM -0600, Li Yang wrote:
> > > Enables the generic QorIQ cpufreq driver to support frequency scaling
> > > for various QorIQ SoCs.  Enabled as built-in as it is a core feature.
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > ---
> > >  arch/arm64/configs/defconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > index e97ef8b944b8..996dc749ea5c 100644
> > > --- a/arch/arm64/configs/defconfig
> > > +++ b/arch/arm64/configs/defconfig
> > > @@ -90,6 +90,7 @@ CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
> > >  CONFIG_ARM_QCOM_CPUFREQ_HW=y
> > >  CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
> > >  CONFIG_ARM_TEGRA186_CPUFREQ=y
> > > +CONFIG_QORIQ_CPUFREQ=y
> > >  CONFIG_ARM_SCPI_PROTOCOL=y
> > >  CONFIG_RASPBERRYPI_FIRMWARE=y
> > >  CONFIG_INTEL_STRATIX10_SERVICE=y
> > > @@ -722,7 +723,6 @@ CONFIG_COMMON_CLK_RK808=y
> > >  CONFIG_COMMON_CLK_SCPI=y
> > >  CONFIG_COMMON_CLK_CS2000_CP=y
> > >  CONFIG_COMMON_CLK_S2MPS11=y
> > > -CONFIG_CLK_QORIQ=y
> > 
> > Why is this getting removed?
> 
> Newly added QORIQ_CPUFREQ selects CLK_QORIQ, so it is removed by savedefconfig.

Note it in the commit log please.

Shawn
