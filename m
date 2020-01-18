Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD3C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 00:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FE72468D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 00:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579306732;
	bh=gSDrQaOdpG8so50JR4QbBrnND0Qmuf7RzbL8om1tDgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=xYVlp/eeRlIe0JT7WONCVd2SPhJXY4pN4V523dMzhFa8Zi78mTRFrHurJWESoSzDP
	 yszpTLolaKfVQXiJuvjn3zoAdYCkkMzJT0FAWQRlpTF2KGR/jolar58OPvAzior6xZ
	 6swb3WG5KTHu0NvwFWk6nRJ1tvO++BC4grojHX6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgARASv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 19:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgARASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 19:18:50 -0500
Received: from localhost (187.sub-174-234-133.myvzw.com [174.234.133.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC9C22464;
        Sat, 18 Jan 2020 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579306730;
        bh=gSDrQaOdpG8so50JR4QbBrnND0Qmuf7RzbL8om1tDgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I8Exl2NrIfZJx/X2Mt2KL0FoOsXTjdC21eetR92F+Y9kZLZbLE23+TCDiAiKJhTg5
         pCrNxmdwgJum+wwghrjSuZFGYcU4J+H8o/KM119A/wm8fFlDtvQB6Nfa7GOXgMneWP
         LLjtiZuvzf4qg0B9hR2l9Cqvoq8emb1A+LwDS67k=
Date:   Fri, 17 Jan 2020 18:18:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for
 iommu passthrough
Message-ID: <20200117232403.GA142078@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101052648.14295-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 01:26:46PM +0800, Lu Baolu wrote:
> The new parameter takes a list of devices separated by a semicolon.
> Each device specified will have its iommu_passthrough bit in struct
> device set. This is very similar to the existing 'disable_acs_redir'
> parameter.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++
>  drivers/pci/pci.c                             | 34 +++++++++++++++++++
>  drivers/pci/pci.h                             |  1 +
>  drivers/pci/probe.c                           |  2 ++
>  4 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..d3edc2cb6696 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3583,6 +3583,11 @@
>  				may put more devices in an IOMMU group.
>  		force_floating	[S390] Force usage of floating interrupts.
>  		nomio		[S390] Do not use MIO instructions.
> +		iommu_passthrough=<pci_dev>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) separated by semicolons.
> +				Each device specified will bypass IOMMU DMA
> +				translation.
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 90dbd7c70371..05bf3f4acc36 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6401,6 +6401,37 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_fixup_cardbus);
>  
> +static const char *iommu_passthrough_param;
> +bool pci_iommu_passthrough_match(struct pci_dev *dev)
> +{
> +	int ret = 0;
> +	const char *p = iommu_passthrough_param;
> +
> +	if (!p)
> +		return false;
> +
> +	while (*p) {
> +		ret = pci_dev_str_match(dev, p, &p);
> +		if (ret < 0) {
> +			pr_info_once("PCI: Can't parse iommu_passthrough parameter: %s\n",
> +				     iommu_passthrough_param);
> +
> +			break;
> +		} else if (ret == 1) {
> +			pci_info(dev, "PCI: IOMMU passthrough\n");
> +			return true;
> +		}
> +
> +		if (*p != ';' && *p != ',') {
> +			/* End of param or invalid format */
> +			break;
> +		}
> +		p++;
> +	}
> +
> +	return false;
> +}

This duplicates a lot of the code in pci_disable_acs_redir().  That
needs to be factored out somehow so we don't duplicate it.

Bjorn
