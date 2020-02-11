Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB0BC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CADE2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ocHiQR2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgBKXpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:45:50 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57644 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgBKXpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/63RZIRpBax9M6SO18Oi0fU9+y2EZyC+pNdMvta4lwc=; b=ocHiQR2CMJL+s3EwRYXwd8Zqi
        aeXyyQ9iTiAJjArEuJ8zmPc7aqkYIrxzXp5wPHqGaIdtkusS1Hu6Wm/8W8fheBcAoGZpkpvF1aE75
        QLf2TpYVrQt5dsbCK8DJzzaV4BIkW7f3mclBxeIkDNfGirCPsRyuKenLsghVXIOtj0vJ7BtcmR5P0
        mQg1bbEtmLiYb8sBViWkSj+DrluPEA0Dk7OQkrkJJbjF1ntiEkBNEytB8A4PmJRr6fauaF1NgWGCy
        FbfIt4Cp32XvfOIsmVivqzc++P6S5sAMFfvhqILBW+Uvv23Kn4wxiKbAQCfQDrLSympDvyywPE8y3
        JJDGTRmwA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46604)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j1fDp-0007jp-Ak; Tue, 11 Feb 2020 23:45:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j1fDk-0000pP-8Y; Tue, 11 Feb 2020 23:45:36 +0000
Date:   Tue, 11 Feb 2020 23:45:36 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu: fix the module name for disable_bypass
 parameter
Message-ID: <20200211234536.GK25745@shell.armlinux.org.uk>
References: <1581464215-24777-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581464215-24777-1-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:36:55PM -0600, Li Yang wrote:
> Since commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module"),
> there is a side effect that the module name is changed from arm-smmu to
> arm-smmu-mod.  So the kernel parameter for disable_bypass need to be
> changed too.  Fix the Kconfig help and error message to the correct
> parameter name.

Hmm, this seems to be a user-visible change - so those of us who have
been booting with "arm-smmu.disable_bypass=0" now need to change that
depending on which kernel is being booted - which is not nice, and
makes the support side on platforms that need this kernel parameter
harder.

> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/Kconfig    | 2 +-
>  drivers/iommu/arm-smmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d2fade984999..fb54be903c60 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -415,7 +415,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>  	  hardcode the bypass disable in the code.
>  
>  	  NOTE: the kernel command line parameter
> -	  'arm-smmu.disable_bypass' will continue to override this
> +	  'arm-smmu-mod.disable_bypass' will continue to override this
>  	  config.
>  
>  config ARM_SMMU_V3
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 16c4b87af42b..2ffe8ff04393 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -512,7 +512,7 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>  		if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
>  		    (gfsr & ARM_SMMU_sGFSR_USF))
>  			dev_err(smmu->dev,
> -				"Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu.disable_bypass=0\" to allow, but this may have security implications\n",
> +				"Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu-mod.disable_bypass=0\" to allow, but this may have security implications\n",
>  				(u16)gfsynr1);
>  		else
>  			dev_err(smmu->dev,
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
