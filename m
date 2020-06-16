Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93C320644
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFPInB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:43:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:53287 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFPInA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:43:00 -0400
IronPort-SDR: eICpMI5FHSfXqOoAQKop53PWvOcW0IDrfy8MVi2qjYoUJ4DcgiY4/uUDJOCwSxgXdROrH/QVK3
 1+Erc7gHPOlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 01:43:00 -0700
IronPort-SDR: ESwecSLyQfPyKt5v+QA7YVSN7oPk6dEwv7A7LD3l65xfCRDTw98JDvGguFbLjsPh4m0pT64k9+
 4LLFQ1luX1oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="449726556"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2020 01:42:57 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Lyude Paul <lyude@redhat.com>, shaoyunl <shaoyun.liu@amd.com>,
        Emily Deng <Emily.Deng@amd.com>,
        Aurabindo Pillai <mail@aurabindo.in>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Simplify IRQ vector request logic
Date:   Tue, 16 Jun 2020 10:42:41 +0200
Message-Id: <20200616084243.18544-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <CADnq5_N95PjqU4nMgZBL_PoNKk8ourb_k9HLGvR_RN5FeZ3tkg@mail.gmail.com>
References: <CADnq5_N95PjqU4nMgZBL_PoNKk8ourb_k9HLGvR_RN5FeZ3tkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_irq_vectors() will handle fallback from MSI-X to MSI
internally, if necessary. So remove checks which determine if we are
dealing with MSI or MSI-X and rely on pci_alloc_irq_vectors() to do the
right thing.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0cc4c67f95f7..2d68ad7d45d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -248,17 +248,8 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	adev->irq.msi_enabled = false;
 
 	if (amdgpu_msi_ok(adev)) {
-		int nvec = pci_msix_vec_count(adev->pdev);
-		unsigned int flags;
-
-		if (nvec <= 0) {
-			flags = PCI_IRQ_MSI;
-		} else {
-			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
-		}
 		/* we only need one vector */
-		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
-		if (nvec > 0) {
+		if (pci_alloc_irq_vectors(adev->pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_MSIX) > 0) {
 			adev->irq.msi_enabled = true;
 			dev_dbg(adev->dev, "using MSI/MSI-X.\n");
 		}
-- 
2.17.2

