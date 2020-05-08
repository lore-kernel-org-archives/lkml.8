Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506B9C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366CC2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEHPpL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:45:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:59832 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgEHPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:45:09 -0400
IronPort-SDR: rzY9RnjQ0KQwEinW4jAxw1l8ZvCujQkFDUUM0m0o+c6vDRkKmSIJme+gvQ9KPHwMus1xCXsJV9
 dUiCTzlS+vTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 08:45:08 -0700
IronPort-SDR: zuLAiuchje8B0YyQv0S/mbUVBsaBhKQ3aT39CD4wudUZg6RsHy7KKcVB23qKFBK/RFueqW6QIA
 q31289LMt4LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="285505776"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2020 08:45:08 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 8 May 2020 08:45:08 -0700
Received: from fmsmsx108.amr.corp.intel.com ([169.254.9.60]) by
 fmsmsx121.amr.corp.intel.com ([169.254.6.5]) with mapi id 14.03.0439.000;
 Fri, 8 May 2020 08:45:08 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom St Denis <tom.stdenis@amd.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        Ori Messinger <Ori.Messinger@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: cleanup coding style a bit
Thread-Topic: [PATCH v2] drm/amd/amdgpu: cleanup coding style a bit
Thread-Index: AQHWJE+3bau47Y1nb0Gh/jTCob7xpaieVcIg
Date:   Fri, 8 May 2020 15:45:07 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663010E20C5BD@FMSMSX108.amr.corp.intel.com>
References: <20200507091311.10898-1-bernard@vivo.com>
In-Reply-To: <20200507091311.10898-1-bernard@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>Bernard Zhao
>Sent: Thursday, May 7, 2020 5:13 AM
>To: Alex Deucher <alexander.deucher@amd.com>; Christian König
><christian.koenig@amd.com>; David (ChunMing) Zhou
><David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
><daniel@ffwll.ch>; Tom St Denis <tom.stdenis@amd.com>; Sam Ravnborg
><sam@ravnborg.org>; Ori Messinger <Ori.Messinger@amd.com>; Bernard
>Zhao <bernard@vivo.com>; amd-gfx@lists.freedesktop.org; dri-
>devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
>Cc: opensource.kernel@vivo.com
>Subject: [PATCH v2] drm/amd/amdgpu: cleanup coding style a bit
>
>There is DEVICE_ATTR mechanism in separate attribute define.
>So this change is to use attr array, also use
>sysfs_create_files in init function & sysfs_remove_files in
>fini function.
>This maybe make the code a bit readable.
>
>Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
>Changes since V1:
>*Use DEVICE_ATTR mechanism
>
>Link for V1:
>*https://lore.kernel.org/patchwork/patch/1228076/
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 43 ++++++-------------
>-
> 1 file changed, 13 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>index 82a3299e53c0..57bbc70662ff 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>@@ -148,6 +148,15 @@ static DEVICE_ATTR(mem_info_vis_vram_used,
>S_IRUGO,
> static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
> 		   amdgpu_mem_info_vram_vendor, NULL);
>
>+static struct attribute *amdgpu_vram_mgr_attributes[] = {
>+	&dev_attr_mem_info_vram_total.attr,
>+	&dev_attr_mem_info_vis_vram_total.attr,
>+	&dev_attr_mem_info_vram_used.attr,
>+	&dev_attr_mem_info_vis_vram_used.attr,
>+	&dev_attr_mem_info_vram_vendor.attr,
>+	NULL
>+};
>+
> /**
>  * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
>  *
>@@ -172,31 +181,9 @@ static int amdgpu_vram_mgr_init(struct
>ttm_mem_type_manager *man,
> 	man->priv = mgr;
>
> 	/* Add the two VRAM-related sysfs files */
>-	ret = device_create_file(adev->dev,
>&dev_attr_mem_info_vram_total);
>-	if (ret) {
>-		DRM_ERROR("Failed to create device file
>mem_info_vram_total\n");
>-		return ret;
>-	}
>-	ret = device_create_file(adev->dev,
>&dev_attr_mem_info_vis_vram_total);
>-	if (ret) {
>-		DRM_ERROR("Failed to create device file
>mem_info_vis_vram_total\n");
>-		return ret;
>-	}
>-	ret = device_create_file(adev->dev,
>&dev_attr_mem_info_vram_used);
>-	if (ret) {
>-		DRM_ERROR("Failed to create device file
>mem_info_vram_used\n");
>-		return ret;
>-	}
>-	ret = device_create_file(adev->dev,
>&dev_attr_mem_info_vis_vram_used);
>-	if (ret) {
>-		DRM_ERROR("Failed to create device file
>mem_info_vis_vram_used\n");
>-		return ret;
>-	}
>-	ret = device_create_file(adev->dev,
>&dev_attr_mem_info_vram_vendor);
>-	if (ret) {
>-		DRM_ERROR("Failed to create device file
>mem_info_vram_vendor\n");
>-		return ret;
>-	}
>+	ret = sysfs_create_files(&adev->dev->kobj,
>amdgpu_vram_mgr_attributes);
>+	if (ret)
>+		DRM_ERROR("Failed to register sysfs\n");

This looks good to me.

I think that there is a new error macro (drm_err?) that you might
want to use instead of DRM_ERROR().

Otherwise:

Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

m

>
> 	return 0;
> }
>@@ -219,11 +206,7 @@ static int amdgpu_vram_mgr_fini(struct
>ttm_mem_type_manager *man)
> 	spin_unlock(&mgr->lock);
> 	kfree(mgr);
> 	man->priv = NULL;
>-	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
>-	device_remove_file(adev->dev,
>&dev_attr_mem_info_vis_vram_total);
>-	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
>-	device_remove_file(adev->dev,
>&dev_attr_mem_info_vis_vram_used);
>-	device_remove_file(adev->dev,
>&dev_attr_mem_info_vram_vendor);
>+	sysfs_remove_files(&adev->dev->kobj,
>amdgpu_vram_mgr_attributes);
> 	return 0;
> }
>
>--
>2.26.2
>
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
