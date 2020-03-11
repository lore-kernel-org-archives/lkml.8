Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2A9C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72120734
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="LCRzxYi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgCKRJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:09:24 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:50128 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbgCKRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:09:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 0C79D3FF96;
        Wed, 11 Mar 2020 18:09:22 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=LCRzxYi9;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dUa-2b0bjt8Z; Wed, 11 Mar 2020 18:09:21 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1AA9F3FF88;
        Wed, 11 Mar 2020 18:09:19 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 730CF362EB1;
        Wed, 11 Mar 2020 18:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583946559; bh=QALlf4jaCGRsKuKgXyRiZ+GDUymJdPMTcMsIafOFzT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCRzxYi9G0SPusaigDSI6LpV+XE57W3UDu5RpVgQERtMgmF6Tw+gXWO9jqgKQDVC0
         40YAkzawHdzDxRQC3H4BpCnaU4mu0/ubE4tEwdKw2ZlzfrWh7LAdwT0tfdPN2gs+or
         pjzn83CbWAfGw1LPHgJ8v47qka2V+bz8PGxuoafU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>
Subject: [PATCH 2/2] drm/vmwgfx: Refuse DMA operation when SEV encryption is active
Date:   Wed, 11 Mar 2020 18:08:39 +0100
Message-Id: <20200311170839.3617-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200311170839.3617-1-thomas_os@shipmail.org>
References: <20200311170839.3617-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

TTM doesn't yet fully support mapping of DMA memory when SEV is active,
so in that case, refuse DMA operation. For guest-backed object operation
this means 3D acceleration will be disabled. For host-backed, VRAM will be
used for data transfer between the guest and the device.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index f2ec3155468d..4f58364421ce 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -29,6 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/mem_encrypt.h>
 
 #include <drm/drm_drv.h>
 #include <drm/drm_ioctl.h>
@@ -575,6 +576,10 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_map_populate] = "Caching DMA mappings.",
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
 
+	/* TTM currently doesn't fully support SEV encryption. */
+	if (mem_encrypt_active())
+		return -EINVAL;
+
 	if (vmw_force_coherent)
 		dev_priv->map_mode = vmw_dma_alloc_coherent;
 	else if (vmw_restrict_iommu)
-- 
2.21.1

