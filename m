Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1327220674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBHPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:15:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:53751 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgFBHPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:15:19 -0400
IronPort-SDR: PUUCL+eaq9mt53odhXHwGPwUGd8BQF6cDkODy8Z9lHcYv9gCUdUUHAvzxsYun7S/ePqPUDxPGU
 vXqi7oiTpBWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 00:15:18 -0700
IronPort-SDR: YBIAVbKL6Ewx0Yi4csv6WAPag/FZJw60XWTNrwPx9dLJoGlLBFbfyACfaPaeNkKAcrK4fOP4o5
 IHzxlehO/Uvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="286547216"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.17]) ([10.255.30.17])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2020 00:15:13 -0700
Cc:     baolu.lu@linux.intel.com, rajatxjain@gmail.com, pmalani@google.com,
        bleung@google.com, levinale@google.com, zsm@google.com,
        mnissler@google.com, tbroch@google.com
Subject: Re: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To:     Rajat Jain <rajatja@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com
References: <20200602054517.191244-1-rajatja@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ad238863-bef8-99bf-38c7-5839af1647e5@linux.intel.com>
Date:   Tue, 2 Jun 2020 15:15:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602054517.191244-1-rajatja@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/2 13:45, Rajat Jain wrote:
> Currently, an external malicious PCI device can masquerade the VID:PID
> of faulty gfx devices, and thus apply iommu quirks to effectively
> disable the IOMMU restrictions for itself.
> 
> Thus we need to ensure that the device we are applying quirks to, is
> indeed an internal trusted device.
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>   drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ef0a5246700e5..f2a480168a02f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
>   
>   static void quirk_iommu_igfx(struct pci_dev *dev)
>   {
> +	if (dev->untrusted) {
> +		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
> +		return;
> +	}
> +
>   	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
>   	dmar_map_gfx = 0;
>   }
> @@ -6255,6 +6260,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
>   
>   static void quirk_iommu_rwbf(struct pci_dev *dev)
>   {
> +	if (dev->untrusted) {
> +		pci_warn(dev, "skipping iommu quirk for untrusted dev\n");
> +		return;
> +	}
> +
>   	/*
>   	 * Mobile 4 Series Chipset neglects to set RWBF capability,
>   	 * but needs it. Same seems to hold for the desktop versions.
> @@ -6285,6 +6295,11 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>   {
>   	unsigned short ggc;
>   
> +	if (dev->untrusted) {
> +		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
> +		return;
> +	}
> +
>   	if (pci_read_config_word(dev, GGC, &ggc))
>   		return;
>   
> @@ -6318,6 +6333,13 @@ static void __init check_tylersburg_isoch(void)
>   	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
>   	if (!pdev)
>   		return;
> +
> +	if (pdev->untrusted) {
> +		pci_warn(pdev, "skipping iommu quirk due to untrusted dev\n");
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
>   	pci_dev_put(pdev);
>   
>   	/* System Management Registers. Might be hidden, in which case
> @@ -6327,6 +6349,12 @@ static void __init check_tylersburg_isoch(void)
>   	if (!pdev)
>   		return;
>   
> +	if (pdev->untrusted) {
> +		pci_warn(pdev, "skipping iommu quirk due to untrusted dev\n");
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
>   	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
>   		pci_dev_put(pdev);
>   		return;
> 
