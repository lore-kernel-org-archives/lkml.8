Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8A5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD82D20663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgFBNg0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:36:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:11395 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBNgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:36:25 -0400
IronPort-SDR: bvFYyemll5sTkaRpzI1aVTMRam3WvWHb5FVhKT9AvBO3010qUbA3LX4F3A4BXhMiNxFPK+2jsG
 G+ddehdN+G0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 06:36:25 -0700
IronPort-SDR: NBeSQghNBhFX6gfvY+doY0ZyDPw4dDqR5/Hs8LXo5/2uJ8VK42VCv7OXn2DNZoegfHmCvIvTSb
 beQDtVJARb4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,464,1583222400"; 
   d="scan'208";a="286653698"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2020 06:36:24 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 06:36:24 -0700
Received: from fmsmsx108.amr.corp.intel.com ([169.254.9.97]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.185]) with mapi id 14.03.0439.000;
 Tue, 2 Jun 2020 06:35:20 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where
 appropriate
Thread-Topic: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where
 appropriate
Thread-Index: AQHWOL8clbNxZ7bnykCB8ftlNPJ+z6jFUrZg
Date:   Tue, 2 Jun 2020 13:35:20 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com>
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>Piotr Stankiewicz
>Sent: Tuesday, June 2, 2020 5:21 AM
>To: Alex Deucher <alexander.deucher@amd.com>; Christian König
><christian.koenig@amd.com>; David Zhou <David1.Zhou@amd.com>; David
>Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>
>Cc: Stankiewicz, Piotr <piotr.stankiewicz@intel.com>; dri-
>devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; linux-
>kernel@vger.kernel.org
>Subject: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where
>appropriate
>
>Seeing as there is shorthand available to use when asking for any type
>of interrupt, or any type of message signalled interrupt, leverage it.
>
>Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
>Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>index 5ed4227f304b..6dbe173a9fd4 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>@@ -251,11 +251,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
> 		int nvec = pci_msix_vec_count(adev->pdev);
> 		unsigned int flags;
>
>-		if (nvec <= 0) {
>+		if (nvec > 0)
>+			flags = PCI_IRQ_MSI_TYPES;
>+		else
> 			flags = PCI_IRQ_MSI;
>-		} else {
>-			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
>-		}

Minor nit:

Is it really necessary to set do this check?  Can flags just
be set?

I.e.: 
	flags = PCI_IRQ_MSI_TYPES;

pci_alloc_irq_vector() tries stuff in order.  If MSIX is not available,
it will try MSI.

M

>+
> 		/* we only need one vector */
> 		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> 		if (nvec > 0) {
>--
>2.17.2
>
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
