Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A00C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4D72158C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322834;
	bh=rslNjUeVlj97qpEPQRjAVmForQmuPgw5erM9aaqm87g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O9O81yT0l4PHep7UK9TANi+VYAlfcCsbSaLURcRbXiaxJrS8exjR2xy1Fj5g3ZP8s
	 DS+5HeZG7VkSoB/Bx4DIk2S2OjNZJzmGSA9OHgL3FF28y7PceqwTCweD90s+OhO+7f
	 nLxkssTvRSwcv8CJv3VgB++eOlQqQ8j4q0+pHjDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgFPPxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732897AbgFPPxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6226F207C4;
        Tue, 16 Jun 2020 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322826;
        bh=rslNjUeVlj97qpEPQRjAVmForQmuPgw5erM9aaqm87g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pK36BmY8WfYriMzImQPN2oR6k/FU0Lib45A2F2u5FG855OtV8qUtiUygVU2Uu3pnA
         bT3FYOeMkgAPYnZLmG7kz+JWl4jkMpkzg1ec5YLtg4++Xy94Bu9Z+J914y4lnbcz+T
         xZ6KBtuYDYSCW/h1DqNjYml645Uul5DWOGILil4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.6 118/161] remoteproc: Fall back to using parent memory pool if no dedicated available
Date:   Tue, 16 Jun 2020 17:35:08 +0200
Message-Id: <20200616153111.977789330@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

commit db9178a4f8c4e523f824892cb8bab00961b07385 upstream.

In some cases, like with OMAP remoteproc, we are not creating dedicated
memory pool for the virtio device. Instead, we use the same memory pool
for all shared memories. The current virtio memory pool handling forces
a split between these two, as a separate device is created for it,
causing memory to be allocated from bad location if the dedicated pool
is not available. Fix this by falling back to using the parent device
memory pool if dedicated is not available.

Cc: stable@vger.kernel.org
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Link: https://lore.kernel.org/r/20200420160600.10467-2-s-anna@ti.com
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/remoteproc_virtio.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -375,6 +375,18 @@ int rproc_add_virtio_dev(struct rproc_vd
 				goto out;
 			}
 		}
+	} else {
+		struct device_node *np = rproc->dev.parent->of_node;
+
+		/*
+		 * If we don't have dedicated buffer, just attempt to re-assign
+		 * the reserved memory from our parent. A default memory-region
+		 * at index 0 from the parent's memory-regions is assigned for
+		 * the rvdev dev to allocate from. Failure is non-critical and
+		 * the allocations will fall back to global pools, so don't
+		 * check return value either.
+		 */
+		of_reserved_mem_device_init_by_idx(dev, np, 0);
 	}
 
 	/* Allocate virtio device */


