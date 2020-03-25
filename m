Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F29C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8B420772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCYNLN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:11:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:31955 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgCYNLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:11:13 -0400
IronPort-SDR: +pyz6I9cTDgx6JJ06qvs5VuPsZZ9Io4xt7lN7Dmem0jqnoUFy6DiZdFR8Rzd0kZqUI/4k17RF5
 ODPS5cHPDvsg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 06:11:12 -0700
IronPort-SDR: clQRKiwbv1/99tLauQvTCow+r5cSYsqoMQeYRPTxir5so2wx7LWxTTxyY0AXS8lLb00XYjuQFP
 F0zXB9bRkTzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="326220818"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2020 06:11:12 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 06:11:11 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.38]) by
 fmsmsx117.amr.corp.intel.com ([169.254.3.48]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 06:11:11 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Shane Francis <bigbeeshane@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx-request@lists.freedesktop.org" 
        <amd-gfx-request@lists.freedesktop.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Subject: RE: [PATCH v4 0/3] AMDGPU / RADEON / DRM Fix mapping of user pages
Thread-Topic: [PATCH v4 0/3] AMDGPU / RADEON / DRM Fix mapping of user pages
Thread-Index: AQHWAoUBcHg2O0WoqkuGqDdXnKtf46hZSF3A
Date:   Wed, 25 Mar 2020 13:11:11 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663FFFBD36E@fmsmsx107.amr.corp.intel.com>
References: <20200325090741.21957-1-bigbeeshane@gmail.com>
In-Reply-To: <20200325090741.21957-1-bigbeeshane@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>Shane Francis
>Sent: Wednesday, March 25, 2020 5:08 AM
>To: dri-devel@lists.freedesktop.org
>Cc: airlied@linux.ie; linux-kernel@vger.kernel.org; bigbeeshane@gmail.com;
>amd-gfx-request@lists.freedesktop.org; alexander.deucher@amd.com;
>christian.koenig@amd.com
>Subject: [PATCH v4 0/3] AMDGPU / RADEON / DRM Fix mapping of user pages
>
>This patch set is to fix a bug in amdgpu / radeon drm that results in
>a crash when dma_map_sg combines elemnets within a scatterlist table.

s/elemnets/elements

>There are 2 shortfalls in the current kernel.
>
>1) AMDGPU / RADEON assumes that the requested and created scatterlist
>   table lengths using from dma_map_sg are equal. This may not be the
>   case using the newer dma-iommu implementation
>
>2) drm_prime does not fetch the length of the scatterlist
>   via the correct dma macro, this can use the incorrect length
>   being used (>0) in places where dma_map_sg has updated the table
>   elements.
>
>   The sg_dma_len macro is representative of the length of the sg item
>   after dma_map_sg
>
>Example Crash :
>> [drm:amdgpu_ttm_backend_bind [amdgpu]] *ERROR* failed to pin userptr
>
>This happens in OpenCL applications, causing them to crash or hang, on
>either amdgpu-pro or ROCm OpenCL implementations
>
>I have verified this fixes the above on kernel 5.5 and 5.5rc using an
>AMD Vega 64 GPU
>
>Shane Francis (3):
>  drm/prime: use dma length macro when mapping sg to arrays
>  drm/amdgpu: fix scatter-gather mapping with user pages
>  drm/radeon: fix scatter-gather mapping with user pages
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> drivers/gpu/drm/drm_prime.c             | 2 +-
> drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
>--
>2.26.0
>
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
