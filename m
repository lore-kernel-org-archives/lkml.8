Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06164C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E138521D91
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 07:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgDRHUH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 03:20:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:10469 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgDRHUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 03:20:06 -0400
IronPort-SDR: 7977/lFMyuCx7o7GSQsvyx5lfoVDykO9llDNq+ibCvsYc+/WvL8y/ZATPSCo+bYxMjyN9/2Jyz
 aIQhPZkCOR4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2020 00:20:06 -0700
IronPort-SDR: v4U7ZaLM9+LM2u7p33DMl/Q9y5aKxDUg2DgZ4c1DuU7wNsKShgVtoHX7Bh1ODznrzNPY89mj+t
 c4IoaU5ACLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,398,1580803200"; 
   d="scan'208";a="272653993"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2020 00:20:05 -0700
Received: from lcsmsx601.ger.corp.intel.com (10.109.210.10) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 18 Apr 2020 00:20:05 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX601.ger.corp.intel.com (10.109.210.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 18 Apr 2020 10:20:02 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sat, 18 Apr 2020 10:20:02 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Benjamin Lee <ben@b1c1l1.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: me: fix irq number stored in hw struct
Thread-Topic: [PATCH] mei: me: fix irq number stored in hw struct
Thread-Index: AQHWFOiiLxa+gQ/r/Uae7dYOsRB6uqh+ePhQ
Date:   Sat, 18 Apr 2020 07:20:02 +0000
Message-ID: <8a9bad577d4e4b019cb22e7e59f742b2@intel.com>
References: <20200417184538.349550-1-ben@b1c1l1.com>
In-Reply-To: <20200417184538.349550-1-ben@b1c1l1.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Commit 261b3e1f2a01 ("mei: me: store irq number in the hw struct.") stores
> the irq number in the hw struct before MSI is enabled.  This caused a regression
> for mei_me_synchronize_irq() waiting for the wrong irq number.  On my laptop
> this causes a hang on shutdown.  Fix the issue by storing the irq number after
> enabling MSI.

Thanks a lot for cracking this down,  this should go to stable (5.5) as well. 

We should be probably calling hw->irq = pci_irq_vector(pdev, 0);  as pci_enable_msi was deprecated. 
Will try to  address this in a follow up patch. 

> Fixes: 261b3e1f2a01 ("mei: me: store irq number in the hw struct.")
> Signed-off-by: Benjamin Lee <ben@b1c1l1.com>
> ---
>  drivers/misc/mei/pci-me.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c index
> 3d21c38e2dbb..0c390fe421ad 100644
> --- a/drivers/misc/mei/pci-me.c
> +++ b/drivers/misc/mei/pci-me.c
> @@ -203,11 +203,12 @@ static int mei_me_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  	}
>  	hw = to_me_hw(dev);
>  	hw->mem_addr = pcim_iomap_table(pdev)[0];
> -	hw->irq = pdev->irq;
>  	hw->read_fws = mei_me_read_fws;
> 
>  	pci_enable_msi(pdev);
> 
> +	hw->irq = pdev->irq;
> +
>  	 /* request and enable interrupt */
>  	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT :
> IRQF_SHARED;
> 
> --
> 2.26.1

