Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5407C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBC520724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgHUMVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:21:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:7993 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbgHUMVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:21:04 -0400
IronPort-SDR: 0yu1DH6/7KglHN4KqAt7TbhJvlh5/sAPn8D+TIDPzbLuYGESkXM3q4CNHezAdT+9bcdYz9+guy
 R1cs0gfo9kdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="173568920"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="173568920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 05:21:03 -0700
IronPort-SDR: h5ov/Vxs9uCKdSZAfTvh5kcVy0zh4tPuWg5CPQc1T2djfWE0tQ1f8+7RhonZ4e+Rcb9qdhVBr0
 fd7yFeB7O5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="321243630"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2020 05:21:00 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k962W-00010i-0X; Fri, 21 Aug 2020 12:21:00 +0000
Date:   Fri, 21 Aug 2020 20:20:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
Subject: [RFC PATCH] vdpa_sim: vdpasim_get_iova_range() can be static
Message-ID: <20200821122051.GA60229@ff58d72860ac>
References: <20200821092813.8952-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821092813.8952-4-jasowang@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 vdpa_sim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 89854e17c3c27b..ff6c9fd8d879bd 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -574,7 +574,7 @@ static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
 	return vdpasim->generation;
 }
 
-struct vdpa_iova_range vdpasim_get_iova_range(struct vdpa_device *vdpa)
+static struct vdpa_iova_range vdpasim_get_iova_range(struct vdpa_device *vdpa)
 {
 	struct vdpa_iova_range range = {
 		.first = 0ULL,
