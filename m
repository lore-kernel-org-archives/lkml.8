Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BAEC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6688B20A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCYOTu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:19:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:29870 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgCYOTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:19:50 -0400
IronPort-SDR: U35KYOhV18z2VqeqbYyxbB5tpKXuSYBAZnB1cWgX6q2naR0L7n2JvbA2ZH4rASSnRQIwGASoe/
 P58pEZrwQGJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:19:48 -0700
IronPort-SDR: XS6LI5XnckcHTf5zP+rVjmfqI2VY0FD2NSScpEi9NFm4cUlytCe0p7mRQSsFRjOrmiUtNLbg2H
 HbPJ9wZxpw4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="250420335"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2020 07:19:49 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 07:19:48 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.38]) by
 fmsmsx118.amr.corp.intel.com ([169.254.1.221]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 07:19:48 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Shane Francis <bigbeeshane@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx-request@lists.freedesktop.org" 
        <amd-gfx-request@lists.freedesktop.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Subject: RE: [PATCH v4 3/3] drm/radeon: fix scatter-gather mapping with user
 pages
Thread-Topic: [PATCH v4 3/3] drm/radeon: fix scatter-gather mapping with
 user pages
Thread-Index: AQHWAoUBcNgIkBIx5kKMIMnKtZMniKhZW20g
Date:   Wed, 25 Mar 2020 14:19:48 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663FFFBD48B@fmsmsx107.amr.corp.intel.com>
References: <20200325090741.21957-1-bigbeeshane@gmail.com>
 <20200325090741.21957-4-bigbeeshane@gmail.com>
In-Reply-To: <20200325090741.21957-4-bigbeeshane@gmail.com>
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
>Subject: [PATCH v4 3/3] drm/radeon: fix scatter-gather mapping with user
>pages
>
>Calls to dma_map_sg may return segments / entries than requested

"may return less segment..." ?
                       ^^^

>if they fall on page bounderies. The old implementation did not
>support this use case.
>
>Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
>---
> drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c
>b/drivers/gpu/drm/radeon/radeon_ttm.c
>index 3b92311d30b9..b3380ffab4c2 100644
>--- a/drivers/gpu/drm/radeon/radeon_ttm.c
>+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>@@ -528,7 +528,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt
>*ttm)
>
> 	r = -ENOMEM;
> 	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents,
>direction);
>-	if (nents != ttm->sg->nents)
>+	if (nents == 0)
> 		goto release_sg;

This looks correct to me.

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

M
> 	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
>--
>2.26.0
>
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
