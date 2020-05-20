Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2706AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86CE206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgETPXz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:23:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:32705 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgETPXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:23:54 -0400
IronPort-SDR: WR8+yPwwH0i1D9vtMloCx6u1fLFkLvn+oalhwokfYdK68XRQPpjAW/b7JGj2PYOXXE+zHk7iWY
 ebPxIYhqm9VA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 08:23:53 -0700
IronPort-SDR: AkeQM6LZ3P7X6Oi8bFUdxbhbbvsvujPavT2OPZY5Aa8oNm0QW2ltDRhi5803B9ircrW61/80KB
 0byOG3sFXlVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="253700519"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 20 May 2020 08:23:53 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 08:23:53 -0700
Received: from fmsmsx108.amr.corp.intel.com ([169.254.9.97]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.85]) with mapi id 14.03.0439.000;
 Wed, 20 May 2020 08:23:53 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>
CC:     David Airlie <airlied@linux.ie>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "Rui Huang" <ray.huang@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Evan Quan <evan.quan@amd.com>,
        "Kenneth Feng" <kenneth.feng@amd.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Yintian Tao <yttao@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: off by on in
 amdgpu_device_attr_create_groups() error handling
Thread-Topic: [PATCH v2] drm/amdgpu: off by on in
 amdgpu_device_attr_create_groups() error handling
Thread-Index: AQHWLqgW9uvuDNiQMEi3BV2xZkJF36ixF+EA
Date:   Wed, 20 May 2020 15:23:52 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663010E2302FA@FMSMSX108.amr.corp.intel.com>
References: <20200520125209.GP3041@kadam> <20200520130812.GA177222@mwanda>
In-Reply-To: <20200520130812.GA177222@mwanda>
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

"off by on"

or 

"off by one"

?

M

>-----Original Message-----
>From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Dan
>Carpenter
>Sent: Wednesday, May 20, 2020 9:08 AM
>To: Alex Deucher <alexander.deucher@amd.com>; Kevin Wang
><kevin1.wang@amd.com>
>Cc: David Airlie <airlied@linux.ie>; kernel-janitors@vger.kernel.org; linux-
>kernel@vger.kernel.org; amd-gfx@lists.freedesktop.org; Hawking Zhang
><Hawking.Zhang@amd.com>; Rui Huang <ray.huang@amd.com>; dri-
>devel@lists.freedesktop.org; Evan Quan <evan.quan@amd.com>; Kenneth
>Feng <kenneth.feng@amd.com>; Christian König
><christian.koenig@amd.com>; Yintian Tao <yttao@amd.com>
>Subject: [PATCH v2] drm/amdgpu: off by on in
>amdgpu_device_attr_create_groups() error handling
>
>This loop in the error handling code should start a "i - 1" and end at
>"i == 0".  Currently it starts a "i" and ends at "i == 1".  The result
>is that it removes one attribute that wasn't created yet, and leaks the
>zeroeth attribute.
>
>Fixes: 4e01847c38f7 ("drm/amdgpu: optimize amdgpu device attribute code")
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>---
>v2: style change
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c           | 3 +--
> 1 files changed, 1 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>index b75362bf0742..e809534fabd4 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>@@ -1942,9 +1942,8 @@ static int amdgpu_device_attr_create_groups(struct
>amdgpu_device *adev,
> 	return 0;
>
> failed:
>-	for (; i > 0; i--) {
>+	while (i--)
> 		amdgpu_device_attr_remove(adev, &attrs[i]);
>-	}
>
> 	return ret;
> }
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
