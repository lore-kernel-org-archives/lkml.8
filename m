Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C702AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E75B2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="IdhsTx1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDIB20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 21:28:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38458 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDIB2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 21:28:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id 13so1603378qtt.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 18:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5kw2Wbvm+jeuA0TKaixDRv8+MULXqVay3QBIHkyklY=;
        b=IdhsTx1X7K+gu0qszXrpQefgwGzG8CB0RvoL1PoE6xMluCGUybvuH1Y1hDU0yhH3lb
         S7ZxnE671zW/V5dVCMIOgpJYyC6qX5dEi8rT9ldP5rLRXGT846mhZ4uTxSNMgJq8hgiy
         DVf+/oXW92XTx+Ke/57DO0CfcC3ryfBU3gwHz3BbjYvxCYPFGah+zYcwZG7q8cWAt+Bn
         VIcoN22EpwE9vvdtIKTtUjvSq0zQv4hHLEppbWzfwOwGFjYq+r3btl1GVxJzPRz8Otf/
         qDz08PtlqeYREFn5SzmohAt6B1fCFjcFdODvQ8szTdoaDTK7sYBdq6qNVFfqbhUZsGdf
         gcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5kw2Wbvm+jeuA0TKaixDRv8+MULXqVay3QBIHkyklY=;
        b=MSELH8Y+rdalHFDgXkt/7G7c0j0JS5R30xfK0IkH1HcxEYylu1HxB7FHVq1jahaYzR
         QpeOe5vCRwC/oF9Ql3ex1G+jxteKdJ77I3YcBm4TBFxoKRIcCixH63uz0W06w9sxZQI+
         L7WV0AI4wY7fv/XchgjryA97WiU/78l3nHyhDsCK/TJbAAj6sILbkn7jmXqZPHtZf51e
         Amw9iEV8Ts9m29ihEvpryI1Y+LSyEybVnlBZf4sAxpMhBBc3V8K3yg1+rXVaY56D+ynZ
         m7CQabv0s4sS+GMzuRr3bNf9LZWqm5yCL6ObELAJfPXgg6Vg0H60RP++DAKmOdn9zlDO
         9psw==
X-Gm-Message-State: AGi0PuZ9wVeosTZdseKm952CjwGydOCyLOWDP+hPvKUGUWFxea4wr687
        EpZEfqnopgCv+m7SQtee/CfA1Q==
X-Google-Smtp-Source: APiQypKkLtyEqv2exCrhc0LFffwP7h8eu9YlvpRilNhQ13nMJibLG+kUqVy7Zkjty2jLqU3zF9iILA==
X-Received: by 2002:ac8:6719:: with SMTP id e25mr10113060qtp.367.1586395704610;
        Wed, 08 Apr 2020 18:28:24 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca. [135.23.249.169])
        by smtp.gmail.com with ESMTPSA id h13sm11710186qkj.21.2020.04.08.18.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 18:28:24 -0700 (PDT)
From:   Aurabindo Pillai <mail@aurabindo.in>
To:     christian.koenig@amd.com, alexander.deucher@amd.com,
        David1.Zhou@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/amd/amdgpu: remove hardcoded module name in prints
Date:   Wed,  8 Apr 2020 21:28:15 -0400
Message-Id: <20200409012815.22309-4-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200409012815.22309-1-mail@aurabindo.in>
References: <20200409012815.22309-1-mail@aurabindo.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let format prefixes take care of printing the module name
through pr_fmt and dev_fmt definitions.

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c            | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index fa8ac9d19..4afd4ef54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -325,13 +325,13 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate,
 					&param);
 	if (ret) {
-		pr_err("amdgpu: failed to validate PT BOs\n");
+		pr_err("failed to validate PT BOs\n");
 		return ret;
 	}
 
 	ret = amdgpu_amdkfd_validate(&param, pd);
 	if (ret) {
-		pr_err("amdgpu: failed to validate PD\n");
+		pr_err("failed to validate PD\n");
 		return ret;
 	}
 
@@ -340,7 +340,7 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 	if (vm->use_cpu_for_update) {
 		ret = amdgpu_bo_kmap(pd, NULL);
 		if (ret) {
-			pr_err("amdgpu: failed to kmap PD, ret=%d\n", ret);
+			pr_err("failed to kmap PD, ret=%d\n", ret);
 			return ret;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b8975857d..0a8c4a266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1092,7 +1092,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
-		pr_info("amdgpu: switched on\n");
+		pr_info("switched on\n");
 		/* don't suspend or resume card normally */
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
@@ -1106,7 +1106,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
 		dev->switch_power_state = DRM_SWITCH_POWER_ON;
 		drm_kms_helper_poll_enable(dev);
 	} else {
-		pr_info("amdgpu: switched off\n");
+		pr_info("switched off\n");
 		drm_kms_helper_poll_disable(dev);
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 		amdgpu_device_suspend(dev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5ed4227f3..0cc4c67f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -260,7 +260,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
 		if (nvec > 0) {
 			adev->irq.msi_enabled = true;
-			dev_dbg(adev->dev, "amdgpu: using MSI/MSI-X.\n");
+			dev_dbg(adev->dev, "using MSI/MSI-X.\n");
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b20503935..c1a530dbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -858,7 +858,7 @@ static int gmc_v6_0_sw_init(void *handle)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+		dev_warn(adev->dev, "No suitable DMA available.\n");
 		return r;
 	}
 	adev->need_swiotlb = drm_need_swiotlb(44);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 9da9596a3..e8529e244 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1019,7 +1019,7 @@ static int gmc_v7_0_sw_init(void *handle)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
-		pr_warn("amdgpu: No suitable DMA available\n");
+		pr_warn("No suitable DMA available\n");
 		return r;
 	}
 	adev->need_swiotlb = drm_need_swiotlb(40);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 27d83204f..0aa5b8280 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1144,7 +1144,7 @@ static int gmc_v8_0_sw_init(void *handle)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
-		pr_warn("amdgpu: No suitable DMA available\n");
+		pr_warn("No suitable DMA available\n");
 		return r;
 	}
 	adev->need_swiotlb = drm_need_swiotlb(40);
-- 
2.26.0

