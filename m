Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955F9206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFCFaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:30:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:4706 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgFCFaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:30:20 -0400
IronPort-SDR: zlIeaoElXAlV2yUpUWHRgJ4dTgkKLKdpyEG/juLXYmjf+sA3PRKgiHuGfit5nr+lsRcy1Ga4j+
 zfrPUHtAoeyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 22:30:13 -0700
IronPort-SDR: 0cWYtPZtBHwgk1szY2u3scGNdBUAiggIUcHJKs3Tae7sEL3mHr97A1ldF8/iuLLoTu0Z8e7ecn
 HOqM/ahP/yKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="377986062"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 02 Jun 2020 22:30:08 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Jun 2020 08:30:08 +0300
Date:   Wed, 3 Jun 2020 08:30:08 +0300
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
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted
 devices
Message-ID: <20200603053008.GR247495@lahna.fi.intel.com>
References: <20200602232602.156049-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602232602.156049-1-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> +static bool risky_device(struct pci_dev *pdev)
> +{
> +	if (pdev->untrusted) {
> +		pci_warn(pdev,
> +			 "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> +			 " PCI link. Please check with your BIOS/Platform"
> +			 " vendor about this\n", pdev->vendor, pdev->device);

You should not break user visible strings like this. It makes grepping
for them harder (see also CodingStyle). You can write it like this instead:

	pci_info(pdev, "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted PCI link\n",
		 pdev->vendor, pdev->device);
	pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");

Also I guess pci_info() might be better here after all. Your call :)

Rest of the patch looks good to me.
