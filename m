Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC90C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E07206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgFBJuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:50:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:24935 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBJuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:50:08 -0400
IronPort-SDR: AsP1mBlZUU/nf+cfanwJ+X5VOqpG6bo3nHqte8EKdBMYvCPE6TduLLTuUvyHRHt7Z8MOJCHxyN
 CoWJgqnPCWcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:50:08 -0700
IronPort-SDR: 1wM2/0IT4DznM5UA7kHHznMwfEwhMqcBUpu+200PCHFFobW4oeFyXE/fxj0z5vp529c0n51qSi
 AmqbmEmkl6gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="377701826"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 02 Jun 2020 02:50:03 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 02 Jun 2020 12:50:03 +0300
Date:   Tue, 2 Jun 2020 12:50:03 +0300
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com, rajatxjain@gmail.com,
        pmalani@google.com, bleung@google.com, levinale@google.com,
        zsm@google.com, mnissler@google.com, tbroch@google.com
Subject: Re: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Message-ID: <20200602095003.GI247495@lahna.fi.intel.com>
References: <20200602054517.191244-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602054517.191244-1-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 10:45:17PM -0700, Rajat Jain wrote:
> Currently, an external malicious PCI device can masquerade the VID:PID
> of faulty gfx devices, and thus apply iommu quirks to effectively
> disable the IOMMU restrictions for itself.
> 
> Thus we need to ensure that the device we are applying quirks to, is
> indeed an internal trusted device.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ef0a5246700e5..f2a480168a02f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
>  
>  static void quirk_iommu_igfx(struct pci_dev *dev)
>  {
> +	if (dev->untrusted) {
> +		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");

I think you should be consistent with other messages. For example iommu
should be spelled IOMMU as done below.

Also this is visible to users so maybe put bit more information there:

  pci_warn(dev, "Will not apply IOMMU quirk for untrusted graphics device\n");

Ditto for all the other places. Also is "untrusted" good word here? If
an ordinary user sees this will it trigger some sort of panic reaction.
Perhaps we should call it "potentially untrusted" or something like
that?

> +		return;
> +	}
> +
>  	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
>  	dmar_map_gfx = 0;
