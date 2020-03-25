Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3043C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A5A2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgCYN4J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:56:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:10299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgCYN4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:56:09 -0400
IronPort-SDR: fD0gy8O2PaKOR+oY1LtjmvPsntJ9CJvP0tWS/TTrhcZGgSr5RecWo6iFPyc2LU/om6INLDNZQX
 MnSLbW0KWa/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 06:56:08 -0700
IronPort-SDR: s57Q6TOkQpu6PJRl7m3fQgh2HQCgGEcvzcVIQBs7hOlRQkCk5SIMJhdsmq1cn+TmvdKZD+wDkY
 //bcVV7IYhLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="250414365"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2020 06:56:08 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.38]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.250]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 06:56:07 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Shane Francis <bigbeeshane@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx-request@lists.freedesktop.org" 
        <amd-gfx-request@lists.freedesktop.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Subject: RE: [PATCH v4 1/3] drm/prime: use dma length macro when mapping sg
Thread-Topic: [PATCH v4 1/3] drm/prime: use dma length macro when mapping sg
Thread-Index: AQHWAoT+OOcEgrTLV0+k11mipUYGbahZUVMA
Date:   Wed, 25 Mar 2020 13:56:07 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663FFFBD421@fmsmsx107.amr.corp.intel.com>
References: <20200325090741.21957-1-bigbeeshane@gmail.com>
 <20200325090741.21957-2-bigbeeshane@gmail.com>
In-Reply-To: <20200325090741.21957-2-bigbeeshane@gmail.com>
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
>Subject: [PATCH v4 1/3] drm/prime: use dma length macro when mapping sg
>
>As dma_map_sg can reorganize scatter-gather lists in a
>way that can cause some later segments to be empty we should
>always use the sg_dma_len macro to fetch the actual length.
>
>This could now be 0 and not need to be mapped to a page or
>address array
>Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
>---
> drivers/gpu/drm/drm_prime.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>index 86d9b0e45c8c..1de2cde2277c 100644
>--- a/drivers/gpu/drm/drm_prime.c
>+++ b/drivers/gpu/drm/drm_prime.c
>@@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct
>sg_table *sgt, struct page **pages,
>
> 	index = 0;
> 	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
>-		len = sg->length;
>+		len = sg_dma_len(sg);
> 		page = sg_page(sg);
> 		addr = sg_dma_address(sg);

This looks correct to me.

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

M

>
>--
>2.26.0
>
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
