Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9A2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073CB2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594364875;
	bh=BvkMbxF8p9ePOnvbDwQMRLRHfDMC+k2cTE5KGnfyFng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tdR3g/wK511Yd+gQPC36/sVk149T8M9TVp6454sD3FrLvzf0ceQDRk12OfTkmn8ma
	 Azs5/bP+jQok1ryKz2LWy0D/YNkzW651IWCO3WBWnWo4ImP26XHyZg8PiLY+5Yf1hb
	 ZSB+HQCxaw4/fpOUcgxf7cMt9ru0s0t9WDnIBiJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGJHHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgGJHHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:07:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA2F2077D;
        Fri, 10 Jul 2020 07:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594364873;
        bh=BvkMbxF8p9ePOnvbDwQMRLRHfDMC+k2cTE5KGnfyFng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCCem0174HgReRB61ts5VlAlIeO+QeUb/sV0BQxtHfpKxM1rG4NrUlteBpeJAyxVu
         ym0TsOmbs6X1RR5CMGGscMyLfS28nNieP+1CNrxfL6ZGDJ/ihQImwH194/EgR2bkdw
         14ngeh+5rTgzYtWVqM/DToyzddPm8JDcyRNNZoFw=
Date:   Fri, 10 Jul 2020 09:07:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
Message-ID: <20200710070758.GB1176018@kroah.com>
References: <20200617035818.54110-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200617035818.54110-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <87blknrjg6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blknrjg6.fsf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:08:09AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> "Ramuthevar,Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> writes:
> 
> > From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >
> > Add support for USB PHY on Intel LGM SoC.
> >
> > Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> > ---
> >  drivers/usb/phy/Kconfig       |  11 ++
> >  drivers/usb/phy/Makefile      |   1 +
> >  drivers/usb/phy/phy-lgm-usb.c | 275 ++++++++++++++++++++++++++++++++++++++++++
> 
> new phy drivers should use drivers/phy instead.

Can we move all of the existing usb/phy drivers there too?

thanks,

greg k-h
