Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169112067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgFBX2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:28:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:38173 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgFBX2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:28:51 -0400
IronPort-SDR: H7+PLikNW0S3HMJ2m+Ebu9YD1SE4din8SYPrT0OYbojWxRckn26ZM2RlxX1hyf3Kjtoyj/TDKD
 4VzrtxakNahw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 16:28:51 -0700
IronPort-SDR: OKjQEHjHSnkvSt2tRndVRvOSocqBUBfTrLaYv+V4qnwAfjFhPzrPDaLEvqVzCuAVrFxWPL3j6b
 gTYN6yObRsVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="257269222"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2020 16:28:49 -0700
Date:   Tue, 2 Jun 2020 16:28:49 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@intel.com>,
        lalithambika.krishnakumar@intel.com, rajatxjain@gmail.com,
        pmalani@google.com, bleung@google.com, levinale@google.com,
        zsm@google.com, mnissler@google.com, tbroch@google.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted
 devices
Message-ID: <20200602232849.GA17696@otc-nc-03>
References: <20200602232602.156049-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602232602.156049-1-rajatja@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> Currently, an external malicious PCI device can masquerade the VID:PID
> of faulty gfx devices, and thus apply iommu quirks to effectively
> disable the IOMMU restrictions for itself.
> 
> Thus we need to ensure that the device we are applying quirks to, is
> indeed an internal trusted device.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

With these changes

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> ---
> v3: - Separate out the warning mesage in a function to be called from
>       other places. Change the warning string as suggested.
> v2: - Change the warning print strings.
>     - Add Lu Baolu's acknowledgement.
> 
>  drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ef0a5246700e5..dc859f02985a0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6185,6 +6185,23 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
>  	return ret;
>  }
>  
> +/*
> + * Check that the device does not live on an external facing PCI port that is
> + * marked as untrusted. Such devices should not be able to apply quirks and
> + * thus not be able to bypass the IOMMU restrictions.
> + */
> +static bool risky_device(struct pci_dev *pdev)
> +{
> +	if (pdev->untrusted) {
> +		pci_warn(pdev,
> +			 "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> +			 " PCI link. Please check with your BIOS/Platform"
> +			 " vendor about this\n", pdev->vendor, pdev->device);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  const struct iommu_ops intel_iommu_ops = {
>  	.capable		= intel_iommu_capable,
>  	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -6214,6 +6231,9 @@ const struct iommu_ops intel_iommu_ops = {
>  
>  static void quirk_iommu_igfx(struct pci_dev *dev)
>  {
> +	if (risky_device(dev))
> +		return;
> +
>  	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
>  	dmar_map_gfx = 0;
>  }
> @@ -6255,6 +6275,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
>  
>  static void quirk_iommu_rwbf(struct pci_dev *dev)
>  {
> +	if (risky_device(dev))
> +		return;
> +
>  	/*
>  	 * Mobile 4 Series Chipset neglects to set RWBF capability,
>  	 * but needs it. Same seems to hold for the desktop versions.
> @@ -6285,6 +6308,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>  {
>  	unsigned short ggc;
>  
> +	if (risky_device(dev))
> +		return;
> +
>  	if (pci_read_config_word(dev, GGC, &ggc))
>  		return;
>  
> @@ -6318,6 +6344,12 @@ static void __init check_tylersburg_isoch(void)
>  	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
>  	if (!pdev)
>  		return;
> +
> +	if (risky_device(pdev)) {
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
>  	pci_dev_put(pdev);
>  
>  	/* System Management Registers. Might be hidden, in which case
> @@ -6327,6 +6359,11 @@ static void __init check_tylersburg_isoch(void)
>  	if (!pdev)
>  		return;
>  
> +	if (risky_device(pdev)) {
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
>  	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
>  		pci_dev_put(pdev);
>  		return;
> -- 
> 2.27.0.rc2.251.g90737beb825-goog
> 
