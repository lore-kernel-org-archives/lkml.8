Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4443C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6F824654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582077773;
	bh=zZgKpAVTcS0HFTReo92vS7ROv9M5SlQjFcvItuZaouo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q2qsp39CAUIkHZrcWXCCjFUeSk5ZOmjhFFfUYwgtnm74w8j5LKidmceVeZM6cy8ED
	 9zvpR4gws9VMkIhiTfgcY5T43ISksyN0IdOOLWQ4+KgdlteN6Wnj9HRgsMWs6ZoBPl
	 0aHubo06+vdgxeBa3eiIuoGkgfJnNPvt4jN62LEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBSCCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:02:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgBSCCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:02:52 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 458AC206DB;
        Wed, 19 Feb 2020 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582077771;
        bh=zZgKpAVTcS0HFTReo92vS7ROv9M5SlQjFcvItuZaouo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCDvIX5ESx+/fv2GnQodDCuhBF3i33bgdk0P29bY4M65DN6YnkPaUL8Eq89/mUfa9
         CHCnzIHCRkXPfC8R9b8lqwJyoRn5SpyfY3uDcf36X2cHocrVtDhl00zts6aYUhpUqg
         8rZ+Sis0tKo+8K56bw/I3farjiXEOpmhwXx5QUfI=
Date:   Wed, 19 Feb 2020 10:02:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: defconfig: enable additional drivers needed
 by NXP QorIQ boards
Message-ID: <20200219020244.GG6075@dragon>
References: <1581382559-18520-1-git-send-email-leoyang.li@nxp.com>
 <1581382559-18520-2-git-send-email-leoyang.li@nxp.com>
 <20200217053730.GB6042@dragon>
 <VE1PR04MB668774D60323E11C7FF1FF7F8F110@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB668774D60323E11C7FF1FF7F8F110@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:44:09PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Sunday, February 16, 2020 11:38 PM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/2] arm64: defconfig: enable additional drivers needed
> > by NXP QorIQ boards
> > 
> > On Mon, Feb 10, 2020 at 06:55:59PM -0600, Li Yang wrote:
> > > This enables the following SoC device drivers for NXP/FSL QorIQ SoCs:
> > > CONFIG_QORIQ_CPUFREQ=y
> > > CONFIG_NET_SWITCHDEV=y
> > > CONFIG_MSCC_OCELOT_SWITCH=y
> > > CONFIG_CAN=m
> > > CONFIG_CAN_FLEXCAN=m
> > > CONFIG_FSL_MC_BUS=y
> > > CONFIG_MTD_NAND_FSL_IFC=y
> > > CONFIG_FSL_ENETC=y
> > > CONFIG_FSL_ENETC_VF=y
> > > CONFIG_SPI_FSL_LPSPI=y
> > > CONFIG_SPI_FSL_QUADSPI=y
> > > CONFIG_SPI_FSL_DSPI=y
> > > CONFIG_GPIO_MPC8XXX=y
> > > CONFIG_ARM_SBSA_WATCHDOG=y
> > > CONFIG_DRM_MALI_DISPLAY=m
> > > CONFIG_FSL_MC_DPIO=y
> > > CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
> > > CONFIG_FSL_DPAA=y
> > > CONFIG_FSL_FMAN=y
> > > CONFIG_FSL_DPAA_ETH=y
> > > CONFIG_FSL_DPAA2_ETH=y
> > >
> > > And the drivers for on-board devices for the upstreamed QorIQ
> > > reference
> > > boards:
> > > CONFIG_MTD_CFI=y
> > > CONFIG_MTD_CFI_ADV_OPTIONS=y
> > > CONFIG_MTD_CFI_INTELEXT=y
> > > CONFIG_MTD_CFI_AMDSTD=y
> > > CONFIG_MTD_CFI_STAA=y
> > > CONFIG_MTD_PHYSMAP=y
> > > CONFIG_MTD_PHYSMAP_OF=y
> > > CONFIG_MTD_DATAFLASH=y
> > > CONFIG_MTD_SST25L=y
> > > CONFIG_EEPROM_AT24=m
> > > CONFIG_RTC_DRV_DS1307=y
> > > CONFIG_RTC_DRV_PCF85363=y
> > > CONFIG_RTC_DRV_PCF2127=y
> > > CONFIG_E1000=y
> > > CONFIG_AQUANTIA_PHY=y
> > > CONFIG_MICROSEMI_PHY=y
> > > CONFIG_VITESSE_PHY=y
> > > CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
> > > CONFIG_MUX_MMIO=y
> > >
> > > The following two options are implied by new options and removed from
> > > defconfig:
> > > CONFIG_CLK_QORIQ=y
> > > CONFIG_MEMORY=y
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > 
> > This is too much change in a single patch. It should be split properly to make
> > review and merge easier, considering arm-soc folks are cautious to those 'y'
> > options.
> 
> Ok.  So probably separating them based on different subsystems will be good?  It would be too many patches if I separate for each individual config option.

Yep, subsystem should be good.  And for those 'y' options, please state
why they need necessarily to be 'y'.

Shawn
