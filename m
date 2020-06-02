Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D56206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0d2Vlsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFBXtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFBXtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:49:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9FC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:49:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g5so268571pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yVZeRlHhmAp/EMedhM3eoU5f2SVcU2Jx7IPSMK+7jJA=;
        b=E0d2VlsqPj91lO5CAD8WZ5itr9frJvtu8iuXkw+qeXzjXC4Uip1vmXF8oIE1I7Ca1o
         nLnMIdg/5ZCKqU7lKZatNBkCKQGp60QG+BjHdhq5P9nAYAe/BwYvIT4s+2hf33fbtaoV
         AIJ/rWolSjpPsy1jTpCDrfDl5YKIGGgJbCrlTbKuDeK1rByox2oTrtEs2PSQOaGTTv9H
         aEHjiE2Pq+23Wn48sELeokRlGixHU8DwSOmOEOYxqZ0tK1C7/qos/NvYDJr9luTBISav
         B1ACivJy1WwLPQb/z4fxEr6civ6H5q1ub1cNpfSastZNT2OOzT2q14oDz6HEx9WhmgzB
         UW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVZeRlHhmAp/EMedhM3eoU5f2SVcU2Jx7IPSMK+7jJA=;
        b=PCCoYe4eqYVeEOIiEfgytK4jS9xqYehKUmWSxwf3oUJxYVQzMzh7IgtcKCVI7MlQU9
         cUhEcqGeIu4H3pUGGmt8/RYsox4OBBZKNV+tMR5rEoPkJ65kBo6HTNqKe+qwbP+nm3Zc
         Rwt9MsAeAA9929JHTki7VVBOsRCsHiEbnN279KqbTGhZyNGy650ltzCdrge5UQLNQqXt
         7+eSy+t6QyyZ2ZFTBStFPKdS3srgWYgu2jR862yh7F/L4aVGr2QvIsv44PE8U/N69el4
         eHOFr5egSTXzItCxp+fAtjYwDn0bpD6HsSnJtsIoNeA1nBHPQH899W0SwxB00AEMl1Zd
         pCPg==
X-Gm-Message-State: AOAM531R9avVFxttqFW2Nw+jpQiFly8OAGcaJXudf9Xfp/RAHYo8czH9
        5RT/JNZ39XdljP4GWwfyQqqloHqPn54=
X-Google-Smtp-Source: ABdhPJwhNjUMzKjWf5QCkLix8B4rbHeEW57Wy0OzwqsMIxXo0t1ac9T2bunWwjBSynyz5CU+162gow==
X-Received: by 2002:a17:90a:17e6:: with SMTP id q93mr1755037pja.133.1591141759693;
        Tue, 02 Jun 2020 16:49:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id k7sm94000pga.87.2020.06.02.16.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 16:49:18 -0700 (PDT)
Date:   Tue, 2 Jun 2020 16:49:12 -0700
From:   Prashant Malani <pmalani@google.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com, rajatxjain@gmail.com,
        bleung@google.com, levinale@google.com, zsm@google.com,
        mnissler@google.com, tbroch@google.com
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted
 devices
Message-ID: <20200602234912.GB109930@google.com>
References: <20200602232602.156049-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602232602.156049-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

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
minor suggestion: Perhaps you could use a guard clause here? It would save you
a level of indentation, and possibly allow better string splitting
(e.g keeping "untrusted PCI" together). So something like:

if (!pdev->untrusted)
	return false;

pci_warn(...);

I also hear the column limit warning is now for 100 chars [1], though
I'm not sure how it's being handled in this file.

Best regards,

-Prashant

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/process/coding-style.rst?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144

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
