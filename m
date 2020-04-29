Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A0C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96C220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgD2VHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:07:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:34699 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgD2VHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:07:43 -0400
IronPort-SDR: y8WvO7u/yrLRl4UxNR5CisRntl2syKAWnrG90d29g1suS+P6geULpha5fLOsXLzFZGuL0nuts/
 8AYyYYEej+Iw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 14:07:43 -0700
IronPort-SDR: 9KMFJS/qBz1Tol+HEl7DO7rg0UpWzvVVdxnC3FBPX/0IsSOZRbtMs3zEGHI4Yq+coGpY15G2OR
 IBNCf7YU/YgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="282629568"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 14:07:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jTtvf-000GMm-33; Thu, 30 Apr 2020 05:07:39 +0800
Date:   Thu, 30 Apr 2020 05:06:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>, konrad.wilk@oracle.com,
        mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com,
        will@kernel.org, stefano.stabellini@xilinx.com
Cc:     kbuild-all@lists.01.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, vatsa@codeaurora.org,
        christoffer.dall@arm.com, alex.bennee@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] virtio: virtio_pool can be static
Message-ID: <20200429210642.GA804@46221c807a07>
References: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 virtio_bounce.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_bounce.c b/drivers/virtio/virtio_bounce.c
index 3de8e0eb71e48..5a68d48667c42 100644
--- a/drivers/virtio/virtio_bounce.c
+++ b/drivers/virtio/virtio_bounce.c
@@ -19,7 +19,7 @@
 static phys_addr_t bounce_buf_paddr;
 static void *bounce_buf_vaddr;
 static size_t bounce_buf_size;
-struct swiotlb_pool *virtio_pool;
+static struct swiotlb_pool *virtio_pool;
 
 #define VIRTIO_MAX_BOUNCE_SIZE	(16*4096)
 
@@ -76,7 +76,7 @@ static void virtio_unmap_page(struct device *dev, dma_addr_t dev_addr,
 					size, dir, attrs);
 }
 
-size_t virtio_max_mapping_size(struct device *dev)
+static size_t virtio_max_mapping_size(struct device *dev)
 {
 	return VIRTIO_MAX_BOUNCE_SIZE;
 }
