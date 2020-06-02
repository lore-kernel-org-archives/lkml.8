Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76543C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFD9206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgFBJUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:20:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:1742 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFBJUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:20:41 -0400
IronPort-SDR: vYnsB2sJya5NJzKW4VV9v6AVEKU7mYe9TWjAULT1d7yfrIbs8NF35FaVlL465CV/1Ma9t2wZKg
 ZnIwZrHncTew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:20:40 -0700
IronPort-SDR: 2jrTq9czAJgHkfCg8Sfvuvet4XPOvwOSY4Atd02F/9QchcTH81ecRpuWw75snVAW5Anx6j1Jx0
 5mzvQcFm0VTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="312219453"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2020 02:20:38 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:20:30 +0200
Message-Id: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5ed4227f304b..6dbe173a9fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -251,11 +251,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 		int nvec = pci_msix_vec_count(adev->pdev);
 		unsigned int flags;
 
-		if (nvec <= 0) {
+		if (nvec > 0)
+			flags = PCI_IRQ_MSI_TYPES;
+		else
 			flags = PCI_IRQ_MSI;
-		} else {
-			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
-		}
+
 		/* we only need one vector */
 		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
 		if (nvec > 0) {
-- 
2.17.2

